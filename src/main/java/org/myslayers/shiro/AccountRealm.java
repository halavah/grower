package org.myslayers.shiro;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.myslayers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * AccountRealm：重写父类AuthorizingRealm方法
 */
@Component
public class AccountRealm extends AuthorizingRealm {

    @Autowired
    UserService userService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        // 1.获取Token
        UsernamePasswordToken usernamePasswordToken = (UsernamePasswordToken) token;
        // 2.根据token获取username、password，并进行login登录，返回AccountProfile账户信息
        AccountProfile profile = userService.login(usernamePasswordToken.getUsername(), String.valueOf(usernamePasswordToken.getPassword()));
        // 3.通过profile、token.getCredentials()、getName()，获取AuthenticationInfo子接口对象（SimpleAuthenticationInfo）
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(profile, token.getCredentials(), getName());

        // 方式二：利用session来实现【登录状态】，修改【更新资料/更新头像】后，需要【手动更新shiro/session数据】
        SecurityUtils.getSubject().getSession().setAttribute("profile", profile);
        return info;
    }
}
