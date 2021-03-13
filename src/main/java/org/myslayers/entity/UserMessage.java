package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("m_user_message")//表名
public class UserMessage extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 发送消息的用户ID
     */
    private Long fromUserId;

    /**
     * 接收消息的用户ID
     */
    private Long toUserId;

    /**
     * 消息可能关联的帖子
     */
    private Long postId;

    /**
     * 消息可能关联的评论
     */
    private Long commentId;

    /**
     * 消息类型：0代表系统消息、1代表评论的文章、2代表回复的评论
     */
    private Integer type;

    /**
     * 状态：0代表未读、1代表已读
     */
    private Integer status;
}
