package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.Comment;
import org.myslayers.mapper.CommentMapper;
import org.myslayers.service.CommentService;
import org.myslayers.vo.CommentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements CommentService {

    @Autowired
    CommentMapper commentMapper;

    @Override
    public IPage<CommentVo> selectComments(Page page, Long postId, Long userId, String order) {
        QueryWrapper<Comment> wrapper = new QueryWrapper<Comment>()
            .eq(postId != null, "post_id", postId)
            .eq(userId != null, "user_id", userId)
            .orderByDesc(order != null, order);
        return commentMapper.selectComments(page, wrapper);
    }
}


