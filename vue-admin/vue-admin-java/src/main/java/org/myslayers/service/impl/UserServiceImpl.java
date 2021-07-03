package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.config.utils.RedisUtil;
import org.myslayers.entity.Menu;
import org.myslayers.entity.Role;
import org.myslayers.entity.User;
import org.myslayers.mapper.UserMapper;
import org.myslayers.service.MenuService;
import org.myslayers.service.RoleService;
import org.myslayers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Autowired
    RedisUtil redisUtil;
    
    @Autowired
    RoleService roleService;
    
    @Autowired
    MenuService menuService;
    
    @Autowired
    UserMapper userMapper;
    
    /**
     * 根据 username 获取 User
     */
    @Override
    public User getByUsername(String username) {
        return getOne(new QueryWrapper<User>().eq("username", username));
    }
    
    /**
     * 根据 userId 获取 角色编码code、菜单权限perms
     */
    @Override
    public String getUserAuthorityInfo(Integer userId) {
        User user = userMapper.selectById(userId);
        
        // authority，形如：ROLE_admin,ROLE_normal,sys:user:list,sys:user:list,sys:role:list,sys:menu:list,sys:tools,sys:dict:list,...
        String authority = "";
        if (redisUtil.hasKey("GrantedAuthority:" + user.getUsername())) {
            authority = (String) redisUtil.get("GrantedAuthority:" + user.getUsername());
        } else {
            // 获取角色编码
            List<Role> roles = roleService.list(new QueryWrapper<Role>().inSql("id", "select role_id from sys_user_role where user_id = " + userId));
            if (roles.size() > 0) {
                // 使用 Stream 通过 , 将 全部编码 进行隔开，并以 String 形式返回
                String roleCodes = roles.stream().map(r -> "ROLE_" + r.getCode()).collect(Collectors.joining(","));
                authority = roleCodes.concat(",");
            }
            // 获取菜单操作编码
            List<Long> menuIds = userMapper.getNavMenuIds(userId);
            if (menuIds.size() > 0) {
                List<Menu> menus = menuService.listByIds(menuIds);
                String menuPerms = menus.stream().map(m -> m.getPerms()).collect(Collectors.joining(","));
                authority = authority.concat(menuPerms);
            }
            redisUtil.set("GrantedAuthority:" + user.getUsername(), authority, 60 * 60);
        }
        return authority;
    }
    
    @Override
    public void clearUserAuthorityInfoByUserName(String username) {
        redisUtil.del("GrantedAuthority:" + username);
    }
    
    @Override
    public void clearUserAuthorityInfoByRoleId(Integer roleId) {
        List<User> sysUsers = this.list(new QueryWrapper<User>().inSql("id", "select user_id from sys_user_role where role_id = " + roleId));
        sysUsers.forEach(u -> {
            this.clearUserAuthorityInfoByUserName(u.getUsername());
        });
    }
    
    @Override
    public void clearUserAuthorityInfoByMenuId(Integer menuId) {
        List<User> sysUsers = userMapper.listByMenuId(menuId);
        sysUsers.forEach(u -> {
            this.clearUserAuthorityInfoByUserName(u.getUsername());
        });
    }
}


