package org.myslayers.controller;

import com.google.code.kaptcha.Producer;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.User;
import org.myslayers.utils.ValidationUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.IOException;

@Controller
public class AuthController extends BaseController {

    private static final String KAPTCHA_SESSION_KEY = "KAPTCHA_SESSION_KEY";

    @Autowired
    Producer producer;

    /**
     * 图片验证码
     */
    @GetMapping("/capthca.jpg")
    public void kaptcha(HttpServletResponse resp) throws IOException {
        // 1.生成text、image
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
     * 登录
     */
    @GetMapping("/login")
    public String login() {
        return "/auth/login";
    }

    /**
     * 注册
     */
    @GetMapping("/register")
    public String register() {
        return "/auth/reg";
    }

    /**
     * 注册：校验
     */
    @ResponseBody
    @PostMapping("/register")
    public Result doRegister(User user, String repass, String vercode) {
        // 使用ValidationUtil工具类，校验【输入是否错误】
        ValidationUtil.ValidResult validResult = ValidationUtil.validateBean(user);
        if(validResult.hasErrors()) {
            return Result.fail(validResult.getErrors());
        }

        // 校验【密码是否一致】
        if(!user.getPassword().equals(repass)) {
            return Result.fail("两次输入密码不相同");
        }

        // 校验【验证码是否正确】：从session中获取KAPTCHA_SESSION_KEY，即正确的验证码【text】
        String kaptcha_session_key = (String) req.getSession().getAttribute("KAPTCHA_SESSION_KEY");
        System.out.println(kaptcha_session_key);
        if(vercode == null || !vercode.equalsIgnoreCase(kaptcha_session_key)) {
            return Result.fail("验证码输入不正确");
        }

        // 完成注册
        Result result = userService.register(user);
        // 如果校验成功，则完成注册，跳转/login页面
        return result.action("/login");
    }
}

