package org.myslayers.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.myslayers.entity.Comment;
import org.myslayers.vo.CommentVo;

public interface CommentMapper extends BaseMapper<Comment> {

    IPage<CommentVo> selectComments(Page page, @Param(Constants.WRAPPER) QueryWrapper<Comment> orderByDesc);

}
