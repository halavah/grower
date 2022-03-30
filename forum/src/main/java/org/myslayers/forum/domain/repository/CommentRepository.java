package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Comment;

import java.util.List;
import java.util.Set;

public interface CommentRepository {

    void save(Comment comment);

    Comment get(Long id);

    List<Comment> queryByPostsId(Long postsId);

    List<Comment> queryInReplyIds(Set<Long> replyIds);

    PageResult<Comment> page(Integer pageNo, Integer pageSize, Long postsId);

    void deleteByPostsId(Long postsId);

    List<Comment> queryInIds(Set<Long> ids);
}
