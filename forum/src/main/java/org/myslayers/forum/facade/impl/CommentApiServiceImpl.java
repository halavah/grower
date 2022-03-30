package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.comment.CommentCreateRequest;
import org.myslayers.forum.api.response.comment.CommentPageResponse;
import org.myslayers.forum.api.service.CommentApiService;
import org.myslayers.forum.app.manager.CommentManager;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.CommentValidator;
import org.myslayers.forum.facade.validator.PageRequestModelValidator;

import javax.annotation.Resource;

@Service
public class CommentApiServiceImpl implements CommentApiService {

    @Resource
    private CommentManager commentManager;

    @Override
    public ResultModel create(CommentCreateRequest request) {
        CommentValidator.create(request);

        commentManager.create(request);

        return ResultModelUtil.success();
    }

    @Override
    public ResultModel<PageResponseModel<CommentPageResponse>> page(PageRequestModel<Long> pageRequest) {
        PageRequestModelValidator.validator(pageRequest);

        return ResultModelUtil.success(commentManager.page(pageRequest));
    }
}
