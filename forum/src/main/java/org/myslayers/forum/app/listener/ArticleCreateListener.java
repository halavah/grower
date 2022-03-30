package org.myslayers.forum.app.listener;

import org.springframework.stereotype.Component;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Article;
import org.myslayers.forum.domain.entity.Tag;
import org.myslayers.forum.domain.repository.ArticleTypeRepository;
import org.myslayers.forum.domain.repository.TagRepository;

import javax.annotation.Resource;
import java.util.Set;
import java.util.stream.Collectors;

@Component
public class ArticleCreateListener extends EventBus.EventHandler<Article> {

    @Resource
    private TagRepository tagRepository;

    @Resource
    private ArticleTypeRepository articleTypeRepository;

    @Override
    public EventBus.Topic topic() {
        return EventBus.Topic.ARTICLE_CREATE;
    }

    @Override
    public void onMessage(Article article) {
        Set<Long> tagIds = article.getTags().stream().map(Tag::getId).collect(Collectors.toSet());
        tagRepository.increaseRefCount(tagIds);

        articleTypeRepository.increaseRefCount(article.getType().getId());
    }
}
