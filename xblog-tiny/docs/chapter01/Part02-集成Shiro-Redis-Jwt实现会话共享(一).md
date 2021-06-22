# Part02-集成Shiro-Redis-Jwt实现会话共享(一)

```text
blog-tiny
│  pom.xml
│
└─src
    └─main
        ├─java
        │  └─org
        │      └─org.myslayers
        │          ├─config
        │          │      ShiroConfig.java
        │          │
        │          ├─shiro
        │          │      AccountProfile.java
        │          │      AccountRealm.java
        │          │      JwtFilter.java
        │          │      JwtToken.java
        │          │
        │          └─utils
        │                  JwtUtils.java
        │
        └─resources
            │  application-win.yml
            │  application.yml
            │
            └─META-INF
                    spring-devtools.properties
```

## 2.1 集成 Shiro-Redis、Jwt 环境

- `pom.xml` ：项目依赖，【shiro-redis、jwt 实现会话共享、身份验证】

```xml
<dependencies>
  <!--shiro-redis、jwt 实现会话共享、身份验证-->
  <dependency>
    <groupId>org.crazycake</groupId>
    <artifactId>shiro-redis-spring-boot-starter</artifactId>
    <version>3.2.1</version>
  </dependency>
  <dependency>
    <groupId>io.jsonwebtoken</groupId>
    <artifactId>jjwt</artifactId>
    <version>0.9.1</version>
  </dependency>
</dependencies>
```

## 2.2 编写 ShiroConfig.java 配置文件

- `ShiroConfig.java` ：配置类，【安全管理器、过滤器链、过滤器工厂】

```java
/**
 * 配置类：安全管理器、过滤器链、过滤器工厂
 */
@Configuration
public class ShiroConfig {

    @Autowired
    JwtFilter jwtFilter;

    /**
     * 1.安全管理器：根据 “https://github.com/alexxiyang/shiro-redis/tree/master/docs” 说明，将 【自定义Realm】、【自定义的session会话管理器】、【自定义的redis缓存管理器】 注入 DefaultWebSecurityManager，并关闭shiro自带的session
     *
     * 具体内容如下：
     * - 引入 RedisSessionDAO 和 RedisCacheManager，为了解决 shiro 的权限数据和会话信息能保存到 redis 中，实现会话共享
     * - 重写 SessionManager 和 DefaultWebSecurityManager，同时在 DefaultWebSecurityManager 中为了关闭 shiro 自带的 session 方式，我们需要设置为 false，这样用户就不再能通过 session 方式登录 shiro，而后将采用 jwt 凭证登录
     */
    @Bean
    public SessionManager sessionManager(RedisSessionDAO redisSessionDAO) {
        DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
        sessionManager.setSessionDAO(redisSessionDAO);

        return sessionManager;
    }

    @Bean
    public DefaultWebSecurityManager securityManager(AccountRealm accountRealm, SessionManager sessionManager, RedisCacheManager redisCacheManager) {
        DefaultWebSecurityManager securityManager = new DefaultWebSecurityManager(accountRealm);
        // 将 自定义Realm 注册到安全管理器中
        securityManager.setRealm(accountRealm);

        // 将 自定义的session会话管理器 注册到安全管理器中
        securityManager.setSessionManager(sessionManager);

        // 将 自定义的redis缓存管理器 注册到安全管理器中
        securityManager.setCacheManager(redisCacheManager);

        // 关闭 shiro自带的session
        DefaultSubjectDAO subjectDAO = new DefaultSubjectDAO();
        DefaultSessionStorageEvaluator defaultSessionStorageEvaluator = new DefaultSessionStorageEvaluator();
        defaultSessionStorageEvaluator.setSessionStorageEnabled(false);
        subjectDAO.setSessionStorageEvaluator(defaultSessionStorageEvaluator);
        securityManager.setSubjectDAO(subjectDAO);

        return securityManager;
    }

    /**
     * 2.过滤器链
     *
     * 具体内容如下：不再通过编码形式拦截 Controller 访问路径，而将全部路由经过 JwtFilter 处理
     * - 如果 JwtFilter 在判断请求头时，如果存在 jwt 信息，校验 jwt 的有效性，如果有效，则直接执行 executeLogin 方法实现自动登录
     * - 如果 JwtFilter 在判断请求头时，如果没有 jwt 信息，则跳过；跳过之后，有 Controller 中的 Shiro 注解【@RequiresAuthentication】 来控制权限访问
     */
    @Bean
    public ShiroFilterChainDefinition shiroFilterChainDefinition() {
        DefaultShiroFilterChainDefinition chainDefinition = new DefaultShiroFilterChainDefinition();
        Map<String, String> filterMap = new LinkedHashMap<>();
        filterMap.put("/**", "jwt");   // 将全部路由交给 JwtFilter 过滤器进行处理
        chainDefinition.addPathDefinitions(filterMap);

        return chainDefinition;
    }

    /**
     * 3.过滤器工厂
     */
    @Bean
    public ShiroFilterFactoryBean shiroFilterFactoryBean(SecurityManager securityManager, ShiroFilterChainDefinition shiroFilterChainDefinition) {
        ShiroFilterFactoryBean shiroFilter = new ShiroFilterFactoryBean();
        // shiroFilter 设置 自定义安全管理器（securityManager）
        shiroFilter.setSecurityManager(securityManager);

        // shiroFilter 设置 自定义jwtFilter
        Map<String, Filter> filters = new HashMap<>();
        filters.put("jwt", jwtFilter);
        shiroFilter.setFilters(filters);

        // shiroFilter 设置 自定义过滤器链（chainDefinition）
        Map<String, String> filterMap = shiroFilterChainDefinition.getFilterChainMap();
        shiroFilter.setFilterChainDefinitionMap(filterMap);

        return shiroFilter;
    }

}
```

