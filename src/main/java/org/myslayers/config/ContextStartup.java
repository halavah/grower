package org.myslayers.config;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.myslayers.entity.Category;
import org.myslayers.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import javax.servlet.ServletContext;
import java.util.List;

/**
 * 实现ApplicationRunner中的run方法, ServletContextAware的setServletContext方法
 */
@Component
public class ContextStartup implements ApplicationRunner, ServletContextAware {

    @Autowired
    CategoryService categoryService;

    ServletContext servletContext;

    /**
     * 项目启动时，会同时调用该run方法：提前加载导航栏中的“提问、分享、讨论、建议”，并将其list放入servletContext上下文对象
     */
    @Override
    public void run(ApplicationArguments args) throws Exception {
        List<Category> categories = categoryService.list(new QueryWrapper<Category>()
                .eq("status", 0)
        );
        servletContext.setAttribute("categorys", categories);
    }

    /**
     * servletContext上下文对象
     */
    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

}
