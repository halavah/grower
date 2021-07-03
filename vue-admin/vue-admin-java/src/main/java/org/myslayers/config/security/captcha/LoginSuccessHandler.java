package org.myslayers.config.security.captcha;

import cn.hutool.json.JSONUtil;
import org.myslayers.common.lang.Result;
import org.myslayers.config.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 登录成功处理器
 */
@Component
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	JwtUtils jwtUtils;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse resp, Authentication authentication) throws IOException, ServletException {
        // 编码：设置字符编码
        resp.setContentType("application/json;charset=UTF-8");
	    
	    // JWT：将生成的 jwt 放置到请求头中
        String jwt = jwtUtils.generateToken(authentication.getName());
        resp.setHeader(jwtUtils.getHeader(), jwt);
        
        // 输出：使用 out 将 result 以 str 的形式 进行输出
        ServletOutputStream out = resp.getOutputStream();
		Result result = Result.success("登录成功处理器：获取 JWT 成功！");
        out.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
        out.flush();
        out.close();
	}
}