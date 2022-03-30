/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-5.7.25
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : forum

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 09/11/2021 12:46:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for m_category
-- ----------------------------
DROP TABLE IF EXISTS `m_category`;
CREATE TABLE `m_category`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类的【标题】',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '分类的【内容描述】',
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '分类的【内容摘要】',
  `icon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类的【图标】',
  `post_count` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '分类的【内容数量】',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '分类的【排序编码】',
  `parent_id` bigint(32) UNSIGNED NULL DEFAULT NULL COMMENT '分类的【父级分类的ID】',
  `meta_keywords` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类的【SEO关键字】',
  `meta_description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类的【SEO描述内容】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '分类的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '分类的【修改日期】',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '分类的【状态】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_category
-- ----------------------------
INSERT INTO `m_category` VALUES (1, '问答', '问答内容内容内容', NULL, NULL, 30, 3, 4, '提问SEO关键字', '提问SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:56', 0);
INSERT INTO `m_category` VALUES (2, '分享', '分享内容内容内容', NULL, NULL, 10, 1, 2, '分享SEO关键字', '分享SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:54', 0);
INSERT INTO `m_category` VALUES (3, '讨论', '讨论内容内容内容', NULL, NULL, 40, 4, 1, '讨论SEO关键字', '讨论SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:57', 0);
INSERT INTO `m_category` VALUES (4, '建议', '建议内容内容内容', NULL, NULL, 20, 2, 3, '建议SEO关键字', '建议SEO元信息', '2020-04-28 22:36:48', '2021-01-05 23:27:55', 0);

-- ----------------------------
-- Table structure for m_comment
-- ----------------------------
DROP TABLE IF EXISTS `m_comment`;
CREATE TABLE `m_comment`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论的【内容】',
  `parent_id` bigint(32) NULL DEFAULT NULL COMMENT '评论的【回复ID】',
  `post_id` bigint(32) NOT NULL COMMENT '评论的【文章ID】',
  `user_id` bigint(32) NOT NULL COMMENT '评论的【用户ID】',
  `vote_up` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的【“顶”的数量】',
  `vote_down` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的【“踩”的数量】',
  `level` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的【置顶等级】',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '评论的【状态】',
  `created` datetime(0) NOT NULL COMMENT '评论的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '评论的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1370759796466192399 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户评论' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_comment
