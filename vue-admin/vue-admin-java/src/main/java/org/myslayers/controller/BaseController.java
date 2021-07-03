package org.myslayers.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.config.utils.RedisUtil;
import org.myslayers.service.RoleService;
import org.myslayers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class BaseController {
    
    @Autowired
    HttpServletRequest req;
    
    @Autowired
    HttpServletResponse resp;
    
    @Autowired
    RedisUtil redisUtil;
    
    @Autowired
    UserService userService;
    
    @Autowired
    RoleService roleService;
    
    /**
     * 首页 -> 默认分页的基本信息
     */
    public Page getPage() {
        // pn代表起始页码
        int pn = ServletRequestUtils.getIntParameter(req, "pn", 1);
        // size代表页面大小
        int size = ServletRequestUtils.getIntParameter(req, "size", 10);
        return new Page(pn, size);
    }
}
