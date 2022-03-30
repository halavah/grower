package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.tag.TagCreateRequest;
import org.myslayers.forum.api.request.tag.TagPageRequest;
import org.myslayers.forum.api.response.tag.TagPageResponse;
import org.myslayers.forum.api.response.tag.TagQueryResponse;
import org.myslayers.forum.api.service.TagApiService;
import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.app.manager.TagManager;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.ArticleValidator;
import org.myslayers.forum.facade.validator.PageRequestModelValidator;
import org.myslayers.forum.facade.validator.TagValidator;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Service
public class TagApiServiceImpl implements TagApiService {

    @Resource
    private TagManager tagManager;

    @Override
    public ResultModel<List<TagQueryResponse>> queryAllRef() {
        return ResultModelUtil.success(tagManager.queryAllRef());
    }

    @Override
    public ResultModel create(TagCreateRequest request) {
        TagValidator.create(request);

        tagManager.create(request);

        return ResultModelUtil.success();
    }

    @Override
    public ResultModel<TagQueryResponse> getByName(String name) {
        return ResultModelUtil.success(tagManager.getByName(name));
    }

    @Override
    public ResultModel<List<TagQueryResponse>> queryAll() {
        return ResultModelUtil.success(tagManager.queryAll());
    }

    @Override
    public ResultModel<List<TagQueryResponse>> queryInIds(Set<Long> ids) {
        CheckUtil.checkParamToast(ids, "ids");

        return ResultModelUtil.success(tagManager.queryInIds(ids));
    }

    @Override
    public ResultModel<PageResponseModel<PostsVO>> pagePosts(PageRequestModel<Long> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(tagManager.pagePosts(pageRequestModel));
    }

    @Override
    public ResultModel<PageResponseModel<PostsVO>> pagePostsByTagIds(PageRequestModel<Set<Long>> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(tagManager.pagePostsByTagIds(pageRequestModel));
    }

    @Override
    public ResultModel<PageResponseModel<TagPageResponse>> page(PageRequestModel<TagPageRequest> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(tagManager.page(pageRequestModel));
    }

    @Override
    public ResultModel auditState(AdminBooleanRequest booleanRequest) {
        ArticleValidator.validatorBooleanRequest(booleanRequest);

        tagManager.tagAuditState(booleanRequest);

        return ResultModelUtil.success();
    }
}
