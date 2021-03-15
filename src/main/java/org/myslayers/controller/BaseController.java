package org.myslayers.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import javax.servlet.http.HttpServletRequest;
import org.apache.shiro.SecurityUtils;
import org.myslayers.service.CategoryService;
import org.myslayers.service.CommentService;
import org.myslayers.service.PostService;
import org.myslayers.service.SearchService;
import org.myslayers.service.UserCollectionService;
import org.myslayers.service.UserMessageService;
import org.myslayers.service.UserService;
import org.myslayers.service.WsService;
import org.myslayers.shiro.AccountProfile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;

@Component
public class BaseController {

    @Autowired
    HttpServletRequest req;

    @Autowired
    UserService userService;

    // 内容（一条 + 多条）（post实体类、PostVo实体类）
    @Autowired
    PostService postService;

    // 评论（comment实体类）
    @Autowired
    CommentService commentService;

    @Autowired
    UserMessageService messageService;

    @Autowired
    UserCollectionService collectionService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    WsService wsService;

    @Autowired
    SearchService searchService;

    /**
     * 首页 -> 默认分页的基本信息
     */
    public Page getPage() {
        // pn代表起始页码
        int pn = ServletRequestUtils.getIntParameter(req, "pn", 1);
        // size代表页面大小
        int size = ServletRequestUtils.getIntParameter(req, "size", 5);
        return new Page(pn, size);
    }

    /**
     * 个人用户中心 -> 获取当前用户的基本信息
     */
    public AccountProfile getProfile() {
        return ((AccountProfile) SecurityUtils.getSubject().getPrincipal());
    }

    /**
     * 个人用户中心 -> 获取当前用户的基本信息-获取id
     */
    public Long getProfileId() {
        return getProfile().getId();
    }

}