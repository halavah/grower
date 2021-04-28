# xblog-tiny

## 介绍

练习项目：前后端分离的博客

### 软件架构

- blog-tiny-java
  - `springmvc` ：网页开发
  - `mybatis-plus、druid、mysql、mp-generator、p6spy、freemarker` ：数据库
  - `shiro、jwt` ：会话共享、身份验证
  - `lombok、hutool、commons` ：工具类
  - `devtools、test` ：热部署、单元测试
- blog-tiny-vue
  - `vue 2.x、vue-cli、vue-router、vuex、vue-axios` ：网页开发
  - `element-ui 2.x` ：桌面组件
  - `mavonEditor、markdown-it、github-markdown-css` ：编写md文档、解析md文档、解析md样式
  
### 项目文档

- Chapter 01
  - [Part01-集成MP完成项目初始化.md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter01/Part01-集成MP完成项目初始化.md)
  - [Part02-集成Shiro-Redis-Jwt实现会话共享(一).md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter01/Part02-集成Shiro-Redis-Jwt实现会话共享(一).md)
  - [Part03-集成Shiro-Redis-Jwt实现会话共享(二).md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter01/Part03-集成Shiro-Redis-Jwt实现会话共享(二).md)
  - [Part04-使用Shiro-Redis-Jwt开发登录接口.md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter01/Part04-使用Shiro-Redis-Jwt开发登录接口.md)
  - [Part05-使用Shiro-Redis-Jwt开发项目接口.md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter01/Part05-使用Shiro-Redis-Jwt开发项目接口.md)
- Chapter 02
  - [Part01-使用VueCli-ElementUi-Axios完成项目搭建.md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter02/Part01-使用VueCli-ElementUi-Axios完成项目搭建.md)
  - [Part02-路由规则-权限拦截-用户登录-状态管理-全局拦截.md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter02/Part02-路由规则-权限拦截-用户登录-状态管理-全局拦截.md)
  - [Part03-公共组件-博客列表-博客发表-博客编辑-博客详情.md](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/chapter02/Part03-公共组件-博客列表-博客发表-博客编辑-博客详情.md)
- SQL
  - [xblog_tiny.sql](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/sql/xblog_tiny.sql)
  - [MySQL_5_7_25-2021_04_06_22_51_20-xblog_tiny.sql](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/sql/MySQL_5_7_25-2021_04_06_22_51_20-xblog_tiny.sql)
  - [MySQL_5_7_25-2021_04_13_14_01_26-xblog_tiny.sql](https://github.com/halavah/blog/tree/master/xblog-tiny/doc/sql/MySQL_5_7_25-2021_04_13_14_01_26-xblog_tiny.sql)
  
### 项目说明

- blog-tiny-java
  - 访问网址：<http://localhost:8765/>
  - 测试账户：admin
  - 测试密码：123456
- blog-tiny-vue
  - 访问网址：<http://localhost:8080/>
  - 测试账户：admin
  - 测试密码：123456
  
### 项目鸣谢

- 项目原作者：[MarkerHub](https://github.com/MarkerHub/)
- 项目原地址：[vueblog](https://github.com/MarkerHub/vueblog)
