package org.myslayers.forum.domain.entity;

import com.alibaba.fastjson.JSONObject;
import lombok.*;
import org.springframework.beans.BeanUtils;
import org.myslayers.forum.common.enums.UserRoleEn;
import org.myslayers.forum.common.enums.UserSexEn;
import org.myslayers.forum.common.enums.UserSourceEn;
import org.myslayers.forum.common.enums.UserStateEn;
import org.myslayers.forum.common.support.AvatarUtil;

import java.util.Date;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User extends BaseEntity {


    private UserRoleEn role;
    
    private UserStateEn state;
    
    private String nickname;
    
    private UserSexEn sex;

    private UserSourceEn source;

    private String avatar;
    
    private String email;

    private String password;
    
    private String signature;

    private JSONObject githubUser;
    
    private Date lastLoginTime;

    public String getAvatar() {
        return AvatarUtil.get(avatar, email);
    }

    public User copy() {
        User user = new User();
        BeanUtils.copyProperties(this, user);

        return user;
    }

}
