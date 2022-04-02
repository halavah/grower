package org.myslayers.im.handler.impl;

import org.myslayers.im.handler.MsgHandler;
import org.tio.core.ChannelContext;
import org.tio.websocket.common.WsRequest;

public class PingMsgHandler implements MsgHandler {

    @Override
    public void handler(String data, WsRequest wsRequest, ChannelContext channelContext) {
        System.out.println("ping~~");
    }
}
