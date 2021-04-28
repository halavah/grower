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
}



