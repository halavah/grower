package org.myslayers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class PostController {

    @RequestMapping("/category/{id:\\d*}")
    public String category(@PathVariable(name = "id") long id) {
//        //根据category表中当前页的id -> 渲染heder-panel.ftl（(item.id == currentCategoryId)? string('layui-hide-xs layui-this', '')）
//        req.setAttribute("currentCategoryId", id);
        return "post/category";
    }

    @RequestMapping("/post/{id:\\d*}")
    public String detail(@PathVariable(name = "id") long id) {
        return "post/detail";
    }
}





