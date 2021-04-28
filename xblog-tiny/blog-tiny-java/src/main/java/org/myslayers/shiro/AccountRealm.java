package org.myslayers.shiro;

import cn.hutool.core.bean.BeanUtil;
import org.myslayers.entity.User;
import org.myslayers.service.UserService;
import org.myslayers.utils.JwtUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * Realm：继承 Shiro 内置的 AuthorizingRealm
 */
@Component
public class AccountRealm extends AuthorizingRealm {

    @Autowired
    JwtUtils jwtUtils;

    @Autowired
    UserService userService;

    /**
     * supports：让 realm 支持 jwt 的凭证校验，【shiro 默认 supports 是 UsernamePasswordToken，使用 jwt 的方式，需要自定义 JwtToken 取代 UsernamePasswordToken】
     */
    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof JwtToken;
    }

    /**
     * doGetAuthorizationInfo（授权）：权限校验
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    /**
     * doGetAuthenticationInfo（认证）：登录认证，【通过 JwtToken 获取到用户信息 来 判断用户的状态，并抛出对应的异常信息】，同时，【登录成功之后返回的一个用户信息的载体，将 user 信息封装成 SimpleAuthenticationInfo 对象 返回给 shiro】
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        JwtToken jwtToken = (JwtToken) token;
        String userId = jwtUtils.getClaimByToken((String) jwtToken.getPrincipal()).getSubject();
        User user = userService.getById(Long.valueOf(userId));
        if (user == null) {
            throw new UnknownAccountException("账户不存在");
        }
        if (user.getStatus() == -1) {
            throw new LockedAccountException("账户已被锁定");
        }

        AccountProfile profile = new AccountProfile();
        BeanUtil.copyProperties(user, profile); //将 user对象 拷贝一份至 AccountProfile 对象
        return new SimpleAuthenticationInfo(profile, jwtToken.getCredentials(), getName());
    }
}
