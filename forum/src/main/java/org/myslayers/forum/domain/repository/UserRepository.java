package org.myslayers.forum.domain.repository;

import org.myslayers.forum.common.model.PageRequest;
import org.myslayers.forum.common.model.PageResult;
import org.myslayers.forum.domain.entity.Follow;
import org.myslayers.forum.domain.entity.User;

import java.util.List;

public interface UserRepository {

    void save(User user);

    User get(Long id);

    User getByEmail(String email);

    void update(User user);

    List<User> queryByIds(List<Long> ids);

    PageResult<User> page(PageRequest<User> pageRequest);

    void follow(Long followed, Long id);

    PageResult<User> pageFollower(PageRequest<Long> longPageRequest);

    PageResult<User> pageFans(PageRequest<Long> longPageRequest);

    Follow getFollow(Long followed, Long follower);

    void cancelFollow(Long followId);

    PageResult<User> pageActive(PageRequest pageRequest);
}
