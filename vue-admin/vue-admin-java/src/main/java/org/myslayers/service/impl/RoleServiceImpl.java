package org.myslayers.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.Role;
import org.myslayers.mapper.RoleMapper;
import org.myslayers.service.RoleService;
import org.springframework.stereotype.Service;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    
}


