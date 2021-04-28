package org.myslayers.controller;


import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import java.util.Map;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.User;
import org.myslayers.service.UserService;
import org.myslayers.utils.JwtUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * <p>
 * 用户信息 前端控制器
 * </p>
 *
 * @author org.myslayers
 * @since 2021-03-31
 */
@RestController
public class UserController extends BaseController {

    @Autowired
    UserService userService;

    @Autowired
    JwtUtils jwtUtils;

    /*--------------------------------------1.用户登录/登出------------------------------------>*/

    @ResponseBody
    @PostMapping("/login")
    public Result login(@RequestBody Map<String, String> map) {
        //使用Map对象接收一个json对象
        String username = map.get("username");
        String password = map.get("password");

        //判断输入是否为空
        if (StrUtil.isEmpty(username) || StrUtil.isBlank(password)) {
            return Result.fail("账号或密码不能为空");
        }
        //根据username查询该用户
        User user = userService.getOne(new QueryWrapper<User>().eq("username", username));
        //判断用户是否存在
        Assert.notNull(user, "用户不存在!");
        //判断密码是否正确
        if (!user.getPassword().equals(SecureUtil.md5(password))) {
            return Result.fail("密码不正确！");
        }

        //登录成功后，根据 用户id 生成 jwt token，并将 jwt 返回至 response 的 header 请求头中
        String jwt = jwtUtils.generateToken(user.getId());
        resp.setHeader("Authorization", jwt);
        resp.setHeader("Access-control-Expose-Headers", "Authorization");

        return Result.success("登录成功！", MapUtil.builder()
            .put("id", user.getId())
            .put("username", user.getUsername())
            .put("avatar", user.getAvatar())
            .put("email", user.getEmail())
            .map()
        );
    }

    @RequiresAuthentication
    @GetMapping("/logout")
    public Result logout() {
        SecurityUtils.getSubject().logout();
        return Result.success("退出登录！");
    }

}