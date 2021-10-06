package org.myslayers.common.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * 自定义异常：验证码，是一个继承了 AuthenticationException 抽象类的异常
 */
public class CaptchaException extends AuthenticationException {
    
    // 构造方法
    public CaptchaException(String msg) {
        super(msg);
    }
}