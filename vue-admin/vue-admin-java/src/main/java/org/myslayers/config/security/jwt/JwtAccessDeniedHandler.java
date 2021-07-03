package org.myslayers.config.security.jwt;

import cn.hutool.json.JSONUtil;
import org.myslayers.common.lang.Result;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * JWT 鉴权失败处理器
 */
@Component
public class JwtAccessDeniedHandler implements AccessDeniedHandler {
    
    @Override
    public void handle(HttpServletRequest req, HttpServletResponse resp, AccessDeniedException e) throws IOException {
        // 编码：设置字符编码
        resp.setContentType("application/json;charset=UTF-8");
        
        // 状态：403
        resp.setStatus(HttpServletResponse.SC_FORBIDDEN);
        
        // 输出：使用 out 将 result 以 str 的形式 进行输出
        ServletOutputStream out = resp.getOutputStream();
        Result result = Result.fail("JWT 鉴权失败处理器：权限不足！", e.getMessage());
        out.write(JSONUtil.toJsonStr(result).getBytes("UTF-8"));
        out.flush();
        out.close();
        
    }
}
