package org.myslayers.forum.app.manager;

import org.springframework.stereotype.Component;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.request.AdminBooleanRequest;
import org.myslayers.forum.api.request.config.ConfigAddRequest;
import org.myslayers.forum.api.request.config.ConfigPageRequest;
import org.myslayers.forum.api.request.config.ConfigUpdateRequest;
import org.myslayers.forum.api.response.config.ConfigResponse;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.app.support.LoginUserContext;
import org.myslayers.forum.app.support.PageUtil;
import org.myslayers.forum.app.transfer.ConfigTransfer;
import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.enums.UserRoleEn;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.domain.entity.Config;
import org.myslayers.forum.domain.repository.ConfigRepository;

import javax.annotation.Resource;
import java.util.List;
import java.util.Set;


@Component
public class ConfigManager {

    @Resource
    private ConfigRepository configRepository;

    @IsLogin(role = UserRoleEn.ADMIN)
    public void add(ConfigAddRequest request) {
        Config config = ConfigTransfer.toConfig(request);
        config.setCreator(LoginUserContext.getUser().getId());

        configRepository.save(config);
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    public void update(ConfigUpdateRequest request) {
        Config config = configRepository.get(request.getId());
        CheckUtil.isEmpty(config, ErrorCodeEn.CONFIG_NOT_EXIST);

        ConfigTransfer.update(config, request);
        configRepository.update(config);
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    public void state(AdminBooleanRequest request) {
        Config config = configRepository.get(request.getId());
        CheckUtil.isEmpty(config, ErrorCodeEn.CONFIG_NOT_EXIST);

        config.setState(request.getIs() ? AuditStateEn.PASS : AuditStateEn.REJECT);
        configRepository.update(config);
    }

    @IsLogin(role = UserRoleEn.ADMIN)
    public PageResponseModel<ConfigResponse> page(PageRequestModel<ConfigPageRequest> pageRequestModel) {
        ConfigPageRequest request = pageRequestModel.getFilter();

        PageResult<Config> pageResult = configRepository.page(PageUtil.buildPageRequest(pageRequestModel, ConfigTransfer.toConfig(request)));

        return PageResponseModel.build(pageResult.getTotal(), pageResult.getSize(), ConfigTransfer.toConfigResponses(pageResult.getList()));
    }

    public List<ConfigResponse> queryAvailable(Set<String> types) {
        return ConfigTransfer.toConfigResponses(configRepository.queryAvailable(types));
    }
}
