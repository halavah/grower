package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Article;
import org.myslayers.forum.domain.entity.value.PostsPageQueryValue;

public interface ArticleRepository {

    void save(Article article);

    Article get(Long id);

    void update(Article article);

    PageResult<Article> page(Integer pageNo, Integer pageSize, PostsPageQueryValue pageQueryValue);
}
