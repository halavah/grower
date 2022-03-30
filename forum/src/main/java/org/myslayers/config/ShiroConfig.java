package org.myslayers.config;

import cn.hutool.core.map.MapUtil;
import java.util.LinkedHashMap;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.myslayers.shiro.AccountRealm;
import org.myslayers.shiro.AuthFilter;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Shiro配置类：安全管理器、拦截器链、自定义过滤器
 */
@Slf4j
@Configuration
public class ShiroConfig {

    /**
     * 安全管理器
     */
    @Bean
    public SecurityManager securityManager(AccountRealm accountRealm) {
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

        // 配置Shiro自定义过滤器：判断请求是否是Ajax请求，还是Web请求
        filterFactoryBean.setFilters(MapUtil.of("auth", authFilter()));

        // 配置过滤链定义图：未登录的情况下，访问/login、/user/home页面，自动跳转登录页面进行认证
        Map<String, String> hashMap = new LinkedHashMap<>();
        hashMap.put("/res/**", "anon");

        hashMap.put("/user/home", "auth");
        hashMap.put("/user/set", "auth");
        hashMap.put("/user/upload", "auth");

        hashMap.put("/user/index", "auth");
        hashMap.put("/user/public", "auth");
        hashMap.put("/user/collection", "auth");
        hashMap.put("/user/mess", "auth");
        hashMap.put("/msg/remove/", "auth");
        hashMap.put("/message/nums/", "auth");

        hashMap.put("/collection/remove/", "auth");
        hashMap.put("/collection/find/", "auth");
        hashMap.put("/collection/add/", "auth");

        hashMap.put("/post/edit", "auth");
        hashMap.put("/post/submit", "auth");
        hashMap.put("/post/delete", "auth");
        hashMap.put("/post/reply/", "auth");

        hashMap.put("/websocket", "anon");
        hashMap.put("/login", "anon");
        filterFactoryBean.setFilterChainDefinitionMap(hashMap);

        return filterFactoryBean;
    }

    /**
     * Shiro自定义过滤器：判断请求是否是Ajax请求，还是Web请求
     */
    @Bean
    public AuthFilter authFilter() {
        return new AuthFilter();
    }
}

