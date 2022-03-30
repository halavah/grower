package org.myslayers.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.User;
import org.myslayers.shiro.AccountProfile;

public interface UserService extends IService<User> {

    Result register(User user);

    AccountProfile login(String email, String password);
}
