package org.myslayers.config;

import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.myslayers.shiro.AccountRealm;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Shiro配置类：安全管理器、拦截器链
 */
@Slf4j
@Configuration
public class ShiroConfig {

    /**
     * 安全管理器
     */
    @Bean
    public SecurityManager securityManager(AccountRealm accountRealm){
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager();
        securityManager.setRealm(accountRealm);
        log.info("------------------>securityManager注入成功");
        return securityManager;
    }

    /**
     * 拦截器链
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager) {
        ShiroFilterFactoryBean filterFactoryBean = new ShiroFilterFactoryBean();
        // 配置安全管理器
        filterFactoryBean.setSecurityManager(securityManager);

        // 配置登录的url
        filterFactoryBean.setLoginUrl("/login");

        // 配置登录成功的url
        filterFactoryBean.setSuccessUrl("/user/center");

        // 配置未授权跳转页面
        filterFactoryBean.setUnauthorizedUrl("/error/403");

        // 配置过滤链定义图：未登录的情况下，访问/login、/user/home页面，自动跳转登录页面进行认证
        Map<String, String> hashMap = new LinkedHashMap<>();
        hashMap.put("/login", "anon");
        hashMap.put("/user/home", "authc");
        hashMap.put("/user/mess", "authc");
        hashMap.put("/user/set", "authc");
        hashMap.put("/user/upload", "authc");
        filterFactoryBean.setFilterChainDefinitionMap(hashMap);

        return filterFactoryBean;
    }
}
