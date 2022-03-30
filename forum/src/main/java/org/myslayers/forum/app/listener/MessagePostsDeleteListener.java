package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.enums.MessageTypeEn;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.BasePosts;
import org.myslayers.forum.domain.repository.MessageRepository;

import javax.annotation.Resource;
import java.util.Arrays;

@Component
public class MessagePostsDeleteListener extends EventBus.EventHandler<BasePosts> {

    @Resource
    private MessageRepository messageRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.POSTS_DELETE;
    }

    @Override
    public void onMessage(BasePosts basePosts) {
        messageRepository.deleteInTypesAndTitle(Arrays.asList(MessageTypeEn.APPROVAL_ARTICLE
                , MessageTypeEn.APPROVAL_FAQ
                , MessageTypeEn.COMMENT_ARTICLE
                , MessageTypeEn.COMMENT_FAQ), basePosts.getId().toString());
    }
}
