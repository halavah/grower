package org.myslayers.controller;

import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.google.code.kaptcha.Producer;
import java.awt.image.BufferedImage;
import java.io.IOException;
import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.User;
import org.myslayers.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AuthController extends BaseController {

    private static final String KAPTCHA_SESSION_KEY = "KAPTCHA_SESSION_KEY";

    @Autowired
    Producer producer;

    /*--------------------------------------1.用户注册------------------------------------>*/

    /**
     * 注册
     */
    @GetMapping("/register")
    public String register() {
        return "/auth/reg";
    }

    /**
     * 图片验证码
     */
    @GetMapping("/capthca.jpg")
    public void kaptcha(HttpServletResponse resp) throws IOException {
        //1.生成text、image
        String text = producer.createText();
        BufferedImage image = producer.createImage(text);
        // 2.校验操作，利用session机制对text进行校验（经过测试，ImageIO输出前，必须完成req、resp请求）
        req.getSession().setAttribute("KAPTCHA_SESSION_KEY", text);
        // 3.通过resp设置Header、ContextType（经过测试，图片ContextType必须为"image/jpeg"，而非"image/jpg"）
        resp.setHeader("Cache-Control", "no-store, no-cache");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setContentType("image/jpeg");
        // 4.通过ImageIO输出image
        ServletOutputStream outputStream = resp.getOutputStream();
        ImageIO.write(image, "jpg", outputStream);
    }

    /**
     * 注册：图片校验
     */
    @ResponseBody
    @PostMapping("/register")
    public Result doRegister(User user, String repass, String vercode) {
        // 使用ValidationUtil工具类，校验【输入是否错误】
        ValidationUtil.ValidResult validResult = ValidationUtil.validateBean(user);
        if (validResult.hasErrors()) {
            return Result.fail(validResult.getErrors());
        }

        // 校验【密码是否一致】
        if (!user.getPassword().equals(repass)) {
            return Result.fail("两次输入密码不相同");
        }

        // 校验【验证码是否正确】：从session中获取KAPTCHA_SESSION_KEY，即正确的验证码【text】
        String kaptcha_session_key = (String) req.getSession().getAttribute(KAPTCHA_SESSION_KEY);
        System.out.println(kaptcha_session_key);
        if (vercode == null || !vercode.equalsIgnoreCase(kaptcha_session_key)) {
            return Result.fail("验证码输入不正确");
        }

        // 完成注册
        Result result = userService.register(user);
        // 如果校验成功，则完成注册，跳转/login页面
        return result.action("/login");
    }

    /*--------------------------------------2.用户登录------------------------------------>*/

    /**
     * 登录
     */
    @GetMapping("/login")
    public String login() {
        return "/auth/login";
    }

    /**
     * 登录：Shiro校验
     */
    @ResponseBody
    @PostMapping("/login")
    public Result doLogin(String email, String password) {
        /**
         * 使用hutool的StrUtil工具类，【isEmpty】字符串是否为空、【isBlank】字符串是否为空白
         */
        if (StrUtil.isEmpty(email) || StrUtil.isBlank(password)) {
            return Result.fail("邮箱或密码不能为空");
        }

        /**
         * 使用Shiro框架，生成token后进行登录
         */
        try {
            // 生成Token：根据UsernamePasswordToken参数可知，会对username、password进行token生成
            UsernamePasswordToken token = new UsernamePasswordToken(email,
                SecureUtil.md5(password));
            // 使用Token：使用该token进行登录
            SecurityUtils.getSubject().login(token);
        } catch (AuthenticationException e) {
            // 使用Shiro框架中封装好的常见错误进行【异常处理】
            if (e instanceof UnknownAccountException) {
                return Result.fail("用户不存在");
            } else if (e instanceof LockedAccountException) {
                return Result.fail("用户被禁用");
            } else if (e instanceof IncorrectCredentialsException) {
                return Result.fail("密码错误");
            } else {
                return Result.fail("用户认证失败");
            }
        }

        /**
         * 如果登录成功，跳转/根页面
         */
        return Result.success().action("/");
    }

    /*--------------------------------------3.用户登出------------------------------------>*/

    /**
     * 登出：Shiro校验
     */
    @GetMapping("/user/logout")
    public String logout() {
        // Shiro将【当前用户】登出
        SecurityUtils.getSubject().logout();
        // 页面重定向至【根目录/】
        return "redirect:/";
    }
}

