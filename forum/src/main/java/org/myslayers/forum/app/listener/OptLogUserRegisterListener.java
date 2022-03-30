package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.OptLog;
import org.myslayers.forum.domain.entity.User;
import org.myslayers.forum.domain.repository.OptLogRepository;

import javax.annotation.Resource;

@Component
public class OptLogUserRegisterListener extends EventBus.EventHandler<User> {

    @Resource
    private OptLogRepository optLogRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.USER_REGISTER;
    }

    @Override
    public void onMessage(User user) {

        // 保存操作记录
        optLogRepository.save(OptLog.createUserRegisterRecordLog(user.getId(), user));
    }
}
