package org.myslayers.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.myslayers.entity.Comment;
import org.myslayers.vo.CommentVo;

public interface CommentService extends IService<Comment> {

    IPage<CommentVo> selectComments(Page page, Long postId, Long userId, String order);
}
