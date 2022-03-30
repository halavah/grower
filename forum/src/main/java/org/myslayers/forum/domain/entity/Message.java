package org.myslayers.forum.domain.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.myslayers.forum.common.enums.MessageChannelEn;
import org.myslayers.forum.common.enums.MessageContentTypeEn;
import org.myslayers.forum.common.enums.MessageReadEn;
import org.myslayers.forum.common.enums.MessageTypeEn;
import org.myslayers.forum.domain.entity.value.IdValue;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Message extends BaseEntity {

    /**
     * 消息发送渠道
     */
    private MessageChannelEn channel;

    /**
     * 消息类型
     */
    private MessageTypeEn type;

    /**
     * 是否已读
     */
    private MessageReadEn read;

    /**
     * 触发人
     */
    private IdValue sender;

    /**
     * 收件人
     */
    private IdValue receiver;

    /**
     * 标题
     */
    private String title;

    /**
     * 内容类型
     */
    private MessageContentTypeEn contentType;

    /**
     * 内容
     */
    private String content;

}
