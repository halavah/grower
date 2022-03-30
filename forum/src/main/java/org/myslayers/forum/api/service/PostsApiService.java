package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.vo.PostsVO;

public interface PostsApiService {

    ResultModel delete(Long id);

    ResultModel<PageResponseModel<PostsVO>> pagePostsFood(PageRequestModel pageRequestModel);

    ResultModel auditState(AdminBooleanRequest booleanRequest);
}
