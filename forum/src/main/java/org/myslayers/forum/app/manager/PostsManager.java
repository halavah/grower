package org.myslayers.forum.app.manager;

import org.springframework.stereotype.Component;
import org.myslayers.forum.api.model.PageRequestModel;
import org.myslayers.forum.api.model.PageResponseModel;
import org.myslayers.forum.api.vo.PostsVO;
import org.myslayers.forum.app.support.IsLogin;
import org.myslayers.forum.app.support.LoginUserContext;
import org.myslayers.forum.app.support.PageUtil;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Posts;
import org.myslayers.forum.domain.repository.UserFoodRepository;

import javax.annotation.Resource;


@Component
public class PostsManager extends AbstractPostsManager {

    @Resource
    private UserFoodRepository userFoodRepository;

    @IsLogin
    public PageResponseModel<PostsVO> pagePostsFood(PageRequestModel pageRequestModel) {
        PageResult<Posts> pageResult = userFoodRepository.pagePosts(PageUtil.buildPageRequest(pageRequestModel, LoginUserContext.getUser().getId()));

        return pagePostsVO(pageResult);
    }
}
