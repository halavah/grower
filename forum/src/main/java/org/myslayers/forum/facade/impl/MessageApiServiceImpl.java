package org.myslayers.forum.facade.impl;

import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Service;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.model.ResultModel;
import org.myslayers.forum.api.request.message.MessagePageRequest;
import org.myslayers.forum.api.response.message.MessagePageResponse;
import org.myslayers.forum.api.service.MessageApiService;
import org.myslayers.forum.app.manager.MessageManager;
import org.myslayers.forum.facade.support.ResultModelUtil;
import org.myslayers.forum.facade.validator.MessageValidator;
import org.myslayers.forum.facade.validator.PageRequestModelValidator;

import javax.annotation.Resource;

@Service
public class MessageApiServiceImpl implements MessageApiService {

    @Resource
    private MessageManager messageManager;

    @Override
    public ResultModel<PageResponseModel<MessagePageResponse>> page(PageRequestModel<MessagePageRequest> pageRequestModel) {
        PageRequestModelValidator.validator(pageRequestModel);
        pageRequestModel.setFilter(JSON.parseObject(JSON.toJSONString(pageRequestModel.getFilter()), MessagePageRequest.class));
        MessageValidator.page(pageRequestModel.getFilter());

        return ResultModelUtil.success(messageManager.page(pageRequestModel));
    }

    @Override
    public ResultModel markIsRead(Long messageId) {
        messageManager.markIsRead(messageId);

        return ResultModelUtil.success();
    }

    @Override
    public ResultModel<Long> countUnRead() {
        return ResultModelUtil.success(messageManager.countUnRead());
    }
}
