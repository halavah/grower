package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.service.SearchApiService;
import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.app.manager.SearchManager;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.PageRequestModelValidator;

import javax.annotation.Resource;


@Service
public class SearchApiServiceImpl implements SearchApiService {

    @Resource
    private SearchManager searchManager;

    @Override
    public ResultModel<PageResponseModel<PostsVO>> pagePostsSearch(PageRequestModel<String> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(searchManager.pagePostsSearch(pageRequestModel));
    }

}