## 2.3 编写 JwtFilter.java 配置文件

- 采用 Jwt 作为跨域身份验证解决方案，原理如下：![1.png](../assets/1.png)

- `JwtFilter.java` ：Filter，【继承 Shiro 内置的 AuthenticatingFilter】

```java
/**
 * Filter：继承 Shiro 内置的 AuthenticatingFilter
 */
@Component
public class JwtFilter extends AuthenticatingFilter {

    @Autowired
    JwtUtils jwtUtils;

    /**
     * createToken：实现登录，【从 request 的 header 中获取 自定义的jwt(Authorization)，然后生成 JwtToken 信息并返回】
     */
    @Override
    protected AuthenticationToken createToken(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String jwt = request.getHeader("Authorization");
        if (StringUtils.isEmpty(jwt)) {
            return null;
        }
        return new JwtToken(jwt);
    }

    /**
     * onAccessDenied：拦截校验，
     * - 如果 JwtFilter 在判断请求头时，如果存在 jwt 信息，校验 jwt 的有效性，如果有效，则直接执行 executeLogin 方法实现自动登录
     * - 如果 JwtFilter 在判断请求头时，如果没有 jwt 信息，则跳过；跳过之后，有 Controller 中的 Shiro 注解【@RequiresAuthentication】 来控制权限访问
     */
    @Override
    protected boolean onAccessDenied(ServletRequest servletRequest, ServletResponse servletResponse) throws Exception {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        String jwt = request.getHeader("Authorization");
        if (StringUtils.isEmpty(jwt)) {
            return true;
        } else {
            // 校验jwt
            Claims claim = jwtUtils.getClaimByToken(jwt);
            if (claim == null || jwtUtils.isTokenExpired(claim.getExpiration())) {
                throw new ExpiredCredentialsException("token已失效，请重新登录");
            }
            // 执行登录
            return executeLogin(servletRequest, servletResponse);
        }
    }

    /**
     * onLoginFailure：登录异常时候进入的方法，【前后端项目，使用JSON格式的数据，将异常信息封装然后抛出】
     */
    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {
        Throwable throwable = e.getCause() == null ? e : e.getCause();
        Result result = Result.fail(throwable.getMessage());
        String json = JSONUtil.toJsonStr(result);
        try {
            HttpServletResponse httpServletResponse = (HttpServletResponse) response;
            httpServletResponse.getWriter().print(json);
        } catch (IOException ioException) {
        }
        return false;
    }

    /**
     * preHandle：拦截器的前置拦截，【前后端项目，除了需要跨域全局配置之外，拦截器中也需要提供跨域支持。这样，拦截器才不会在进入 Controller 之前就被限制了】
     */
    @Override
    protected boolean preHandle(ServletRequest request, ServletResponse response) throws Exception {
        HttpServletRequest httpServletRequest = WebUtils.toHttp(request);
        HttpServletResponse httpServletResponse = WebUtils.toHttp(response);
        httpServletResponse.setHeader("Access-control-Allow-Origin", httpServletRequest.getHeader("Origin"));
        httpServletResponse.setHeader("Access-Control-Allow-Methods", "GET,POST,OPTIONS,PUT,DELETE");
        httpServletResponse.setHeader("Access-Control-Allow-Headers", httpServletRequest.getHeader("Access-Control-Request-Headers"));
        // 跨域时会首先发送一个OPTIONS请求，这里我们给OPTIONS请求直接返回正常状态
        if (httpServletRequest.getMethod().equals(RequestMethod.OPTIONS.name())) {
            httpServletResponse.setStatus(org.springframework.http.HttpStatus.OK.value());
            return false;
        }
        return super.preHandle(request, response);
    }

}
```

