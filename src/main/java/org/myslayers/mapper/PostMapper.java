package org.myslayers.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.myslayers.entity.Post;
import org.myslayers.vo.PostVo;

public interface PostMapper extends BaseMapper<Post> {

    IPage<PostVo> selectPosts(Page page, @Param(Constants.WRAPPER) QueryWrapper<Post> wrapper);

    PostVo selectOnePost(@Param(Constants.WRAPPER) QueryWrapper<Post> warapper);
}
