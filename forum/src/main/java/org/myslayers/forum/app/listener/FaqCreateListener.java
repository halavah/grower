package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Faq;
import org.myslayers.forum.domain.entity.Tag;
import org.myslayers.forum.domain.repository.TagRepository;

import javax.annotation.Resource;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class FaqCreateListener extends EventBus.EventHandler<Faq> {

    @Resource
    private TagRepository tagRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.FAQ_CREATE;
    }

    @Override
    public void onMessage(Faq faq) {
        Set<Long> tagIds = faq.getTags().stream().map(Tag::getId).collect(Collectors.toSet());
        tagRepository.increaseRefCount(tagIds);
    }
}
