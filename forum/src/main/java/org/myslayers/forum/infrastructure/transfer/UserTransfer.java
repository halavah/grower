package org.myslayers.forum.infrastructure.transfer;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.util.ObjectUtils;
import org.myslayers.forum.common.enums.*;
import org.myslayers.forum.common.support.SafesUtil;
import org.myslayers.forum.domain.entity.Follow;
import org.myslayers.forum.domain.entity.User;
import org.myslayers.forum.infrastructure.dal.dataobject.UserDO;
import org.myslayers.forum.infrastructure.dal.dataobject.UserFollowDO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserTransfer {

    private static final String EXT_KET_GITHUB_USER = "githubUser";

    public static Follow toFollow(UserFollowDO userFollowDO) {
        Follow follow = Follow.builder()
                .followed(userFollowDO.getFollowed())
                .followedType(FollowedTypeEn.getEntity(userFollowDO.getFollowedType()))
                .follower(userFollowDO.getFollower())
                .build();
        follow.setCreateAt(userFollowDO.getCreateAt());
        follow.setId(userFollowDO.getId());
        follow.setUpdateAt(userFollowDO.getUpdateAt());

        return follow;
    }

    public static UserDO toUserDO(User user) {
        if (ObjectUtils.isEmpty(user)) {
            return null;
        }

        UserDO userDO = UserDO.builder()
                .ext("{}")
                .avatar(user.getAvatar())
                .email(user.getEmail())
                .nickname(user.getNickname())
                .password(user.getPassword())
                .signature(user.getSignature())
                .lastLoginTime(user.getLastLoginTime())
                .build();

        if (!ObjectUtils.isEmpty(user.getSource())) {
            userDO.setSource(user.getSource().getValue());
        }
        if (!ObjectUtils.isEmpty(user.getGithubUser())) {
            Map<String, Object> ext = new HashMap<>();
            ext.put(EXT_KET_GITHUB_USER, user.getGithubUser());
            userDO.setExt(JSON.toJSONString(ext));
        }
        if (!ObjectUtils.isEmpty(user.getRole())) {
            userDO.setRole(user.getRole().getValue());
        }
        if (!ObjectUtils.isEmpty(user.getState())) {
            userDO.setState(user.getState().getValue());
        }
        if (!ObjectUtils.isEmpty(user.getSex())) {
            userDO.setSex(user.getSex().getValue());
        }
        userDO.setId(user.getId());
        userDO.setCreateAt(user.getCreateAt());
        userDO.setUpdateAt(user.getUpdateAt());

        return userDO;
    }

    public static User toUser(UserDO userDO) {
        if (ObjectUtils.isEmpty(userDO)) {
            return null;
        }

        User user = User.builder()
                .avatar(userDO.getAvatar())
                .source(UserSourceEn.getEntity(userDO.getSource()))
                .state(UserStateEn.getEntity(userDO.getState()))
                .email(userDO.getEmail())
                .nickname(userDO.getNickname())
                .password(userDO.getPassword())
                .role(UserRoleEn.getEntity(userDO.getRole()))
                .sex(UserSexEn.getEntity(userDO.getSex()))
                .signature(userDO.getSignature())
                .lastLoginTime(userDO.getLastLoginTime())
                .build();

        if (!ObjectUtils.isEmpty(userDO.getExt())) {
            JSONObject ext = JSON.parseObject(userDO.getExt());
            user.setGithubUser(ext.getJSONObject(EXT_KET_GITHUB_USER));
        }

        user.setId(userDO.getId());
        user.setCreateAt(userDO.getCreateAt());
        user.setUpdateAt(userDO.getUpdateAt());

        return user;
    }

    public static List<User> toUsers(List<UserDO> userDOS) {
        List<User> users = new ArrayList<>();

        SafesUtil.ofList(userDOS).forEach(userDO -> users.add(toUser(userDO)));

        return users;
    }
}
