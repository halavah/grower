package org.myslayers.im.server;

import cn.hutool.core.map.MapUtil;
import cn.hutool.json.JSONUtil;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.myslayers.common.lang.Consts;
import org.myslayers.im.handler.MsgHandler;
import org.myslayers.im.handler.MsgHandlerFactory;
import org.tio.core.ChannelContext;
import org.tio.core.Tio;
import org.tio.http.common.HttpRequest;
import org.tio.http.common.HttpResponse;
import org.tio.websocket.common.WsRequest;
import org.tio.websocket.server.handler.IWsMsgHandler;

/**
 * 2.判断-消息处理器-类别【接受字符类型消息：Chat类型、Ping类型】
 */
@Slf4j
public class ImWsMsgHandler implements IWsMsgHandler {

    /**
     * 握手时候走的方法
     */
    @Override
    public HttpResponse handshake(HttpRequest httpRequest, HttpResponse httpResponse, ChannelContext channelContext) throws Exception {

        // 绑定个人通道
        String userId = httpRequest.getParam("userId");
        log.info("{} --------------> 正在握手！", userId);
        Tio.bindUser(channelContext, userId);

        return httpResponse;
    }

    /**
     * 握手完成之后
     */
    @Override
    public void onAfterHandshaked(HttpRequest httpRequest, HttpResponse httpResponse, ChannelContext channelContext) throws Exception {

        // 绑定群聊通道，群名称叫做：e-group-study
        Tio.bindGroup(channelContext, Consts.IM_GROUP_NAME);
        log.info("{} --------------> 已绑定群！", channelContext.getId());

    }

    /**
     * 接受字节类型消息
     */
    @Override
    public Object onBytes(WsRequest wsRequest, byte[] bytes, ChannelContext channelContext) throws Exception {
        return null;
    }

    /**
     * 接受字符类型消息
     */
    @Override
    public Object onText(WsRequest wsRequest, String text, ChannelContext channelContext) throws Exception {
        if(text != null && text.indexOf("ping") < 0) {
            log.info("接收到信息——————————————————>{}", text);
        }

        Map map = JSONUtil.toBean(text, Map.class);
        String type = MapUtil.getStr(map, "type");
        String data = MapUtil.getStr(map, "data");

        //处理消息
        MsgHandler handler = MsgHandlerFactory.getMsgHandler(type);
        handler.handler(data, wsRequest, channelContext);
        return null;
    }

    /**
     * 链接关闭时候方法
     */
    @Override
    public Object onClose(WsRequest wsRequest, byte[] bytes, ChannelContext channelContext) throws Exception {

        return null;
    }
}
