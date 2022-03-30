package org.myslayers.forum.portal.controller.rest;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.comment.CommentCreateRequest;
import org.myslayers.forum.api.service.CommentApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/comment-rest")
public class CommentRestController {

    @Resource
    private CommentApiService commentApiService;

    @PostMapping("/create")
    public ResultModel create(@RequestBody CommentCreateRequest createRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return commentApiService.create(createRequest);
    }

}
