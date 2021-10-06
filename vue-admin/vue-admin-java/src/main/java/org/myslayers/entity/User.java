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
 * 用户
 */
@ApiModel(value = "org-myslayers-entity-User")
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@TableName(value = "sys_user")
public class User implements Serializable {
    /**
     * 主键ID
     */
    //@NotNull(message = "角色的【主键】不能为空")
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 用户的【昵称】
     */
    @NotNull(message = "角色的【昵称】不能为空")
    @TableField(value = "username")
    @ApiModelProperty(value = "用户的【昵称】")
    private String username;
    
    /**
     * 用户的【密码】
     */
    //@NotNull(message = "角色的【密码】不能为空")
    @TableField(value = "`password`")
    @ApiModelProperty(value = "用户的【密码】")
    private String password;
    
    /**
     * 用户的【邮件】
     */
    @NotNull(message = "角色的【邮件】不能为空")
    @TableField(value = "email")
    @ApiModelProperty(value = "用户的【邮件】")
    private String email;
    
    /**
     * 用户的【手机】
     */
    @NotNull(message = "角色的【手机】不能为空")
    @TableField(value = "mobile")
    @ApiModelProperty(value = "用户的【手机】")
    private String mobile;
    
    /**
     * 用户的【头像】
     */
    //@NotNull(message = "角色的【头像】不能为空")
    @TableField(value = "avatar")
    @ApiModelProperty(value = "用户的【头像】")
    private String avatar;
    
    /**
     * 用户的【状态】：0代表登录成功、-1代表登录失败
     */
    @NotNull(message = "角色的【状态】不能为空")
    @TableField(value = "`status`")
    @ApiModelProperty(value = "用户的【状态】：0代表登录成功、-1代表登录失败")
    private Integer status;
    
    /**
     * 用户的【更新日期】"
     */
    //@NotNull(message = "角色的【更新日期】不能为空")
    @TableField(value = "modified")
    @ApiModelProperty(value = "用户的【更新日期】")
    private Date modified;
    
    /**
     * 用户的【创建日期】
     */
    //@NotNull(message = "角色的【创建日期】不能为空")
    @TableField(value = "created")
    @ApiModelProperty(value = "用户的【创建日期】")
    private Date created;
    
    /**
     * 用户的【角色序号】
     */
    //@NotNull(message = "角色的【角色序号】不能为空")
    @TableField(exist = false)
    private List<Long> roleIds = new ArrayList<>();
    
    /**
     * 用户的【角色列表】
     */
    //@NotNull(message = "用户的【角色列表】不能为空")
    @TableField(exist = false)
    private List<Role> roles = new ArrayList<>();
    
    private static final long serialVersionUID = 1L;
}