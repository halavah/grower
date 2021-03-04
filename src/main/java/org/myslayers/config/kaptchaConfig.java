package org.myslayers.config;

import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.Properties;

/**
 * kaptcha图片验证码配置类
 */
@Configuration
public class kaptchaConfig {

    @Bean
    public DefaultKaptcha producer () {
        Properties propertis = new Properties();
        //无边框
        propertis.put("kaptcha.border", "no");
        //高度
        propertis.put("kaptcha.image.height", "38");
        //长度
        propertis.put("kaptcha.image.width", "150");
        //字体颜色
        propertis.put("kaptcha.textproducer.font.color", "black");
        //字体大小
        propertis.put("kaptcha.textproducer.font.size", "32");
        Config config = new Config(propertis);
        DefaultKaptcha defaultKaptcha = new DefaultKaptcha();
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }
}

