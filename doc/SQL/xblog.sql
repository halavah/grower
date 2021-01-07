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

 Date: 07/01/2021 11:04:32
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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_comment
-- ----------------------------
INSERT INTO `m_comment` VALUES (1, '评论1评论1评论1评论1评论1评论1', 1, 1, 1, 10, 11, 1, 0, '2020-12-08 12:33:46', '2020-12-08 12:33:48');
INSERT INTO `m_comment` VALUES (2, '评论2评论2评论2评论2评论2评论2', 2, 2, 1, 20, 22, 0, 1, '2020-12-08 12:36:25', '2020-12-08 12:36:30');
INSERT INTO `m_comment` VALUES (3, '评论3评论3评论3评论3评论3评论3', 3, 3, 1, 30, 33, 1, 0, '2020-12-08 12:36:26', '2020-12-08 12:36:31');
INSERT INTO `m_comment` VALUES (4, '评论4评论4评论4评论4评论4评论4', 4, 4, 1, 40, 44, 0, 1, '2020-12-08 12:36:27', '2020-12-08 12:36:32');
INSERT INTO `m_comment` VALUES (5, '评论5评论5评论5评论5评论5评论5', 1, 5, 2, 50, 55, 1, 0, '2020-12-08 12:36:28', '2020-12-08 12:36:33');
INSERT INTO `m_comment` VALUES (6, '评论6评论6评论6评论6评论6评论6', 2, 6, 2, 60, 66, 0, 1, '2020-12-08 12:36:29', '2020-12-08 12:36:34');
INSERT INTO `m_comment` VALUES (7, '评论7评论7评论7评论7评论7评论7', 3, 7, 2, 70, 77, 1, 0, '2020-12-08 12:36:29', '2020-12-08 12:36:34');
INSERT INTO `m_comment` VALUES (8, '评论8评论8评论8评论8评论8评论8', 4, 8, 2, 80, 88, 0, 1, '2020-12-08 12:33:46', '2020-12-08 12:33:48');
INSERT INTO `m_comment` VALUES (9, '评论9评论9评论9评论9评论9评论9', 1, 1, 3, 10, 11, 1, 0, '2020-12-08 12:36:25', '2020-12-08 12:36:30');
INSERT INTO `m_comment` VALUES (10, '评论10评论10评论10评论10评论10', 2, 2, 3, 20, 22, 0, 1, '2020-12-08 12:36:26', '2020-12-08 12:36:31');
INSERT INTO `m_comment` VALUES (11, '评论11评论11评论11评论11评论11', 3, 3, 3, 30, 33, 1, 0, '2020-12-08 12:36:27', '2020-12-08 12:36:32');
INSERT INTO `m_comment` VALUES (12, '评论12评论12评论12评论12评论12', 4, 4, 3, 40, 44, 0, 1, '2020-12-08 12:36:28', '2020-12-08 12:36:33');
INSERT INTO `m_comment` VALUES (13, '评论13评论13评论13评论13评论13', 1, 5, 4, 50, 55, 1, 0, '2020-12-08 12:36:29', '2020-12-08 12:36:34');
INSERT INTO `m_comment` VALUES (14, '评论14评论14评论14评论14评论14', 2, 6, 4, 60, 66, 0, 1, '2020-12-08 12:36:29', '2020-12-08 12:36:34');
INSERT INTO `m_comment` VALUES (15, '评论15评论15评论15评论15评论15', 3, 7, 4, 70, 77, 1, 0, '2020-12-08 12:33:46', '2020-12-08 12:33:48');
INSERT INTO `m_comment` VALUES (16, '评论16评论16评论16评论16评论16', 4, 8, 4, 80, 88, 0, 1, '2020-12-08 12:36:25', '2020-12-08 12:36:30');
INSERT INTO `m_comment` VALUES (17, '评论17评论17评论17评论17评论17', 1, 1, 3, 10, 11, 1, 0, '2020-12-08 12:36:25', '2020-12-08 12:36:30');
INSERT INTO `m_comment` VALUES (18, '评论18评论18评论18评论18评论18', 2, 2, 3, 20, 22, 0, 1, '2020-12-08 12:36:26', '2020-12-08 12:36:31');
INSERT INTO `m_comment` VALUES (19, '评论19评论19评论19评论19评论19', 3, 3, 3, 30, 33, 1, 0, '2020-12-08 12:36:27', '2020-12-08 12:36:32');
INSERT INTO `m_comment` VALUES (20, '评论20评论20评论20评论20评论20', 4, 4, 3, 40, 44, 0, 1, '2020-12-08 12:36:28', '2020-12-08 12:36:33');
INSERT INTO `m_comment` VALUES (21, '评论21评论21评论21评论21评论21', 1, 5, 4, 50, 55, 1, 0, '2020-12-08 12:36:29', '2020-12-08 12:36:34');
INSERT INTO `m_comment` VALUES (22, '评论22评论22评论22评论22评论22', 2, 6, 4, 60, 66, 0, 1, '2020-12-08 12:36:29', '2020-12-08 12:36:34');
INSERT INTO `m_comment` VALUES (23, '评论23评论23评论23评论23评论23', 3, 7, 4, 70, 77, 1, 0, '2020-12-08 12:33:46', '2020-12-08 12:33:48');
INSERT INTO `m_comment` VALUES (24, '评论24评论24评论24评论24评论24', 4, 8, 4, 80, 88, 0, 1, '2020-12-08 12:36:25', '2020-12-08 12:36:30');

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
INSERT INTO `m_post` VALUES (1, '文章1', '文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1', '1', 1, 1, 10, 1, 11, 1, 0, 1, 1, '2020-04-28 14:41:41', '2020-04-28 14:41:41');
INSERT INTO `m_post` VALUES (2, '文章2', '文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2', '1', 1, 1, 20, 2, 22, 2, 1, 0, 1, '2020-04-28 14:55:16', '2020-04-28 14:55:16');
INSERT INTO `m_post` VALUES (3, '文章3', '文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3', '1', 2, 1, 30, 3, 33, 3, 0, 1, 1, '2020-04-28 14:55:48', '2020-04-28 14:55:48');
INSERT INTO `m_post` VALUES (4, '文章4', '文章4文章4文章4文章4文章4文章4文章4文章4文章4文章4文章4文章4', '1', 2, 1, 40, 4, 44, 4, 1, 0, 1, '2020-12-08 12:32:30', '2020-12-08 12:32:37');
INSERT INTO `m_post` VALUES (5, '文章5', '文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5', '1', 3, 2, 50, 5, 55, 5, 0, 1, 1, '2020-12-08 12:32:32', '2020-12-08 12:32:36');
INSERT INTO `m_post` VALUES (6, '文章6', '文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6', '1', 3, 2, 60, 6, 66, 6, 1, 0, 1, '2020-12-08 12:32:32', '2020-12-08 12:32:37');
INSERT INTO `m_post` VALUES (7, '文章7', '文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7', '1', 4, 2, 70, 7, 77, 7, 0, 1, 1, '2020-12-08 12:32:33', '2020-12-08 12:32:38');
INSERT INTO `m_post` VALUES (8, '文章8', '文章8文章8文章8文章8文章8文章8文章8文章8文章8文章8文章8文章8', '1', 4, 2, 80, 8, 88, 8, 1, 0, 1, '2020-12-08 12:32:34', '2020-12-08 12:32:39');
INSERT INTO `m_post` VALUES (9, '文章9', '文章9文章9文章9文章9文章9文章9文章9文章9文章9', '1', 1, 3, 10, 1, 11, 1, 0, 1, 1, '2020-04-28 14:41:41', '2020-04-28 14:41:41');
INSERT INTO `m_post` VALUES (10, '文章10', '文章10文章10文章10文章10文章10文章10文章10', '1', 1, 3, 20, 2, 22, 2, 1, 0, 1, '2020-04-28 14:55:16', '2020-04-28 14:55:16');
INSERT INTO `m_post` VALUES (11, '文章11', '文章11文章11文章11文章11文章11文章11文章11', '1', 2, 3, 30, 3, 33, 3, 0, 1, 1, '2020-04-28 14:55:48', '2020-04-28 14:55:48');
INSERT INTO `m_post` VALUES (12, '文章12', '文章12文章12文章12文章12文章12文章12文章12', '1', 2, 3, 40, 4, 44, 4, 1, 0, 1, '2020-12-08 12:32:30', '2020-12-08 12:32:37');
INSERT INTO `m_post` VALUES (13, '文章13', '文章13文章13文章13文章13文章13文章13文章13', '1', 3, 4, 50, 5, 55, 5, 0, 1, 1, '2020-12-08 12:32:32', '2020-12-08 12:32:36');
INSERT INTO `m_post` VALUES (14, '文章14', '文章14文章14文章14文章14文章14文章14文章14', '1', 3, 4, 60, 6, 66, 6, 1, 0, 1, '2020-12-08 12:32:32', '2020-12-08 12:32:37');
INSERT INTO `m_post` VALUES (15, '文章15', '文章15文章15文章15文章15文章15文章15文章15', '1', 4, 4, 70, 7, 77, 7, 0, 1, 1, '2020-12-08 12:32:33', '2020-12-08 12:32:38');
INSERT INTO `m_post` VALUES (16, '文章16', '文章16文章16文章16文章16文章16文章16文章16', '1', 4, 4, 80, 8, 88, 8, 1, 0, 1, '2020-12-08 12:32:34', '2020-12-08 12:32:39');

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
INSERT INTO `m_user` VALUES (1, 'admin', '96e79218965eb72c92a549dd5a330112', '11111@qq.com', '13599998888', 100, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-09 12:23:27', '/res/images/avatar/default.png', 20, 2, 0, '2020-12-04 12:17:31', '2020-04-28 14:37:24', '2020-12-08 12:25:11');
INSERT INTO `m_user` VALUES (2, 'test01', '96e79218965eb72c92a549dd5a330112', '22222@qq.com', '13599998888', 200, '勿因喜而轻诺！', '0', 'visions', 1, '2020-12-08 12:23:34', '/res/images/avatar/1.jpg', 30, 3, 0, '2020-12-08 12:24:22', '2020-04-28 14:45:07', '2020-12-08 12:25:12');
INSERT INTO `m_user` VALUES (3, 'test02', '96e79218965eb72c92a549dd5a330112', '33333@qq.com', '13599998888', 300, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-08 12:23:36', '/res/images/avatar/2.jpg', 40, 4, 1, '2020-12-08 12:24:23', '2020-04-28 14:48:26', '2020-12-08 12:25:13');
INSERT INTO `m_user` VALUES (4, 'test03', '96e79218965eb72c92a549dd5a330112', '44444@qq.com', '13599998888', 400, '勿因喜而轻诺！', '0', 'visions', 1, '2020-12-08 12:23:37', '/res/images/avatar/3.jpg', 50, 5, 0, '2020-12-08 12:24:25', '2020-04-28 14:48:26', '2020-12-08 12:25:14');
INSERT INTO `m_user` VALUES (5, 'test04', '96e79218965eb72c92a549dd5a330112', '55555@qq.com', '13599998888', 500, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-08 12:23:37', '/res/images/avatar/4.jpg', 60, 6, 0, '2020-12-08 12:24:26', '2020-04-28 14:53:49', '2020-12-08 12:25:15');

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
