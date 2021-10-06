package org.myslayers.service;

import org.myslayers.common.dto.MenuDto;
import org.myslayers.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

public interface MenuService extends IService<Menu> {
    
    List<MenuDto> getUserMenuInfo();
    
    List<Menu> getAllMenuInfo();
    
    List<Menu> listMenusByRoleId(Long roleId);
}


