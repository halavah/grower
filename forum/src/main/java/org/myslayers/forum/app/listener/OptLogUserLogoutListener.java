package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.OptLog;
import org.myslayers.forum.domain.repository.OptLogRepository;

import javax.annotation.Resource;

@Component
public class OptLogUserLogoutListener extends EventBus.EventHandler<OptLog> {

    @Resource
    private OptLogRepository optLogRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.USER_LOGOUT;
    }

    @Override
    public void onMessage(OptLog optLog) {
        optLogRepository.save(optLog);
    }
}
