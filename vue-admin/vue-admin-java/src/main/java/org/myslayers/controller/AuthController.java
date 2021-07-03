package org.myslayers.controller;

import cn.hutool.core.map.MapUtil;
import com.google.code.kaptcha.Producer;
import org.myslayers.common.lang.Const;
import org.myslayers.common.lang.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import sun.misc.BASE64Encoder;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.UUID;

@RestController
public class AuthController extends BaseController{
    @Autowired
    Producer producer;
    
    /*--------------------------------------0.接口测试------------------------------------>*/
    
    @PreAuthorize("hasRole('admin')")
    @GetMapping("/test")
    public Result test() {
        return Result.success("操作成功！", userService.list());
    }
    
    @PreAuthorize("hasAuthority('sys:user:list')")
    @GetMapping("/test2")
    public Result test2() {
        return Result.success("操作成功！", roleService.list());
    }
    
    /*--------------------------------------1.权限接口------------------------------------>*/
    
    /**
     * 图片验证码
     */
    @GetMapping("/captcha")
    public Result captcha() throws IOException {
        // 1.生成 key、code
        String key = UUID.randomUUID().toString();
        String code = producer.createText();
        
        // Redis：利用哈希表，将【key】-【code】存储到【Const.CAPTCHA_KEY】中
        redisUtil.hset(Const.CAPTCHA_KEY, key, code, 120);
        
        // 2.通过 IO 输出 codeImage
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        BufferedImage image = producer.createImage(code);
        ImageIO.write(image, "jpg", outputStream);
        
        // 3.codeImage 经 BASE64 后生成 codeBase64Image
        String str = "data:image/jpeg;base64,";
        BASE64Encoder encoder = new BASE64Encoder();
        String codeBase64Image = str + encoder.encode(outputStream.toByteArray());
        
        return Result.success(
            "操作成功！",
            MapUtil.builder()
                .put("key", key)
                .put("codeBase64Image", codeBase64Image)
                .build()
        );
    }
    
    // /doLogin：SpringSecurity 提供
    
    // /doLogout：SpringSecurity 提供
}
