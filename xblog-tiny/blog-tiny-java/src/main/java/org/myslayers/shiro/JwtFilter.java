package org.myslayers.shiro;

import cn.hutool.json.JSONUtil;
import io.jsonwebtoken.Claims;
import java.io.IOException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.myslayers.common.lang.Result;
import org.myslayers.utils.JwtUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.ExpiredCredentialsException;
import org.apache.shiro.web.filter.authc.AuthenticatingFilter;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Filter：继承 Shiro 内置的 AuthenticatingFilter
 */
@Component
public class JwtFilter extends AuthenticatingFilter {

    @Autowired
    JwtUtils jwtUtils;

    /**
     * createToken：实现登录，【从 request 的 header 中获取 自定义的jwt(Authorization)，然后生成 JwtToken 信息并返回】
     */
    @Override
    protected AuthenticationToken createToken(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String jwt = request.getHeader("Authorization");
        if (StringUtils.isEmpty(jwt)) {
            return null;
        }
        return new JwtToken(jwt);
    }

    /**
     * onAccessDenied：拦截校验，
     * - 如果 JwtFilter 在判断请求头时，如果存在 jwt 信息，校验 jwt 的有效性，如果有效，则直接执行 executeLogin 方法实现自动登录
     * - 如果 JwtFilter 在判断请求头时，如果没有 jwt 信息，则跳过；跳过之后，有 Controller 中的 Shiro 注解【@RequiresAuthentication】 来控制权限访问
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String jwt = request.getHeader("Authorization");
        if (StringUtils.isEmpty(jwt)) {
            return true;
        } else {
            // 校验jwt
            Claims claim = jwtUtils.getClaimByToken(jwt);
            if (claim == null || jwtUtils.isTokenExpired(claim.getExpiration())) {
                throw new ExpiredCredentialsException("token已失效，请重新登录");
            }
            // 执行登录
            return executeLogin(servletRequest, servletResponse);
        }
    }

    /**
     * onLoginFailure：登录异常时候进入的方法，【前后端项目，使用JSON格式的数据，将异常信息封装然后抛出】
     */
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        Throwable throwable = e.getCause() == null ? e : e.getCause();
        Result result = Result.fail(throwable.getMessage());
        String json = JSONUtil.toJsonStr(result);
        try {
            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.getWriter().print(json);
        } catch (IOException ioException) {
        }
        return false;
    }

    /**
     * preHandle：拦截器的前置拦截，【前后端项目，除了需要跨域全局配置之外，拦截器中也需要提供跨域支持。这样，拦截器才不会在进入 Controller 之前就被限制了】
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
        httpServletResponse.setHeader("Access-control-Allow-Origin", httpServletRequest.getHeader("Origin"));
        httpServletResponse.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,PUT,DELETE");
        httpServletResponse.setHeader("Access-Control-Allow-Headers", httpServletRequest.getHeader("Access-Control-Request-Headers"));
        // 跨域时会首先发送一个OPTIONS请求，这里我们给OPTIONS请求直接返回正常状态
        if (httpServletRequest.getMethod().equals(RequestMethod.OPTIONS.name())) {
            httpServletResponse.setStatus(org.springframework.http.HttpStatus.OK.value());
            return false;
        }
        return super.preHandle(request, response);
    }

}
