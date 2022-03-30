package org.myslayers.forum.infrastructure;

import org.springframework.stereotype.Repository;
import org.myslayers.forum.common.enums.FollowedTypeEn;
import org.myslayers.forum.domain.repository.UserFollowRepository;
import org.myslayers.forum.infrastructure.dal.dao.UserFollowDAO;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class UserFollowRepositoryImpl implements UserFollowRepository {

    @Resource
    private UserFollowDAO userFollowDAO;

    @Override
    public List<Long> getAllFollowerIds(Long follower, FollowedTypeEn type) {
        return userFollowDAO.getAllFollowerIds(follower, type.getValue());
    }
}
