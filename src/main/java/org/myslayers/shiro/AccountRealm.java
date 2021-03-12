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
 * Shiro过滤器：授权 / 认证
 */
@Component
public class AccountRealm extends AuthorizingRealm {

    @Autowired
    UserService userService;

    /**
     * doGetAuthorizationInfo（授权）：
     *
     * 需要判断是否有访问某个资源的权限
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    /**
     * doGetAuthenticationInfo（认证）
     *
     * 执行以下语句的时候，用于生成token验证信息，在doCredentialsMatch之前执行：SecurityUtils.getSubject().login(token);
     * 即，本次项目在AuthController.java中，/login数据接口，会使用token进行登录（SecurityUtils.getSubject().login(token);）
     */
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
