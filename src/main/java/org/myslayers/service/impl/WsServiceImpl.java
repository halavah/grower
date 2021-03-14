package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.myslayers.entity.UserMessage;
import org.myslayers.service.UserMessageService;
import org.myslayers.service.WsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class WsServiceImpl implements WsService {

    @Autowired
    UserMessageService messageService;

    @Autowired
    SimpMessagingTemplate messagingTemplate;    //Spring自带的【消息模板】

    @Async  //异步消息
    @Override
    public void sendMessCountToUser(Long toUserId) {
        int count = messageService.count(new QueryWrapper<UserMessage>()
            .eq("to_user_id", toUserId) //全部数量的消息
            .eq("status", "0")      //未读的消息  未读0 已读1
        );

        // websocket 使用 messagingTemplate模板 进行通知，拼凑结果url为：/user/20/messCount/
        // super.convertAndSend(this.destinationPrefix + user + destination, payload, headers, postProcessor);
        messagingTemplate.convertAndSendToUser(toUserId.toString(), "/messCount", count);
    }
}
