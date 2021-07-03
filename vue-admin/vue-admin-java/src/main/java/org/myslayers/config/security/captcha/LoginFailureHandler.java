package org.myslayers.config.security.captcha;

import cn.hutool.json.JSONUtil;
import org.myslayers.common.lang.Result;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 登录失败处理器
 */
@Component
public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse resp, AuthenticationException exception) throws IOException, ServletException {
		// 编码：设置字符编码
		resp.setContentType("application/json;charset=UTF-8");
		
		// 输出：使用 out 将 result 以 str 的形式 进行输出
		ServletOutputStream out = resp.getOutputStream();
		Result result = Result.fail("登录失败处理器：用户名/密码/验证码 有误！");
		out.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
		out.flush();
		out.close();
	}
}
