package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import java.io.Serializable;
import java.util.Date;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 角色的【名称】
     */
    @TableField(value = "`name`")
    @ApiModelProperty(value = "角色的【名称】")
    private String name;
    
    /**
     * 角色的【编码】
     */
    @TableField(value = "code")
    @ApiModelProperty(value = "角色的【编码】")
    private String code;
    
    /**
     * 角色的【描述】
     */
    @TableField(value = "remark")
    @ApiModelProperty(value = "角色的【描述】")
    private String remark;
    
    /**
     * 角色的【状态】：0代表正常、1代表禁用
     */
    @TableField(value = "`status`")
    @ApiModelProperty(value = "角色的【状态】：0代表正常、1代表禁用")
    private Integer status;
    
    /**
     * 角色的【更新日期】
     */
    @TableField(value = "modified")
    @ApiModelProperty(value = "角色的【更新日期】")
    private Date modified;
    
    /**
     * 角色的【创建日期】
     */
    @TableField(value = "created")
    @ApiModelProperty(value = "角色的【创建日期】")
    private Date created;
    
    private static final long serialVersionUID = 1L;
}