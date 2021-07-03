package org.myslayers.config.security.jwt;

import cn.hutool.json.JSONUtil;
import org.myslayers.common.lang.Result;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * JWT 认证失败处理器
 */
@Component
public class JwtAuthenticationEntryPoint implements AuthenticationEntryPoint {

	@Override
	public void commence(HttpServletRequest req, HttpServletResponse resp, AuthenticationException e) throws IOException {
		// 编码：设置字符编码
		resp.setContentType("application/json;charset=UTF-8");
		
		// 状态：401
		resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
		
		// 输出：使用 out 将 result 以 str 的形式 进行输出
		ServletOutputStream out = resp.getOutputStream();
		Result result = Result.fail("JWT 认证失败处理器：请先登录！", e.getMessage());
		out.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
		out.flush();
		out.close();
	}
}
