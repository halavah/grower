package org.myslayers.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.UserRole;
import org.myslayers.mapper.UserRoleMapper;
import org.myslayers.service.UserRoleService;
import org.springframework.stereotype.Service;

@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {
    
}


