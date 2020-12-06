package org.myslayers.service.impl;

import org.myslayers.entity.Category;
import org.myslayers.mapper.CategoryMapper;
import org.myslayers.service.CategoryService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author myslayers
 * @since 2020-12-06
 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

}
