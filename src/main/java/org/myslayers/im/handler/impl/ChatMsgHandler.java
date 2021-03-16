package org.myslayers.im.handler.impl;

import cn.hutool.json.JSONUtil;
import java.util.Date;
import lombok.extern.slf4j.Slf4j;
import org.myslayers.common.lang.Consts;
import org.myslayers.im.handler.MsgHandler;
import org.myslayers.im.handler.filter.ExculdeMineChannelContextFilter;
import org.myslayers.im.message.ChatImMess;
import org.myslayers.im.message.ChatOutMess;
import org.myslayers.im.vo.ImMess;
import org.myslayers.im.vo.ImTo;
import org.myslayers.im.vo.ImUser;
import org.myslayers.service.ChatService;
import org.myslayers.utils.SpringUtil;
import org.tio.core.ChannelContext;
import org.tio.core.Tio;
import org.tio.websocket.common.WsRequest;
import org.tio.websocket.common.WsResponse;

@Slf4j
public class ChatMsgHandler implements MsgHandler {
    @Override
    public void handler(String data, WsRequest wsRequest, ChannelContext channelContext) {
        ChatImMess chatImMess = JSONUtil.toBean(data, ChatImMess.class);

        ImUser mine = chatImMess.getMine();
        ImTo to = chatImMess.getTo();

        // 特殊处理？？

        ImMess imMess = new ImMess();
        imMess.setContent(mine.getContent());
        imMess.setAvatar(mine.getAvatar());
        imMess.setMine(false); // 是否是我发送的消息

        imMess.setUsername(mine.getUsername());
        imMess.setFromid(mine.getId());

        imMess.setId(Consts.IM_GROUP_ID);
        imMess.setTimestamp(new Date());
        imMess.setType(to.getType());


        ChatOutMess chatOutMess = new ChatOutMess();
        chatOutMess.setEmit("chatMessage");
        chatOutMess.setData(imMess);

        String result = JSONUtil.toJsonStr(chatOutMess);
        log.info("群聊消息----------> {}", result);

        WsResponse wsResponse = WsResponse.fromText(result, "utf-8");

        //过滤器：过滤当前用户，不需要发送消息
        ExculdeMineChannelContextFilter filter = new ExculdeMineChannelContextFilter();
        filter.setCurrentContext(channelContext);

        Tio.sendToGroup(channelContext.getGroupContext(), Consts.IM_GROUP_NAME, wsResponse, filter);

        //保存群聊信息
        ChatService chatService = (ChatService) SpringUtil.getBean("chatService");
        chatService.setGroupHistoryMsg(imMess);

    }
}
