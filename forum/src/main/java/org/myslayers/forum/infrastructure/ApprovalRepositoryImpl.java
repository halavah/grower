package org.myslayers.forum.infrastructure;

import org.springframework.stereotype.Repository;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.common.enums.FollowedTypeEn;
import org.myslayers.forum.domain.entity.Approval;
import org.myslayers.forum.domain.repository.ApprovalRepository;
import org.myslayers.forum.infrastructure.dal.dao.UserFollowDAO;
import org.myslayers.forum.infrastructure.dal.dataobject.UserFollowDO;
import org.myslayers.forum.infrastructure.transfer.ApprovalTransfer;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class ApprovalRepositoryImpl implements ApprovalRepository {

    @Resource
    private UserFollowDAO userFollowDAO;

    @Override
    public void save(Approval approval) {
        UserFollowDO userFollowDO = ApprovalTransfer.toUserFollowDO(approval);
        userFollowDO.initBase();

        userFollowDAO.insert(userFollowDO);
    }

    @Override
    public void delete(Long approvalId) {
        userFollowDAO.delete(approvalId);
    }

    @Override
    public Approval get(Long postsId, Long userId) {
        List<UserFollowDO> userFollowDOS = userFollowDAO.query(UserFollowDO.builder()
                .follower(userId)
                .followed(postsId)
                .followedType(FollowedTypeEn.POSTS.getValue())
                .build());
        if (ObjectUtils.isEmpty(userFollowDOS)) {
            return null;
        }

        return ApprovalTransfer.toApproval(userFollowDOS.get(0));
    }
}
