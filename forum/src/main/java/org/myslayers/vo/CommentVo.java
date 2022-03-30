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

    public Long getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Long authorId) {
        this.authorId = authorId;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getAuthorAvatar() {
        return authorAvatar;
    }

    public void setAuthorAvatar(String authorAvatar) {
        this.authorAvatar = authorAvatar;
    }
}
