package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.Role;
import org.myslayers.mapper.RoleMapper;
import org.myslayers.service.RoleService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    
    @Override
    public List<Role> listRolesByUserId(Long userId) {
        List<Role> sysRoles = this.list(new QueryWrapper<Role>()
            .inSql("id", "select role_id from sys_user_role where user_id = " + userId)
        );
        return sysRoles;
    }
}