package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.config.ConfigAddRequest;
import org.myslayers.forum.api.request.config.ConfigPageRequest;
import org.myslayers.forum.api.request.config.ConfigUpdateRequest;
import org.myslayers.forum.api.response.config.ConfigResponse;

import java.util.List;
import java.util.Set;

public interface ConfigApiService {
    
    ResultModel add(ConfigAddRequest request);

    ResultModel update(ConfigUpdateRequest request);

    ResultModel state(AdminBooleanRequest request);

    ResultModel<PageResponseModel<ConfigResponse>> page(PageRequestModel<ConfigPageRequest> pageRequestModel);
    
    ResultModel<List<ConfigResponse>> queryAvailable(Set<String> types);
}
