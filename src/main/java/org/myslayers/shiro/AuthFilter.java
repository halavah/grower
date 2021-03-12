package org.myslayers.shiro;

import cn.hutool.json.JSONUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.authc.UserFilter;
import org.myslayers.common.lang.Result;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Shiro过滤器：判断请求是否是Ajax请求，还是Web请求
 */
public class AuthFilter extends UserFilter {

    @Override
    protected void redirectToLogin(ServletRequest request, ServletResponse response) throws IOException {

        /**
         * Ajax请求：通过对request字段的处理，来判断如果为Ajax请求，则设置response返回一段Json请求，并弹窗提示【请先登录！】
         */
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        //通过“X-Requested-With”来确定“该请求是一个Ajax请求”
        String header = httpServletRequest.getHeader("X-Requested-With");
        if(header != null  && "XMLHttpRequest".equals(header)) {
            //isAuthenticated()：如果此主题/用户在当前会话期间通过提供与系统已知的凭据匹配的有效凭据来证明了自己的身份，则返回true否则返回false
            boolean authenticated = SecurityUtils.getSubject().isAuthenticated();
            //如果!authenticated = true，则将resp设置为“返回一段Json数据”，Result.fail("请先登录！")会触发【弹窗】显示【请先登录！】
            if(!authenticated) {
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().print(JSONUtil.toJsonStr(Result.fail("请先登录！")));
            }
        } else {

            /**
             * Web请求，则重定向到【登录页面】，直接super.父类方法，无需对request、response进行处理
             */
            super.redirectToLogin(request, response);
        }
    }
}

