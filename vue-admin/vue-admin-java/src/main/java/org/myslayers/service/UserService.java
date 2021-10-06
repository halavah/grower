package org.myslayers.service;

import org.myslayers.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

public interface UserService extends IService<User> {
    
    User getByUsername(String username);
    
    String getUserAuthorityInfo(Integer userId);
    
    void clearUserAuthorityInfoByUserName(String username);
    
    void clearUserAuthorityInfoByRoleId(Integer roleId);
    
    void clearUserAuthorityInfoByMenuId(Integer menuId);
}


