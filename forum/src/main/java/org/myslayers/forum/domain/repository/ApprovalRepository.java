package org.myslayers.forum.domain.repository;

import org.myslayers.forum.domain.entity.Approval;

public interface ApprovalRepository {

    void save(Approval approval);

    void delete(Long approvalId);

    Approval get(Long postsId, Long userId);

}
