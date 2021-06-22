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
import java.util.Date;

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
    @TableId(value = "id", type = IdType.INPUT)
    @ApiModelProperty(value = "主键ID")
    private Integer id;
    
    /**
     * 用户的【昵称】
     */
    @TableField(value = "username")
    @ApiModelProperty(value = "用户的【昵称】")
    private String username;
    
    /**
     * 用户的【密码】
     */
    @TableField(value = "`password`")
    @ApiModelProperty(value = "用户的【密码】")
    private String password;
    
    /**
     * 用户的【邮件】
     */
    @TableField(value = "email")
    @ApiModelProperty(value = "用户的【邮件】")
    private String email;
    
    /**
     * 用户的【手机】
     */
    @TableField(value = "mobile")
    @ApiModelProperty(value = "用户的【手机】")
    private String mobile;
    
    /**
     * 用户的【头像】
     */
    @TableField(value = "avatar")
    @ApiModelProperty(value = "用户的【头像】")
    private String avatar;
    
    /**
     * 用户的【状态】：0代表登录成功、-1代表登录失败
     */
    @TableField(value = "`status`")
    @ApiModelProperty(value = "用户的【状态】：0代表登录成功、-1代表登录失败")
    private Integer status;
    
    /**
     * 用户的【更新日期】
     */
    @TableField(value = "modified")
    @ApiModelProperty(value = "用户的【更新日期】")
    private Date modified;
    
    /**
     * 用户的【创建日期】
     */
    @TableField(value = "created")
    @ApiModelProperty(value = "用户的【创建日期】")
    private Date created;
    
    private static final long serialVersionUID = 1L;
}