package org.myslayers.im.handler;

import java.util.HashMap;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.myslayers.common.lang.Consts;
import org.myslayers.im.handler.impl.ChatMsgHandler;
import org.myslayers.im.handler.impl.PingMsgHandler;

/**
 * 消息处理器-操作类别
 */
@Slf4j
public class MsgHandlerFactory {

    private static Map<String, MsgHandler> handlerMap = new HashMap<>();

    public static void init() {
        //Chat类型
        handlerMap.put(Consts.IM_MESS_TYPE_CHAT, new ChatMsgHandler());
        //Ping类型
        handlerMap.put(Consts.IM_MESS_TYPE_PING, new PingMsgHandler());

        log.info("hander factory init!!");
    }

    public static MsgHandler getMsgHandler(String type) {
        return handlerMap.get(type);
    }

}
