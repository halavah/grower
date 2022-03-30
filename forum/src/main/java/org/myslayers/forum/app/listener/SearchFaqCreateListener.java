package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.enums.SearchTypeEn;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Faq;
import org.myslayers.forum.domain.entity.Search;
import org.myslayers.forum.domain.service.SearchService;

import javax.annotation.Resource;

@Component
public class SearchFaqCreateListener extends EventBus.EventHandler<Faq> {

    @Resource
    private SearchService searchService;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.FAQ_CREATE;
    }

    @Override
    public void onMessage(Faq faq) {
        searchService.deleteByPostsId(faq.getId());

        searchService.save(Search.builder()
                .content(faq.getMarkdownContent())
                .entityId(faq.getId())
                .title(faq.getTitle())
                .type(SearchTypeEn.POSTS)
                .build());
    }
}
