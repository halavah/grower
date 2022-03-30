package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.app.support.Pair;
import org.myslayers.forum.common.enums.*;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.entity.value.IdValue;
import org.myslayers.forum.domain.repository.MessageRepository;

import javax.annotation.Resource;

@Component
public class MessageUserFollowListener extends EventBus.EventHandler<Pair<Long>> {

    @Resource
    private MessageRepository messageRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.USER_FOLLOW;
    }

    @Override
    public void onMessage(Pair<Long> pair) {
        Long followed = pair.getValue0();
        Long follower = pair.getValue1();

        messageRepository.save(Message.builder()
                .channel(MessageChannelEn.STATION_LETTER)
                .type(MessageTypeEn.FOLLOW_USER)
                .receiver(IdValue.builder()
                        .id(followed.toString())
                        .type(IdValueTypeEn.USER_ID)
                        .build())
                .read(MessageReadEn.NO)
                .contentType(MessageContentTypeEn.TEXT)
                .content("")
                .sender(IdValue.builder()
                        .id(follower.toString())
                        .type(IdValueTypeEn.USER_ID)
                        .build())
                .title("")
                .build());
    }
}
