package org.myslayers.shiro;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户在login后，将查询后的user结果，复制一份给AccountProfile【用户信息】
 */
@Data
public class AccountProfile implements Serializable {

    private Long id;

    private String username;
    private String email;
    private String sign;

    private String avatar;
    private String gender;
    private Date created;
}
