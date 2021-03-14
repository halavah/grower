package org.myslayers.mapper;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Param;
import org.myslayers.entity.UserMessage;
import org.myslayers.vo.UserMessageVo;
import org.springframework.transaction.annotation.Transactional;

public interface UserMessageMapper extends BaseMapper<UserMessage> {

    IPage<UserMessageVo> selectMessages(Page page, @Param(Constants.WRAPPER) QueryWrapper<UserMessage> wrapper);

    @Transactional
    void updateToReaded(@Param(Constants.WRAPPER) QueryWrapper<UserMessage> wrapper);
}
