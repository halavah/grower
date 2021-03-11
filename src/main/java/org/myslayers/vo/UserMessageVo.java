package org.myslayers.vo;

import lombok.Data;
import org.myslayers.entity.UserMessage;

@Data
public class UserMessageVo extends UserMessage {
    /**
     * 我的消息的【接收消息的用户ID】-用户名name     未使用
     */
    private String toUserName;

    /**
     * 我的消息的【发送消息的用户ID】-用户名name
     */
    private String fromUserName;

    /**
     * 我的消息的【关联的文章ID】-文章标题title
     */
    private String postTitle;

    /**
     * 我的消息的【关联的文章-对应的评论ID】-评论内容content
     */
    private String commentContent;
}
