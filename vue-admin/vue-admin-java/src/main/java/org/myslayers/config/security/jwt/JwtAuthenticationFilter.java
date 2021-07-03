package org.myslayers.config.security.jwt;

import cn.hutool.core.util.StrUtil;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.JwtException;
import org.myslayers.config.security.auth.UserDetailServiceImpl;
import org.myslayers.config.utils.JwtUtils;
import org.myslayers.entity.User;
import org.myslayers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * JWT 过滤器：获取请求里的 token，验证 token 是否合法/异常/过期，并将 UsernamePasswordAuthenticationToken 填充到 SecurityContextHolder
 */
public class JwtAuthenticationFilter extends BasicAuthenticationFilter {

    @Autowired
    JwtUtils jwtUtils;

    @Autowired
    UserDetailServiceImpl userDetailService;

    @Autowired
    UserService userService;

    public JwtAuthenticationFilter(AuthenticationManager authenticationManager) {
        super(authenticationManager);
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse resp, FilterChain chain) throws IOException, ServletException {
        // 获取请求里的 token，验证 token 是否合法/异常/过期
        String jwt = req.getHeader(jwtUtils.getHeader());
        if (StrUtil.isBlankOrUndefined(jwt)) {
            chain.doFilter(req, resp);
            return;
        }
        Claims claim = jwtUtils.getClaimByToken(jwt);
        if (claim == null) {
            throw new JwtException("TOKEN 异常");
        }
        if (jwtUtils.isTokenExpired(claim)) {
            throw new JwtException("TOKEN 已过期");
        }

        // 返回一个 UsernamePasswordAuthenticationToken 对象，并将其填充到 SecurityContextHolder
        String username = claim.getSubject();
        User user = userService.getByUsername(username);
        UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, null, userDetailService.getAuthority(user.getId()));
        SecurityContextHolder.getContext().setAuthentication(token);

        // 过滤器：放行
        chain.doFilter(req, resp);
    }
}
