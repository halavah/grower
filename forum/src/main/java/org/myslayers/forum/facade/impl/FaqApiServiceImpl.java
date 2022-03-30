package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.faq.*;
import org.myslayers.forum.api.response.faq.FaqHotsResponse;
import org.myslayers.forum.api.response.faq.FaqInfoResponse;
import org.myslayers.forum.api.response.faq.FaqUserPageResponse;
import org.myslayers.forum.api.service.FaqApiService;
import org.myslayers.forum.app.manager.FaqManager;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.common.enums.UserRoleEn;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.FaqValidator;
import org.myslayers.forum.facade.validator.PageRequestModelValidator;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FaqApiServiceImpl implements FaqApiService {

    @Resource
    private FaqManager faqManager;

    @Override
    public ResultModel<Long> saveFaq(FaqSaveFaqRequest request) {
        FaqValidator.saveFaq(request);

        return ResultModelUtil.success(faqManager.saveFaq(request));
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    @Override
    public ResultModel<PageResponseModel<FaqUserPageResponse>> adminPage(PageRequestModel<FaqAdminPageRequest> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(faqManager.adminPage(pageRequestModel));
    }

    @Override
    public ResultModel<PageResponseModel<FaqUserPageResponse>> userPage(PageRequestModel<FaqUserPageRequest> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(faqManager.userPage(pageRequestModel));
    }

    @Override
    public ResultModel<PageResponseModel<FaqUserPageResponse>> authorPage(PageRequestModel<FaqAuthorPageRequest> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(faqManager.authorPage(pageRequestModel));
    }

    @Override
    public ResultModel<FaqInfoResponse> info(Long id) {
        return ResultModelUtil.success(faqManager.info(id));
    }

    @Override
    public ResultModel<List<FaqHotsResponse>> hots(int size) {
        return ResultModelUtil.success(faqManager.hots(size));
    }

    @Override
    public ResultModel solution(FaqSolutionRequest request) {
        FaqValidator.solution(request);

        faqManager.solution(request);

        return ResultModelUtil.success();
    }
}
