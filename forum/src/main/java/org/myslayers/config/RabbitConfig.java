package org.myslayers.config;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * RabbitConfig：配置类
 */
@Configuration
public class RabbitConfig {

    public final static String es_queue = "es_queue";
    public final static String es_exchage = "es_exchage";
    public final static String es_bind_key = "es_exchage";

    //队列
    @Bean
    public Queue exQueue() {
        return new Queue(es_queue);
    }

    //交换机
    @Bean
    DirectExchange exchange() {
        return new DirectExchange(es_exchage);
    }

    //绑定队列与交换机
    @Bean
    Binding binding(Queue exQueue, DirectExchange exchange) {
        return BindingBuilder.bind(exQueue).to(exchange).with(es_bind_key);
    }
}