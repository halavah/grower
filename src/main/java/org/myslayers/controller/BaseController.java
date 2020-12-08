package org.myslayers.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.service.CommentService;
import org.myslayers.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.ServletRequestUtils;

import javax.servlet.http.HttpServletRequest;

@Component
public class BaseController {
    @Autowired
    HttpServletRequest req;

    // 内容（一条 + 多条）（post实体类、PostVo实体类）
    @Autowired
    PostService postService;

    // 评论（comment实体类）
    @Autowired
    CommentService commentService;

    /**
     * 首页 -> 默认分页的基本信息
     */
    public Page getPage() {
        // pn代表起始页码
        int pn = ServletRequestUtils.getIntParameter(req, "pn", 1);
        // size代表页面大小
        int size = ServletRequestUtils.getIntParameter(req, "size", 8);
        return new Page(pn, size);
    }
}


