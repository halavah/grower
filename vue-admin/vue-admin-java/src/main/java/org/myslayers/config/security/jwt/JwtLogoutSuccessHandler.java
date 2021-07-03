package org.myslayers.config.security.jwt;

import cn.hutool.json.JSONUtil;
import org.myslayers.common.lang.Result;
import org.myslayers.config.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 登出成功处理器
 */
@Component
public class JwtLogoutSuccessHandler implements LogoutSuccessHandler {
    
    @Autowired
    JwtUtils jwtUtils;
    
    @Override
    public void onLogoutSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication auth) throws IOException, ServletException {
        // 登出：调用 SecurityContextLogoutHandler 的 logout 方法
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(req, resp, auth);
        }
        
        // 编码：设置字符编码
        resp.setContentType("application/json;charset=UTF-8");
        
        // JWT：将请求头的 jwt 置空
        ServletOutputStream outputStream = resp.getOutputStream();
        resp.setHeader(jwtUtils.getHeader(), "");
        
        // 输出：使用 out 将 result 以 str 的形式 进行输出
        Result result = Result.success("登出成功处理器：置空 JWT 成功！");
        outputStream.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
        outputStream.flush();
        outputStream.close();
    }
}
