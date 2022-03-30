package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.app.support.Pair;
import org.myslayers.forum.common.enums.*;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.BasePosts;
import org.myslayers.forum.domain.entity.Message;
import org.myslayers.forum.domain.entity.value.IdValue;
import org.myslayers.forum.domain.repository.MessageRepository;
import org.myslayers.forum.domain.repository.PostsRepository;

import javax.annotation.Resource;

@Component
public class MessageApprovalCreateListener extends EventBus.EventHandler<Pair<Long>> {

    @Resource
    private MessageRepository messageRepository;

    @Resource
    private PostsRepository postsRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.APPROVAL_CREATE;
    }

    @Override
    public void onMessage(Pair<Long> pair) {
        Long userId = pair.getValue0();
        Long postsId = pair.getValue1();

        BasePosts basePosts = postsRepository.get(postsId);
        if (ObjectUtils.isEmpty(basePosts)) {
            return;
        }

        Message message = Message.builder()
                .channel(MessageChannelEn.STATION_LETTER)
                .receiver(IdValue.builder()
                        .id(basePosts.getAuthorId().toString())
                        .type(IdValueTypeEn.USER_ID)
                        .build())
                .read(MessageReadEn.NO)
                .contentType(MessageContentTypeEn.TEXT)
                .title(postsId.toString())
                .content("")
                .sender(IdValue.builder()
                        .id(userId.toString())
                        .type(IdValueTypeEn.USER_ID)
                        .build())
                .build();
        if (PostsCategoryEn.ARTICLE.equals(basePosts.getCategory())) {
            message.setType(MessageTypeEn.APPROVAL_ARTICLE);
        } else if (PostsCategoryEn.FAQ.equals(basePosts.getCategory())) {
            message.setType(MessageTypeEn.APPROVAL_FAQ);
        } else {
            return;
        }

        messageRepository.save(message);
    }
}
