package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.UserMessage;
import org.myslayers.mapper.UserMessageMapper;
import org.myslayers.service.UserMessageService;
import org.myslayers.vo.UserMessageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author myslayers
 * @since 2020-12-06
 */
@Service
public class UserMessageServiceImpl extends ServiceImpl<UserMessageMapper, UserMessage> implements UserMessageService {
    @Autowired
    UserMessageMapper messageMapper;

    @Override
    public IPage<UserMessageVo> paging(Page page, QueryWrapper<UserMessage> wrapper) {
        return messageMapper.selectMessages(page, wrapper);
    }
}
