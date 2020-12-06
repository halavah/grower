package org.myslayers.vo;

import lombok.Data;
import org.myslayers.entity.Post;

@Data
public class PostVo extends Post {

    private Long authorId;

    private String authorName;

    private String authorAvatar;

    //父类存在该属性
//    private Long categoryId;

    private String categoryName;
}



