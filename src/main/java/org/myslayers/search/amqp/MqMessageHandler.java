package org.myslayers.search.amqp;

import lombok.extern.slf4j.Slf4j;
import org.myslayers.config.RabbitConfig;
import org.myslayers.service.SearchService;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * RabbitMQ：执行操作的逻辑
 */
@Slf4j
@Component
@RabbitListener(queues = RabbitConfig.es_queue) //监听的队列es_queue
public class MqMessageHandler {

    @Autowired
    SearchService searchService;

    @RabbitHandler
    public void handler(org.myslayers.search.amqp.PostMqIndexMessage message) {

        log.info("mq 收到一条消息： {}", message.toString());

        switch (message.getType()) {
            //类型：创建或更新，【CREATE_OR_UPDATE】
            case PostMqIndexMessage.CREATE_OR_UPDATE:
                searchService.createOrUpdateIndex(message);
                break;

            //类型：删除，【REMOVE】
            case PostMqIndexMessage.REMOVE:
                searchService.removeIndex(message);
                break;

            //其他类型：输出错误日志
            default:
                log.error("没找到对应的消息类型，请注意！！ --》 {}", message.toString());
                break;
        }
    }
}