-- ----------------------------
INSERT INTO `m_comment` VALUES (1, '评论1评论1评论1评论1评论1评论1', NULL, 1, 1, 10, 11, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO `m_comment` VALUES (2, '评论2评论2评论2评论2评论2评论2', NULL, 4, 1, 20, 22, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO `m_comment` VALUES (3, '评论3评论3评论3评论3评论3评论3', NULL, 3, 1, 30, 33, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO `m_comment` VALUES (4, '评论4评论4评论4评论4评论4评论4', NULL, 4, 2, 40, 44, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO `m_comment` VALUES (5, '评论5评论5评论5评论5评论5评论5', NULL, 5, 3, 50, 55, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO `m_comment` VALUES (6, '评论6评论6评论6评论6评论6评论6', NULL, 6, 3, 60, 66, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO `m_comment` VALUES (7, '评论7评论7评论7评论7评论7评论7', NULL, 3, 3, 70, 77, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO `m_comment` VALUES (8, '评论8评论8评论8评论8评论8评论8', NULL, 8, 4, 80, 88, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO `m_comment` VALUES (9, '评论9评论9评论9评论9评论9评论9', NULL, 9, 4, 10, 11, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO `m_comment` VALUES (10, '评论10评论10评论10评论10评论10', NULL, 10, 4, 20, 22, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO `m_comment` VALUES (11, '评论11评论11评论11评论11评论11', NULL, 11, 3, 30, 33, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO `m_comment` VALUES (12, '评论12评论12评论12评论12评论12', NULL, 12, 3, 40, 44, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO `m_comment` VALUES (13, '评论13评论13评论13评论13评论13', NULL, 13, 2, 50, 55, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO `m_comment` VALUES (14, '评论14评论14评论14评论14评论14', NULL, 14, 2, 60, 66, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO `m_comment` VALUES (15, '评论15评论15评论15评论15评论15', NULL, 15, 1, 70, 77, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO `m_comment` VALUES (16, '评论16评论16评论16评论16评论16', NULL, 16, 1, 80, 88, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO `m_comment` VALUES (17, '评论17评论17评论17评论17评论17', NULL, 1, 1, 10, 11, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO `m_comment` VALUES (19, '评论19评论19评论19评论19评论19', NULL, 3, 2, 30, 33, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO `m_comment` VALUES (20, '评论20评论20评论20评论20评论20', NULL, 4, 2, 40, 44, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO `m_comment` VALUES (21, '评论21评论21评论21评论21评论21', NULL, 5, 3, 50, 55, 1, 0, '2021-02-05 10:57:53', '2021-02-05 10:57:53');
INSERT INTO `m_comment` VALUES (22, '评论22评论22评论22评论22评论22', NULL, 6, 3, 60, 66, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
INSERT INTO `m_comment` VALUES (23, '评论23评论23评论23评论23评论23', NULL, 7, 4, 70, 77, 1, 0, '2021-02-07 10:57:53', '2021-02-07 10:57:53');
INSERT INTO `m_comment` VALUES (24, '评论24评论24评论24评论24评论24', NULL, 8, 4, 80, 88, 0, 1, '2021-02-08 10:57:53', '2021-02-08 10:57:53');
INSERT INTO `m_comment` VALUES (1370757722592518146, 'face[哈哈] ', NULL, 15, 1, 0, 0, 0, NULL, '2021-03-13 15:24:43', '2021-03-13 15:24:43');
INSERT INTO `m_comment` VALUES (1370757832856576002, '1111111', NULL, 15, 1, 0, 0, 0, NULL, '2021-03-13 15:25:09', '2021-03-13 15:25:09');
INSERT INTO `m_comment` VALUES (1370757934476173314, '1111', NULL, 15, 1, 0, 0, 0, NULL, '2021-03-13 15:25:34', '2021-03-13 15:25:34');
INSERT INTO `m_comment` VALUES (1370759796466192386, '2222', NULL, 15, 1, 0, 0, 0, NULL, '2021-03-13 15:32:57', '2021-03-13 15:32:57');
INSERT INTO `m_comment` VALUES (1370759796466192387, '1111111111111111', NULL, 16, 1, 0, 0, 0, NULL, '2021-03-13 16:04:59', '2021-03-13 16:04:59');
INSERT INTO `m_comment` VALUES (1370759796466192388, '222222222', NULL, 16, 1, 0, 0, 0, NULL, '2021-03-13 16:05:11', '2021-03-13 16:05:11');
INSERT INTO `m_comment` VALUES (1370759796466192389, 'face[亲亲] ', NULL, 2, 1, 0, 0, 0, NULL, '2021-11-08 17:40:18', '2021-11-08 17:40:18');
INSERT INTO `m_comment` VALUES (1370759796466192390, 'face[太开心] ', NULL, 1, 1, 0, 0, 0, NULL, '2021-11-08 17:48:12', '2021-11-08 17:48:12');
INSERT INTO `m_comment` VALUES (1370759796466192391, 'face[晕] ', NULL, 2, 1, 0, 0, 0, NULL, '2021-11-08 18:58:04', '2021-11-08 18:58:04');
INSERT INTO `m_comment` VALUES (1370759796466192392, 'face[右哼哼] ', NULL, 16, 1, 0, 0, 0, NULL, '2021-11-09 03:10:45', '2021-11-09 03:10:45');
INSERT INTO `m_comment` VALUES (1370759796466192393, 'face[馋嘴] ', NULL, 22, 1, 0, 0, 0, NULL, '2021-11-09 03:18:22', '2021-11-09 03:18:22');
INSERT INTO `m_comment` VALUES (1370759796466192394, '222222', NULL, 22, 2, 0, 0, 0, NULL, '2021-11-09 03:18:40', '2021-11-09 03:18:40');
INSERT INTO `m_comment` VALUES (1370759796466192395, '22222', NULL, 23, 2, 0, 0, 0, NULL, '2021-11-09 03:18:44', '2021-11-09 03:18:44');
INSERT INTO `m_comment` VALUES (1370759796466192396, '发表评论发表评论发表评论发表评论发表评论', NULL, 27, 1, 0, 0, 0, NULL, '2021-11-09 04:33:49', '2021-11-09 04:33:49');
INSERT INTO `m_comment` VALUES (1370759796466192398, '@admin 回复评论回复评论回复评论回复评论回复评论回复评论', NULL, 27, 1, 0, 0, 0, NULL, '2021-11-09 04:36:23', '2021-11-09 04:36:23');

-- ----------------------------
-- Table structure for m_post
-- ----------------------------
DROP TABLE IF EXISTS `m_post`;
CREATE TABLE `m_post`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【标题】',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【内容】',
  `edit_mode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '文章的【编辑模式】：html可视化，markdown文档',
  `category_id` bigint(32) NULL DEFAULT NULL COMMENT '文章的【分类ID】',
  `user_id` bigint(32) NULL DEFAULT NULL COMMENT '文章的【用户ID】',
  `vote_up` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的【支持人数】',
  `vote_down` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的【反对人数】',
  `view_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的【访问量】',
  `comment_count` int(11) NOT NULL DEFAULT 0 COMMENT '文章的【评论数量】',
  `recommend` tinyint(1) NULL DEFAULT NULL COMMENT '文章的【精华】：0代表取消加精、1代表加精',
  `level` tinyint(2) NOT NULL DEFAULT 0 COMMENT '文章的【置顶等级】：0代表取消置顶、1代表置顶',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '文章的【状态】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '文章的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '文章的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_post
-- ----------------------------
INSERT INTO `m_post` VALUES (1, '文章1', '文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1', '1', 1, 2, 10, 1, 22, 3, 1, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (2, '文章2', '文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2', '1', 1, 2, 20, 2, 31, 3, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (3, '文章3', '文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3\n                    ', '1', 2, 1, 30, 3, 43, 2, 0, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (5, '文章5', '文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5', '1', 3, 4, 50, 5, 57, 2, 0, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (6, '文章6', '文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6', '1', 3, 4, 60, 6, 79, 2, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (7, '文章7', '文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7', '1', 4, 1, 70, 7, 120, 2, 1, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (9, '文章9', '文章9文章9文章9文章9文章9文章9文章9文章9文章9', '1', 4, 1, 10, 1, 15, 1, 0, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (10, '文章10', '文章10文章10文章10文章10文章10文章10文章10', '1', 4, 1, 20, 2, 22, 1, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (11, '文章11', '文章11文章11文章11文章11文章11文章11文章11', '1', 3, 2, 30, 3, 36, 1, 0, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (12, '文章12', '文章12文章12文章12文章12文章12文章12文章12', '1', 3, 2, 40, 4, 46, 1, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (13, '文章13', '文章13文章13文章13文章13文章13文章13文章13', '1', 2, 1, 50, 5, 65, 1, 1, 1, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (14, '文章14', '文章14文章14文章14文章14文章14文章14文章14', '1', 2, 1, 60, 6, 70, 1, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (16, '文章16', '文章16文章16文章16文章16文章16文章16文章16', '1', 1, 4, 80, 8, 123, 4, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (17, '文章17', '文章17文章17文章17文章17文章17文章17文章17', '1', 2, 1, 80, 8, 119, 3, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (18, '文章18', '文章18文章18文章18文章18文章18文章18文章18', '1', 3, 4, 80, 8, 119, 3, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (19, '文章19', '文章19文章19文章19文章19文章19文章19文章19', '1', 4, 1, 80, 8, 119, 3, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (20, '文章20', '文章20文章20文章20文章20文章20文章20文章20', '1', 2, 2, 80, 8, 121, 3, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (21, '文章21', '文章21文章21文章21文章21文章21文章21文章21', '1', 1, 2, 80, 8, 119, 3, 1, 0, 1, '2021-11-07 11:05:46', '2021-11-07 11:05:46');
INSERT INTO `m_post` VALUES (22, '测试文章', '测试文章测试文章测试文章测试文章测试文章测试文章测试文章测试文章测试文章', '0', 2, 1, 0, 0, 15, 2, 1, 0, NULL, '2021-11-08 18:54:04', '2021-11-08 18:54:04');
INSERT INTO `m_post` VALUES (23, '测试文章2', '测试文章2测试文章2测试文章2', '0', 1, 1, 0, 0, 3, 1, 0, 0, NULL, '2021-11-08 18:55:39', '2021-11-08 18:55:39');
INSERT INTO `m_post` VALUES (27, '反向代理和正向代理区别', '正向代理类似一个跳板机，代理访问外部资源\n比如我们国内访问谷歌，直接访问访问不到，我们可以通过一个正向代理服务器，请求发到代理服，代理服务器能够访问谷歌，这样由代理去谷歌取到返回数据，再返回给我们，这样我们就能访问谷歌了\n\n反向代理的作用：\n（1）保证内网的安全，阻止web攻击，大型网站，通常将反向代理作为公网访问地址，Web服务器是内网\n（2）负载均衡，通过反向代理服务器来优化网站的负载\n\n------------', '0', 2, 1, 0, 0, 9, 2, 0, 0, NULL, '2021-11-09 04:31:04', '2021-11-09 04:31:04');

-- ----------------------------
-- Table structure for m_user
-- ----------------------------
DROP TABLE IF EXISTS `m_user`;
CREATE TABLE `m_user`  (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【昵称】',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【密码】',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【邮件】',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【手机】',
  `point` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的【积分】',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【个性签名】',
  `gender` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【性别】:0代表男，1代表女',
  `wechat` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【微信号】',
  `vip_level` int(32) NULL DEFAULT NULL COMMENT '用户的【VIP等级】',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '用户的【生日日期】',
  `comment_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的【评论数量】',
  `post_count` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的【内容数量】',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【头像】',
  `status` tinyint(2) NOT NULL DEFAULT 0 COMMENT '用户的【状态】:0代表登录成功，-1代表登录失败',
  `lasted` datetime(0) NULL DEFAULT NULL COMMENT '用户的【近期登陆日期】',
  `created` datetime(0) NOT NULL COMMENT '用户的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '用户的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user
-- ----------------------------
INSERT INTO `m_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '11111@qq.com', '13599998888', 100, 'Don\'t let joy take you down !', '0', 'visions', 0, '2021-10-30 12:23:27', 2, 20, '/upload/avatar/avatar_1.jpg', 0, '2021-11-09 04:13:42', '2021-11-09 04:23:27', '2021-11-09 04:23:27');
INSERT INTO `m_user` VALUES (2, 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '22222@qq.com', '13599998888', 200, '勿因喜而轻诺！', '0', 'visions', 1, '2021-11-07 12:23:27', 3, 30, '/res/images/avatar/02_0051.jpg', 0, '2021-11-09 03:18:33', '2021-11-09 04:23:27', '2021-11-09 04:23:27');
INSERT INTO `m_user` VALUES (3, 'admin3', 'e10adc3949ba59abbe56e057f20f883e', '33333@qq.com', '13599998888', 300, '勿因喜而轻诺！', '1', 'visions', 0, '2021-11-09 04:23:27', 4, 40, '/res/images/avatar/03_0053.jpg', 0, '2021-11-09 04:23:27', '2021-11-09 04:23:27', '2021-11-09 04:23:27');
INSERT INTO `m_user` VALUES (4, 'admin4', 'e10adc3949ba59abbe56e057f20f883e', '44444@qq.com', '13599998888', 400, '勿因喜而轻诺！', '0', 'visions', 1, '2021-11-09 04:23:27', 5, 50, '/res/images/avatar/04_0054.jpg', 1, '2021-11-09 04:23:27', '2021-11-09 04:23:27', '2021-11-09 04:23:27');
INSERT INTO `m_user` VALUES (5, 'admin5', 'e10adc3949ba59abbe56e057f20f883e', '55555@qq.com', '13599998888', 500, '勿因喜而轻诺！', '1', 'visions', 0, '2021-11-09 04:23:27', 6, 60, '/res/images/avatar/05_0056.jpg', 0, '2021-11-09 04:23:27', '2021-11-09 04:23:27', '2021-11-09 04:23:27');
INSERT INTO `m_user` VALUES (6, 'halavah', 'e10adc3949ba59abbe56e057f20f883e', 'halavah@126.com', NULL, 0, NULL, '0', NULL, 0, '2021-11-09 04:23:27', 0, 0, '/res/images/avatar/default.jpg', 0, '2021-11-09 04:23:27', '2021-11-09 04:23:27', '2021-11-09 04:23:27');

-- ----------------------------
-- Table structure for m_user_action
-- ----------------------------
DROP TABLE IF EXISTS `m_user_action`;
CREATE TABLE `m_user_action`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活跃用户的【用户ID】',
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活跃用户的【动作类型】',
  `point` int(11) NULL DEFAULT NULL COMMENT '活跃用户的【用户得分】',
  `post_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活跃用户的【关联的文章ID】',
  `comment_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活跃用户的【关联的评论ID】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '活跃用户的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '活跃用户的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活跃用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_action
-- ----------------------------

-- ----------------------------
-- Table structure for m_user_collection
-- ----------------------------
DROP TABLE IF EXISTS `m_user_collection`;
CREATE TABLE `m_user_collection`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(20) NOT NULL COMMENT '收藏的贴【当前用户ID】',
  `post_id` bigint(20) NOT NULL COMMENT '收藏的贴【收藏的文章ID】',
  `post_user_id` bigint(20) NOT NULL COMMENT '收藏的贴【收藏的文章-拥有者ID】',
  `created` datetime(0) NOT NULL COMMENT '收藏的贴【创建日期】',
  `modified` datetime(0) NOT NULL COMMENT '收藏的贴【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1370178027908034567 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户中心-收藏的贴' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_collection
-- ----------------------------
INSERT INTO `m_user_collection` VALUES (2, 2, 3, 3, '2021-03-08 23:21:11', '2021-03-08 23:21:14');
INSERT INTO `m_user_collection` VALUES (4, 2, 5, 2, '2021-03-08 23:22:01', '2021-03-08 23:22:03');
INSERT INTO `m_user_collection` VALUES (5, 3, 6, 3, '2021-03-08 23:22:21', '2021-03-08 23:22:23');
INSERT INTO `m_user_collection` VALUES (1370178027908034561, 1, 16, 4, '2021-03-12 01:01:13', '2021-03-12 01:01:13');
INSERT INTO `m_user_collection` VALUES (1370178027908034562, 1, 2, 2, '2021-11-08 17:39:55', '2021-11-08 17:39:55');
INSERT INTO `m_user_collection` VALUES (1370178027908034563, 1, 3, 1, '2021-11-08 18:03:05', '2021-11-08 18:03:05');
INSERT INTO `m_user_collection` VALUES (1370178027908034564, 1, 9, 1, '2021-11-08 18:03:21', '2021-11-08 18:03:21');
INSERT INTO `m_user_collection` VALUES (1370178027908034565, 1, 1, 2, '2021-11-08 18:03:52', '2021-11-08 18:03:52');

-- ----------------------------
-- Table structure for m_user_message
-- ----------------------------
DROP TABLE IF EXISTS `m_user_message`;
CREATE TABLE `m_user_message`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `from_user_id` bigint(20) NULL DEFAULT NULL COMMENT '我的消息的【发送消息的用户ID】',
  `to_user_id` bigint(20) NULL DEFAULT NULL COMMENT '我的消息的【接收消息的用户ID】',
  `post_id` bigint(20) NULL DEFAULT NULL COMMENT '我的消息的【关联的文章ID】',
  `comment_id` bigint(20) NULL DEFAULT NULL COMMENT '我的消息的【关联的文章-对应的评论ID】',
  `type` tinyint(2) NULL DEFAULT NULL COMMENT '我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论',
  `created` datetime(0) NOT NULL COMMENT '我的消息的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '我的消息的【更新日期】',
  `status` int(11) NULL DEFAULT NULL COMMENT '我的消息的【状态】：0代表未读、1代表已读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '我的消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_message
-- ----------------------------
INSERT INTO `m_user_message` VALUES (1, 1, 2, NULL, 2, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (2, 2, 1, 13, 13, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (3, 1, 3, 5, 4, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (4, 3, 4, NULL, 5, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (6, 2, 1, 3, 7, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (7, 4, 5, 11, 8, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (8, 5, 4, 12, 9, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (14, 2, 1, 14, 14, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (15, 1, 4, 16, 1370759796466192387, 1, '2021-03-13 16:04:59', NULL, 0);
INSERT INTO `m_user_message` VALUES (16, 1, 4, 16, 1370759796466192388, 1, '2021-03-13 16:05:11', NULL, 0);
INSERT INTO `m_user_message` VALUES (17, 1, 2, 2, 1370759796466192389, 1, '2021-11-08 17:40:18', NULL, 1);
INSERT INTO `m_user_message` VALUES (18, 1, 2, 1, 1370759796466192390, 1, '2021-11-08 17:48:12', NULL, 1);
INSERT INTO `m_user_message` VALUES (19, 1, 2, 2, 1370759796466192391, 1, '2021-11-08 18:58:04', NULL, 1);
INSERT INTO `m_user_message` VALUES (20, 1, 4, 16, 1370759796466192392, 1, '2021-11-09 03:10:45', NULL, 0);
INSERT INTO `m_user_message` VALUES (21, 2, 1, 22, 1370759796466192394, 1, '2021-11-09 03:18:40', NULL, 1);
INSERT INTO `m_user_message` VALUES (22, 2, 1, 23, 1370759796466192395, 1, '2021-11-09 03:18:44', NULL, 1);
INSERT INTO `m_user_message` VALUES (23, 1, 1, 27, 1370759796466192397, 2, '2021-11-09 04:33:53', NULL, 1);
INSERT INTO `m_user_message` VALUES (24, 1, 1, 27, 1370759796466192398, 2, '2021-11-09 04:36:23', NULL, 1);

SET FOREIGN_KEY_CHECKS = 1;
