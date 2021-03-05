package org.myslayers.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.User;
import org.myslayers.mapper.UserMapper;
import org.myslayers.service.UserService;
import org.myslayers.shiro.AccountProfile;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author myslayers
 * @since 2020-12-06
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public Result register(User user) {
        /**
         * 查询【用户名或邮箱】是否被占用
         */
        int count = this.count(new QueryWrapper<User>()
                .eq("email", user.getEmail())
                .or()
                .eq("username", user.getUsername())
        );
        if (count > 0) {
            return Result.fail("用户名或邮箱已被占用");
        }

        /**
         * 设置【新注册用户】中属性：
         *
         * 1.防止前端对传来数据进行伪造，因此，重新获取name、password、email重要属性
         * 2.对其他属性进行默认额外处理，比如，Avatar、Created、Point、VipLevel、CommentCount、PostCount、Gender
         */
        User temp = new User();
        temp.setUsername(user.getUsername());
        temp.setPassword(SecureUtil.md5(user.getPassword()));//SecureUtil使用md5对password加密
        temp.setEmail(user.getEmail());
        temp.setAvatar("/res/images/avatar/default.png");
        temp.setCreated(new Date());
        temp.setPoint(0);
        temp.setVipLevel(0);
        temp.setCommentCount(0);
        temp.setPostCount(0);
        temp.setGender("0");
        this.save(temp);
        return Result.success();
    }

    @Override
    public AccountProfile login(String email, String password) {
        /**
         * 查询【用户名或邮箱】是否正确：通过【数据库中获取的username、password】与【token中获取的username、password】进行对比
         */
        User user = this.getOne(new QueryWrapper<User>().eq("email", email));
        //用户名不存在，抛出异常
        if(user == null) {
            throw new UnknownAccountException();
        }
        //用户密码不正确，抛出异常
        if(!user.getPassword().equals(password)){
            throw new IncorrectCredentialsException();
        }
        //更新用户最后登录时间，并updateById将user写入到数据库
        user.setLasted(new Date());
        this.updateById(user);

        /**
         * 将查询后的user结果，复制一份给AccountProfile
         *
         * copyProperties(Object source, Object target) ：将source复制给target目标对象
         */
        AccountProfile profile = new AccountProfile();
        BeanUtil.copyProperties(user, profile);
        return profile;
    }
}