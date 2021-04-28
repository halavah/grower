CREATE DATABASE IF NOT EXISTS `xblog` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;

USE xblog;

create table m_category
(
    id               bigint(32) auto_increment comment '主键id'
        primary key,
    name             varchar(512)               not null comment '分类的【标题】',
    content          text                       null comment '分类的【内容描述】',
    summary          text                       null comment '分类的【内容摘要】',
    icon             varchar(128)               null comment '分类的【图标】',
    post_count       int(11) unsigned default 0 null comment '分类的【内容数量】',
    order_num        int                        null comment '分类的【排序编码】',
    parent_id        bigint(32) unsigned        null comment '分类的【父级分类的ID】',
    meta_keywords    varchar(256)               null comment '分类的【SEO关键字】',
    meta_description varchar(256)               null comment '分类的【SEO描述内容】',
    created          datetime                   null comment '分类的【创建日期】',
    modified         datetime                   null comment '分类的【修改日期】',
    status           tinyint(2)                 null comment '分类的【状态】'
)
    comment '文章分类' collate = utf8mb4_unicode_ci;
	
create table m_comment
(
    id        bigint(32) auto_increment comment '主键ID'
        primary key,
    content   longtext                      not null comment '评论的【内容】',
    parent_id bigint(32)                    null comment '评论的【回复ID】',
    post_id   bigint(32)                    not null comment '评论的【文章ID】',
    user_id   bigint(32)                    not null comment '评论的【用户ID】',
    vote_up   int(11) unsigned    default 0 not null comment '评论的【“顶”的数量】',
    vote_down int(11) unsigned    default 0 not null comment '评论的【“踩”的数量】',
    level     tinyint(2) unsigned default 0 not null comment '评论的【置顶等级】',
    status    tinyint(2)                    null comment '评论的【状态】',
    created   datetime                      not null comment '评论的【创建日期】',
    modified  datetime                      null comment '评论的【更新日期】'
)
    comment '用户评论' collate = utf8mb4_unicode_ci;

create table m_post
(
    id            bigint(32) auto_increment comment '主键ID'
        primary key,
    title         varchar(128)                 not null comment '文章的【标题】',
    content       longtext                     not null comment '文章的【内容】',
    edit_mode     varchar(32)      default '0' not null comment '文章的【编辑模式】：html可视化，markdown文档',
    category_id   bigint(32)                   null comment '文章的【分类ID】',
    user_id       bigint(32)                   null comment '文章的【用户ID】',
    vote_up       int(11) unsigned default 0   not null comment '文章的【支持人数】',
    vote_down     int(11) unsigned default 0   not null comment '文章的【反对人数】',
    view_count    int(11) unsigned default 0   not null comment '文章的【访问量】',
    comment_count int              default 0   not null comment '文章的【评论数量】',
    recommend     tinyint(1)                   null comment '文章的【精华】：0代表取消加精、1代表加精',
    level         tinyint(2)       default 0   not null comment '文章的【置顶等级】：0代表取消置顶、1代表置顶',
    status        tinyint(2)                   null comment '文章的【状态】',
    created       datetime                     null comment '文章的【创建日期】',
    modified      datetime                     null comment '文章的【更新日期】'
)
    comment '用户文章' collate = utf8mb4_unicode_ci;

