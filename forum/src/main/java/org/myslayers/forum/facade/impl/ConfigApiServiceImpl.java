package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.config.ConfigAddRequest;
import org.myslayers.forum.api.request.config.ConfigPageRequest;
import org.myslayers.forum.api.request.config.ConfigUpdateRequest;
import org.myslayers.forum.api.response.config.ConfigResponse;
import org.myslayers.forum.api.service.ConfigApiService;
import org.myslayers.forum.app.manager.ConfigManager;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.PageRequestModelValidator;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;

@Service
public class ConfigApiServiceImpl implements ConfigApiService {

    @Resource
    private ConfigManager configManager;

    @Override
    public ResultModel add(ConfigAddRequest request) {

        configManager.add(request);

        return ResultModelUtil.success();
    }

    @Override
    public ResultModel update(ConfigUpdateRequest request) {

        configManager.update(request);

        return ResultModelUtil.success();
    }

    @Override
    public ResultModel state(AdminBooleanRequest request) {

        configManager.state(request);

        return ResultModelUtil.success();
    }

    @Override
    public ResultModel<PageResponseModel<ConfigResponse>> page(PageRequestModel<ConfigPageRequest> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);

        return ResultModelUtil.success(configManager.page(pageRequestModel));
    }

    @Override
    public ResultModel<List<ConfigResponse>> queryAvailable(Set<String> types) {

        return ResultModelUtil.success(configManager.queryAvailable(types));
    }
}
