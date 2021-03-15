## 3. 集成 RabbitMQ 实现文章内容-消息同步
### 3.1 集成 RabbitMQ 环境
- `pom.xml` ：项目依赖，【RabbitMQ 消息同步】
```xml
<dependencies>
  <!--rabbitmq：消息同步-->
  <dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
    <version>2.1.2.RELEASE</version>
  </dependency>
</dependencies>
```
- `application.yml` ：配置文件，【RabbitMQ 消息同步】
```yaml
spring:
  rabbitmq:
    username: guest
    password: guest
    host: 127.0.0.1
    port: 5672
```

### 3.2 配置 RabbitMQ 环境
- `WsConfig.java` ：配置类，
```java

```

### 3.3 使用 RabbitMQ 消息同步
- `PostController.java` ：控制层
```java

```