package org.myslayers.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.myslayers.entity.Role;

import java.util.List;

public interface RoleService extends IService<Role> {
    
    
    List<Role> listRolesByUserId(Long userId);
}


