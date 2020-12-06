package org.myslayers.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;

@Component
public class BaseController {
    @Autowired
    HttpServletRequest req;

    @Autowired
    PostService postService;

    public Page getPage() {
        int pn = ServletRequestUtils.getIntParameter(req, "pn", 1);
        int size = ServletRequestUtils.getIntParameter(req, "size", 2);
        return new Page(pn, size);
    }
}


