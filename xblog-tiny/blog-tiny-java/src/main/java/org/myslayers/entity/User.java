package org.myslayers.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import java.util.Date;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 用户信息
 * </p>
 *
 * @author org.myslayers
 * @since 2021-03-31
 */
@Data
@EqualsAndHashCode(callSuper = true)
@Accessors(chain = true)
@TableName("m_user")
public class User extends BaseEntity {

    private static final long serialVersionUID = 1L;

    /**
     * 用户的【昵称】
     */
    @NotBlank(message = "昵称不能为空")
    private String username;

    /**
     * 用户的【密码】
     */
    @NotBlank(message = "密码不能为空")
    private String password;

    /**
     * 用户的【邮件】
     */
    @NotBlank(message = "邮箱不能为空")
    @Email(message = "邮箱格式不正确")
    private String email;

    /**
     * 用户的【性别】:0代表男，1代表女
     */
    private String gender;

    /**
     * 用户的【头像】
     */
    private String avatar;

    /**
     * 用户的【状态】:0代表登录成功，-1代表登录失败
     */
    private Integer status;

    /**
     * 用户的【近期登陆日期】
     */
    private Date lasted;
}
