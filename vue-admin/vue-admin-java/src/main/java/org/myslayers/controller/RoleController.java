package org.myslayers.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.Menu;
import org.myslayers.entity.Role;
import org.myslayers.entity.RoleMenu;
import org.myslayers.entity.UserRole;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/sys/role")
public class RoleController extends BaseController {
    
    /*--------------------------------------1.权限接口------------------------------------>*/
    
    
    /*--------------------------------------2.增删改查------------------------------------>*/
    @GetMapping("/info/{roleId}")
    @PreAuthorize("hasAnyAuthority('sys:role:list')")
    public Result info(@PathVariable("roleId") Long roleId) {
        // 获取 role 对应的 menuIds
        List<RoleMenu> roleMenus = roleMenuService.list(new QueryWrapper<RoleMenu>().eq("role_id", roleId));
        List<Long> menuIds = roleMenus.stream().map(p ->
            p.getMenuId()
        ).collect(Collectors.toList());
        
        // 查看 role 角色信息
        Role role = roleService.getById(roleId);
        role.setMenuIds(menuIds);
        
        return Result.success("获取/sys/role/info成功！", role);
    }
    
    @GetMapping("/list")
    @PreAuthorize("hasAuthority('sys:role:list')")
    public Result list(String name) {
        // 查看 role 角色信息（全部）
        Page<Role> pageData = roleService.page(getPage(),
            new QueryWrapper<Role>().like(StrUtil.isNotBlank(name), "name", name)
        );
        
        // 获取 role 对应的 menus
        pageData.getRecords().forEach(u -> {
            List<Menu> menus = menuService.listMenusByRoleId(u.getId().longValue());
            u.setMenus(menus);
        });
        
        return Result.success("获取/sys/role/list", pageData);
    }
    
    @PostMapping("/save")
    @PreAuthorize("hasAuthority('sys:role:save')")
    public Result save(@Validated @RequestBody Role role) {
        // 增加 role 角色信息
        role.setCreated(new Date());
        role.setModified(new Date());
        boolean flag = roleService.save(role);
        
        return Result.success("获取/sys/role/save成功！", flag);
    }
    
    @PostMapping("/update")
    @PreAuthorize("hasAuthority('sys:role:update')")
    public Result update(@Validated @RequestBody Role role) {
        // 更新 role 角色信息
        role.setModified(new Date());
        boolean flag = roleService.updateById(role);
        
        // 清除 redis 权限缓存
        userService.clearUserAuthorityInfoByRoleId(role.getId());
        
        return Result.success("获取/sys/role/update成功！", flag);
    }
    
    @Transactional
    @PostMapping("/delete")
    @PreAuthorize("hasAuthority('sys:role:delete')")
    public Result delete(@RequestBody Long[] ids) {
        // 删除 role 角色信息
        boolean flag = roleService.removeByIds(Arrays.asList(ids));
        
        // 删除 user_role 中间表
        userRoleService.remove(new QueryWrapper<UserRole>().in("role_id", ids));
        
        // 删除 role_menu 中间表
        roleMenuService.remove(new QueryWrapper<RoleMenu>().in("role_id", ids));
        
        // 清除 redis 权限缓存
        Arrays.stream(ids).forEach(id -> {
            userService.clearUserAuthorityInfoByRoleId(id.intValue());
        });
        
        return Result.success("获取/sys/role/delete成功！", flag);
    }
    
    /*--------------------------------------3.关联表------------------------------------>*/
    
    @Transactional
    @PostMapping("/menu/{roleId}")
    @PreAuthorize("hasAuthority('sys:role:perm')")
    public Result delete(@PathVariable("roleId") Long roleId, @RequestBody Long[] menuIds) {
        // 删除 role_menu 原中间表
        roleMenuService.remove(new QueryWrapper<RoleMenu>().eq("role_id", roleId));
        
        // 增加 role_menu 新中间表
        ArrayList<RoleMenu> roleMenus = new ArrayList<>();
        Arrays.stream(menuIds).forEach(menuId -> {
            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setRoleId(roleId);
            roleMenu.setMenuId(menuId);
            roleMenus.add(roleMenu);
        });
        boolean flag = roleMenuService.saveBatch(roleMenus);
        
        // 删除 redis 权限缓存
        userService.clearUserAuthorityInfoByRoleId(roleId.intValue());
        
        return Result.success("获取/sys/role/menu/{roleId}成功", flag);
    }
}
