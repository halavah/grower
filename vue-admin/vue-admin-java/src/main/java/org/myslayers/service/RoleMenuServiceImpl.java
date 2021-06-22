package org.myslayers.service;

import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import java.util.List;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.mapper.RoleMenuMapper;
import org.myslayers.entity.RoleMenu;
import org.myslayers.service.impl.RoleMenuService;

@Service
public class RoleMenuServiceImpl extends ServiceImpl<RoleMenuMapper, RoleMenu> implements RoleMenuService {
    
}


