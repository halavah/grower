package org.myslayers.forum.portal.controller.admin;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.config.ConfigAddRequest;
import org.myslayers.forum.api.request.config.ConfigPageRequest;
import org.myslayers.forum.api.request.config.ConfigUpdateRequest;
import org.myslayers.forum.api.response.config.ConfigResponse;
import org.myslayers.forum.api.service.ConfigApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/admin-rest/config")
public class AdminRestConfigController {

    @Resource
    private ConfigApiService configApiService;

    @PostMapping("/add")
    public ResultModel add(@RequestBody ConfigAddRequest addRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return configApiService.add(addRequest);
    }

    @PostMapping("/update")
    public ResultModel update(@RequestBody ConfigUpdateRequest updateRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return configApiService.update(updateRequest);
    }

    @PostMapping("/state")
    public ResultModel state(@RequestBody AdminBooleanRequest booleanRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return configApiService.state(booleanRequest);
    }

    @PostMapping("/page")
    public ResultModel<PageResponseModel<ConfigResponse>> page(@RequestBody PageRequestModel<ConfigPageRequest> pageRequestModel, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return configApiService.page(pageRequestModel);
    }

}
