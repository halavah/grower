package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 用户_角色
 */
@ApiModel(value = "org-myslayers-entity-UserRole")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_user_role")
public class UserRole implements Serializable {
    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 用户-角色【用户ID】
     */
    @TableField(value = "user_id")
    @ApiModelProperty(value = "用户-角色【用户ID】")
    private Long userId;
    
    /**
     * 用户-角色【角色ID】
     */
    @TableField(value = "role_id")
    @ApiModelProperty(value = "用户-角色【角色ID】")
    private Long roleId;
    
    private static final long serialVersionUID = 1L;
}