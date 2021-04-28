package org.myslayers.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.Post;
import org.myslayers.mapper.PostMapper;
import org.myslayers.service.PostService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 用户文章 服务实现类
 * </p>
 *
 * @author org.myslayers
 * @since 2021-03-31
 */
@Service
public class PostServiceImpl extends ServiceImpl<PostMapper, Post> implements PostService {

}
