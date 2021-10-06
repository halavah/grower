package org.myslayers.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.common.dto.MenuDto;
import org.myslayers.entity.Menu;
import org.myslayers.entity.User;
import org.myslayers.mapper.MenuMapper;
import org.myslayers.mapper.UserMapper;
import org.myslayers.service.MenuService;
import org.myslayers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {
    
    @Autowired
    UserService userService;
    
    @Autowired
    UserMapper userMapper;
    
    /**
     * 获取 Menu 菜单信息（用户）
     */
    @Override
    public List<MenuDto> getUserMenuInfo() {
        // 获取 User 信息
        String username = (String) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        User user = userService.getByUsername(username);
        
        // 获取 User 对应的 menu 菜单信息
        List<Menu> menus = this.listByIds(userMapper.getNavMenuIds(user.getId()));
        
        // 将 menu 从 List 转换为 树状结构的 List
        List<Menu> menuTree = buildTreeMenu(menus);
        
        // 实体转DTO
        return convert(menuTree);
    }
    
    /**
     * 获取 Menu 菜单信息（全部）
     */
    @Override
    public List<Menu> getAllMenuInfo() {
        // 获取 全部 menu 菜单信息
        List<Menu> sysMenus = this.list(new QueryWrapper<Menu>().orderByAsc("sorted"));
        
        // 将 menu 从 List 转换为 树状结构的 List
        return buildTreeMenu(sysMenus);
    }
    
    @Override
    public List<Menu> listMenusByRoleId(Long roleId) {
        List<Menu> sysMenus = this.list(new QueryWrapper<Menu>()
            .inSql("id", "select menu_id from sys_role_menu where role_id = " + roleId)
        );
        return sysMenus;
    }
    
    // 将 menu 从 List 转换为 树状结构的 List
    private List<Menu> buildTreeMenu(List<Menu> menus) {
        ArrayList<Menu> finalMenus = new ArrayList<>();
        for (Menu menu1 : menus) {
            // 将 Menu 表中，根据 id 与 parentId 进行匹配，并将 父子关系 以 List 方式 进行存储
            for (Menu menu2 : menus) {
                if (Objects.equals(menu1.getId().longValue(), menu2.getParentId())) {
                    menu1.getChildren().add(menu2);
                }
            }
            // 将 系统工具、用户管理-角色管理-菜单管理、... 提取出 最终父节点（系统工具），以 finalMenus 列表的形式 进行存储
            if (menu1.getParentId() == 0L) {
                finalMenus.add(menu1);
            }
        }
        return finalMenus;
    }
    
    // 实体类 转 DTO类
    private List<MenuDto> convert(List<Menu> menuTree) {
        List<MenuDto> menuDtos = new ArrayList<>();
        menuTree.forEach(m -> {
            MenuDto dto = new MenuDto();
            dto.setId(m.getId());
            dto.setParentId(m.getParentId());
            dto.setTitle(m.getTitle());
            dto.setName(m.getName());
            dto.setPath(m.getPath());
            dto.setIcon(m.getIcon());
            dto.setPerms(m.getPerms());
            dto.setComponent(m.getComponent());
            dto.setSorted(m.getSorted());
            dto.setType(m.getType());
            dto.setStatus(m.getStatus());
            dto.setCreated(m.getCreated());
            dto.setModified(m.getModified());
            // 递归调用：如果该节点有子节点，则调用 convert 进行递归转换
            if (m.getChildren().size() > 0) {
                dto.setChildren(convert(m.getChildren()));
            }
            // 将 每一个转换的 dto 全部存放到 menuDtos 中
            menuDtos.add(dto);
        });
        return menuDtos;
    }
}
