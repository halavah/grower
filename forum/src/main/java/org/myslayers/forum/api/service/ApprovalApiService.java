package org.myslayers.forum.api.service;

import org.myslayers.forum.api.model.ResultModel;

public interface ApprovalApiService {

    ResultModel<Long> create(Long postsId);

    ResultModel<Long> delete(Long postsId);

    ResultModel<Boolean> hasApproval(Long postsId);

}
