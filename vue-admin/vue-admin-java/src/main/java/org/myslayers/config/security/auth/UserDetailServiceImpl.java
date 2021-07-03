package org.myslayers.config.security.auth;

import org.myslayers.entity.User;
import org.myslayers.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 身份认证：返回一个 UserDetails 对象
 */
@Service
public class UserDetailServiceImpl implements UserDetailsService {

	@Autowired
	UserService userService;

	/**
	 * 校验用户是否存在、获取用户权限信息（角色、菜单权限），返回一个 UserDetails 对象
	 */
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// 校验用户是否存在
		User user = userService.getByUsername(username);
		if (user == null) {
			throw new UsernameNotFoundException("用户名不存在！");
		}

		// 获取用户权限信息（角色编码code、菜单权限perms）
		List<GrantedAuthority> authority = getAuthority(user.getId());

		// 返回 AccountUser 对象
        UserDetailAccount accountUser = new UserDetailAccount(user.getId(), user.getUsername(), user.getPassword(), authority);
		return accountUser;
	}
	
	/**
	 * 获取用户权限信息（角色编码code、菜单权限perms）
	 */
	public List<GrantedAuthority> getAuthority(Integer userId) {
		String authority = userService.getUserAuthorityInfo(userId);
		return AuthorityUtils.commaSeparatedStringToAuthorityList(authority);
	}
}
