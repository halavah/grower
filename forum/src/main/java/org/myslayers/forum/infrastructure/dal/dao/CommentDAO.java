package org.myslayers.forum.infrastructure.dal.dao;

import org.apache.ibatis.annotations.Param;
import org.myslayers.forum.infrastructure.dal.dataobject.CommentDO;

import java.util.List;
import java.util.Set;

public interface CommentDAO {

    CommentDO findByPrimaryKey(@Param("id") Long id);

    List<CommentDO> findByIds(@Param("ids") Set<Long> ids);

    void insert(CommentDO commentDO);

    void update(CommentDO commentDO);

    List<CommentDO> queryByPostsId(@Param("postsId") Long postsId);

    List<CommentDO> queryInReplyIds(@Param("commentIds") List<Long> commentIds);

    void deleteByPostsId(@Param("postsId") Long id);

    List<CommentDO> queryInIds(@Param("ids") Set<Long> ids);
}
