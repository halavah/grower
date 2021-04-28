package org.myslayers.controller;


import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.myslayers.service.PostService;
import org.myslayers.service.UserService;
import org.myslayers.shiro.AccountProfile;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;

@Component
public class BaseController {

    @Autowired
    HttpServletRequest req;

    @Autowired
    HttpServletResponse resp;

    @Autowired
    UserService userService;

    @Autowired
    PostService postService;

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
     * 获取当前登录用户
     */
    public static AccountProfile getProfile() {
        AccountProfile accountProfile = (AccountProfile) SecurityUtils.getSubject().getPrincipal();
        return accountProfile;
    }
}