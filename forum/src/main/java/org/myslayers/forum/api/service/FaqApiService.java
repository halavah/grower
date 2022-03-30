package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.faq.*;
import org.myslayers.forum.api.response.faq.FaqHotsResponse;
import org.myslayers.forum.api.response.faq.FaqInfoResponse;
import org.myslayers.forum.api.response.faq.FaqUserPageResponse;

import java.util.List;

public interface FaqApiService {

    ResultModel<Long> saveFaq(FaqSaveFaqRequest request);

    ResultModel<PageResponseModel<FaqUserPageResponse>> adminPage(PageRequestModel<FaqAdminPageRequest> pageRequestModel);

    ResultModel<PageResponseModel<FaqUserPageResponse>> userPage(PageRequestModel<FaqUserPageRequest> pageRequestModel);

    ResultModel<PageResponseModel<FaqUserPageResponse>> authorPage(PageRequestModel<FaqAuthorPageRequest> pageRequestModel);

    ResultModel<FaqInfoResponse> info(Long id);

    ResultModel<List<FaqHotsResponse>> hots(int size);

    ResultModel solution(FaqSolutionRequest request);
}
