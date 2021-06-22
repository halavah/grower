# Part04-使用Shiro-Redis-Jwt开发登录接口

```text
blog-tiny
└─src
    └─main
        ├─java
        │  └─org
        │      └─org.myslayers
        │          ├─controller
        │          │      UserController.java   # 登录接口
        │          │
        │          └─utils
        │                 ValidationUtil.java  # 工具类
```

## 4.1 集成 ValidationUtil 工具类

- `ValidationUtil.java` ：工具类，【常见校验】

```java
/**
 * ValidationUtil 工具类
 */
@Component
public class ValidationUtil {

    /**
     * 开启快速结束模式 failFast (true)
     */
    private static Validator validator = Validation.byProvider(HibernateValidator.class).configure()
        .failFast(false).buildValidatorFactory().getValidator();

    /**
     * 校验对象
     *
     * @param t      bean
     * @param groups 校验组
     * @return ValidResult
     */
    public static <T> ValidResult validateBean(T t, Class<?>... groups) {
        ValidResult result = new ValidationUtil().new ValidResult();
        Set<ConstraintViolation<T>> violationSet = validator.validate(t, groups);
        boolean hasError = violationSet != null && violationSet.size() > 0;
        result.setHasErrors(hasError);
        if (hasError) {
            for (ConstraintViolation<T> violation : violationSet) {
                result.addError(violation.getPropertyPath().toString(), violation.getMessage());
            }
        }
        return result;
    }

    /**
     * 校验bean的某一个属性
     *
     * @param obj          bean
     * @param propertyName 属性名称
     * @return ValidResult
     */
    public static <T> ValidResult validateProperty(T obj, String propertyName) {
        ValidResult result = new ValidationUtil().new ValidResult();
        Set<ConstraintViolation<T>> violationSet = validator.validateProperty(obj, propertyName);
        boolean hasError = violationSet != null && violationSet.size() > 0;
        result.setHasErrors(hasError);
        if (hasError) {
            for (ConstraintViolation<T> violation : violationSet) {
                result.addError(propertyName, violation.getMessage());
            }
        }
        return result;
    }

    /**
     * 校验结果类
     */
    @Data
    public class ValidResult {

        /**
         * 是否有错误
         */
        private boolean hasErrors;

        /**
         * 错误信息
         */
        private List<ErrorMessage> errors;

        public ValidResult() {
            this.errors = new ArrayList<>();
        }

        public boolean hasErrors() {
            return hasErrors;
        }

        public void setHasErrors(boolean hasErrors) {
            this.hasErrors = hasErrors;
        }

        /**
         * 获取所有验证信息
         *
         * @return 集合形式
         */
        public List<ErrorMessage> getAllErrors() {
            return errors;
        }

        /**
         * 获取所有验证信息
         *
         * @return 字符串形式
         */
        public String getErrors() {
            StringBuilder sb = new StringBuilder();
            for (ErrorMessage error : errors) {
                sb.append(error.getPropertyPath()).append(":").append(error.getMessage())
                    .append(" ");
            }
            return sb.toString();
        }

        public void addError(String propertyName, String message) {
            this.errors.add(new ErrorMessage(propertyName, message));
        }
    }

    @Data
    public class ErrorMessage {

        private String propertyPath;

        private String message;

        public ErrorMessage() {
        }

        public ErrorMessage(String propertyPath, String message) {
            this.propertyPath = propertyPath;
            this.message = message;
        }
    }

}
```

## 4.2 集成 Shiro-Redis、Jwt 开发登录接口

- `UserController.java` ：控制层，【用户登录/登出】

```java
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
```

- 效果图如下：![4.png](../assets/4.png)
- 效果图如下：![5.png](../assets/5.png)
