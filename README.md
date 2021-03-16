# blog

### 介绍
前后端不分离的博客

### 软件架构
1. `springmvc` ：网页开发
2. `freemarker` ：模板引擎
3. `lombok、hutool、commons、modelmapper` ：工具类
4. `mybatis-plus、druid、mysql、mp-generator、p6spy` ：数据库
5. `redis` ：文章缓存
6. `kaptcha` ：图片验证码
7. `shiro、shiro-freemarker-tags` ：权限管理
8. `websocket、tio-websocket` ：网络通讯
9. `elasticsearch` ：全文搜索引擎
10. `rabbitmq` ：消息中间件

### 使用说明
1. 测试账户：11111@qq.com  
2. 测试密码：123456

### 项目文档
- Chapter 01
    - [Part01-博客页面划分.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part01-博客页面划分.md)
    - [Part02-MyBatis-Plus的使用.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part02-MyBatis-Plus的使用.md)
    - [Part03-Controller控制层接口.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part03-Controller控制层接口.md)
    - [Part04-自定义Freemaker标签.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part04-自定义Freemaker标签.md)
    - [Part05-项目启动前加载导航栏.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part05-项目启动前加载导航栏.md)
    - [Part06-侧边栏本周热议.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part06-侧边栏本周热议.md)
    - [Part07-文章阅读缓存访问量.md](https://github.com/halavah/blog/tree/master/doc/Chapter01/Part07-文章阅读缓存访问量.md)
- Chapter 02
    - [Part01-集成Kaptcha实现用户注册.md](https://github.com/halavah/blog/tree/master/doc/Chapter02/Part01-集成Kaptcha实现用户注册.md)
    - [Part02-集成Shiro实现用户登录.md](https://github.com/halavah/blog/tree/master/doc/Chapter02/Part02-集成Shiro实现用户登录.md)
    - [Part03-集成Shiro实现个人账户-我的主页、基本设置.md](https://github.com/halavah/blog/tree/master/doc/Chapter02/Part03-集成Shiro实现个人账户-我的主页、基本设置.md)
    - [Part04-集成Shiro实现个人账户-用户中心.md](https://github.com/halavah/blog/tree/master/doc/Chapter02/Part04-集成Shiro实现个人账户-用户中心.md)
    - [Part05-集成Shiro实现个人账户-我的消息.md](https://github.com/halavah/blog/tree/master/doc/Chapter02/Part05-集成Shiro实现个人账户-我的消息.md)
- Chapter 03
    - [Part01-集成Shiro实现博客详情-收藏文章.md](https://github.com/halavah/blog/tree/master/doc/Chapter03/Part01-集成Shiro实现博客详情-收藏文章.md)
    - [Part02-集成Shiro实现博客详情-添加文章、编辑文章、提交文章.md](https://github.com/halavah/blog/tree/master/doc/Chapter03/Part02-集成Shiro实现博客详情-添加文章、编辑文章、提交文章.md)
    - [Part03-集成Shiro实现博客详情-超级用户、删除、置顶、精华.md](https://github.com/halavah/blog/tree/master/doc/Chapter03/Part03-集成Shiro实现博客详情-超级用户、删除、置顶、精华.md)
    - [Part04-集成Shiro实现博客详情-用户文章、用户评论.md](https://github.com/halavah/blog/tree/master/doc/Chapter03/Part04-集成Shiro实现博客详情-用户文章、用户评论.md)
- Chapter 04
    - [Part01-集成WeSocket实现用户评论-即时通讯.md](https://github.com/halavah/blog/tree/master/doc/Chapter04/Part01-集成WeSocket实现用户评论-即时通讯.md)
    - [Part02-集成Elasticsearch实现文章内容-搜索引擎.md](https://github.com/halavah/blog/tree/master/doc/Chapter04/Part02-集成Elasticsearch实现文章内容-搜索引擎.md)
    - [Part03-集成RabbitMQ保证ES随文章增删改查-实时更新.md](https://github.com/halavah/blog/tree/master/doc/Chapter04/Part03-集成RabbitMQ保证ES随文章增删改查-实时更新.md)
    - [Part04-集成WebSocket-tio实现网络群聊-聊天室.md](https://github.com/halavah/blog/tree/master/doc/Chapter04/Part04-集成WebSocket-tio实现网络群聊-聊天室.md)
- SQL
    - [MySQL_5_7_25-2021_03_09_23_51_22-xblog.sql](https://github.com/halavah/blog/tree/master/doc/SQL/MySQL_5_7_25-2021_03_09_23_51_22-xblog.sql)
    - [MySQL_5_7_25-2021_03_11_11_20_45-xblog.sql](https://github.com/halavah/blog/tree/master/doc/SQL/MySQL_5_7_25-2021_03_11_11_20_45-xblog.sql)
    - [MySQL_5_7_25-2021_03_11_18_47_44-xblog.sql](https://github.com/halavah/blog/tree/master/doc/SQL/MySQL_5_7_25-2021_03_11_18_47_44-xblog.sql)
    - [MySQL_5_7_25-2021_03_14_14_36_04-xblog.sql](https://github.com/halavah/blog/tree/master/doc/SQL/MySQL_5_7_25-2021_03_14_14_36_04-xblog.sql)