package org.myslayers.forum.app.manager;

import org.springframework.stereotype.Component;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.app.support.PageUtil;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Posts;
import org.myslayers.forum.domain.service.SearchService;

import javax.annotation.Resource;

@Component
public class SearchManager extends AbstractPostsManager {

    @Resource
    private SearchService searchService;

    public PageResponseModel<PostsVO> pagePostsSearch(PageRequestModel<String> pageRequestModel) {
        PageResult<Posts> pageResult = searchService.pagePosts(PageUtil.buildPageRequest(pageRequestModel, pageRequestModel.getFilter()));

        return pagePostsVO(pageResult);
    }
}
