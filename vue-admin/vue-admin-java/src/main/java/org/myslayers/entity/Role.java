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

/**
 * 角色
 */
@ApiModel(value = "org-myslayers-entity-Role")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_role")
public class Role implements Serializable {
    /**
     * 主键ID
     */
    //@NotNull(message = "主键ID不能为空")
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 角色的【名称】
     */
    @NotNull(message = "角色的【名称】不能为空")
    @TableField(value = "`name`")
    @ApiModelProperty(value = "角色的【名称】")
    private String name;
    
    /**
     * 角色的【编码】
     */
    @NotNull(message = "角色的【编码】不能为空")
    @TableField(value = "code")
    @ApiModelProperty(value = "角色的【编码】")
    private String code;
    
    /**
     * 角色的【描述】
     */
    //@NotNull(message = "角色的【描述】不能为空")
    @TableField(value = "remark")
    @ApiModelProperty(value = "角色的【描述】")
    private String remark;
    
    /**
     * 角色的【状态】：0代表正常、1代表禁用
     */
    //@NotNull(message = "角色的【状态】不能为空")
    @TableField(value = "`status`")
    @ApiModelProperty(value = "角色的【状态】：0代表正常、1代表禁用")
    private Integer status;
    
    /**
     * 角色的【创建日期】
     */
    //@NotNull(message = "角色的【创建日期】不能为空")
    @TableField(value = "created")
    @ApiModelProperty(value = "角色的【创建日期】")
    private Date created;
    
    /**
     * 角色的【更新日期】
     */
    //@NotNull(message = "角色的【更新日期】不能为空")
    @TableField(value = "modified")
    @ApiModelProperty(value = "角色的【更新日期】")
    private Date modified;
    
    /**
     * 角色的【菜单序号】
     */
    //@NotNull(message = "角色的【菜单序号】不能为空")
    @TableField(exist = false)
    private List<Long> menuIds = new ArrayList<>();
    
    /**
     * 角色的【菜单列表】
     */
    //@NotNull(message = "角色的【菜单列表】不能为空")
    @TableField(exist = false)
    private List<Menu> menus = new ArrayList<>();
    
    private static final long serialVersionUID = 1L;
}