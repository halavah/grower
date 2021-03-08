package org.myslayers.config;

import org.myslayers.common.lang.Consts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * SpringMvc配置类
 */
@Configuration
public class SpringMvcConfig implements WebMvcConfigurer {

    @Autowired
    Consts consts;

    /**
     * 重写父类addResourceHandlers方法（识别非静态资源目录：/upload/avatar/**）
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/upload/avatar/**")
                .addResourceLocations("file:///" + consts.getUploadDir() + "/avatar/");
    }
}
