package org.myslayers.controller;

import org.myslayers.common.lang.Result;
import org.myslayers.entity.Post;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdminController extends BaseController {

    /**
     * 访问 /post/{id} 的文章时，如果为 admin 超级管理员，则可以管理该文章，例如【删除】、【置顶】、【加精】
     *
     * 实现思路：
     * 1.AccountRealm.java 中的 doGetAuthorizationInfo() 方法 -> 授权 id = 1 的用户 admin 为 超级管理员
     * 2.detail.ftl 页面，使用<@shiro.hasRole name="admin"></@shiro>标签对【删除】、【置顶】、【加精】进行处理，因此，该功能只能【登录admin超级管理员账户】
     * 3.根据前端传来的 3 个参数：id、rank、field，对功能进行实现
     *
     * @param id    post.id
     * @param rank  0表示取消（取消置顶、取消加精），1表示操作（删除、置顶、加精）
     * @param field 操作类型：删除（field：delete）、置顶（field：stick）、加精（field：status）
     */
    @ResponseBody
    @PostMapping("/admin/jie-set")
    public Result jetSet(Long id, Integer rank, String field) {
        //根据id判断该文章是否被删除
        Post post = postService.getById(id);
        Assert.notNull(post, "该文章已被删除");

        //删除
        if ("delete".equals(field)) {
            postService.removeById(id);
            return Result.success();
        } else if ("status".equals(field)) {
            //置顶
            post.setRecommend(rank == 1);
        } else if ("stick".equals(field)) {
            //加精
            post.setLevel(rank);
        }

        postService.updateById(post);
        return Result.success();
    }
}
