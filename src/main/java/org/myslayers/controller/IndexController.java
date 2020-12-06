package org.myslayers.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController{

//  @Autowired
//  PostService postService;

  @RequestMapping({"", "/", "/index"})
  public String index() {
//    //page(分页信息、分类、用户、置顶、精选、排序)
//    IPage<PostVo> results = postService.paging(getPage(), null, null, null, null, "created");
//
//    req.setAttribute("pageData", results);
//    req.setAttribute("currentCategoryId", 0);
    return "index";
  }
}



