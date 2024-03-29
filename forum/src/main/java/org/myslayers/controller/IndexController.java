package org.myslayers.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import org.myslayers.vo.PostVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController extends BaseController {

    /*--------------------------------------首页index--------------------------------------->*/

    /**
     * 首页index
     */
    @GetMapping({"", "/", "/index", "/index.html"})
    public String index() {
        /**
         * 多条（post实体类、PostVo实体类）：分页集合results
         */
        //多条：selectPosts(分页信息、分类id、用户id、置顶、精选、排序)
        IPage<PostVo> results = postService
            .selectPosts(getPage(), null, null, null, null, "created");
        req.setAttribute("postVoDatas", results);

        /**
         * 分类（传入id） -> 渲染分类
         */
        //req：根据传入category表中当前页的id -> 【渲染】分类
        req.setAttribute("currentCategoryId", 0);

        return "index";
    }

    /*--------------------------------------搜索search--------------------------------------->*/

    /**
     * 搜索 Elasticsearch
     */
    @GetMapping("/search")
    public String search(String q) {
        //使用自定义es的search方法，进行查询
        IPage pageData = searchService.search(getPage(), q);

        //关键词：${q}
        req.setAttribute("q", q);
        //搜索结果：${pageData.total}、${pageData.records}
        req.setAttribute("pageData", pageData);

        return "search";
    }
}