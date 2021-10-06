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

import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 菜单
 */
@ApiModel(value = "org-myslayers-entity-Menu")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_menu")
public class Menu implements Serializable {
    /**
     * 主键ID
     */
    //@NotNull(message = "主键ID不能为空")
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 菜单的【上级菜单】：0代表父菜单，1开始依次代表子菜单
     */
    @NotNull(message = "菜单的【上级菜单】不能为空")
    @TableField(value = "parent_id")
    @ApiModelProperty(value = "菜单的【上级菜单】：0代表父菜单，1开始依次代表子菜单")
    private Long parentId;
    
    /**
     * 菜单的【标题】
     */
    @NotNull(message = "菜单的【标题】不能为空")
    @TableField(value = "title")
    @ApiModelProperty(value = "菜单的【标题】")
    private String title;
    
    /**
     * 菜单的【名称】
     */
    //@NotNull(message = "菜单的【名称】不能为空")
    @TableField(value = "`name`")
    @ApiModelProperty(value = "菜单的【名称】")
    private String name;
    
    /**
     * 菜单的【路径】
     */
    //@NotNull(message = "菜单的【路径】不能为空")
    @TableField(value = "`path`")
    @ApiModelProperty(value = "菜单的【路径】")
    private String path;
    
    /**
     * 菜单的【图标】
     */
    //@NotNull(message = "菜单的【图标】不能为空")
    @TableField(value = "icon")
    @ApiModelProperty(value = "菜单的【图标】")
    private String icon;
    
    /**
     * 菜单的【权限】
     */
    @NotNull(message = "菜单的【权限】不能为空")
    @TableField(value = "perms")
    @ApiModelProperty(value = "菜单的【权限】")
    private String perms;
    
    /**
     * 菜单的【组件】
     */
    //@NotNull(message = "菜单的【组件】不能为空")
    @TableField(value = "component")
    @ApiModelProperty(value = "菜单的【组件】")
    private String component;
    
    /**
     * 菜单的【排列】：1代表first、2代表second
     */
    @NotNull(message = "菜单的【排列】不能为空")
    @TableField(value = "sorted")
    @ApiModelProperty(value = "菜单的【排列】：1代表first、2代表second")
    private Integer sorted;
    
    /**
     * 菜单的【类型】：0代表目录、1代表菜单、2代表按钮
     */
    @NotNull(message = "菜单的【类型】不能为空")
    @TableField(value = "`type`")
    @ApiModelProperty(value = "菜单的【类型】：0代表目录、1代表菜单、2代表按钮")
    private Integer type;
    
    /**
     * 菜单的【状态】：0代表正常、1代表禁用
     */
    @NotNull(message = "菜单的【状态】不能为空")
    @TableField(value = "`status`")
    @ApiModelProperty(value = "菜单的【状态】：0代表正常、1代表禁用")
    private Integer status;
    
    /**
     * 菜单的【创建日期】
     */
    //@NotNull(message = "菜单的【创建日期】不能为空")
    @TableField(value = "created")
    @ApiModelProperty(value = "菜单的【创建日期】")
    private Date created;
    
    /**
     * 菜单的【更新日期】
     */
    //@NotNull(message = "菜单的【更新日期】不能为空")
    @TableField(value = "modified")
    @ApiModelProperty(value = "菜单的【更新日期】")
    private Date modified;
    
    /**
     * 菜单的【子菜单】
     */
    //@NotNull(message = "菜单的【子菜单】不能为空")
    @TableField(exist = false)
    private List<Menu> children = new ArrayList<>();
    
    private static final long serialVersionUID = 1L;
    
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Menu)) return false;
        Menu menu = (Menu) o;
        return Objects.equals(getId(), menu.getId()) && Objects.equals(getParentId(), menu.getParentId()) && Objects.equals(getTitle(), menu.getTitle()) && Objects.equals(getName(), menu.getName()) && Objects.equals(getPath(), menu.getPath()) && Objects.equals(getIcon(), menu.getIcon()) && Objects.equals(getPerms(), menu.getPerms()) && Objects.equals(getComponent(), menu.getComponent()) && Objects.equals(getSorted(), menu.getSorted()) && Objects.equals(getType(), menu.getType()) && Objects.equals(getStatus(), menu.getStatus()) && Objects.equals(getCreated(), menu.getCreated()) && Objects.equals(getModified(), menu.getModified()) && Objects.equals(getChildren(), menu.getChildren());
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(getId(), getParentId(), getTitle(), getName(), getPath(), getIcon(), getPerms(), getComponent(), getSorted(), getType(), getStatus(), getCreated(), getModified(), getChildren());
    }
}