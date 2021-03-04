package org.myslayers.service;

import org.myslayers.common.lang.Result;
import org.myslayers.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author myslayers
 * @since 2020-12-06
 */
public interface UserService extends IService<User> {

    Result register(User user);

}
