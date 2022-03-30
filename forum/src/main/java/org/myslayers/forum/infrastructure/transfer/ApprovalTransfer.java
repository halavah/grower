package org.myslayers.forum.infrastructure.transfer;

import org.myslayers.forum.common.enums.FollowedTypeEn;
import org.myslayers.forum.domain.entity.Approval;
import org.myslayers.forum.infrastructure.dal.dataobject.UserFollowDO;

public class ApprovalTransfer {

    public static UserFollowDO toUserFollowDO(Approval approval) {
        return UserFollowDO.builder()
                .followedType(FollowedTypeEn.POSTS.getValue())
                .followed(approval.getPostsId())
                .follower(approval.getUserId())
                .build();
    }

    public static Approval toApproval(UserFollowDO userFollowDO) {
        Approval approval = Approval.builder()
                .userId(userFollowDO.getFollower())
                .postsId(userFollowDO.getFollowed())
                .build();
        approval.setCreateAt(userFollowDO.getCreateAt());
        approval.setId(userFollowDO.getId());
        approval.setUpdateAt(userFollowDO.getUpdateAt());

        return approval;
    }
}
