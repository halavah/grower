package org.myslayers.controller;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.util.Date;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.Post;
import org.myslayers.entity.UserCollection;
import org.myslayers.vo.CommentVo;
import org.myslayers.vo.PostVo;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
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

    /*--------------------------------------详情detail------------------------------------>*/

    /**
     * 详情detail：文章展示
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
        IPage<CommentVo> results = commentService
            .selectComments(getPage(), postVo.getId(), null, "created");
        //req：CommentVo分页集合
        req.setAttribute("pageData", results);

        /**
         * 文章阅读【缓存实现访问量】：减少访问数据库的次数，存在一个BUG，只与点击链接的次数相关，没有与用户的id进行绑定
         */
        postService.putViewCount(postVo);

        return "post/detail";
    }

    /*--------------------------------------详情detail------------------------------------>*/

    /**
     * 详情detail：判断用户是否收藏了文章
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
     * 详情detail：【加入收藏】文章
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
     * 详情detail：【取消收藏】文章
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


}

