package org.myslayers.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.myslayers.entity.UserCollection;
import org.myslayers.mapper.UserCollectionMapper;
import org.myslayers.service.UserCollectionService;
import org.springframework.stereotype.Service;

@Service
public class UserCollectionServiceImpl extends ServiceImpl<UserCollectionMapper, UserCollection> implements UserCollectionService {

}
