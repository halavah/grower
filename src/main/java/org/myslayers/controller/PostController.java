package org.myslayers.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.myslayers.entity.Post;
import org.myslayers.vo.CommentVo;
import org.myslayers.vo.PostVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
     * 详情detail
     */
    @GetMapping("/detail/{id:\\d*}")
    public String detail(@PathVariable(name = "id") long id) {
        /**
         * 一条（post实体类、PostVo实体类）
         */
        //一条：selectOnePost（表 文章id = 传 文章id），因为Mapper中select信息中，id过多引起歧义，故采用p.id
        PostVo postVo = postService.selectOnePost(new QueryWrapper<Post>().eq("p.id", id));
        //req：PostVo实体类 -> CategoryId属性
        req.setAttribute("currentCategoryId", postVo.getCategoryId());
        //req：PostVo实体类（回调）
        req.setAttribute("postVoData", postVo);

        /**
         * 评论（comment实体类）
         */
        //评论：page(分页信息、文章id、用户id、排序)
        IPage<CommentVo> results = commentService.selectComments(getPage(), postVo.getId(), null, "created");
        //req：CommentVo分页集合
        req.setAttribute("commentVoDatas", results);

        /**
         * 文章阅读【缓存实现访问量】：减少访问数据库的次数，存在一个BUG，只与点击链接的次数相关，没有与用户的id进行绑定
         */
        postService.putViewCount(postVo);

        return "post/detail";
    }
}

