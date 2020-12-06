package org.myslayers.config;


import org.myslayers.template.TimeAgoMethod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

/**
 * Freemarker配置类
 */
@Configuration
public class FreemarkerConfig {

    @Autowired
    private freemarker.template.Configuration configuration;

    @Autowired
    TimeAgoMethod timeAgoMethod;

    /**
     * 注册为“timeAgo”函数：快速实现日期转换
     */
    @PostConstruct
    public void setUp() {
        configuration.setSharedVariable("timeAgo", timeAgoMethod);
    }
}

