package org.myslayers.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.myslayers.entity.User;

import java.util.List;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    List<Long> getNavMenuIds(Integer userId);
    
    List<User> listByMenuId(Integer menuId);
}