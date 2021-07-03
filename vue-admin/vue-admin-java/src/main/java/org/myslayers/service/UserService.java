package org.myslayers.service;

import org.myslayers.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

public interface UserService extends IService<User> {
    
    User getByUsername(String username);
    
    String getUserAuthorityInfo(Integer userId);
    
    public void clearUserAuthorityInfoByUserName(String username);
    
    public void clearUserAuthorityInfoByRoleId(Integer roleId);
    
    public void clearUserAuthorityInfoByMenuId(Integer menuId);
}


