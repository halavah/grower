package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 角色_菜单
 */
@ApiModel(value = "org-myslayers-entity-RoleMenu")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_role_menu")
public class RoleMenu implements Serializable {
    /**
     * 主键ID
     */
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 角色-菜单【角色ID】
     */
    @TableField(value = "role_id")
    @ApiModelProperty(value = "角色-菜单【角色ID】")
    private Long roleId;
    
    /**
     * 角色-菜单【菜单ID】
     */
    @TableField(value = "menu_id")
    @ApiModelProperty(value = "角色-菜单【菜单ID】")
    private Long menuId;
    
    private static final long serialVersionUID = 1L;
}