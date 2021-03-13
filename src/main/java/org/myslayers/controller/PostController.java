package org.myslayers.controller;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.Date;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.Comment;
import org.myslayers.entity.Post;
import org.myslayers.entity.User;
import org.myslayers.entity.UserCollection;
import org.myslayers.entity.UserMessage;
import org.myslayers.utils.ValidationUtil;
import org.myslayers.vo.CommentVo;
import org.myslayers.vo.PostVo;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class PostController extends BaseController {

    /*--------------------------------------分类category------------------------------------>*/

    /**
     * 分类category
     */
    @GetMapping("/category/{id:\\d*}")
    public String category(@PathVariable(name = "id") long id) {
        /**
         * 分类（传入id）-> 渲染分类
         */
        //req：根据传入category表中当前页的id -> 【渲染】分类
        req.setAttribute("currentCategoryId", id);

        //req：解决使用<@details categoryId=currentCategoryId pn=pn size=2>时，无法传入参数pn的方法：让pn直接从req请求中获取 -> 作为传入posts方法的参数
        req.setAttribute("pn", ServletRequestUtils.getIntParameter(req, "pn", 1));

        return "post/category";
    }

    /*--------------------------------------详情detail-------------------------------------->*/

    /**
     * 详情detail：【查看】文章、【评论】文章
     */
    @GetMapping("/post/{id:\\d*}")
    public String detail(@PathVariable(name = "id") long id) {
        /**
         * 一条（post实体类、PostVo实体类）
         */
        //一条：selectOnePost（表 文章id = 传 文章id），因为Mapper中select信息中，id过多引起歧义，故采用p.id
        PostVo postVo = postService.selectOnePost(new QueryWrapper<Post>().eq("p.id", id));
        //req：PostVo实体类 -> CategoryId属性
        req.setAttribute("currentCategoryId", postVo.getCategoryId());
        //req：PostVo实体类（回调）
        req.setAttribute("post", postVo);

        /**
         * 评论（comment实体类）
         */
        //评论：page(分页信息、文章id、用户id、排序)
        IPage<CommentVo> results = commentService.selectComments(getPage(), postVo.getId(), null, "created");
        //req：CommentVo分页集合
        req.setAttribute("pageData", results);

        /**
         * 文章阅读【缓存实现访问量】：减少访问数据库的次数，存在一个BUG，只与点击链接的次数相关，没有与用户的id进行绑定
         */
        postService.putViewCount(postVo);

        return "post/detail";
    }

    /**
     * 详情detail：【删除】文章
     */
    @ResponseBody
    @Transactional
    @PostMapping("/post/delete")
    public Result delete(Long id) {
        Post post = postService.getById(id);
        Assert.notNull(post, "该帖子已被删除");
        Assert.isTrue(post.getUserId().longValue() == getProfileId().longValue(), "无权限删除此文章！");

        // 删除-该篇文章【该篇文章】-Post
        postService.removeById(id);
        // 删除-我的消息【收到消息】-UserMessage中的post_id
        messageService.removeByMap(MapUtil.of("post_id", id));
        // 删除-用户中心【收藏的帖】-UserCollection中的post_id
        collectionService.removeByMap(MapUtil.of("post_id", id));

        return Result.success().action("/user/index");
    }

    /**
     * 详情detail：【评论】文章
     */
    @ResponseBody
    @Transactional
    @PostMapping("/post/reply/")
    public Result reply(Long jid, String content) {
        Assert.notNull(jid, "找不到对应的文章");
        Assert.hasLength(content, "评论内容不能为空");

        Post post = postService.getById(jid);
        Assert.isTrue(post != null, "该文章已被删除");

        // 新增评论
        Comment comment = new Comment();
        comment.setPostId(jid);
        comment.setContent(content);
        comment.setUserId(getProfileId());
        comment.setCreated(new Date());
        comment.setModified(new Date());
        comment.setLevel(0);
        comment.setVoteDown(0);
        comment.setVoteUp(0);
        commentService.save(comment);

        // 评论数量+1
        post.setCommentCount(post.getCommentCount() + 1);
        postService.updateById(post);

        // 本周热议数量+1
        postService.incrCommentCountAndUnionForWeekRank(post, true);

        // 通知作者，有人评论了你的文章
        // 作者自己评论自己文章，不需要通知
        if (comment.getUserId() != post.getUserId()) {
            UserMessage message = new UserMessage();
            message.setFromUserId(getProfileId());
            message.setToUserId(post.getUserId());
            message.setPostId(jid);
            message.setCommentId(comment.getId());
            message.setType(1); //我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论
            message.setStatus(0); //我的消息的【状态】：0代表未读、1代表已读
            message.setCreated(new Date());
            messageService.save(message);
        }

        // 通知被@的人，有人回复了你的文章
        if (content.startsWith("@")) {
            String username = content.substring(1, content.indexOf(" "));
            User user = userService.getOne(new QueryWrapper<User>().eq("username", username));
            if (user != null) {
                UserMessage message = new UserMessage();
                message.setFromUserId(getProfileId());
                message.setToUserId(post.getUserId());
                message.setPostId(jid);
                message.setCommentId(comment.getId());
                message.setType(2); //我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论
                message.setStatus(0); //我的消息的【状态】：0代表未读、1代表已读
                message.setCreated(new Date());
                messageService.save(message);
            }
        }

        return Result.success().action("/post/" + post.getId());
    }



    /*--------------------------------------收藏collection------------------------------------>*/

    /**
     * 收藏collection：判断用户是否收藏了文章
     */
    @ResponseBody
    @PostMapping("/collection/find/")
    public Result collectionFind(Long pid) {
        int count = collectionService.count(new QueryWrapper<UserCollection>()
            .eq("user_id", getProfileId())
            .eq("post_id", pid)
        );
        //【/res/mods/jie.js】源码可知，异步渲染（layui.cache.user.uid != -1时，会调用/collection/find/接口）
        //【/res/mods/jie.js】源码可知，异步渲染（res.data.collection ? '取消收藏' : '收藏'），count > 0 为true时，则res.data.collection也为true
        return Result.success(MapUtil.of("collection", count > 0));
    }

    /**
     * 收藏collection：【加入收藏】文章
     */
    @ResponseBody
    @PostMapping("/collection/add/")
    public Result collectionAdd(Long pid) {
        Post post = postService.getById(pid);

        //文章是否被删除
        //如果【post != null】为true，则直接跳过该条语句；否则为false，则报异常【java.lang.IllegalArgumentException: 改帖子已被删除】
        //等价写法【if (post == null) return Result.fail("该帖子已被删除");】
        Assert.isTrue(post != null, "该文章已被删除");

        //文章是否被收藏
        int count = collectionService.count(new QueryWrapper<UserCollection>()
            .eq("user_id", getProfileId())
            .eq("post_id", pid)
        );
        if (count > 0) {
            return Result.fail("你已经收藏");
        }

        //将该文章进行收藏
        UserCollection collection = new UserCollection();
        collection.setUserId(getProfileId());
        collection.setPostId(pid);
        collection.setCreated(new Date());
        collection.setModified(new Date());
        collection.setPostUserId(post.getUserId());
        collectionService.save(collection);

        return Result.success();
    }

    /**
     * 收藏collection：【取消收藏】文章
     */
    @ResponseBody
    @PostMapping("/collection/remove/")
    public Result collectionRemove(Long pid) {
        Post post = postService.getById(pid);

        //文章是否被删除
        Assert.isTrue(post != null, "该文章已被删除");

        //将该文章进行删除
        collectionService.remove(new QueryWrapper<UserCollection>()
            .eq("user_id", getProfileId())
            .eq("post_id", pid));

        return Result.success();
    }

    /*--------------------------------------添加/编辑edit-------------------------------------->*/

    /**
     * 添加/编辑edit：【添加/编辑】文章
     */
    @GetMapping("/post/edit")
    public String edit() {
        //getParameter：http://localhost:8080/post/edit?id=1
        String id = req.getParameter("id");
        //如果id不为空
        if (!StringUtils.isEmpty(id)) {
            Post post = postService.getById(id);
            Assert.isTrue(post != null, "该文章已被删除！");
            Assert.isTrue(post.getUserId().longValue() == getProfileId().longValue(), "没权限操作此文章！");
            //向request域存放【post文章信息】
            req.setAttribute("post", post);
        }

        //向request域存放【categories分类信息】
        req.setAttribute("categories", categoryService.list());
        return "/post/edit";
    }

    /**
     * 添加/编辑edit：【提交】文章
     */
    @ResponseBody
    @PostMapping("/post/submit")
    public Result submit(Post post) {
        // 使用ValidationUtil工具类，校验【输入是否错误】
        ValidationUtil.ValidResult validResult = ValidationUtil.validateBean(post);
        if (validResult.hasErrors()) {
            return Result.fail(validResult.getErrors());
        }

        // 在传入【req.setAttribute("post", post);】后，同一页面请求的数据，可以通过post.getId()查询到【id】
        // 如果id不存在，则为【添加-文章】
        if (post.getId() == null) {
            post.setUserId(getProfileId());
            post.setModified(new Date());
            post.setCreated(new Date());
            post.setCommentCount(0);
            post.setEditMode(null);
            post.setLevel(0);
            post.setRecommend(false);
            post.setViewCount(0);
            post.setVoteDown(0);
            post.setVoteUp(0);
            postService.save(post);
        } else {
            // 如果id存在，则为【更新-文章】
            Post tempPost = postService.getById(post.getId());
            Assert.isTrue(tempPost.getUserId().longValue() == getProfileId().longValue(), "无权限编辑此文章！");
            tempPost.setTitle(post.getTitle());
            tempPost.setContent(post.getContent());
            tempPost.setCategoryId(post.getCategoryId());
            postService.updateById(tempPost);
        }

        // 无论id是否存在，两类情况都会 retern 跳转到 /post/${id}
        return Result.success().action("/post/" + post.getId());
    }
}

