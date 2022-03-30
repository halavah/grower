package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.enums.MessageChannelEn;
import org.myslayers.forum.common.enums.MessageTypeEn;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.entity.User;
import org.myslayers.forum.domain.service.MessageService;

import javax.annotation.Resource;

@Component
public class NotifyAdminUserRegisterListener extends EventBus.EventHandler<User> {

    @Resource
    private MessageService messageService;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.USER_REGISTER;
    }

    @Override
    public void onMessage(User user) {

        // 发送消息通知
        messageService.send(Message.builder()
                .channel(MessageChannelEn.MAIL)
                .type(MessageTypeEn.USER_REGISTER_NOTIFY_ADMIN)
//                .sender(IdValue.builder()
//                        .id()
//                        .name()
//                        .type(IdValueTypeEn.MAIL)
//                        .build())
//                .receiver(IdValue.builder()
//                        .id()
//                        .name()
//                        .type(IdValueTypeEn.MAIL)
//                        .build())
                .title("")
                .content("")
                .build());
    }
}
