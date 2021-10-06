package org.myslayers.config.security.captcha;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import org.myslayers.common.exception.CaptchaException;
import org.myslayers.common.lang.Const;
import org.myslayers.config.utils.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Captcha 过滤器：对 /login 请求，在 redis 中校验的 Captcha 正确性，并在  redis 中将该条缓存删除，同时对该过滤器进行放行
 */
@Component
public class CaptchaFilter extends OncePerRequestFilter {
	
	@Autowired
    RedisUtil redisUtil;
    
    @Autowired
    LoginFailureHandler loginFailureHandler;
    
    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse resp, FilterChain filterChain) throws ServletException, IOException {
        // 匹配 /doLogin 时，请求方式必须为 POST，而 post 无法识别
        if ("/doLogin".equals(req.getRequestURI()) && req.getMethod().equals("POST")) {
            try {
                // 校验：验证码的正确性
                String key = req.getParameter("key");
                String code = req.getParameter("code");
                if (StringUtils.isBlank(code) || StringUtils.isBlank(key)) {
                    throw new CaptchaException("验证码错误！");
                }
                if (!code.equals(redisUtil.hget(Const.CAPTCHA_KEY, key))) {
                    throw new CaptchaException("验证码错误！");
                }
                // Redis：删除当前使用的验证码，【Const.CAPTCHA_KEY】对应的键值对【key】-【code】
                redisUtil.hdel(Const.CAPTCHA_KEY, key);
            } catch (CaptchaException e) {
                // 异常：交给认证失败处理器
                loginFailureHandler.onAuthenticationFailure(req, resp, e);
            }
        }
        
        // 过滤器：放行
        filterChain.doFilter(req, resp);
    }
}