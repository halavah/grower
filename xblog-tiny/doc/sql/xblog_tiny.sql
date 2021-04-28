CREATE DATABASE IF NOT EXISTS `xblog_tiny` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

USE xblog_tiny;

create table m_post
(
    id            bigint(32) auto_increment comment '主键ID' primary key,
	user_id       bigint(32)                   null comment '文章的【用户ID】',	
    title         varchar(128)                 not null comment '文章的【标题】',
	description   varchar(128)                 not null comment '文章的【描述】',
    content       longtext                     not null comment '文章的【内容】',
	status        tinyint(2)                   null comment '文章的【状态】',
    created       datetime                     null comment '文章的【创建日期】',
    modified      datetime                     null comment '文章的【更新日期】'
)
    comment '用户文章' collate = utf8mb4_unicode_ci;

create table m_user
(
    id            bigint(32) auto_increment comment '主键ID' primary key,
    username      varchar(128)               not null comment '用户的【昵称】',
    password      varchar(128)               not null comment '用户的【密码】',
    email         varchar(64)                null comment '用户的【邮件】',
    gender        varchar(16)                null comment '用户的【性别】:0代表男，1代表女',
    avatar        varchar(256)               not null comment '用户的【头像】',
    status        tinyint(2)       default 0 not null comment '用户的【状态】:0代表登录成功，-1代表登录失败',
    lasted        datetime                   null comment '用户的【近期登陆日期】',
    created       datetime                   not null comment '用户的【创建日期】',
    modified      datetime                   null comment '用户的【更新日期】',
    constraint email
        unique (email),
    constraint username
        unique (username)
)
    comment '用户信息' collate = utf8mb4_unicode_ci;