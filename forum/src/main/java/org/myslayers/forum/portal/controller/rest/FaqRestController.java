package org.myslayers.forum.portal.controller.rest;

import org.springframework.web.bind.annotation.*;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.faq.FaqSaveFaqRequest;
import org.myslayers.forum.api.request.faq.FaqSolutionRequest;
import org.myslayers.forum.api.response.faq.FaqInfoResponse;
import org.myslayers.forum.api.service.FaqApiService;
import org.myslayers.forum.common.constant.Constant;
import org.myslayers.forum.portal.support.WebUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;


@RestController
@RequestMapping("/faq-rest")
public class FaqRestController {

    @Resource
    private FaqApiService faqApiService;

    @PostMapping("/save")
    public ResultModel<Long> save(@RequestBody FaqSaveFaqRequest faqRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return faqApiService.saveFaq(faqRequest);
    }

    @PostMapping("/{id}")
    public ResultModel<FaqInfoResponse> get(@PathVariable("id") Long id, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));
        return faqApiService.info(id);
    }

    @PostMapping("/solution")
    public ResultModel solution(@RequestBody FaqSolutionRequest solutionRequest, HttpServletRequest request) {
        request.setAttribute(Constant.REQUEST_HEADER_TOKEN_KEY, WebUtil.cookieGetSid(request));

        return faqApiService.solution(solutionRequest);
    }
}
