package org.myslayers.shiro;

import org.apache.shiro.authc.AuthenticationToken;

/**
 * Token：用于 AccountRealm.java 的 supports 方法，【shiro 默认 supports 是 UsernamePasswordToken，使用 jwt 的方式，需要自定义 JwtToken 取代 UsernamePasswordToken】
 */
public class JwtToken implements AuthenticationToken {

    private String token;

    public JwtToken(String jwt) {
        this.token = jwt;
    }

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
