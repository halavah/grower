package org.myslayers.forum.portal.controller.rest;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.service.MessageApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/message-rest")
public class MessageRestController {

    @Resource
    private MessageApiService messageApiService;

    @PostMapping("/mark-is-read/{id}")
    public ResultModel delete(@PathVariable("id") Long id, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return messageApiService.markIsRead(id);
    }


}
