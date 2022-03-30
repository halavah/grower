package org.myslayers.forum.facade.impl;

import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.service.ApprovalApiService;
import org.myslayers.forum.app.manager.ApprovalManager;
import org.myslayers.forum.facade.support.ResultModelUtil;

import javax.annotation.Resource;

@Service
public class ApprovalApiServiceImpl implements ApprovalApiService {

    @Resource
    private ApprovalManager approvalManager;

    @Override
    public ResultModel<Long> create(Long postsId) {
        return ResultModelUtil.success(approvalManager.create(postsId));
    }

    @Override
    public ResultModel<Long> delete(Long postsId) {
        return ResultModelUtil.success(approvalManager.delete(postsId));
    }

    @Override
    public ResultModel<Boolean> hasApproval(Long postsId) {
        return ResultModelUtil.success(approvalManager.hasApproval(postsId));
    }

}
