package org.myslayers.controller;

import cn.hutool.core.map.MapUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.myslayers.common.dto.MenuDto;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.Menu;
import org.myslayers.entity.RoleMenu;
import org.myslayers.entity.User;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/sys/menu")
public class MenuController extends BaseController {
    
    /*--------------------------------------1.权限接口------------------------------------>*/
    
    @GetMapping("/nav")
    public Result nav(Principal principal) {
        // 1.获取 authority 权限信息：根据 userId 获取 角色编码code、菜单权限perms
        User user = userService.getByUsername(principal.getName());
        String authorityInfo = userService.getUserAuthorityInfo(user.getId());
        String[] authorityInfoArray = StringUtils.tokenizeToStringArray(authorityInfo, ",");
        
        // 2.获取 Menu 菜单信息（用户）
        List<MenuDto> navs = menuService.getUserMenuInfo();
        
        return Result.success("获取/sys/menu/nav成功！",
            MapUtil.builder()
                .put("authoritys", authorityInfoArray)
                .put("nav", navs)
                .map()
        );
    }
    
    /*--------------------------------------2.增删改查------------------------------------>*/
    
    @GetMapping("/info/{menuId}")
    @PreAuthorize("hasAuthority('sys:menu:list')")
    public Result info(@PathVariable("menuId") Long menuId) {
        // 查看 menu 菜单信息
        Menu menu = menuService.getById(menuId);
        
        return Result.success("获取/sys/menu/info成功！", menu);
    }
    
    @GetMapping("/list")
    @PreAuthorize("hasAuthority('sys:menu:list')")
    public Result list() {
        // 查看 menu 菜单信息（全部）
        List<Menu> menus = menuService.getAllMenuInfo();
        
        return Result.success("获取/sys/menu/list成功！", menus);
    }
    
    @PostMapping("/save")
    @PreAuthorize("hasAuthority('sys:menu:save')")
    public Result save(@Validated @RequestBody Menu menu) {
        // 增加 menu 菜单信息
        menu.setCreated(new Date());
        boolean flag = menuService.save(menu);
        
        return Result.success("获取/sys/menu/save成功！", flag);
    }
    
    @PostMapping("/update")
    @PreAuthorize("hasAuthority('sys:menu:update')")
    public Result update(@Validated @RequestBody Menu menu) {
        // 更新 menu 菜单信息
        menu.setModified(new Date());
        boolean flag = menuService.updateById(menu);
        
        // 清除 redis 权限缓存
        userService.clearUserAuthorityInfoByMenuId(menu.getId());
        
        return Result.success("获取/sys/menu/update成功！", flag);
    }
    
    @PostMapping("/delete/{menuId}")
    @PreAuthorize("hasAuthority('sys:menu:delete')")
    public Result delete(@PathVariable("menuId") Long menuId) {
        // 判断 是否 存在子菜单
        if (menuService.count(new QueryWrapper<Menu>().eq("parent_id", menuId)) > 0) {
            return Result.fail("请先删除子菜单");
        }
        
        // 删除 menu 菜单信息
        boolean flag = menuService.removeById(menuId);
    
        // 删除 role_menu 中间表
        roleMenuService.remove(new QueryWrapper<RoleMenu>().eq("menu_id", menuId));
        
        // 清除 redis 权限缓存
        userService.clearUserAuthorityInfoByMenuId(menuId.intValue());
        
        return Result.success("获取/sys/menu/delete成功！", flag);
    }
}
