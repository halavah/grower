package org.myslayers.forum.portal.support;

import org.myslayers.forum.api.response.user.UserInfoResponse;

public class WebContext {

    /**
     * 当前登录用户
     */
    private static final ThreadLocal<UserInfoResponse> CURRENT_LOGIN_USER = new ThreadLocal<>();

    /**
     * 当前登录用户登录凭证 sid
     */
    private static final ThreadLocal<String> CURRENT_USER_LOGIN_SID = new ThreadLocal<>();

    /**
     * 保存当前登录用户
     */
    public static void setCurrentUser(UserInfoResponse loginUser) {
        CURRENT_LOGIN_USER.set(loginUser);
    }

    /**
     * 获取当前登录用户
     */
    public static UserInfoResponse getCurrentUser() {
        return CURRENT_LOGIN_USER.get();
    }

    /**
     * 保存当前登录凭证
     */
    public static void setCurrentSid(String sid) {
        CURRENT_USER_LOGIN_SID.set(sid);
    }

    /**
     * 获取当前登录凭证
     */
    public static String getCurrentSid() {
        return CURRENT_USER_LOGIN_SID.get();
    }

    public static void removeAll() {
        CURRENT_LOGIN_USER.remove();
        CURRENT_USER_LOGIN_SID.remove();
    }

}
