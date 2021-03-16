package org.myslayers.config;

import java.io.IOException;
import lombok.extern.slf4j.Slf4j;
import org.myslayers.im.handler.MsgHandlerFactory;
import org.myslayers.im.server.ImServerStarter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * 执行入口类 -> 1.启动tio服务（绑定端口），并调用-消息处理器
 *          -> 2.判断-消息处理器-类别【接受字符类型消息：Chat类型、Ping类型】
 */
@Slf4j
@Configuration
public class ImServerConfig {

    @Value("${im.server.port}")
    private int imPort;

    @Bean
    ImServerStarter imServerStarter() {
        try {
            // 启动tio服务（绑定端口）
            ImServerStarter serverStarter = new ImServerStarter(imPort);
            serverStarter.start();

            // 初始化消息处理器类别
            MsgHandlerFactory.init();
            return serverStarter;
        } catch (IOException e) {
            log.error("tio server 启动失败", e);
        }

        return null;
    }
}
