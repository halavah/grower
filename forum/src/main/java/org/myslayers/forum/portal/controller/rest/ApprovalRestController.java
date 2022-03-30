package org.myslayers.forum.portal.controller.rest;

import org.springframework.web.bind.annotation.*;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.service.ApprovalApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/approval-rest")
public class ApprovalRestController {

    @Resource
    private ApprovalApiService approvalApiService;

    @PostMapping("/create/{postsId}")
    public ResultModel create(@PathVariable Long postsId, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return approvalApiService.create(postsId);
    }

    @PostMapping("/delete/{postsId}")
    public ResultModel delete(@PathVariable Long postsId, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return approvalApiService.delete(postsId);
    }
}
