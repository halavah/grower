package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.tag.TagCreateRequest;
import org.myslayers.forum.api.request.tag.TagPageRequest;
import org.myslayers.forum.api.response.tag.TagPageResponse;
import org.myslayers.forum.api.response.tag.TagQueryResponse;
import org.myslayers.forum.api.vo.PostsVO;

import java.util.List;
import java.util.Set;

public interface TagApiService {

    ResultModel<List<TagQueryResponse>> queryAllRef();

    ResultModel create(TagCreateRequest request);

    ResultModel<TagQueryResponse> getByName(String name);

    ResultModel<List<TagQueryResponse>> queryAll();

    ResultModel<List<TagQueryResponse>> queryInIds(Set<Long> ids);

    ResultModel<PageResponseModel<PostsVO>> pagePosts(PageRequestModel<Long> pageRequestModel);

    ResultModel<PageResponseModel<PostsVO>> pagePostsByTagIds(PageRequestModel<Set<Long>> pageRequestModel);

    ResultModel<PageResponseModel<TagPageResponse>> page(PageRequestModel<TagPageRequest> pageRequestModel);

    ResultModel auditState(AdminBooleanRequest booleanRequest);
}
