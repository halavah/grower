package org.myslayers.vo;

import lombok.Data;
import org.myslayers.entity.Post;

/**
 * post（内容） + vo（用户信息_分类信息）
 */
@Data
public class PostVo extends Post {

    private Long authorId;

    private String authorName;

    private String authorAvatar;

    //父类存在该属性
//    private Long categoryId;

    private String categoryName;

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

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}



