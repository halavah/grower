package org.myslayers.search.amqp;

import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * PostMqIndexMessage：实体类
 * 供 -> 【/post/submit、/post/delete】 -> 使用 convertAndSend 【 交换机，路由密钥，发送的消息（操作的文章、操作的类型) 】
 */
@Data
@AllArgsConstructor
public class PostMqIndexMessage implements Serializable {

    // 两种type：一种是create_update、一种是remove
    public final static String CREATE_OR_UPDATE = "create_update";
    public final static String REMOVE = "remove";

    // 操作的文章：postId
    private Long postId;

    // 操作的类型：增删改查
    private String type;

}
