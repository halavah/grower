package org.myslayers.im.server;

import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.tio.server.ServerGroupContext;
import org.tio.websocket.server.WsServerStarter;
import org.tio.websocket.server.handler.IWsMsgHandler;

/**
 * 1.启动tio服务（绑定端口），并调用-消息处理器
 */
@Slf4j
public class ImServerStarter {

    //返回全局变量：使用websocket-tio包中的ImServerStarter【org.tio.websocket.server.WsServerStarter】
    private WsServerStarter starter;

    /**
     * 构造方法：启动tio服务（绑定端口）
     */
    public ImServerStarter(int port) throws IOException {
        //调用【消息处理器】
        IWsMsgHandler handler = new ImWsMsgHandler();
        starter = new WsServerStarter(port, handler);

        //可选【在上下文对象中，设置心跳时间】
        ServerGroupContext serverGroupContext = starter.getServerGroupContext();
        serverGroupContext.setHeartbeatTimeout(50000);
    }

    /**
     * 初始化消息处理器类别
     */
    public void start() throws IOException {
        starter.start();
        log.info("tio server start !!");
    }
}