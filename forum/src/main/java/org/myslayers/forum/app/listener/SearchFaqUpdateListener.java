package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.app.support.Pair;
import org.myslayers.forum.common.enums.SearchTypeEn;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Faq;
import org.myslayers.forum.domain.entity.Search;
import org.myslayers.forum.domain.service.SearchService;

import javax.annotation.Resource;

@Component
public class SearchFaqUpdateListener extends EventBus.EventHandler<Pair<Faq>> {

    @Resource
    private SearchService searchService;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.FAQ_UPDATE;
    }

    @Override
    public void onMessage(Pair<Faq> pair) {
        Faq newFaq = pair.getValue1();

        searchService.deleteByPostsId(newFaq.getId());

        searchService.save(Search.builder()
                .content(newFaq.getMarkdownContent())
                .entityId(newFaq.getId())
                .title(newFaq.getTitle())
                .type(SearchTypeEn.POSTS)
                .build());
    }
}
