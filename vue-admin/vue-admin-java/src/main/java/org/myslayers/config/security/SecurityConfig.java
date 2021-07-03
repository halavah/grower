package org.myslayers.config.security;

import org.myslayers.config.security.auth.UserDetailServiceImpl;
import org.myslayers.config.security.captcha.CaptchaFilter;
import org.myslayers.config.security.captcha.LoginFailureHandler;
import org.myslayers.config.security.captcha.LoginSuccessHandler;
import org.myslayers.config.security.jwt.JwtAccessDeniedHandler;
import org.myslayers.config.security.jwt.JwtAuthenticationEntryPoint;
import org.myslayers.config.security.jwt.JwtAuthenticationFilter;
import org.myslayers.config.security.jwt.JwtLogoutSuccessHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
    // 身份认证：基于数据库的认证
    @Autowired
    UserDetailServiceImpl userDetailServiceImpl;
    
    // Captcha 过滤器
    @Autowired
    CaptchaFilter captchaFilter;
    
    // 登录成功处理器
    @Autowired
    LoginSuccessHandler loginSuccessHandler;
    
    // 登录失败处理器
    @Autowired
    LoginFailureHandler loginFailureHandler;
    
    // 登出成功处理器
    @Autowired
    JwtLogoutSuccessHandler jwtLogoutSuccessHandler;
    
    // JWT 认证失败处理器
    @Autowired
    JwtAuthenticationEntryPoint jwtAuthenticationEntryPoint;
    
    // JWT 鉴权失败处理器
    @Autowired
    JwtAccessDeniedHandler jwtAccessDeniedHandler;
    
    // JWT 过滤器
    @Bean
    JwtAuthenticationFilter jwtAuthenticationFilter() throws Exception {
        JwtAuthenticationFilter jwtAuthenticationFilter = new JwtAuthenticationFilter(authenticationManager());
        return jwtAuthenticationFilter;
    }
    
    /**
     * 身份认证：明文/密文
     */
    @Bean
    PasswordEncoder bCryptPasswordEncoder() {
        return NoOpPasswordEncoder.getInstance();
        //return new BCryptPasswordEncoder();
    }
    
    /**
     * 身份认证：基于数据库的认证
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailServiceImpl);
    }
    
    /**
     * 责任链：单个HttpSecurity
     */
    protected void configure(HttpSecurity http) throws Exception {
        // 开启 cors
        http.cors()
        
            // 关闭 csrf
            .and()
            .csrf()
            .disable()
        
            // 登录
            .formLogin()
            .loginProcessingUrl("/doLogin")
            .usernameParameter("username")
            .passwordParameter("password")
            // 登录：登录成功处理器
            .successHandler(loginSuccessHandler)
            // 登录：登录失败处理器
            .failureHandler(loginFailureHandler)
        
            // 登出
            .and()
            .logout()
            // 登出：登出成功处理器
            .logoutSuccessHandler(jwtLogoutSuccessHandler)
        
            // 禁用 session
            .and()
            .sessionManagement()
            .sessionCreationPolicy(SessionCreationPolicy.STATELESS)
        
            // 配置拦截规则
            .and()
            .authorizeRequests()
            // 配置拦截规则：白名单：跳过权限验证的URL（登录、登出、验证码、静态资源）
            .antMatchers("/login", "/logout", "/captcha", "/favicon.ico").permitAll()
            // 配置拦截规则：其他路径，验证
            .anyRequest().authenticated()
        
            // 异常处理器
            .and()
            .exceptionHandling()
            // 异常处理器：JWT 认证失败处理器
            .authenticationEntryPoint(jwtAuthenticationEntryPoint)
            // 异常处理器：JWT 鉴权失败处理器
            .accessDeniedHandler(jwtAccessDeniedHandler)
        
            // 自定义过滤器
            .and()
            // 自定义过滤器：将 jwtAuthenticationFilter 放到 LogoutFilter 之后
            .addFilter(jwtAuthenticationFilter())
            // 自定义过滤器：将 captchaFilter 放到 UsernamePasswordAuthenticationFilter 之前
            .addFilterBefore(captchaFilter, UsernamePasswordAuthenticationFilter.class)
        ;
    }
}
