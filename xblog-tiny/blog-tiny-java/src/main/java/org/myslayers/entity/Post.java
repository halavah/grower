package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户文章
 * </p>
 *
 * @author org.myslayers
 * @since 2021-03-31
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("m_post")
public class Post extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 文章的【用户ID】
     */
    private Long userId;

    /**
     * 文章的【标题】
     */
    @NotBlank(message = "标题不能为空")
    private String title;

    /**
     * 文章的【描述】
     */
    @NotBlank(message = "描述不能为空")
    private String description;

    /**
     * 文章的【内容】
     */
    @NotBlank(message = "内容不能为空")
    private String content;

    /**
     * 文章的【状态】
     */
    private Integer status;

}
