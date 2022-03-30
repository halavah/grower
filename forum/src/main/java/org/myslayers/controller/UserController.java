package org.myslayers.controller;

import cn.hutool.core.map.MapUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.shiro.SecurityUtils;
import org.myslayers.common.lang.Result;
import org.myslayers.entity.Post;
import org.myslayers.entity.User;
import org.myslayers.entity.UserMessage;
import org.myslayers.shiro.AccountProfile;
import org.myslayers.utils.UploadUtil;
import org.myslayers.vo.UserMessageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UserController extends BaseController {

    @Autowired
    UploadUtil uploadUtil;

    /*--------------------------------------1.我的主页------------------------------------>*/

    /**
     * 我的主页
     */
    @GetMapping("/user/home")
    public String home() {
        //用户：从Shiro中获取用户
        User user = userService.getById(getProfileId());
        req.setAttribute("user", user);

        //文章：用户近期【30天】的文章
        List<Post> posts = postService.list(new QueryWrapper<Post>()
            .eq("user_id", getProfileId())
            .orderByDesc("created")
        );
        req.setAttribute("posts", posts);

        return "/user/home";
    }

    /*--------------------------------------2.基本设置------------------------------------>*/

    /**
     * 基本设置
     */
    @GetMapping("/user/set")
    public String set() {
        //用户：从Shiro中获取用户
        User user = userService.getById(getProfileId());
        req.setAttribute("user", user);

        return "/user/set";
    }

    /**
     * 基本设置：更新资料
     */
    @ResponseBody
    @PostMapping("/user/set")
    public Result doSet(User user) {
        //校验：昵称不能为空
        if (StrUtil.isBlank(user.getUsername())) {
            return Result.fail("昵称不能为空");
        }

        //校验：从数据库中查询【username是否存在】、【id并非当前用户】，如果count > 0，则代表“该昵称已被占用”
        int count = userService.count(new QueryWrapper<User>()
            .eq("username", getProfile().getUsername())
            .ne("id", getProfileId()));
        if (count > 0) {
            return Result.fail("该昵称已被占用");
        }

        //更新显示【数据库】：username、gender、sign -> 数据库 -> 刷新页面
        User temp = userService.getById(getProfileId());
        temp.setUsername(user.getUsername());
        temp.setGender(user.getGender());
        temp.setSign(user.getSign());
        userService.updateById(temp);

        //更新显示【Shiro】：更新 “AccountRealm类中，返回的AccountProfile对象” -> 【header.ftl】
        AccountProfile profile = getProfile();
        profile.setUsername(temp.getUsername());
        profile.setSign(temp.getSign());

        //方式二：利用session来实现【登录状态】，修改【更新资料/更新头像】后，需要【手动更新shiro/session数据】
        SecurityUtils.getSubject().getSession().setAttribute("profile", profile);

        return Result.success().action("/user/set#info");
    }

    /**
     * 基本设置：上传头像
     */
    @ResponseBody
    @PostMapping("/user/upload")
    public Result uploadAvatar(@RequestParam(value = "file") MultipartFile file)
        throws IOException {
        return uploadUtil.upload(UploadUtil.type_avatar, file);
    }

    /**
     * 基本设置：更新头像
     */
    @ResponseBody
    @PostMapping("/user/setAvatar")
    public Result doAvatar(User user) {
        if (StrUtil.isNotBlank(user.getAvatar())) {
            //更新显示【数据库】：avatar -> 数据库 -> 刷新页面
            User temp = userService.getById(getProfileId());
            temp.setAvatar(user.getAvatar());
            userService.updateById(temp);

            //更新显示【Shiro】：更新 “AccountRealm类中，返回的AccountProfile对象” -> 【header.ftl】
            AccountProfile profile = getProfile();
            profile.setAvatar(user.getAvatar());

            //方式二：利用session来实现【登录状态】，修改【更新资料/更新头像】后，需要【手动更新shiro/session数据】
            SecurityUtils.getSubject().getSession().setAttribute("profile", profile);

            return Result.success().action("/user/set#avatar");
        }
        return Result.success().action("/user/set#avatar");
    }

    /**
     * 基本设置：更新密码
     */
    @ResponseBody
    @PostMapping("/user/repass")
    public Result repass(String nowpass, String pass, String repass) {
        //判断nowpass与pass两次输入是否一致
        if (!pass.equals(repass)) {
            return Result.fail("两次密码不相同");
        }

        //判断nowpass是否正确
        User user = userService.getById(getProfileId());
        String nowPassMd5 = SecureUtil.md5(nowpass);
        if (!nowPassMd5.equals(user.getPassword())) {
            return Result.fail("密码不正确");
        }

        //如果nowpass正确，则更新密码
        user.setPassword(SecureUtil.md5(pass));
        userService.updateById(user);

        return Result.success().action("/user/set#pass");
    }

    /*--------------------------------------3.用户中心------------------------------------>*/

    /**
     * 用户中心
     */
    @GetMapping("/user/index")
    public String index() {
        return "/user/index";
    }

    /**
     * 用户中心：发布的贴
     */
    @ResponseBody
    @GetMapping("/user/publish")
    public Result userPublic() {
        IPage page = postService.page(getPage(), new QueryWrapper<Post>()
            .eq("user_id", getProfileId())
            .orderByDesc("created"));
        long total = page.getTotal();
        req.setAttribute("publishCount", total);
        return Result.success(page);
    }

    /**
     * 用户中心：收藏的贴
     */
    @ResponseBody
    @GetMapping("/user/collection")
    public Result userCollection() {
        IPage page = postService.page(getPage(), new QueryWrapper<Post>()
            .inSql("id", "SELECT post_id FROM m_user_collection where user_id = " + getProfileId())
        );
        req.setAttribute("collectionCount", page.getTotal());
        return Result.success(page);
    }

    /*--------------------------------------4.我的消息------------------------------------>*/

    /**
     * 我的消息：查询消息
     */
    @GetMapping("/user/mess")
    public String mess() {
        IPage<UserMessageVo> page = messageService.paging(getPage(), new QueryWrapper<UserMessage>()
            .eq("to_user_id", getProfileId())
            .orderByDesc("created")
        );
        req.setAttribute("pageData", page);

        //查看消息时，将全部消息的【状态：未读0】改为【状态：已读1】，并【批量修改 状态为已读1】
        List<Long> ids = new ArrayList<>();
        for (UserMessageVo messageVo : page.getRecords()) {
            if (messageVo.getStatus() == 0) {
                ids.add(messageVo.getId());
            }
        }
        messageService.updateToReaded(ids); //批量处理

        return "/user/mess";
    }

    /**
     * 我的消息：删除单个消息 或 删除全部消息（前端参数包含“all=true”，如果为ture时，使用【.eq(!all, "id", id))】 删除全部消息）
     */
    @ResponseBody
    @PostMapping("/message/remove/")
    public Result msgRemove(Long id, @RequestParam(defaultValue = "false") Boolean all) {
        boolean remove = messageService.remove(new QueryWrapper<UserMessage>()
            .eq("to_user_id", getProfileId())
            .eq(!all, "id", id));
        return remove ? Result.success(null) : Result.fail("删除失败");
    }

    /**
     * 我的消息：使用layout.ftl中 利用session来实现【登录状态】 后，发现【接口异常】， 查看后发现，【/res/mods/index.js】源码，【新消息通知 ->
     * layui.cache.user.uid !== -1】 -> 因此补充 status、count 数据接口
     */
    @ResponseBody
    @PostMapping("/message/nums/")
    public Map msgNums() {
        int count = messageService.count(new QueryWrapper<UserMessage>()
            .eq("to_user_id", getProfileId())//全部数量的消息
            .eq("status", "0")           //未读的消息  未读0 已读1
        );
        return MapUtil.builder("status", 0).put("count", count).build();
    }
}