package org.myslayers.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.myslayers.entity.Post;
import org.myslayers.vo.PostVo;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author myslayers
 * @since 2020-12-06
 */
public interface PostService extends IService<Post> {

    IPage<PostVo> selectPosts(Page page, Long categoryId, Long userId, Integer level, Boolean recommend, String order);

    PostVo selectOnePost(QueryWrapper<Post> warapper);

    void initWeekRank();
}