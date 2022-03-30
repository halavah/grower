package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.app.support.Pair;
import org.myslayers.forum.common.enums.SearchTypeEn;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Article;
import org.myslayers.forum.domain.entity.Search;
import org.myslayers.forum.domain.service.SearchService;

import javax.annotation.Resource;

@Component
public class SearchArticleUpdateListener  extends EventBus.EventHandler<Pair<Article>> {

    @Resource
    private SearchService searchService;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.ARTICLE_UPDATE;
    }

    @Override
    public void onMessage(Pair<Article> pair) {
        Article newArticle = pair.getValue1();

        searchService.deleteByPostsId(newArticle.getId());

        searchService.save(Search.builder()
                .content(newArticle.getMarkdownContent())
                .entityId(newArticle.getId())
                .title(newArticle.getTitle())
                .type(SearchTypeEn.POSTS)
                .build());
    }
}