- `JwtUtils.java` ：生成和校验 jwt 的工具类：【来自 application.yml 配置文件】

```java
/**
 * 生成和校验 jwt 的工具类：【来自 application.yml 配置文件】
 */
@Slf4j
@Data
@Component
@ConfigurationProperties(prefix = "org.myslayers.jwt")
public class JwtUtils {

    private String secret;
    private long expire;
    private String header;

    /**
     * 生成 jwt token
     */
    public String generateToken(long userId) {
        Date nowDate = new Date();
        //过期时间
        Date expireDate = new Date(nowDate.getTime() + expire * 1000);

        return Jwts.builder()
            .setHeaderParam("typ", "JWT")
            .setSubject(userId + "")
            .setIssuedAt(nowDate)
            .setExpiration(expireDate)
            .signWith(SignatureAlgorithm.HS512, secret)
            .compact();
    }

    /**
     * 获取 jwt 信息
     */
    public Claims getClaimByToken(String token) {
        try {
            return Jwts.parser()
                .setSigningKey(secret)
                .parseClaimsJws(token)
                .getBody();
        } catch (Exception e) {
            log.debug("validate is token error ", e);
            return null;
        }
    }

    /**
     * 判断 token 是否过期，true代表过期；false代表有效
     */
    public boolean isTokenExpired(Date expiration) {
        return expiration.before(new Date());
    }
}
```

- `application.yml` ：配置文件，用于 JwtUtils.java 的 属性注入，【开启 shiro-redis 会话管理、向 JwtUtils.java 类中的属性注入值】

```yaml
shiro-redis:
  enabled: true
  redis-manager:
    host: 127.0.0.1:6379
    password: org.myslayers

org.myslayers:
  jwt:
    # 加密秘钥
    secret: f4e2e52034348f86b67cde581c0f9eb5
    # token有效时长，7天，单位秒
    expire: 604800
    # header
    header: authorization
```

- `spring-devtools.properties` ：配置文件，【项目使用 spring-boot-devtools 时，在热部署的情况下，防止重启报错】

```properties
restart.include.shiro-redis=/shiro-[\\w-\\.]+jar
```

## 2.4 编写 AccountRealm.java 配置文件

- `AccountRealm.java` ：Realm，【继承 Shiro 内置的 AuthorizingRealm】

