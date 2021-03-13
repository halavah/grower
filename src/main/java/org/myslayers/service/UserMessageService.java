package org.myslayers.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.myslayers.entity.UserMessage;
import org.myslayers.vo.UserMessageVo;

public interface UserMessageService extends IService<UserMessage> {

    IPage<UserMessageVo> paging(Page page, QueryWrapper<UserMessage> wrapper);
}
