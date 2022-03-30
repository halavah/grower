package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.github.GithubOauthLoginRequest;

public interface GithubApiService {

    ResultModel<String> oauthLogin(GithubOauthLoginRequest request);

}
