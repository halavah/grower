package org.myslayers.vo;

import lombok.Data;
import org.myslayers.entity.UserMessage;

@Data
public class UserMessageVo extends UserMessage {

    /**
     * 我的消息的【接收消息的用户ID】-用户名name
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

    public String getToUserName() {
        return toUserName;
    }

    public void setToUserName(String toUserName) {
        this.toUserName = toUserName;
    }

    public String getFromUserName() {
        return fromUserName;
    }

    public void setFromUserName(String fromUserName) {
        this.fromUserName = fromUserName;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }
}
