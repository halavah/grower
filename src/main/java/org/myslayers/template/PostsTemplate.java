package org.myslayers.template;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.common.templates.DirectiveHandler;
import org.myslayers.common.templates.TemplateDirective;
import org.myslayers.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class PostsTemplate extends TemplateDirective {

    @Autowired
    PostService postService;

    @Override
    public String getName() {
        return "posts";
    }

    @Override
    public void execute(DirectiveHandler handler) throws Exception {
        // 置顶等级level
        Integer level = handler.getInteger("level");
        // 页码pn
        Integer pn = handler.getInteger("pn", 1);
        // 页面大小size
        Integer size = handler.getInteger("size", 2);
        // 分类信息categoryId
        Long categoryId = handler.getLong("categoryId");
        IPage page = postService.paging(new Page(pn, size), categoryId, null, level, null, "created");
        handler.put(RESULTS, page).render();
    }
}


