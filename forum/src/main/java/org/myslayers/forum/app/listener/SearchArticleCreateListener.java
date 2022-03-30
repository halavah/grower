package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.enums.SearchTypeEn;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Article;
import org.myslayers.forum.domain.entity.Search;
import org.myslayers.forum.domain.service.SearchService;

import javax.annotation.Resource;

@Component
public class SearchArticleCreateListener extends EventBus.EventHandler<Article> {

    @Resource
    private SearchService searchService;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.ARTICLE_CREATE;
    }

    @Override
    public void onMessage(Article article) {
        searchService.deleteByPostsId(article.getId());

        searchService.save(Search.builder()
                .content(article.getMarkdownContent())
                .entityId(article.getId())
                .title(article.getTitle())
                .type(SearchTypeEn.POSTS)
                .build());
    }
}
