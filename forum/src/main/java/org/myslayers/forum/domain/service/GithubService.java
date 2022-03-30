package org.myslayers.forum.domain.service;

import com.alibaba.fastjson.JSONObject;

public interface GithubService {

    JSONObject getUserInfo(String code);

}