create table m_user
(
    id            bigint(32) auto_increment comment '主键ID'
        primary key,
    username      varchar(128)               not null comment '用户的【昵称】',
    password      varchar(128)               not null comment '用户的【密码】',
    email         varchar(64)                null comment '用户的【邮件】',
    mobile        varchar(32)                null comment '用户的【手机】',
    point         int(11) unsigned default 0 not null comment '用户的【积分】',
    sign          varchar(255)               null comment '用户的【个性签名】',
    gender        varchar(16)                null comment '用户的【性别】:0代表男，1代表女',
    wechat        varchar(32)                null comment '用户的【微信号】',
    vip_level     int(32)                    null comment '用户的【VIP等级】',
    birthday      datetime                   null comment '用户的【生日日期】',
    comment_count int(11) unsigned default 0 not null comment '用户的【评论数量】',
    post_count    int(11) unsigned default 0 not null comment '用户的【内容数量】',
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

create table m_user_action
(
    id         varchar(32) default '' not null comment '主键ID'
        primary key,
    user_id    varchar(32)            null comment '活跃用户的【用户ID】',
    action     varchar(32)            null comment '活跃用户的【动作类型】',
    point      int                    null comment '活跃用户的【用户得分】',
    post_id    varchar(32)            null comment '活跃用户的【关联的文章ID】',
    comment_id varchar(32)            null comment '活跃用户的【关联的评论ID】',
    created    datetime               null comment '活跃用户的【创建日期】',
    modified   datetime               null comment '活跃用户的【更新日期】'
)
    comment '活跃用户' collate = utf8mb4_unicode_ci;

create table m_user_collection
(
    id           bigint auto_increment comment '主键ID'
        primary key,
    user_id      bigint   not null comment '收藏的贴【当前用户ID】',
    post_id      bigint   not null comment '收藏的贴【收藏的文章ID】',
    post_user_id bigint   not null comment '收藏的贴【收藏的文章-拥有者ID】',
    created      datetime not null comment '收藏的贴【创建日期】',
    modified     datetime not null comment '收藏的贴【更新日期】'
)
    comment '用户中心-收藏的贴' collate = utf8mb4_unicode_ci;

create table m_user_message
(
    id           bigint auto_increment comment '主键ID'
        primary key,
    from_user_id bigint     null comment '我的消息的【发送消息的用户ID】',
    to_user_id   bigint     null comment '我的消息的【接收消息的用户ID】',
    post_id      bigint     null comment '我的消息的【关联的文章ID】',
    comment_id   bigint     null comment '我的消息的【关联的文章-对应的评论ID】',
    type         tinyint(2) null comment '我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论',
    created      datetime   not null comment '我的消息的【创建日期】',
    modified     datetime   null comment '我的消息的【更新日期】',
    status       int        null comment '我的消息的【状态】：0代表未读、1代表已读'
)
    comment '我的消息' collate = utf8mb4_unicode_ci;
	
INSERT INTO xblog.m_category (id, name, content, summary, icon, post_count, order_num, parent_id, meta_keywords, meta_description, created, modified, status) VALUES (1, '提问', '提问内容内容内容', null, null, 30, 3, 4, '提问SEO关键字', '提问SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:56', 0);
INSERT INTO xblog.m_category (id, name, content, summary, icon, post_count, order_num, parent_id, meta_keywords, meta_description, created, modified, status) VALUES (2, '分享', '分享内容内容内容', null, null, 10, 1, 2, '分享SEO关键字', '分享SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:54', 0);
INSERT INTO xblog.m_category (id, name, content, summary, icon, post_count, order_num, parent_id, meta_keywords, meta_description, created, modified, status) VALUES (3, '讨论', '讨论内容内容内容', null, null, 40, 4, 1, '讨论SEO关键字', '讨论SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:57', 0);
INSERT INTO xblog.m_category (id, name, content, summary, icon, post_count, order_num, parent_id, meta_keywords, meta_description, created, modified, status) VALUES (4, '建议', '建议内容内容内容', null, null, 20, 2, 3, '建议SEO关键字', '建议SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:55', 0);

INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1, '评论1评论1评论1评论1评论1评论1', null, 1, 1, 10, 11, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (2, '评论2评论2评论2评论2评论2评论2', null, 4, 1, 20, 22, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (3, '评论3评论3评论3评论3评论3评论3', null, 3, 1, 30, 33, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (4, '评论4评论4评论4评论4评论4评论4', null, 4, 2, 40, 44, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (5, '评论5评论5评论5评论5评论5评论5', null, 5, 3, 50, 55, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (6, '评论6评论6评论6评论6评论6评论6', null, 6, 3, 60, 66, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (7, '评论7评论7评论7评论7评论7评论7', null, 3, 3, 70, 77, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (8, '评论8评论8评论8评论8评论8评论8', null, 8, 4, 80, 88, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (9, '评论9评论9评论9评论9评论9评论9', null, 9, 4, 10, 11, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (10, '评论10评论10评论10评论10评论10', null, 10, 4, 20, 22, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (11, '评论11评论11评论11评论11评论11', null, 11, 3, 30, 33, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (12, '评论12评论12评论12评论12评论12', null, 12, 3, 40, 44, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (13, '评论13评论13评论13评论13评论13', null, 13, 2, 50, 55, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (14, '评论14评论14评论14评论14评论14', null, 14, 2, 60, 66, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (15, '评论15评论15评论15评论15评论15', null, 15, 1, 70, 77, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (16, '评论16评论16评论16评论16评论16', null, 16, 1, 80, 88, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (17, '评论17评论17评论17评论17评论17', null, 1, 1, 10, 11, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (18, '评论18评论18评论18评论18评论18', null, 2, 1, 20, 22, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (19, '评论19评论19评论19评论19评论19', null, 3, 2, 30, 33, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (20, '评论20评论20评论20评论20评论20', null, 4, 2, 40, 44, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (21, '评论21评论21评论21评论21评论21', null, 5, 3, 50, 55, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (22, '评论22评论22评论22评论22评论22', null, 6, 3, 60, 66, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (23, '评论23评论23评论23评论23评论23', null, 7, 4, 70, 77, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (24, '评论24评论24评论24评论24评论24', null, 8, 4, 80, 88, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1370757722592518146, 'face[哈哈] ', null, 15, 1, 0, 0, 0, null, '2021-03-13 15:24:43', '2021-03-13 15:24:43');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1370757832856576002, '1111111', null, 15, 1, 0, 0, 0, null, '2021-03-13 15:25:09', '2021-03-13 15:25:09');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1370757934476173314, '1111', null, 15, 1, 0, 0, 0, null, '2021-03-13 15:25:34', '2021-03-13 15:25:34');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1370759796466192386, '2222', null, 15, 1, 0, 0, 0, null, '2021-03-13 15:32:57', '2021-03-13 15:32:57');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1370759796466192387, '1111111111111111', null, 16, 1, 0, 0, 0, null, '2021-03-13 16:04:59', '2021-03-13 16:04:59');
INSERT INTO xblog.m_comment (id, content, parent_id, post_id, user_id, vote_up, vote_down, level, status, created, modified) VALUES (1370759796466192388, '222222222', null, 16, 1, 0, 0, 0, null, '2021-03-13 16:05:11', '2021-03-13 16:05:11');

INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (1, '文章1', '文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1', '1', 1, 2, 10, 1, 13, 2, 0, 1, 1, '2021-02-01 11:05:46', '2021-02-01 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (2, '文章2', '文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2', '1', 1, 2, 20, 2, 24, 2, 1, 0, 1, '2021-02-02 11:05:46', '2021-02-02 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (3, '文章3', '文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3', '1', 2, 1, 30, 3, 36, 2, 0, 1, 1, '2021-02-03 11:05:46', '2021-02-03 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (5, '文章5', '文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5', '1', 3, 4, 50, 5, 56, 2, 0, 1, 1, '2021-02-05 11:05:46', '2021-02-05 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (6, '文章6', '文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6', '1', 3, 4, 60, 6, 77, 2, 1, 0, 1, '2021-02-06 11:05:46', '2021-02-06 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (7, '文章7', '文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7', '1', 4, 1, 70, 7, 114, 2, 1, 1, 1, '2021-02-07 11:05:46', '2021-02-07 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (9, '文章9', '文章9文章9文章9文章9文章9文章9文章9文章9文章9', '1', 4, 1, 10, 1, 12, 1, 0, 1, 1, '2021-02-01 11:05:46', '2021-02-01 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (10, '文章10', '文章10文章10文章10文章10文章10文章10文章10', '1', 4, 1, 20, 2, 22, 1, 1, 0, 1, '2021-02-02 11:05:46', '2021-02-02 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (11, '文章11', '文章11文章11文章11文章11文章11文章11文章11', '1', 3, 2, 30, 3, 35, 1, 0, 1, 1, '2021-02-03 11:05:46', '2021-02-03 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (12, '文章12', '文章12文章12文章12文章12文章12文章12文章12', '1', 3, 2, 40, 4, 46, 1, 1, 0, 1, '2021-02-04 11:05:46', '2021-02-04 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (13, '文章13', '文章13文章13文章13文章13文章13文章13文章13', '1', 2, 1, 50, 5, 65, 1, 1, 1, 1, '2021-02-05 11:05:46', '2021-02-05 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (14, '文章14', '文章14文章14文章14文章14文章14文章14文章14', '1', 2, 1, 60, 6, 70, 1, 1, 0, 1, '2021-02-06 11:05:46', '2021-02-06 11:05:46');
INSERT INTO xblog.m_post (id, title, content, edit_mode, category_id, user_id, vote_up, vote_down, view_count, comment_count, recommend, level, status, created, modified) VALUES (16, '文章16', '文章16文章16文章16文章16文章16文章16文章16', '1', 1, 4, 80, 8, 116, 3, 1, 0, 1, '2021-02-08 11:05:46', '2021-02-08 11:05:46');

INSERT INTO xblog.m_user (id, username, password, email, mobile, point, sign, gender, wechat, vip_level, birthday, comment_count, post_count, avatar, status, lasted, created, modified) VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '11111@qq.com', '13599998888', 100, 'Don''t let joy take you down !', '0', 'visions', 0, '2020-09-07 12:23:27', 2, 20, '/upload/avatar/avatar_1.jpg', 0, '2021-03-13 16:35:56', '2020-04-28 14:37:24', '2020-12-08 12:25:11');
INSERT INTO xblog.m_user (id, username, password, email, mobile, point, sign, gender, wechat, vip_level, birthday, comment_count, post_count, avatar, status, lasted, created, modified) VALUES (2, 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '22222@qq.com', '13599998888', 200, '勿因喜而轻诺！', '0', 'visions', 1, '2020-12-08 12:23:34', 3, 30, '/res/images/avatar/02_0051.jpg', 0, '2020-12-08 12:24:22', '2020-04-28 14:45:07', '2020-12-08 12:25:12');
INSERT INTO xblog.m_user (id, username, password, email, mobile, point, sign, gender, wechat, vip_level, birthday, comment_count, post_count, avatar, status, lasted, created, modified) VALUES (3, 'admin3', 'e10adc3949ba59abbe56e057f20f883e', '33333@qq.com', '13599998888', 300, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-08 12:23:36', 4, 40, '/res/images/avatar/03_0053.jpg', 1, '2020-12-08 12:24:23', '2020-04-28 14:48:26', '2020-12-08 12:25:13');
INSERT INTO xblog.m_user (id, username, password, email, mobile, point, sign, gender, wechat, vip_level, birthday, comment_count, post_count, avatar, status, lasted, created, modified) VALUES (4, 'admin4', 'e10adc3949ba59abbe56e057f20f883e', '44444@qq.com', '13599998888', 400, '勿因喜而轻诺！', '0', 'visions', 1, '2020-12-08 04:23:37', 5, 50, '/res/images/avatar/04_0054.jpg', 0, '2021-03-13 16:04:47', '2020-04-28 14:48:26', '2020-12-08 12:25:14');
INSERT INTO xblog.m_user (id, username, password, email, mobile, point, sign, gender, wechat, vip_level, birthday, comment_count, post_count, avatar, status, lasted, created, modified) VALUES (5, 'admin5', 'e10adc3949ba59abbe56e057f20f883e', '55555@qq.com', '13599998888', 500, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-08 12:23:37', 6, 60, '/res/images/avatar/05_0056.jpg', 0, '2020-12-08 12:24:26', '2020-04-28 14:53:49', '2020-12-08 12:25:15');
INSERT INTO xblog.m_user (id, username, password, email, mobile, point, sign, gender, wechat, vip_level, birthday, comment_count, post_count, avatar, status, lasted, created, modified) VALUES (6, 'halavah', 'e10adc3949ba59abbe56e057f20f883e', 'halavah@126.com', null, 0, null, '0', null, 0, null, 0, 0, '/res/images/avatar/default.jpg', 0, '2021-03-06 14:00:44', '2021-03-06 14:00:30', null);

INSERT INTO xblog.m_user_collection (id, user_id, post_id, post_user_id, created, modified) VALUES (1, 1, 2, 3, '2021-03-08 23:20:46', '2021-03-08 23:20:49');
INSERT INTO xblog.m_user_collection (id, user_id, post_id, post_user_id, created, modified) VALUES (2, 2, 3, 3, '2021-03-08 23:21:11', '2021-03-08 23:21:14');
INSERT INTO xblog.m_user_collection (id, user_id, post_id, post_user_id, created, modified) VALUES (4, 2, 5, 2, '2021-03-08 23:22:01', '2021-03-08 23:22:03');
INSERT INTO xblog.m_user_collection (id, user_id, post_id, post_user_id, created, modified) VALUES (5, 3, 6, 3, '2021-03-08 23:22:21', '2021-03-08 23:22:23');
INSERT INTO xblog.m_user_collection (id, user_id, post_id, post_user_id, created, modified) VALUES (6, 1, 16, 4, '2021-03-12 01:01:13', '2021-03-12 01:01:13');

INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (1, 1, 2, null, 2, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (2, 2, 1, 13, 13, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (3, 1, 3, 5, 4, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (4, 3, 4, null, 5, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (6, 2, 1, 3, 7, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (7, 4, 5, 11, 8, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (8, 5, 4, 12, 9, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (14, 2, 1, 14, 14, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (15, 1, 4, 16, 1370759796466192387, 1, '2021-03-13 16:04:59', null, 0);
INSERT INTO xblog.m_user_message (id, from_user_id, to_user_id, post_id, comment_id, type, created, modified, status) VALUES (16, 1, 4, 16, 1370759796466192388, 1, '2021-03-13 16:05:11', null, 0);
	