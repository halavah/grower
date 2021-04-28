package org.myslayers.config;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.Filter;
import org.myslayers.shiro.AccountRealm;
import org.myslayers.shiro.JwtFilter;
import org.apache.shiro.mgt.DefaultSessionStorageEvaluator;
import org.apache.shiro.mgt.DefaultSubjectDAO;
import org.apache.shiro.mgt.SecurityManager;
import org.apache.shiro.session.mgt.SessionManager;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.spring.web.config.DefaultShiroFilterChainDefinition;
import org.apache.shiro.spring.web.config.ShiroFilterChainDefinition;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.crazycake.shiro.RedisCacheManager;
import org.crazycake.shiro.RedisSessionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
/**
 * 配置类：安全管理器、过滤器链、过滤器工厂
 */
@Configuration
public class ShiroConfig {

    @Autowired
    JwtFilter jwtFilter;

    /**
     * 1.安全管理器：根据 “https://github.com/alexxiyang/shiro-redis/tree/master/docs” 说明，将 【自定义Realm】、【自定义的session会话管理器】、【自定义的redis缓存管理器】 注入 DefaultWebSecurityManager，并关闭shiro自带的session
     *
     * 具体内容如下：
     * - 引入 RedisSessionDAO 和 RedisCacheManager，为了解决 shiro 的权限数据和会话信息能保存到 redis 中，实现会话共享
     * - 重写 SessionManager 和 DefaultWebSecurityManager，同时在 DefaultWebSecurityManager 中为了关闭 shiro 自带的 session 方式，我们需要设置为 false，这样用户就不再能通过 session 方式登录 shiro，而后将采用 jwt 凭证登录
     */
    @Bean
    public SessionManager sessionManager(RedisSessionDAO redisSessionDAO) {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        sessionManager.setSessionDAO(redisSessionDAO);

        return sessionManager;
    }

    @Bean
    public DefaultWebSecurityManager securityManager(AccountRealm accountRealm, SessionManager sessionManager, RedisCacheManager redisCacheManager) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager(accountRealm);
        // 将 自定义Realm 注册到安全管理器中
        securityManager.setRealm(accountRealm);

        // 将 自定义的session会话管理器 注册到安全管理器中
        securityManager.setSessionManager(sessionManager);

        // 将 自定义的redis缓存管理器 注册到安全管理器中
        securityManager.setCacheManager(redisCacheManager);

        // 关闭 shiro自带的session
        DefaultSubjectDAO subjectDAO = new DefaultSubjectDAO();
        DefaultSessionStorageEvaluator defaultSessionStorageEvaluator = new DefaultSessionStorageEvaluator();
        defaultSessionStorageEvaluator.setSessionStorageEnabled(false);
        subjectDAO.setSessionStorageEvaluator(defaultSessionStorageEvaluator);
        securityManager.setSubjectDAO(subjectDAO);

        return securityManager;
    }

    /**
     * 2.过滤器链
     *
     * 具体内容如下：不再通过编码形式拦截 Controller 访问路径，而将全部路由经过 JwtFilter 处理
     * - 如果 JwtFilter 在判断请求头时，如果存在 jwt 信息，校验 jwt 的有效性，如果有效，则直接执行 executeLogin 方法实现自动登录
     * - 如果 JwtFilter 在判断请求头时，如果没有 jwt 信息，则跳过；跳过之后，有 Controller 中的 Shiro 注解【@RequiresAuthentication】 来控制权限访问
     */
    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition() {
        DefaultShiroFilterChainDefinition chainDefinition = new DefaultShiroFilterChainDefinition();
        Map<String, String> filterMap = new LinkedHashMap<>();
        filterMap.put("/**", "jwt");   // 将全部路由交给 JwtFilter 过滤器进行处理
        chainDefinition.addPathDefinitions(filterMap);

        return chainDefinition;
    }

    /**
     * 3.过滤器工厂
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager, ShiroFilterChainDefinition shiroFilterChainDefinition) {
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        // shiroFilter 设置 自定义安全管理器（securityManager）
        shiroFilter.setSecurityManager(securityManager);

        // shiroFilter 设置 自定义jwtFilter
        Map<String, Filter> filters = new HashMap<>();
        filters.put("jwt", jwtFilter);
        shiroFilter.setFilters(filters);

        // shiroFilter 设置 自定义过滤器链（chainDefinition）
        Map<String, String> filterMap = shiroFilterChainDefinition.getFilterChainMap();
        shiroFilter.setFilterChainDefinitionMap(filterMap);

        return shiroFilter;
    }

}