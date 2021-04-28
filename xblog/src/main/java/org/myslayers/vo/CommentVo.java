package org.myslayers.vo;

import lombok.Data;
import org.myslayers.entity.Comment;

/**
 * comment（评论） + vo（用户信息）
 */
@Data
public class CommentVo extends Comment {

    private Long authorId;

    private String authorName;

    private String authorAvatar;
}
