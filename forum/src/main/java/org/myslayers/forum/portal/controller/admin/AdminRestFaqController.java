package org.myslayers.forum.portal.controller.admin;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.faq.FaqAdminPageRequest;
import org.myslayers.forum.api.response.faq.FaqUserPageResponse;
import org.myslayers.forum.api.service.FaqApiService;
import org.myslayers.forum.api.service.PostsApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/admin-rest/faq")
public class AdminRestFaqController {

    @Resource
    private FaqApiService faqApiService;

    @Resource
    private PostsApiService postsApiService;
    
    @PostMapping("/page")
    public ResultModel<PageResponseModel<FaqUserPageResponse>> page(@RequestBody PageRequestModel<FaqAdminPageRequest> pageRequestModel
            , HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));
        return faqApiService.adminPage(pageRequestModel);
    }

    @PostMapping("/audit-state")
    public ResultModel auditState(@RequestBody AdminBooleanRequest booleanRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return postsApiService.auditState(booleanRequest);
    }

}
