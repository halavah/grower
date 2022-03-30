package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.github.GithubOauthLoginRequest;
import org.myslayers.forum.api.service.GithubApiService;
import org.myslayers.forum.app.manager.GithubManager;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.facade.support.ResultModelUtil;

import javax.annotation.Resource;

@Service
public class GithubApiServiceImpl implements GithubApiService {

    @Resource
    private GithubManager githubManager;

    @Override
    public ResultModel<String> oauthLogin(GithubOauthLoginRequest request) {
        CheckUtil.checkParamToast(request, "request");
        CheckUtil.checkParamToast(request.getCode(), "code");

        return ResultModelUtil.success(githubManager.oauthLogin(request));
    }
}
