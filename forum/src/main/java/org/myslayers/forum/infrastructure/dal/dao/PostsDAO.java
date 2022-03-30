package org.myslayers.forum.infrastructure.dal.dao;

import org.apache.ibatis.annotations.Param;
import org.myslayers.forum.domain.entity.value.PostsPageQueryValue;
import org.myslayers.forum.infrastructure.dal.dataobject.PostsDO;

import java.util.Date;
import java.util.List;
import java.util.Set;

public interface PostsDAO {

    void insert(PostsDO postsDO);

    List<PostsDO> query(PostsDO postsDO);

    List<PostsDO> queryByValue(PostsPageQueryValue pageQueryValue);

    void update(PostsDO postsDO);

    PostsDO get(Long id);

    void increaseComments(@Param("id") Long id, @Param("updateAt") Date updateAt);

    void decreaseComments(@Param("id") Long id, @Param("updateAt") Date updateAt);

    void increaseViews(@Param("id") Long id, @Param("updateAt") Date updateAt);

    List<PostsDO> queryOrderViews(@Param("category") String category, @Param("auditState") String auditState);

    List<PostsDO> queryInIds(@Param("ids") Set<Long> ids);

    List<PostsDO> queryInIdsAndState(@Param("ids") Set<Long> ids, @Param("auditState") String auditState);

    void delete(Long id);

    void increaseApproval(@Param("id") Long id, @Param("updateAt") Date updateAt);

    void decreaseApproval(@Param("id") Long id, @Param("updateAt") Date updateAt);

    List<Long> getAllIdByAuthorId(@Param("authorId") Long authorId, @Param("auditState") String auditState);
}
