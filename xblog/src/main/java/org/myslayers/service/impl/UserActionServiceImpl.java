package org.myslayers.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.UserAction;
import org.myslayers.mapper.UserActionMapper;
import org.myslayers.service.UserActionService;
import org.springframework.stereotype.Service;

@Service
public class UserActionServiceImpl extends ServiceImpl<UserActionMapper, UserAction> implements UserActionService {

}
