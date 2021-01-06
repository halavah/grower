/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-5.7.25
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : xblog

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 06/01/2021 00:26:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for m_category
-- ----------------------------
DROP TABLE IF EXISTS `m_category`;
CREATE TABLE `m_category`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '内容描述',
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `icon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '图标',
  `post_count` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '该分类的内容数量',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序编码',
  `parent_id` bigint(32) UNSIGNED NULL DEFAULT NULL COMMENT '父级分类的ID',
  `meta_keywords` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'SEO描述内容',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `modified` datetime(0) NULL DEFAULT NULL,
  `status` tinyint(2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_category
-- ----------------------------
INSERT INTO `m_category` VALUES (1, '提问', '提问内容内容内容', NULL, NULL, 30, 3, 4, '提问SEO关键字', '提问SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:56', 0);
INSERT INTO `m_category` VALUES (2, '分享', '分享内容内容内容', NULL, NULL, 10, 1, 2, '分享SEO关键字', '分享SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:54', 0);
INSERT INTO `m_category` VALUES (3, '讨论', '讨论内容内容内容', NULL, NULL, 40, 4, 1, '讨论SEO关键字', '讨论SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:57', 0);
INSERT INTO `m_category` VALUES (4, '建议', '建议内容内容内容', NULL, NULL, 20, 2, 3, '建议SEO关键字', '建议SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:55', 0);

-- ----------------------------
-- Table structure for m_comment
-- ----------------------------
DROP TABLE IF EXISTS `m_comment`;
CREATE TABLE `m_comment`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论的内容',
  `parent_id` bigint(32) NULL DEFAULT NULL COMMENT '回复的评论ID',
  `post_id` bigint(32) NOT NULL COMMENT '评论的内容ID',
  `user_id` bigint(32) NOT NULL COMMENT '评论的用户ID',
  `vote_up` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '“顶”的数量',
  `vote_down` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '“踩”的数量',
  `level` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '置顶等级',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '评论的状态',
  `created` datetime(0) NOT NULL COMMENT '评论的时间',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '评论的更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_comment
-- ----------------------------
INSERT INTO `m_comment` VALUES (1, '评论评论评论评论评论评论评论评论', 4, 4, 4, 1000, 10, 1, NULL, '2021-01-06 00:21:58', '2021-01-06 00:22:00');
INSERT INTO `m_comment` VALUES (2, '评论评论评论评论评论评论评论评论', 3, 3, 1, 2000, 20, 1, NULL, '2021-01-06 00:21:58', '2021-01-06 00:22:00');
INSERT INTO `m_comment` VALUES (3, '评论评论评论评论评论评论评论评论', 4, 2, 2, 3000, 30, 2, NULL, '1970-01-01 00:00:00', '2021-01-06 00:21:58');
INSERT INTO `m_comment` VALUES (4, '评论评论评论评论评论评论评论评论', 1, 4, 2, 4000, 40, 2, NULL, '1970-01-01 00:00:00', '2021-01-06 00:21:58');
INSERT INTO `m_comment` VALUES (5, '评论评论评论评论评论评论评论评论', 3, 2, 3, 5000, 50, 3, NULL, '1970-01-01 00:00:00', '2021-01-06 00:21:58');
INSERT INTO `m_comment` VALUES (6, '评论评论评论评论评论评论评论评论', 2, 3, 3, 6000, 60, 3, NULL, '1970-01-01 00:00:00', '2021-01-06 00:21:58');
INSERT INTO `m_comment` VALUES (7, '评论评论评论评论评论评论评论评论', 1, 1, 4, 7000, 70, 4, NULL, '1970-01-01 00:00:00', '2021-01-06 00:21:58');
INSERT INTO `m_comment` VALUES (8, '评论评论评论评论评论评论评论评论', 4, 4, 4, 8000, 80, 4, NULL, '2021-01-06 00:21:58', '2021-01-06 00:22:00');

-- ----------------------------
-- Table structure for m_post
-- ----------------------------
DROP TABLE IF EXISTS `m_post`;
CREATE TABLE `m_post`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `edit_mode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '编辑模式：html可视化，markdown ..',
  `category_id` bigint(32) NULL DEFAULT NULL,
  `user_id` bigint(32) NULL DEFAULT NULL COMMENT '用户ID',
  `vote_up` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '支持人数',
  `vote_down` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '反对人数',
  `view_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '访问量',
  `comment_count` int(11) NOT NULL DEFAULT 0 COMMENT '评论数量',
  `recommend` tinyint(1) NULL DEFAULT NULL COMMENT '是否为精华',
  `level` tinyint(2) NOT NULL DEFAULT 0 COMMENT '置顶等级',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '状态',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '最后更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_post
-- ----------------------------
INSERT INTO `m_post` VALUES (1, '文章1', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 1, 1, 1000, 100, 10, 1, 1, 1, NULL, '2021-04-28 14:41:41', '2021-04-28 14:41:41');
INSERT INTO `m_post` VALUES (2, '文章2', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 1, 2, 2000, 200, 20, 2, 1, 1, NULL, '2021-04-28 14:55:16', '2021-04-28 14:55:16');
INSERT INTO `m_post` VALUES (3, '文章3', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 2, 3, 3000, 300, 30, 3, 0, 0, NULL, '2021-04-28 14:55:48', '2021-04-28 14:55:48');
INSERT INTO `m_post` VALUES (4, '文章4', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 2, 4, 4000, 400, 40, 4, 1, 1, NULL, '2021-04-28 14:41:41', '2021-04-28 14:41:41');
INSERT INTO `m_post` VALUES (5, '文章5', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 3, 4, 5000, 500, 50, 5, 1, 1, NULL, '2021-04-28 14:55:16', '2021-04-28 14:55:16');
INSERT INTO `m_post` VALUES (6, '文章6', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 3, 3, 6000, 600, 60, 6, 0, 0, NULL, '2021-04-28 14:55:48', '2021-04-28 14:55:48');
INSERT INTO `m_post` VALUES (7, '文章7', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 4, 2, 7000, 700, 70, 7, 1, 1, NULL, '2021-04-28 14:41:41', '2021-04-28 14:41:41');
INSERT INTO `m_post` VALUES (8, '文章8', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 4, 1, 8000, 800, 80, 8, 1, 1, NULL, '2021-04-28 14:55:16', '2021-04-28 14:55:16');
INSERT INTO `m_post` VALUES (9, '文章9', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 1, 1, 9000, 900, 90, 9, 0, 0, NULL, '2021-04-28 14:55:48', '2021-04-28 14:55:48');
INSERT INTO `m_post` VALUES (10, '文章10', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 1, 2, 10000, 1000, 100, 10, 1, 1, NULL, '2021-04-28 14:41:41', '2021-04-28 14:41:41');
INSERT INTO `m_post` VALUES (11, '文章11', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 2, 3, 11000, 1100, 110, 11, 1, 1, NULL, '2021-04-28 14:55:16', '2021-04-28 14:55:16');
INSERT INTO `m_post` VALUES (12, '文章12', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 2, 4, 12000, 1200, 120, 12, 0, 0, NULL, '2021-04-28 14:55:48', '2021-04-28 14:55:48');
INSERT INTO `m_post` VALUES (13, '文章13', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 3, 4, 13000, 1300, 130, 13, 1, 1, NULL, '2021-04-28 14:41:41', '2021-04-28 14:41:41');
INSERT INTO `m_post` VALUES (14, '文章14', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 3, 3, 14000, 1400, 140, 14, 1, 1, NULL, '2021-04-28 14:55:16', '2021-04-28 14:55:16');
INSERT INTO `m_post` VALUES (15, '文章15', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 4, 2, 15000, 1500, 150, 15, 0, 0, NULL, '2021-04-28 14:55:48', '2021-04-28 14:55:48');
INSERT INTO `m_post` VALUES (16, '文章16', '内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容', '0', 4, 1, 16000, 1600, 160, 16, 0, 0, NULL, '2021-04-28 14:55:48', '2021-04-28 14:55:48');

-- ----------------------------
-- Table structure for m_user
-- ----------------------------
DROP TABLE IF EXISTS `m_user`;
CREATE TABLE `m_user`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮件',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机电话',
  `point` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '积分',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '个性签名',
  `gender` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '性别',
  `wechat` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信号',
  `vip_level` int(32) NULL DEFAULT NULL COMMENT 'vip等级',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '生日',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '头像',
  `post_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '内容数量',
  `comment_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论数量',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '状态',
  `lasted` datetime(0) NULL DEFAULT NULL COMMENT '最后的登陆时间',
  `created` datetime(0) NOT NULL COMMENT '创建日期',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user
-- ----------------------------
INSERT INTO `m_user` VALUES (1, 'admin', '96e79218965eb72c92a549dd5a330112', '11111@qq.com', '15133336666', 100, '浮生皆纵，恍如一梦', '0', '15133336666', 1, '2021-01-05 22:20:47', '/res/images/avatar/1.jpg', 100, 10, 0, '2021-04-28 14:54:11', '2020-04-28 14:37:24', '2021-01-05 22:21:48');
INSERT INTO `m_user` VALUES (2, 'test01', '96e79218965eb72c92a549dd5a330112', '22222@qq.com', '15133336666', 200, '浮生皆纵，恍如一梦', '1', '15133336666', 2, '2021-01-05 22:20:52', '/res/images/avatar/2.jpg', 200, 20, 0, '2021-01-05 22:21:34', '2020-04-28 14:45:07', '2021-01-05 22:21:50');
INSERT INTO `m_user` VALUES (3, 'test02', '96e79218965eb72c92a549dd5a330112', '33333@qq.com', '15133336666', 300, '浮生皆纵，恍如一梦', '0', '15133336666', 3, '2021-01-05 22:20:53', '/res/images/avatar/3.jpg', 300, 30, 0, '2021-01-05 22:21:36', '2020-04-28 14:48:26', '2021-01-05 22:21:51');
INSERT INTO `m_user` VALUES (4, 'test03', '96e79218965eb72c92a549dd5a330112', '44444@qq.com', '15133336666', 400, '浮生皆纵，恍如一梦', '1', '15133336666', 4, '2021-01-05 22:20:54', '/res/images/avatar/4.jpg', 400, 40, 0, '2021-01-05 22:21:37', '2020-04-28 14:48:26', '2021-01-05 22:21:52');
INSERT INTO `m_user` VALUES (5, 'test04', '96e79218965eb72c92a549dd5a330112', '55555@qq.com', '15133336666', 500, '浮生皆纵，恍如一梦', '0', '15133336666', 5, '2021-01-05 22:20:55', '/res/images/avatar/5.jpg', 500, 50, 0, '2021-01-05 22:21:37', '2020-04-28 14:53:49', '2021-01-05 22:21:53');

-- ----------------------------
-- Table structure for m_user_action
-- ----------------------------
DROP TABLE IF EXISTS `m_user_action`;
CREATE TABLE `m_user_action`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户ID',
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '动作类型',
  `point` int(11) NULL DEFAULT NULL COMMENT '得分',
  `post_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联的帖子ID',
  `comment_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '关联的评论ID',
  `created` datetime(0) NULL DEFAULT NULL,
  `modified` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_action
-- ----------------------------
INSERT INTO `m_user_action` VALUES ('1', '1', 'A', 100, '1', '1', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('2', '1', 'B', 200, '2', '2', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('3', '1', 'C', 300, '3', '3', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('4', '1', 'D', 400, '4', '4', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('5', '1', 'A', 500, '5', '5', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('6', '1', 'B', 600, '6', '6', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('7', '1', 'C', 700, '7', '7', '2021-01-06 00:13:57', '2021-01-06 00:14:00');
INSERT INTO `m_user_action` VALUES ('8', '1', 'D', 800, '8', '8', '2021-01-06 00:13:57', '2021-01-06 00:14:00');

-- ----------------------------
-- Table structure for m_user_collection
-- ----------------------------
DROP TABLE IF EXISTS `m_user_collection`;
CREATE TABLE `m_user_collection`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `post_user_id` bigint(20) NOT NULL,
  `created` datetime(0) NOT NULL,
  `modified` datetime(0) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_collection
-- ----------------------------
INSERT INTO `m_user_collection` VALUES (1, 1, 4, 1, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (2, 2, 3, 2, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (3, 3, 2, 3, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (4, 4, 1, 4, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (5, 1, 4, 5, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (6, 2, 3, 6, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (7, 3, 2, 7, '2021-01-06 00:17:49', '2021-01-06 00:17:52');
INSERT INTO `m_user_collection` VALUES (8, 4, 1, 8, '2021-01-06 00:17:49', '2021-01-06 00:17:52');

-- ----------------------------
-- Table structure for m_user_message
-- ----------------------------
DROP TABLE IF EXISTS `m_user_message`;
CREATE TABLE `m_user_message`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) NOT NULL COMMENT '发送消息的用户ID',
  `to_user_id` bigint(20) NOT NULL COMMENT '接收消息的用户ID',
  `post_id` bigint(20) NULL DEFAULT NULL COMMENT '消息可能关联的帖子',
  `comment_id` bigint(20) NULL DEFAULT NULL COMMENT '消息可能关联的评论',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `type` tinyint(2) NULL DEFAULT NULL COMMENT '消息类型',
  `created` datetime(0) NOT NULL,
  `modified` datetime(0) NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_message
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
