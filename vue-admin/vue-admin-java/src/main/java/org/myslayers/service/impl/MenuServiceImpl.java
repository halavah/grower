package org.myslayers.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.Menu;
import org.myslayers.mapper.MenuMapper;
import org.myslayers.service.MenuService;
import org.springframework.stereotype.Service;

@Service
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {
    
}


