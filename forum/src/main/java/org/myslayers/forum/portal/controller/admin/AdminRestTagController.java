package org.myslayers.forum.portal.controller.admin;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.tag.TagCreateRequest;
import org.myslayers.forum.api.request.tag.TagPageRequest;
import org.myslayers.forum.api.response.tag.TagPageResponse;
import org.myslayers.forum.api.service.TagApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/admin-rest/tag")
public class AdminRestTagController {

    @Resource
    private TagApiService tagApiService;

    @PostMapping("/page")
    public ResultModel<PageResponseModel<TagPageResponse>> page(@RequestBody PageRequestModel<TagPageRequest> pageRequestModel
            , HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return tagApiService.page(pageRequestModel);
    }

    @PostMapping("/audit-state")
    public ResultModel auditState(@RequestBody AdminBooleanRequest booleanRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return tagApiService.auditState(booleanRequest);
    }

    @PostMapping("/add")
    public ResultModel add(@RequestBody TagCreateRequest request) {
        return tagApiService.create(request);
    }

}
