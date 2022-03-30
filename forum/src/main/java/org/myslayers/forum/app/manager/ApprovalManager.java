package org.myslayers.forum.app.manager;

import org.springframework.stereotype.Component;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.app.support.LoginUserContext;
import org.myslayers.forum.app.support.Pair;
import org.myslayers.forum.common.enums.ErrorCodeEn;
import org.myslayers.forum.common.support.CheckUtil;
import org.myslayers.forum.common.support.EventBus;
import org.myslayers.forum.domain.entity.Approval;
import org.myslayers.forum.domain.entity.BasePosts;
import org.myslayers.forum.domain.repository.ApprovalRepository;
import org.myslayers.forum.domain.repository.PostsRepository;

import javax.annotation.Resource;

@Component
public class ApprovalManager {

    @Resource
    private ApprovalRepository approvalRepository;

    @Resource
    private PostsRepository postsRepository;

    @IsLogin
    public Long create(Long postsId) {
        Approval approval = approvalRepository.get(postsId, LoginUserContext.getUser().getId());
        CheckUtil.isNotEmpty(approval, ErrorCodeEn.REPEAT_OPERATION);

        BasePosts basePosts = postsRepository.get(postsId);
        CheckUtil.isEmpty(basePosts, ErrorCodeEn.POSTS_NOT_EXIST);

        approvalRepository.save(Approval.builder()
                .postsId(postsId)
                .userId(LoginUserContext.getUser().getId())
                .build());
        postsRepository.increaseApproval(postsId, basePosts.getUpdateAt());

        EventBus.emit(EventBus.Topic.APPROVAL_CREATE, Pair.build(LoginUserContext.getUser().getId(), postsId));

        return basePosts.getApprovals() + 1;
    }

    @IsLogin
    public Long delete(Long postsId) {
        Approval approval = approvalRepository.get(postsId, LoginUserContext.getUser().getId());
        CheckUtil.isEmpty(approval, ErrorCodeEn.OPERATION_DATA_NOT_EXIST);

        BasePosts basePosts = postsRepository.get(postsId);
        CheckUtil.isEmpty(basePosts, ErrorCodeEn.POSTS_NOT_EXIST);

        approvalRepository.delete(approval.getId());
        postsRepository.decreaseApproval(postsId, basePosts.getUpdateAt());

        return basePosts.getApprovals() - 1;
    }

    @IsLogin
    public Boolean hasApproval(Long postsId) {
        Approval approval = approvalRepository.get(postsId, LoginUserContext.getUser().getId());

        return approval != null;
    }

}
