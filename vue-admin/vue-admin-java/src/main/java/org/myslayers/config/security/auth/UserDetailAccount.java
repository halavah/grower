package org.myslayers.config.security.auth;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.util.Assert;

import java.util.Collection;

/**
 * 身份认证：UserDetails 对象
 */
public class UserDetailAccount implements UserDetails {

	private Integer id;
	
	// 获取当前用户对象的用户名
	private String username;
	
	// 获取当前用户对象的密码
	private String password;
	
	// 当前账户是否可用
	private Boolean enabled;
	
	// 当前账户是否未过期
	private Boolean accountNonExpired;
	
	// 当前账户是否未锁定
	private Boolean accountNonLocked;
	
	// 当前账户是否未过期
	private Boolean credentialsNonExpired;
	
	// 获取当前用户对象所具有的角色信息
	private final Collection<? extends GrantedAuthority> authorities;

	public UserDetailAccount(Integer id, String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities) {
		Assert.isTrue(username != null && !"".equals(username) && password != null, "Cannot pass null or empty values to constructor");
		this.id = id;
		this.username = username;
		this.password = password;
		this.enabled = enabled;
		this.accountNonExpired = accountNonExpired;
		this.credentialsNonExpired = credentialsNonExpired;
		this.accountNonLocked = accountNonLocked;
		this.authorities = authorities;
	}
	
	public UserDetailAccount(Integer id, String username, String password, Collection<? extends GrantedAuthority> authorities) {
		this(id, username, password, true, true, true, true, authorities);
	}
	
	@Override
	public String getUsername() {
		return this.username;
	}
	
	@Override
	public String getPassword() {
		return this.password;
	}
	
	@Override
	public boolean isEnabled() {
		return this.enabled;
	}
	
	@Override
	public boolean isAccountNonExpired() {
		return this.accountNonExpired;
	}

	@Override
	public boolean isAccountNonLocked() {
		return this.accountNonLocked;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return this.credentialsNonExpired;
	}
	
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}
}
