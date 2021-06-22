package org.myslayers.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.myslayers.entity.User;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}