```java
/**
 * Realm：继承 Shiro 内置的 AuthorizingRealm
 */
@Component
public class AccountRealm extends AuthorizingRealm {

    @Autowired
    JwtUtils jwtUtils;

    @Autowired
    UserService userService;

    /**
     * supports：让 realm 支持 jwt 的凭证校验，【shiro 默认 supports 是 UsernamePasswordToken，使用 jwt 的方式，需要自定义 JwtToken 取代 UsernamePasswordToken】
     */
    @Override
    public boolean supports(AuthenticationToken token) {
        return token instanceof JwtToken;
    }

    /**
     * doGetAuthorizationInfo（授权）：权限校验
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        return null;
    }

    /**
     * doGetAuthenticationInfo（认证）：登录认证，【通过 JwtToken 获取到用户信息 来 判断用户的状态，并抛出对应的异常信息】，同时，【登录成功之后返回的一个用户信息的载体，将 user 信息封装成 SimpleAuthenticationInfo 对象 返回给 shiro】
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        JwtToken jwtToken = (JwtToken) token;
        String userId = jwtUtils.getClaimByToken((String) jwtToken.getPrincipal()).getSubject();
        User user = userService.getById(Long.valueOf(userId));
        if (user == null) {
            throw new UnknownAccountException("账户不存在");
        }
        if (user.getStatus() == -1) {
            throw new LockedAccountException("账户已被锁定");
        }

        AccountProfile profile = new AccountProfile();
        BeanUtil.copyProperties(user, profile); //将 user对象 拷贝一份至 AccountProfile 对象
        return new SimpleAuthenticationInfo(profile, jwtToken.getCredentials(), getName());
    }
}
```

- `JwtToken.java` ：Token，用于 AccountRealm.java 的 supports 方法，【shiro 默认 supports 是 UsernamePasswordToken，使用 jwt 的方式，需要自定义 JwtToken 取代 UsernamePasswordToken】

```java
/**
 * Token：用于 AccountRealm.java 的 supports 方法，【shiro 默认 supports 是 UsernamePasswordToken，使用 jwt 的方式，需要自定义 JwtToken 取代 UsernamePasswordToken】
 */
public class JwtToken implements AuthenticationToken {

    private String token;

    public JwtToken(String jwt) {
        this.token = jwt;
    }

    @Override
    public Object getPrincipal() {
        return token;
    }

    @Override
    public Object getCredentials() {
        return token;
    }
}
```

- `AccountProfile.java` ：Profile，用于 AccountRealm.java 的 AuthenticationInfo 方法，【登录成功之后返回的一个用户信息的载体，将 user 信息封装成 SimpleAuthenticationInfo 对象 返回给 shiro】

```java
/**
 * Profile：用于 AccountRealm.java 的 AuthenticationInfo 方法，【登录成功之后返回的一个用户信息的载体，将 user 信息封装成 SimpleAuthenticationInfo 对象 返回给 shiro】
 */
@Data
public class AccountProfile implements Serializable {

    private Long id;

    private String username;

    private String avatar;

    private String email;

}
```

- `AuthenticatingFilter.java` ：源码分析，`executeLogin()` 执行登录时，会使用 JWT(token)，并委托 AccountRealm.java 中的 doGetAuthenticationInfo 方法进行登录认证

```java
public abstract class AuthenticatingFilter extends AuthenticationFilter {

    protected boolean executeLogin(ServletRequest request, ServletResponse response) throws Exception {
        AuthenticationToken token = this.createToken(request, response);
        if (token == null) {
            String msg = "createToken method implementation returned null. A valid non-null AuthenticationToken must be created in order to execute a login attempt.";
            throw new IllegalStateException(msg);
        } else {
            try {
                // 使用token，并委托 AccountRealm.java 中的 doGetAuthenticationInfo 方法进行登录认证
                Subject subject = this.getSubject(request, response);
                subject.login(token);
                return this.onLoginSuccess(token, subject, request, response);
            } catch (AuthenticationException var5) {
                return this.onLoginFailure(token, var5, request, response);
            }
        }
    }
}
```
