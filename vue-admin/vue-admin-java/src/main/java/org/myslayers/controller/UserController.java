package org.myslayers.controller;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.common.dto.PassDto;
import org.myslayers.common.lang.Const;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.Role;
import org.myslayers.entity.User;
import org.myslayers.entity.UserRole;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/sys/user")
public class UserController extends BaseController {
    
    /*--------------------------------------1.权限接口------------------------------------>*/
    @GetMapping("/info")
    public Result userInfo(Principal principal) {
        User user = userService.getByUsername(principal.getName());
        return Result.success("获取/sys/user/info成功！",
            MapUtil.builder()
                .put("id", user.getId())
                .put("username", user.getUsername())
                .put("avatar", user.getAvatar())
                .map()
        );
    }
    
    /*--------------------------------------2.增删改查------------------------------------>*/
    
    @GetMapping("/info/{userId}")
    @PreAuthorize("hasAuthority('sys:user:list')")
    public Result info(@PathVariable("userId") Long userId) {
        // 获取 user 对应的 roleIds
        List<UserRole> userRoles = userRoleService.list(new QueryWrapper<UserRole>().eq("user_id", userId));
        List<Long> roleIds = userRoles.stream().map(p ->
            p.getRoleId()
        ).collect(Collectors.toList());
        
        // 查看 user 用户信息
        User user = userService.getById(userId);
        user.setRoleIds(roleIds);
        
        return Result.success("获取/sys/user/info/{id}成功！", user);
    }
    
    @GetMapping("/list")
    @PreAuthorize("hasAuthority('sys:user:list')")
    public Result list(String name) {
        // 查看 user 用户信息（全部）
        Page<User> pageData = userService.page(getPage(),
            new QueryWrapper<User>().like(StrUtil.isNotBlank(name), "username", name)
        );
        
        // 获取 user 对应的 roles
        pageData.getRecords().forEach(u -> {
            List<Role> roles = roleService.listRolesByUserId(u.getId().longValue());
            u.setRoles(roles);
        });
        
        return Result.success("获取/sys/user/list成功！", pageData);
    }
    
    @PostMapping("/save")
    @PreAuthorize("hasAuthority('sys:user:save')")
    public Result save(@Validated @RequestBody User user) {
        // 增加 user 用户信息
        user.setPassword(new BCryptPasswordEncoder().encode(Const.DEFULT_PASSWORD));
        user.setAvatar(Const.DEFULT_AVATAR);
        user.setCreated(new Date());
        user.setModified(new Date());
        boolean flag = userService.save(user);
        
        return Result.success("获取/sys/user/save成功！", flag);
    }
    
    @PostMapping("/update")
    @PreAuthorize("hasAuthority('sys:user:update')")
    public Result update(@Validated @RequestBody User user) {
        // 更新 user 用户信息
        user.setModified(new Date());
        boolean flag = userService.updateById(user);
        
        // 清除 redis 权限信息
        userService.clearUserAuthorityInfoByUserName(user.getUsername());
        
        return Result.success("获取/sys/user/update成功！", flag);
    }
    
    @Transactional
    @PostMapping("/delete")
    @PreAuthorize("hasAuthority('sys:user:delete')")
    public Result delete(@RequestBody Long[] ids) {
        // 删除 role 用户信息
        boolean flag = userService.removeByIds(Arrays.asList(ids));
        
        // 删除 user_role 中间表
        userRoleService.remove(new QueryWrapper<UserRole>().in("user_id", ids));
        
        // 清除 redis 权限缓存
        Arrays.stream(ids).forEach(id -> {
            User user = userService.getById(id);
            userService.clearUserAuthorityInfoByUserName(user.getUsername());
        });
        
        return Result.success("获取/sys/user/delete成功！", flag);
    }
    
    /*--------------------------------------3.关联表------------------------------------>*/
    
    @Transactional
    @PostMapping("/role/{userId}")
    @PreAuthorize("hasAuthority('sys:user:role')")
    public Result rolePerm(@PathVariable("userId") Long userId, @RequestBody Long[] roleIds) {
        // 删除 user_role 原中间表
        userRoleService.remove(new QueryWrapper<UserRole>().eq("user_id", userId));
        
        // 增加 user_role 新中间表
        List<UserRole> userRoles = new ArrayList<UserRole>();
        Arrays.stream(roleIds).forEach(r -> {
            UserRole userRole = new UserRole();
            userRole.setRoleId(r);
            userRole.setUserId(userId);
            userRoles.add(userRole);
        });
        boolean flag = userRoleService.saveBatch(userRoles);
        
        // 清除 redis 权限缓存
        userService.clearUserAuthorityInfoByUserName(userService.getById(userId).getUsername());
        
        return Result.success("获取/sys/user/role/{userId}", flag);
    }
    
    /*--------------------------------------4.用户密码------------------------------------>*/
    
    @PostMapping("/repass")
    @PreAuthorize("hasAuthority('sys:user:repass')")
    public Result repass(@RequestBody Long userId) {
        // 更新 user 用户信息
        User user = userService.getById(userId);
        user.setPassword(new BCryptPasswordEncoder().encode(Const.DEFULT_PASSWORD));
        user.setModified(new Date());
        boolean flag = userService.updateById(user);
        
        return Result.success("获取/sys/user/repass成功", flag);
    }
    
    @PostMapping("/updatePass")
    public Result updatePass(@Validated @RequestBody PassDto passDto, Principal principal) {
        // 校验 旧密码 是否正确
        User user = userService.getByUsername(principal.getName());
        boolean matches = new BCryptPasswordEncoder().matches(passDto.getCurrentPass(), user.getPassword());
        if (!matches) {
            return Result.fail("旧密码不正确");
        }
        
        // 更新 user 用户信息
        user.setPassword(new BCryptPasswordEncoder().encode(passDto.getPassword()));
        user.setModified(new Date());
        boolean flag = userService.updateById(user);
        
        return Result.success("获取/sys/user/updatePass成功！", flag);
    }
    
    public static void main(String[] args) {
        
    }
}
