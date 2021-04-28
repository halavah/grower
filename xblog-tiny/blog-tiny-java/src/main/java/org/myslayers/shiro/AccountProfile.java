package org.myslayers.shiro;

import java.io.Serializable;
import lombok.Data;

/**
 * Profile：用于 AccountRealm.java 的 AuthenticationInfo 方法，【登录成功之后返回的一个用户信息的载体，将 user 信息封装成 SimpleAuthenticationInfo 对象 返回给 shiro】
 */
@Data
public class AccountProfile implements Serializable {

    private Long id;

    private String username;

    private String avatar;

    private String email;

}
