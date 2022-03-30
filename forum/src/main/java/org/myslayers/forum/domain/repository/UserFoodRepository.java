package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Posts;
import org.myslayers.forum.domain.entity.UserFood;

import java.util.List;

public interface UserFoodRepository {

    void batchSave(List<UserFood> userFoods);

    PageResult<Posts> pagePosts(PageRequest<Long> pageRequest);

    void deleteByPostsId(Long postsId);
}
