package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.enums.AuditStateEn;
import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Posts;
import org.myslayers.forum.domain.entity.Tag;

import java.util.List;
import java.util.Set;

public interface TagRepository {

    void save(Tag tag);

    List<Tag> query(Tag tag);

    List<Tag> queryByIds(Set<Long> ids);

    List<Tag> queryByState(AuditStateEn auditState);

    void deletePostsMapping(Long articleId);

    void increaseRefCount(Set<Long> ids);

    void decreaseRefCount(Set<Long> ids);

    Tag getByNameAndState(String name, AuditStateEn pass);

    PageResult<Posts> pagePosts(PageRequest<Long> longPageRequest);

    PageResult<Posts> pagePostsByTagIds(PageRequest<Set<Long>> pageRequest);

    PageResult<Tag> page(PageRequest<Tag> tagPageRequest);

    Tag get(Long id);

    void update(Tag tag);
}
