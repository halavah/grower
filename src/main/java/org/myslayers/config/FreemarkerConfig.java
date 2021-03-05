package org.myslayers.config;


import com.jagregory.shiro.freemarker.ShiroTags;
import org.myslayers.template.HotsTemplate;
import org.myslayers.template.PostsTemplate;
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

    @Autowired
    PostsTemplate postsTemplate;

    @Autowired
    HotsTemplate hotsTemplate;

    /**
     * 注册为“timeAgo”函数：快速实现日期转换
     * 注册为“posts”函数：快速实现分页
     */
    @PostConstruct
    public void setUp() {
        configuration.setSharedVariable("timeAgo", timeAgoMethod);
        configuration.setSharedVariable("details", postsTemplate);
        configuration.setSharedVariable("hots", hotsTemplate);
        configuration.setSharedVariable("shiro", new ShiroTags()); //shiro-freemarker-tags标签 -> 声明为shiro标签
    }
}

