package org.myslayers.template;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.common.templates.DirectiveHandler;
import org.myslayers.common.templates.TemplateDirective;
import org.myslayers.service.PostService;
import org.myslayers.vo.PostVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * 文章具体详情
 */
@Component
public class PostsTemplate extends TemplateDirective {

    @Autowired
    PostService postService;

    @Override
    public String getName() {
        return "details";
    }

    /**
     * 分页外（置顶） -> 默认分页的基本信息
     */
    @Override
    public void execute(DirectiveHandler handler) throws Exception {
        // 置顶等级level
        Integer level = handler.getInteger("level",1);
        // 起始页码pn
        Integer pn = handler.getInteger("pn", 1);
        // 页面大小size
        Integer size = handler.getInteger("size", 2);
        // 分类信息categoryId
        Long categoryId = handler.getLong("categoryId");

        /**
         * 多条（post实体类、PostVo实体类）：分页集合results：
         *   1.封装level、pn、size、categoryId
         *   2.注册为“posts”函数：默认调用该函数时，自动查询 -> 分页集合results
         */
        IPage<PostVo> page = postService.selectPosts(new Page(pn, size), categoryId, null, level, null, "created");
        handler.put(RESULTS, page).render();
    }
}

