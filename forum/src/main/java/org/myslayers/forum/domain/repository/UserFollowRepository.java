package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.enums.FollowedTypeEn;

import java.util.List;

public interface UserFollowRepository {

    List<Long> getAllFollowerIds(Long follower, FollowedTypeEn type);
}
