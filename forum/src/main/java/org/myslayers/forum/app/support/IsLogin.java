package org.myslayers.forum.app.support;

import org.myslayers.forum.common.enums.UserRoleEn;

import java.lang.annotation.*;

@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface IsLogin {
    
    UserRoleEn role() default UserRoleEn.USER;

}