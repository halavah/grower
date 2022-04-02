/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-8.0.20
 Source Server Type    : MySQL
 Source Server Version : 80020
 Source Host           : localhost:3307
 Source Schema         : forum

 Target Server Type    : MySQL
 Target Server Version : 80020
 File Encoding         : 65001

 Date: 02/04/2022 08:02:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for m_category
-- ----------------------------
DROP TABLE IF EXISTS `m_category`;
CREATE TABLE `m_category`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类的【标题】',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '分类的【内容描述】',
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '分类的【内容摘要】',
  `icon` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类的【图标】',
  `post_count` int(0) UNSIGNED NULL DEFAULT 0 COMMENT '分类的【内容数量】',
  `order_num` int(0) NULL DEFAULT NULL COMMENT '分类的【排序编码】',
  `parent_id` bigint(0) UNSIGNED NULL DEFAULT NULL COMMENT '分类的【父级分类的ID】',
  `meta_keywords` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类的【SEO关键字】',
  `meta_description` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '分类的【SEO描述内容】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '分类的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '分类的【修改日期】',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '分类的【状态】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章分类' ROW_FORMAT = Dynamic;

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
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论的【内容】',
  `parent_id` bigint(0) NULL DEFAULT NULL COMMENT '评论的【回复ID】',
  `post_id` bigint(0) NOT NULL COMMENT '评论的【文章ID】',
  `user_id` bigint(0) NOT NULL COMMENT '评论的【用户ID】',
  `vote_up` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的【“顶”的数量】',
  `vote_down` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的【“踩”的数量】',
  `level` tinyint(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '评论的【置顶等级】',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '评论的【状态】',
  `created` datetime(0) NOT NULL COMMENT '评论的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '评论的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1370759796466192389 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户评论' ROW_FORMAT = Dynamic;

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
INSERT INTO `m_comment` VALUES (18, '评论18评论18评论18评论18评论18', NULL, 2, 1, 20, 22, 0, 1, '2021-02-06 10:57:53', '2021-02-06 10:57:53');
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
INSERT INTO `m_comment` VALUES (1370759796466192389, '获取 SecretId 和 SecretKey', NULL, 1370683409914920963, 1, 0, 0, 0, NULL, '2022-04-01 23:24:03', '2022-04-01 23:24:03');
INSERT INTO `m_comment` VALUES (1370759796466192390, '我们自定义注解的时候，大概最常见的是三种情况。\n1、在某个类的特定方法上加上注解，进行特定拦截；\n2、要对整个类的所有方法进行拦截；\n3、我的类太多了，想在某个父类里加上注解，然后集成该类的子类都能被拦截。', NULL, 1370683409914920999, 1, 0, 0, 0, NULL, '2022-04-01 23:44:27', '2022-04-01 23:44:27');
INSERT INTO `m_comment` VALUES (1370759796466192391, '上文已经提到，AspectJ 实际上是作用于方法的，那如果我要实现对整个类进行拦截怎么玩？其答案在设置 @PonitCut 的声明中。\n\n第 1 种情况，我们声明 @Pointcut 是通过 @annotation 来指定具体的某个注解。这种情况下，注解加在类上是不会生效的。\n如果你要想加在类上生效，那就不能用 annotation 而应该是 within，那么代码正确的写法如下：\n', NULL, 1370683409914920998, 1, 0, 0, 0, NULL, '2022-04-01 23:44:39', '2022-04-01 23:44:39');
INSERT INTO `m_comment` VALUES (1370759796466192392, '@Pointcut 参数详解\nexecution：用于匹配方法执行的连接点；\n\nwithin：用于匹配指定类型内的方法执行；\n\nthis：用于匹配当前 AOP 代理对象类型的执行方法；注意是 AOP 代理对象的类型匹配，这样就可能包括引入接口也类型匹配；\n\ntarget：用于匹配当前目标对象类型的执行方法；注意是目标对象的类型匹配，这样就不包括引入接口也类型匹配；\n', NULL, 1370683409914920998, 1, 0, 0, 0, NULL, '2022-04-01 23:44:55', '2022-04-01 23:44:55');
INSERT INTO `m_comment` VALUES (1370759796466192393, '@admin 最后附上一个完整的切面处理逻辑，分别实现特定方法拦截、类级别拦截和继承拦截。\n\n自定义注解和两种切点声明见上文，处理逻辑如下：', NULL, 1370683409914920998, 1, 0, 0, 0, NULL, '2022-04-01 23:45:02', '2022-04-01 23:45:02');
INSERT INTO `m_comment` VALUES (1370759796466192394, '特定方法拦截', NULL, 1370683409914920964, 4, 0, 0, 0, NULL, '2022-04-01 23:46:28', '2022-04-01 23:46:28');
INSERT INTO `m_comment` VALUES (1370759796466192395, '类级别拦截', NULL, 1370683409914920965, 4, 0, 0, 0, NULL, '2022-04-01 23:46:36', '2022-04-01 23:46:36');
INSERT INTO `m_comment` VALUES (1370759796466192396, '继承类拦截', NULL, 1370683409914920963, 4, 0, 0, 0, NULL, '2022-04-01 23:46:42', '2022-04-01 23:46:42');
INSERT INTO `m_comment` VALUES (1370759796466192397, '当然，如果想要更为直观的体现切面逻辑，可以再增加一个切面处理逻辑：', NULL, 1370683409914920962, 4, 0, 0, 0, NULL, '2022-04-01 23:46:51', '2022-04-01 23:46:51');
INSERT INTO `m_comment` VALUES (1370759796466192398, '本文分享一个方便的周日报模板', NULL, 1370683409914920999, 1, 0, 0, 0, NULL, '2022-04-01 23:48:02', '2022-04-01 23:48:02');
INSERT INTO `m_comment` VALUES (1370759796466192399, '自动生成每周一到周五日期对应的标题（生', NULL, 1370683409914920999, 1, 0, 0, 0, NULL, '2022-04-01 23:48:06', '2022-04-01 23:48:06');
INSERT INTO `m_comment` VALUES (1370759796466192400, '我个人的用法是弄一个文件夹', NULL, 1370683409914920999, 1, 0, 0, 0, NULL, '2022-04-01 23:48:12', '2022-04-01 23:48:12');
INSERT INTO `m_comment` VALUES (1370759796466192401, '项目中，有的路径需要登录', NULL, 1370683409914920964, 4, 0, 0, 0, NULL, '2022-04-01 23:49:04', '2022-04-01 23:49:04');
INSERT INTO `m_comment` VALUES (1370759796466192402, '有的不需要登录，需要登', NULL, 1370683409914920964, 4, 0, 0, 0, NULL, '2022-04-01 23:49:08', '2022-04-01 23:49:08');
INSERT INTO `m_comment` VALUES (1370759796466192403, '这里是使用路径进行是否需要登', NULL, 1370683409914920965, 4, 0, 0, 0, NULL, '2022-04-01 23:49:13', '2022-04-01 23:49:13');
INSERT INTO `m_comment` VALUES (1370759796466192404, '登录访问：SecurityBasicAuthFilter、', NULL, 1370683409914920963, 4, 0, 0, 0, NULL, '2022-04-01 23:49:21', '2022-04-01 23:49:21');
INSERT INTO `m_comment` VALUES (1370759796466192405, '在开发的时候，会遇到这样一个情况：', NULL, 1370683409914920962, 4, 0, 0, 0, NULL, '2022-04-01 23:49:27', '2022-04-01 23:49:27');
INSERT INTO `m_comment` VALUES (1370759796466192406, 'd 不是必填，编辑时是必须的，其他的字段', NULL, 1370683409914920996, 4, 0, 0, 0, NULL, '2022-04-01 23:49:34', '2022-04-01 23:49:34');
INSERT INTO `m_comment` VALUES (1370759796466192407, '而在 swagger 中，不属于新增接口的 id 字段，', NULL, 1370683409914920995, 4, 0, 0, 0, NULL, '2022-04-01 23:49:39', '2022-04-01 23:49:39');
INSERT INTO `m_comment` VALUES (1370759796466192408, '以前是新增、编辑使用不同的实体，或者编辑继承新增实体，再加上 id 字段，但是这样会造成项目中有很多的实体，类臃肿', NULL, 1370683409914920992, 4, 0, 0, 0, NULL, '2022-04-01 23:49:58', '2022-04-01 23:49:58');

-- ----------------------------
-- Table structure for m_post
-- ----------------------------
DROP TABLE IF EXISTS `m_post`;
CREATE TABLE `m_post`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【标题】',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【内容】',
  `edit_mode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '文章的【编辑模式】：html可视化，markdown文档',
  `category_id` bigint(0) NULL DEFAULT NULL COMMENT '文章的【分类ID】',
  `user_id` bigint(0) NULL DEFAULT NULL COMMENT '文章的【用户ID】',
  `vote_up` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的【支持人数】',
  `vote_down` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的【反对人数】',
  `view_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文章的【访问量】',
  `comment_count` int(0) NOT NULL DEFAULT 0 COMMENT '文章的【评论数量】',
  `recommend` tinyint(1) NULL DEFAULT NULL COMMENT '文章的【精华】：0代表取消加精、1代表加精',
  `level` tinyint(0) NOT NULL DEFAULT 0 COMMENT '文章的【置顶等级】：0代表取消置顶、1代表置顶',
  `status` tinyint(0) NULL DEFAULT NULL COMMENT '文章的【状态】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '文章的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '文章的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1370683409914920962 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_post
-- ----------------------------
INSERT INTO `m_post` VALUES (1, '文章1', '文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1', '1', 1, 2, 10, 1, 13, 2, 0, 1, 1, '2021-02-01 11:05:46', '2021-02-01 11:05:46');
INSERT INTO `m_post` VALUES (2, '文章2', '文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2', '1', 1, 2, 20, 2, 24, 2, 1, 0, 1, '2021-02-02 11:05:46', '2021-02-02 11:05:46');
INSERT INTO `m_post` VALUES (3, '文章3', '文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3\n                    ', '1', 2, 1, 30, 3, 36, 2, 0, 1, 1, '2021-02-03 11:05:46', '2021-02-03 11:05:46');
INSERT INTO `m_post` VALUES (5, '文章5', '文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5', '1', 3, 4, 50, 5, 58, 2, 1, 1, 1, '2021-02-05 11:05:46', '2021-02-05 11:05:46');
INSERT INTO `m_post` VALUES (6, '文章6', '文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6', '1', 3, 4, 60, 6, 77, 2, 1, 0, 1, '2021-02-06 11:05:46', '2021-02-06 11:05:46');
INSERT INTO `m_post` VALUES (7, '文章7', '文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7', '1', 4, 1, 70, 7, 117, 2, 1, 1, 1, '2021-02-07 11:05:46', '2021-02-07 11:05:46');
INSERT INTO `m_post` VALUES (9, '文章9', '文章9文章9文章9文章9文章9文章9文章9文章9文章9', '1', 4, 1, 10, 1, 12, 1, 0, 1, 1, '2021-02-01 11:05:46', '2021-02-01 11:05:46');
INSERT INTO `m_post` VALUES (10, '文章10', '文章10文章10文章10文章10文章10文章10文章1020220402_071724', '1', 4, 1, 20, 2, 23, 1, 1, 0, 1, '2021-02-02 11:05:46', '2021-02-02 11:05:46');
INSERT INTO `m_post` VALUES (11, '文章11', '文章11文章11文章11文章11文章11文章11文章11', '1', 3, 2, 30, 3, 35, 1, 0, 1, 1, '2021-02-03 11:05:46', '2021-02-03 11:05:46');
INSERT INTO `m_post` VALUES (12, '文章12', '文章12文章12文章12文章12文章12文章12文章12', '1', 3, 2, 40, 4, 46, 1, 1, 0, 1, '2021-02-04 11:05:46', '2021-02-04 11:05:46');
INSERT INTO `m_post` VALUES (13, '文章13', '文章13文章13文章13文章13文章13文章13文章13', '1', 2, 1, 50, 5, 66, 1, 1, 1, 1, '2021-02-05 11:05:46', '2021-02-05 11:05:46');
INSERT INTO `m_post` VALUES (14, '文章14', '文章14文章14文章14文章14文章14文章14文章14', '1', 2, 1, 60, 6, 70, 1, 1, 0, 1, '2021-02-06 11:05:46', '2021-02-06 11:05:46');
INSERT INTO `m_post` VALUES (16, '文章16', '文章16文章16文章16文章16文章16文章16文章16', '1', 1, 4, 80, 8, 119, 3, 1, 0, 1, '2021-02-08 11:05:46', '2021-02-08 11:05:46');
INSERT INTO `m_post` VALUES (1370683409914920962, '测试文章', '测试文章测试文章', '0', 1, 1, 0, 0, 13, 2, 1, 0, NULL, '2022-04-01 23:16:01', '2022-04-01 23:16:01');
INSERT INTO `m_post` VALUES (1370683409914920963, 'Spring Boot 注册登录 demo', '1、前言\n接上文 SpringBoot 整合 Spring Security 实现自定义页面以及验证码登录\n\n环境版本说明\nMongoDB：5.0.6\nSpringBoot：2.5.3\nJDK：1.8\n\n2、腾讯云短信 api\n介绍\n本 demo 使用免费赠送的腾讯云短信\nhttps://curl.qcloud.com/a18eCzrO 短信试用有 100 个\nhttps://console.cloud.tencent.com/smsv2 在这里通过模板还会赠送 100 个\n如果不够可以购买\n\n如果觉得短信验证麻烦可换成邮箱验证码\n\n3、主要代码\n完整代码链接放文末\n', '0', 1, 1, 0, 0, 9, 3, 0, 0, NULL, '2022-04-01 23:23:44', '2022-04-01 23:23:44');
INSERT INTO `m_post` VALUES (1370683409914920964, 'Apache FtpServer 实现文件的上传和下载', '1 搭建 ftp 服务器\n参考 Windows 上搭建 Apache FtpServer，搭建 ftp 服务器\n\n2 主要代码\n在 eclipse 中实现 ftp 的上传和下载功能还是很简单的，在编码过程中遇到的一个 bug 就是对于 ftp 中中文文件的下载不是乱码，就是下载后文件的大小是 0KB。后来发现问题在于 eclipse 的编码，更改为“utf-8”，在上传和下载的时候，设置 ftp 服务端目录的名字，编码为 iso-8859-1 格式。\n', '0', 1, 1, 0, 0, 8, 3, 0, 0, NULL, '2022-04-01 23:24:44', '2022-04-01 23:24:44');
INSERT INTO `m_post` VALUES (1370683409914920965, 'springBoot 配置 filter 的两种方式', '一、使用注解\n1. 假设 Filter 类的路径为 com.sanro.filter\n\n2.自动扫描配置如下\n\n二、手动配置\n1.Filter 类\n2.Filter 配置类', '0', 1, 1, 0, 0, 6, 2, 0, 0, NULL, '2022-04-01 23:25:30', '2022-04-01 23:25:30');
INSERT INTO `m_post` VALUES (1370683409914920966, 'jetcache 再一次踩坑', '先给我吐槽一下，简直就是玩我个 der，不过打铁还得自身硬，自己还是太菜了，玩个毛球哦。\n\n故事\n今天突然发现，哎，服务缓存失效了，具体原因就是因为 redis 数据库设置密码时候设置了个 @ 符号，好家伙，就是因为这个东西，加上 jetcache 采用 lettuce 进行连接，而在 lettuce 连接时采用解析 uri 的形式，但是 uri 解析时候 @ 会当作分割符号进行处理，这样就导致 redis 连接不上，之后看了源码后进行更改，更改后又给我报了一个 redis 不支持集群，哦豁，最后没得办法改用 redis 的 jedis 连接方式，果断放弃了 lettuce，问题得以解决。\n\n问题一： lettuce 解析 uri 中的 @ 分割符\n描述\n在配置 jetcache 文件时候，由于 redis 数据库密码存在 @，由于是线上环境，不能更改，然后 jetcache 采用 lettuce 连接，解析 uri 时出错，导致连接失败，缓存失效。具体配置如下：', '0', 1, 1, 0, 0, 2, 0, 0, 0, NULL, '2022-04-01 23:26:16', '2022-04-01 23:26:16');
INSERT INTO `m_post` VALUES (1370683409914920967, '网状模型数据库和图数据库的区别', '最近学习数据库课程，看到数据库模型的发展历史，从最初的层次模型，到网状模型，之后发展出了关系模型，前两种模型就都被淘汰了，但在关系模型之前，层次模型数据库和网状模型数据库曾经得到非常广泛的应用。\n\n关系模型是用表的形式组织数据。\n\n层次模型是用树的形式组织数据，它需要满足的条件是\n\n有且仅有一个结点没有双亲结点，这个结点称为根结点\n根以外的其他结点有且只有一个双亲结点\n网状模型是用图的形式组织数据，它需要满足的条件是\n\n允许一个以上的结点无双亲\n一个结点可以有多个双亲\n百度百科中有一句对网状模型描述是：网状模型取消了层次模型的不能表示非数状结构的限制，两个或两个以上的结点都可以有多个双亲结点，则此时有向树变成了有向图，该有向图描述了网状模型。这不禁让我想到了现在知识图谱领域用到的重要数据库类型——图数据库。图数据库也是用有向图来描述数据模型，但图数据库是这几年才新发展起来的技术，而网状模型则早已被淘汰，难道说图数据库只是网状模型改了个名字就来标榜自己是新技术？\n', '0', 1, 1, 0, 0, 2, 0, 0, 0, NULL, '2022-04-01 23:26:41', '2022-04-01 23:26:41');
INSERT INTO `m_post` VALUES (1370683409914920968, 'java 基础教程', 'JavaTutorial 内容说明\n该 Java 教程是学习 Java 过程中对 Java 知识点进行梳理。每一个包中的代码都有一个 ReadMe 来说明该包代码的作用以及知识点。 src 包里面是 Java 的源码，test 包里面是针对源码的测试\n\nThreadTutorial 内容说明\n在源码路径下 cn.byhieg.threadtutorial 中放置的是 Java 多线程的代码和测试例子，在每一个章的包下，都有一个 ReadMe 来说明该章的知识点。\n\n在 char01 包里放置 Java 多线程基本知识的代码。内容如下：\n\n如何使用多线程\n如何得到多线程的一些信息\n如何停止线程\n如何暂停线程\n线程的一些其他用法\n在 char02 包里放置了 Java 对变量和对象并发访问的知识的代码。内容如下：\n\n对于方法的同步处理\n对于语句块的同步处理\n对类加锁的同步处理\n保证可见性的关键字——volatile\n在 char03 包里放置了 Java 线程间通信的知识的代码。内容如下：\n\n等待/通知机制\njoin 方法的使用\n', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:27:27', '2022-04-01 23:27:27');
INSERT INTO `m_post` VALUES (1370683409914920969, 'Kafka', '为什么要学习 Kafka？\n系统学习 Kafka 已成为刚需\n\n企业要求掌握 Kafka（核心 API+ 原理）\n工作中要用到 Kafka（倾目实战 + 配置经验）\n面试里要问到 Kafka（底层实现 + 面试点）\nKafka 入门\n介绍并安装 kafka\nkafka 的简单介绍\nA distributed streaming platform\nKafka 是基于 zookeeper 的分布式消息系统\nKafka 具有高吞吐率、高性能、实时及高可靠等特点\n\nkafka 的基本概念\nTopic：一个虚拟的概念，由 1 到多个 Partitions 组成\nPartition：实际消息存储单位\n特征\n每一个分区都是顺序，不可变的队列\n可以持续增加消息\n消息：尾部追加，头部消费\n每一个消息都会配分一个唯一标识，俗称“offset”\n规则\nProducer 的消息会放置在哪一个 Partition 上，根据系统默认规则\nPartition 的数量在运行期间可以增加，但是不能减少\n每一个 Partition 都有一个物理日志文件\n优点：集群情况下，日志可根据 Partition 拆分，避免单个日志文件过大；并行处理单元，提高吞吐量\nSegment：\nProducer：消息生产者\nConsumer：消息消费者', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:27:51', '2022-04-01 23:27:51');
INSERT INTO `m_post` VALUES (1370683409914920970, '【JUC】CAS 底层原理', '比较并交换（compare and set）\nCAS 翻译成中文即：比较并交换，他是一条 CPU 原语操作（保证读写的原子性），底层基于 c/c++ 实现，直接通过指针操作内存实现。通过使用 CAS 原语能够解决并发更新数据的问题，不用额外加锁去保证线程安全。\n\nCAS 的使用\n以下例子，通过 AtomicInteger 类的两个方法阐述 CAS 的使用。\n\ngetAndIncrement()\n有个面试高频考点，i++ 线程安全吗？\n实际上在多线程环境下，基于 JMM 模型，每个线程都有各自的本地内存，线程工作时会从主内存拷贝一份自己需要的数据，在值回写主内存时容易引发线程安全问题。\n\n比如两个线程 t1,t2 同时进行 i++ 操作，\n\nt1 与 t2 同时从主内存拷贝了 i=0 的值到本地内存\nt1 率先完成了两次 ++ 操作，此时主内存值为 2。t2 因故挂起未执行，且 t2 的本地内存值为 0。\nt2 被唤醒，执行 1 次 ++ 操作，回写主内存，将主内存的值覆盖为 1，至此引发线程安全问题。\n有同学可能要讲，加上 volatile 保证可见性，就不会有上述问题了，那我们继续看看：\n首先 i++ 实际上是由四条指令组成的\n\n第一条指令 getfield ：取出 n 这个元素\n第二条指令 iconst_1 ：把常量 1 压入栈\n第三条指令 iadd ：把 n 和常量 1 进行相加\n第四条指令 putfield ：把数据刷回主内存\n\n', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:28:15', '2022-04-01 23:28:15');
INSERT INTO `m_post` VALUES (1370683409914920971, 'JVM 新生代为什么要有两个 survivor(from, to) 区', '先附一段对新生代中复制算法较好的理解：\n\n首先得明白复制算法的思想：\n将原有的内存空间划分成两块，每次只使用其中一块，在垃圾回收的时候，将正在使用的内存中的存活对象复制到另一块内存区域中，然后清除正使用过的内存区域，交换两个区域的角色，完成垃圾回收。\n\n然后为什么要在新生代中使用复制算法：\n因为新生代 gc 比较频繁、对象存活率低，用复制算法在回收时的效率会更高，也不会产生内存碎片。但复制算法的代价就是要将内存折半，为了不浪费过多的内存，就划分了两块相同大小的内存区域 survivor\nfrom 和 survivor to。在每次 gc 后就会把存活对象给复制到另一个 survivor 上，然后清空 Eden 和刚使用过的 survivor。\n\n以上引用自：https://www.zhihu.com/question/44929481/answer/98016105，上述回答解释了：\n\n为什么新生代要在标记清除死亡对象后使用复制算法，而不是标记清除死亡对象后进行压缩整理以消除内存碎片（此处内存碎片是死亡对象之前所占用的空间）。\n新生代使用复制算法存在的缺陷，由于使用了复制算法，每次只能使用 1/2 的空间，可使用的内存空间变成了 1/2。\n由于存在 2. 中描述的缺陷，要想办法优化，让复制算法中可使用内存空间 > 1/2。优化办法是从 eden 区 : survivor 区 = 1 : 1，变为 eden 区 : survivor 区 = 8 : 2，这样可使用内存空间就变成了 8/10。但是这样在下一次 Young GC 后，存活对象移动到 survivor 区，我们的可使用区域只有 2/8，太小了。\n继续优化 3. 中描述的问题，我们把新生代分为 eden 区 : survivor0(from) : survivor1(to) = 8 : 1 : 1，每次新生代对象在 eden 区创建，上一次 GC 存活的对象在 from 区，下次 GC 时要移动的对象是 eden 区和 from 区中存活的对象，移动至 to 区，然后 from 区和 to 区身份交换。这样我们新生代可使用的内存空间就有 9/10(eden + from) 了。\n上述解决方案的演进为 \"JVM 新生代为什么要有两个 survivor(from, to) 区\" 的原因。\n', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:28:55', '2022-04-01 23:28:55');
INSERT INTO `m_post` VALUES (1370683409914920972, 'HV-Com——一个全程使用 Vditor 的评论系统', 'HV-Com——一个全程使用 Vditor 的评论系统\nHV-Com\n🚧 WIP - 功能和结构可能迅速变化，且兼容性不被保证 🚧\n\nGitHub 地址\n\n💡 简介\nHV-Com 是一个使用 TypeScript 编写的评论系统。它使用 Vditor 作为 markdown 编辑器，lute 作为 markdown 引擎。\n\n✨ 特性\nHV-Com 的 HV 有很多个意思：\n\nHeaVy - 这套评论系统的规模不小，对前后端都将有不小的性能开销。gzip 下 React+HV-Com+Vditor+lute=45kB+42kB+110kB+315kB=512kB，其中 Vditor 暂未 minify，体积偏大，将在它最新的 release 中修复。\n以上述缺陷为代价，HV-Com 有如下优势：\n\nHave Vditor - HV-Com 使用 Vditor 作为 markdown 编辑器与渲染器，做到从编辑到查看的全面“所见即所得”。\nHigh Value - HV-Com 拥有不亚于论坛评论区的功能，在这里可以进行高价值的公共讨论。事实上，HV-Com 离论坛只差一个发帖功能。\n它还拥有这些特性：\n\n使用 markdown，拥有从编辑到查看的全过程所见即所得。\n支持 Vditor 可编辑的所有格式，包括：\nLaTeX 公式\nmermaid.js 流程图\nabc.js 乐谱\n代码高亮\n详见 Vditor readme\n可自行部署后端，也可托管。\n支持 PostgreSQL、MySQL、SQLite 三大 SQL 数据库，未来可能支持 OrbitDB，成为去中心化评论系统。\n具备良好的可扩展性：\n全程以 React + TypeScript 编写\n使用 jest 进行自动化测试以保证稳定\n使用 OpenAPI 规范对后端接口进行定义与检查\n支持 JSX 语法，可作为 React 组件引入。\n自由软件。以 AGPLv3 开放所有源代码。', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:29:19', '2022-04-01 23:29:19');
INSERT INTO `m_post` VALUES (1370683409914920973, 'Java 学习之第 2 章 java 编程基础', '2.1 Java 的基本语法\n2.1.1 Java 代码的基本格式\n修饰符 class 类名{\n\n​ 程序代码\n\n}\n\n注意点：\n\nJava 是严格区分大小写的\n每条功能执行语句后都要用分号结束（与 C 语言类似）\nJava 程序中一个连续的字符串不能分开在两行中书写，但可以分开后用 + 连接\npublic class HelloWorld {\n    public static void main(String[] args) {\n        System.out.println(\"HelloWorld!\");\n    }\n}\n2.1.2 Java 中的注释\n单行注释\nint x = 1;         //定义一个整型变量x\n多行注释\n/*  int x = 1;\n    int y = 2; */\n文档注释\n/**\n *  Person实体类\n */\n2.1.3 Java 中的标识符\n可以由字母、数字、美元符号和下划线组成，但不能以数字开头，也不可以使用关键字\n\n命名规范：\n\n类名和接口名首字母一律大写\n包名一律小写\n常量名一律大写\n变量名和方法名第一个单词首字母小写，从第二个开始每个单词首字母大写', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:29:52', '2022-04-01 23:29:52');
INSERT INTO `m_post` VALUES (1370683409914920974, 'MySQL 面试指南', 'MySQL 版本类问题\n你之前工作中使用的是什么版本的 MySQL？为什么选择这个版本？\n知识点\n\nMySQL 常见的发行版：官方社区版、官方企业版、Percona MySQL、MariaDB\n\n各个发行版之间的区别及优缺点\n\n如何决定是否要对 MYSQL 进行升级？如何进行升级？\n在对 MySQL 进行升级前要考虑什么？\n\n升级可以给业务带来的益处\n是否可以解决业务上某一方面的痛点\n是否可以解决运维上某一方面的痛点\n升级可能对业务带来的影响\n对原业务程序的支持是否有影响\n对原业务程序的性能是否有影响\n数据库升级方案的制定\n评估受影响的业务系统\n升级的详细步骤（演练）\n升级后的数据库环境检查\n升级后的业务检查\n升级失败的回滚方案\n升级失败回滚的步骤\n回滚后的数据库环境检查\n回滚后的业务检查\nMYSQL 升级的步骤', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:30:30', '2022-04-01 23:30:30');
INSERT INTO `m_post` VALUES (1370683409914920975, 'Windows 安装 Python', '在 Windows 上安装 Python 和安装普通软件一样简单，下载安装包以后猛击“下一步”即可。\n\nPython 安装包下载地址：https://www.python.org/downloads/\n\n打开链接，可以看到以下截图\n\n建议初学者直接使用最新 Python 3.x。截止到目前（2021-12），Python 的最新版本是 3.10.x，我们就以该版本为例演示 Windows 下的 Python 安装过程。\n\n点击上图中的版本号或者“Download”按钮进入对应版本的下载页面，滚动到最后即可看到各个平台的 Python 安装包。\n', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:31:02', '2022-04-01 23:31:02');
INSERT INTO `m_post` VALUES (1370683409914920976, '思源笔记数据库表与字段', '思源笔记数据库表与字段\n注 1: 本文同步发布至语雀的思源社区文档 思源数据库表与字段 · 语雀, 后续更新也会从语雀发布\n\n注 2: 思源数据库共有如下 7 张表, 不过在编辑区内使用 SQL 语句仅能渲染 blocks 表中的内容(即句首使用 SELECT * FROM blocks ...), 但是可以使用其他表进行辅助查询, 例如通过块引用表 refs 生成一个可视化的反链列表, 详情请参考 [思源笔记使用心得] 分享一个拆书方法及一个对应的用于汇总所有引用当前文章的 SQL 语句 - 链滴', '0', 1, 2, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:31:24', '2022-04-01 23:31:24');
INSERT INTO `m_post` VALUES (1370683409914920977, '大厂是如何考察 HashMap 的', '一、HashMap 的底层数据结构\nHashMap 是我们非常常用的数据结构，由数组和链表组合构成的数据结构。\n在不发生 hash 冲撞的情况下数据结构是数组，一但出现 hash 冲突，则 Entry.next 来实现链表结构\n\n大概如下，数组里面每个地方都存了 Key-Value 这样的实例，在 Java7 叫 Entry 在 Java8 中叫 Node。\n\n二、链表节点是怎么插入的\njava7 头插法，就是说新来的值会取代原有的值，原有的值就顺推到链表中去，就像上面的例子一样，因为写这个代码的作者认为后来的值被查找的可能性更大一点，提升查找的效率。\n但是，在 java8 之后，都是所用尾部插入了。（图画的有点 low，体谅）\n\ntip:为啥尾部插呢？就是因为多线程情况，在扩容的时候容易形成闭环（死循环），最后面我会画图说明这个问题的，大家耐心往下看。毕竟这是本文的重点\n\n三、什么时候扩容\n数组容量是有限的，数据多次插入的，到达一定的数量就会进行扩容，也就是 resize。什么时候 resize 呢？有两个因素：Capacity：HashMap 当前长度。\n\nLoadFactor：负载因子，默认值 0.75f。\n\n怎么理解呢，就比如当前的容量大小为 16，当你存进第 14 个的时候，判断发现需要进行 resize 了，那就进行扩容，但是 HashMap 的扩容也不是简单的扩大点容量这么简单的。\n扩容分两步\n1.创建一个新的 Entry 空数组，长度是原数组的 2 倍。\n2.遍历原 Entry 数组，把所有的 Entry 重新 Hash 到新数组。\n（为什么不直接复制过去呢？是因为 hash 在计算的时候其实涉及了数组长度 ，你扩容长度都改变了，那么就好导致扩容前后计算的 hash 值是不一样的）\n\n四、为什么默认初始化长度为 16\n因为计算位置的时候用到了位运算(位与运算比算数计算的效率高了很多)\nindex 的计算公式：index = HashCode（Key） & （Length- 1）其实这个计算 index 的方法和 hashCode%length 小说是一样的\n例如： hashCode : 2 2%16 index= 2\nhashCode: 2 （0010） & 1111(16-1 的二进制) = 0010（2）\n所以用位与运算效果与取模一样，性能也提高了不少！', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:33:14', '2022-04-01 23:33:14');
INSERT INTO `m_post` VALUES (1370683409914920978, 'Http 协议', '1. Http 协议\n概念\n在 BS 架构中，浏览器通过 Http 协议访问服务器。它是一种应用层协议，运行在 TCP 传输层协议之上。Http 作用是指定数据的传输格式。\n\n默认端口号：80\n\nHttp 协议特点\nHttp 协议组成：由请求和响应组成\n是一种无状态协议，不记录用户访问状态。同一个用户在同一个浏览器上发送多次请求，服务器并不能通过 Http 协议判断是否是同一个用户\n传输效率相对较高\n2. Http 请求\nHttp 请求的组成\n请求行\n请求的方式\nGet\nPost\n请求的地址\n协议和版本\n1.0 版本：每次请求都会关闭 TCP 连接\n1.1 版本：普遍使用版本，一次请求多个 web 资源，不会在每次请求结束关闭 TCP 连接\n', '0', 1, 3, 0, 0, 2, 0, 0, 0, NULL, '2022-04-01 23:33:46', '2022-04-01 23:33:46');
INSERT INTO `m_post` VALUES (1370683409914920979, 'xml 和 xml 解析', 'XML\n1. XML 介绍\neXtensible Markup Language 可扩展标记语言，通常用于各种组件或者框架的配置文件，文件内容由各种标签组成\n\n2. XML 与 HTML 区别\n区别	HTML	XML\n功能	制作网页	用于配置文件\n大小写	不区分大小写	区分大小写\n语法严谨性	不严谨，若一个标签有开始，没有结束，浏览器也能解析	很严谨，标签的开始和结束必须严格配对\n可扩展性	没有可扩展性，所有的标签的功能都已固定	可以扩展，因为所有的标签都是', '0', 1, 3, 0, 0, 2, 0, 0, 0, NULL, '2022-04-01 23:34:04', '2022-04-01 23:34:04');
INSERT INTO `m_post` VALUES (1370683409914920980, '深入浅出索引', '什么是索引？索引又是如何工作的。\n一句话简单来说，索引的出现其实就是为了提高数据查询的效率，就像书的目录一样。一本 500 页的书，如果你想快速找到其中的某一个知识点，在不借助目录的情况下，那我估计你可得找一会儿。同样，对于数据库的表而言，索引其实就是它的“目录”。\n\n索引常见的模型\n索引的出现是为了提高查询效率，但是实现索引的方式却有很多种，可以用于提高读写效率的数据结构很多，介绍三种常见、也比较简单的数据结构，它们分别是哈希表、有序数组和搜索树。\n\n哈希表：\n\n哈希表是一种以键 - 值（key-value）存储数据的结构，我们只要输入待查找的键即 key，就可以找到其对应的值即 Value。哈希的思路很简单，把值放在数组里，用一个哈希函数把 key 换算成一个确定的位置，然后把 value 放在数组的这个位置。\n\n不可避免地，多个 key 值经过哈希函数的换算，会出现同一个值的情况。处理这种情况的一种方法是，拉出一个链表。假设，你现在维护着一个身份证信息和姓名的表，需要根据身份证号查找对应的名字，这时对应的哈希索引的示意图如下所示', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:34:30', '2022-04-01 23:34:30');
INSERT INTO `m_post` VALUES (1370683409914920981, '注解和反射', '1、注解\n1.1、内置注解\n@Override\n子类重写方法\n\n@Deprecated\n标识这个方法或者类已经被废弃或有更好的选择\n\n@SuppressWarnings\n抑制编译器告警\n\n1.2、元注解\n元注解是用来修饰注解的注解\n\n@Target\n指定注释的使用范围\n\n@Retention\n注释的生命周期，有 SOURCE（编译时被抛弃），CLASS（class 文件中存在，但是运行时被抛弃），RUNTIME（运行时依然存在）\n\n@Documented\n标识生成 javadoc 时，该注解修饰的注解也会在 javadock 中显示\n\n@Inherited\n某个类使用了用 @Inherited 注解标识的注解，则他的子类也会继承这个注解\n', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:35:16', '2022-04-01 23:35:16');
INSERT INTO `m_post` VALUES (1370683409914920982, '断言不生效如何开启？', '安卓项目，gradle6.3,AGP3.6.0 代码中的短信默认不生效，怎么才能开启？\n\n例：assert false；\n\n在 debug 下 这段代码按理说应该直接抛出异常，但是实际上还是往下走了。\n\n按照网上的说法是 java 断言默认是不开启的！\n\n网上说在 VM options 中加入-ea 但是好像也没用？是我加错了吗？\n\n那么问题来了 这个要怎么开启？跪求大佬解惑。\n', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:35:40', '2022-04-01 23:35:40');
INSERT INTO `m_post` VALUES (1370683409914920983, 'Java IO 流、属性操作', '根据流向分类：\n\n输入流：把数据从输入设备读取到内存中的流\n输出流：把数据从内存中写出到输出设备的流\n根据操作数据单位不同分类：\n\n字节流：以字节为单位读写数据的流\n字符流：以字符为单位（主要操作文本数据）读写数据的流\n在 Java 中描述的底层父类（JavaIO 流共涉及 40 多个类，都是从如下 4 个底层父类派生的，由这 4 个类派生出来的子类名称都是以其父类作为子类名后缀，4 个底层父类都已实现 AutoCloseable 接口）：\n\n字节流\n字节输入流：InputStream\n字节输出流：OutputStream\n字符流\n字符输入流：Reader\n字符输出流：Writer\n读取流', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:36:29', '2022-04-01 23:36:29');
INSERT INTO `m_post` VALUES (1370683409914920984, 'SpringBoot 全局配置 Jackson 未生效', '问题背景\n由于在项目中有以一些不得已的原因，继承了 org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport 类，导致配置文件中 Jackson 的配置失效，也参考过一些文章，解决办法都是将继承 org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport  类改为实现 org.springframework.web.servlet.config.annotation.WebMvcConfigurer 接口来解决，但是由于一些原因，改为实现接口后原有功能会出现一些问题，所以采用了其他方式实现。\n\nSpringBoot 版本 2.5.1\n\n解决方案\n在继承了 org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport 类的类中重写 configureMessageConverters 方法，此方法是参考 org.springframework.boot.autoconfigure.web.servlet.WebMvcAutoConfiguration.WebMvcAutoConfigurationAdapter#configureMessageConvertersf 方法写的，手动把消息转换的自动配置添加到当前配置中，使 Jackson 的配置生效，代码如下\n', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:36:54', '2022-04-01 23:36:54');
INSERT INTO `m_post` VALUES (1370683409914920985, 'ribbon 的几种负载均衡', '3.1、轮询策略\n轮询策略在 RoundRobinRule 类中实现，它将可用服务存储在一个 List 中，然后定义了一个原子操作类，每次调用就 +1，下次调用就把这个值作为 List 的下标，以此决定要调用哪个服务。\n\n下面是定义，在 RoundRobinRule 构造函数中，会初始化值为 0\n\n3.3、根据响应时间分配权重的策略\n这个策略由 WeightedResponseTimeRule 实现，使用这个策略的话，相应时间越长的服务，越不容易被选中，响应时间越短的被选中的概率越大。\n\nWeightedResponseTimeTule 定义了一个定时任务 30S 执行一次\n', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:37:18', '2022-04-01 23:37:18');
INSERT INTO `m_post` VALUES (1370683409914920986, '监听器 & 过滤器中注入 Bean 的问题', '前言\n  之前提到过在使用 Redis 发布订阅模式解决集群环境下 WebSocket 通讯问题的时候，遇到了在监听器中无法使用 @Autowired 注解注入 bean 的问题，百度查询了一下，有多种解决方案，这里记录一下我使用的方案。\n\n原因分析\n  由于 Spring 启动对 IOC 容器初始化也是监听的 Servlet 的初始化之后才开始初始化，但是 Servlet 的初始化是由 Servlet 容器在启动时初始化的（一般我们使用的较多的就是 Tomcat），然后在初始化完 Servlet 之后在对过滤器&监听器进行初始化。这样就导致一个问题——由于监听器是由 Servlet 容器进行初始化的，他执行在 Spring IOC 容器初始化之前，导致我们自己本身定义的监听器不能被 Spring 初始化到 IOC 容器，就不能使用 Spring 的依赖注入特性了。\n\n解决方案\n  使用 Spring 提供的 ApplicationContext 获取实例，不使用注解注入。ApplicationContext 是 Spring 继 BeanFactory 之外的另一个核心接口或容器，允许容器通过应用程序上下文环境创建、获取、管理 bean。\n', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:37:49', '2022-04-01 23:37:49');
INSERT INTO `m_post` VALUES (1370683409914920987, '使用 jasypt 加密配置', '前言\n  项目的配置文件中数据库密码以及 redis 密码是明文形式，要求改造成密文，网上查了一下，决定使用 jasypt 进行加密改造，记录一下改造过程。\n\n正文\npom 文件中引入 jar 包，附上项目 github 地址 ulisesbocchio/jasypt-spring-boot: Jasypt integration for Spring boot (github.com)，版本可自行更换。\n\n配置文件中添加密钥配置。', '0', 1, 3, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:38:18', '2022-04-01 23:38:18');
INSERT INTO `m_post` VALUES (1370683409914920988, '面试题之数据库篇', '渐进式问题\n有两个表：学生 student（id,name,age,class_id）和班级 class(id,name)。\n\n口述查询语句：查询人数大于 10 的班级，及其人数\nselect class.id, count(*) from class join student on class.id = student.class_id group by class.id having count(*) > 10;\n左连接，右连接和内连接的区别\n连接分为内连接和外连接，外连接又分为左外连接和右外连接。比如表 1 join 表 2，在字段 a 上做关联，如果是左外连接，会把所有表 1 的记录查询出来，对应字段 a 的值，如果在表 2 中没有记录，表 2 相关字段会都是 null；而如果是右外连接，会把表 2 的记录都查询出来，对应字段 a 的值，如果在表 1 中没有记录，表 1 相关字段会都是 null；如果是内连接，会把这类只有一个表里有的记录过滤掉。\n单纯的 join 关键字，是哪种连接方式', '0', 1, 4, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:39:06', '2022-04-01 23:39:06');
INSERT INTO `m_post` VALUES (1370683409914920989, '面试题之 golang 语言篇', 'golang 协程和线程的区别\n线程是操作系统负责调度的，调度时需要切换到内核态；golang 协程也称用户态线程，是由 golang 运行时负责调度的，完全在用户态进行调度。由于没有切换到内核态的开销，golang 协程的调度会比线程调度快很多。\n相比线程，golang 协程占用内存空间很小，再加上调度快，golang 可以轻松地支持数百万的协程并发。\n数组和切片的区别与联系\n数组和固定长度的，在创建时就要指定长度，且后续长度不可变，准确地说，数组的长度也是数组类型的一部分，比如[1]string 和[2]string 是不同的两种类型；而切片长度可变，在不断往切片里添加元素后切片会进行扩容。\n切片可以看做是对数组的一层封装，切片中维护了指向底层数组的指针，以及在底层数组中的开始位置和结束位置，因此，在使用切片时需要注意：修改切片的元素会影响底层数组，尤其在多个切片共用同一个底层数组时，会相互影响。\n需要注意的时，切片永远不会替换底层数组，在调用 append()函数给切片增加元素时，如果需要做扩容，会新创建一个底层数组，同时也会新建一个切片，作为 append()函数的返回值，原来的切片与原来的底层数组的对应关系不会改变。\n简单介绍下 golang 协程调度模型\ngolang 运行时实现的协程调度模型被称为 GMP 模型。G 指 goroutine，即 golang 协程；M 指 mathine，即物理线程；P 指 processor，即调度器，由 golang 运行时实现。\nprocessor 会维护一个待运行的协程队列，并与一个物理线程关联，processor 会从待运行的协程队列里取出一个协程与物理线程进行绑定，开始执行协程代码，当协程遇到阻塞事件时，processor 会把协程与物理线程解绑，并取出下一个协程绑定到物理线程中开始执行，这个切换动作完全是在用户态进行的，并不涉及内核态的上下文切换，因此很快。', '0', 3, 4, 0, 0, 1, 0, 0, 0, NULL, '2022-04-01 23:39:24', '2022-04-01 23:39:24');
INSERT INTO `m_post` VALUES (1370683409914920990, '工厂模式', '抽象工厂模式解决了工厂模式增加产品需要修改工厂代码的问题，其实就是对工厂也进行抽象，得到一个生产工厂的工厂，在具体的工厂中，可以增加产品，每个工厂也是一个产品簇，这样符合开闭原则，功能扩展性强，但是产品簇的扩展比原来难\n\n工厂模式\n工厂模式根据传递的参数来决定生产的产品，增加产品需要改动工厂的的代码，在明确不同条件生产不同实例的情况下可以使用这个模式（一般这个模式可以应付大多数场景了）', '0', 1, 4, 0, 0, 2, 0, 0, 0, NULL, '2022-04-01 23:40:01', '2022-04-01 23:40:01');
INSERT INTO `m_post` VALUES (1370683409914920991, 'SDB ：纯 golang 开发、数据结构丰富、', '为什么需要 SDB？\n试想以下业务场景：\n\n计数服务：对内容的点赞、播放等数据进行统计\n评论服务：发布评论后，查看某个内容的评论列表\n推荐服务：每个用户有一个包含内容和权重的推荐列表\n以上几个业务场景，都可以通过 MySQL + Redis 的方式实现。 这里的问题是：MySQL 更多的是充当持久化的能力，Redis 充当的是在线服务的读写能力。\n\n那么只使用 Redis 行不行？ 答案是否定的，因为 Redis 无法保证数据不丢失。\n\n那有没有一种存储能够支持高级的数据结构，并能够将数据进行持久化的呢？\n\n答案是：非常少的。有些数据库要么是支持的数据结构不够丰富，要么是接入成本太高，要么是不可控。\n\n为了解决上述问题，SDB 产生了。SDB 提供了非常丰富的数据结构和持久化能力。\n', '0', 1, 4, 0, 0, 2, 0, 0, 0, NULL, '2022-04-01 23:40:25', '2022-04-01 23:40:25');
INSERT INTO `m_post` VALUES (1370683409914920992, 'seata+nacos 实现 TCC 模式分布式事务', '、简介\nAT 模式（参考链接 TBD）基于 支持本地 ACID 事务 的 关系型数据库 ：\n\nTCC 模式，不依赖于底层数据资源的事务支持。\n\n2、建立项目\nTCC 模式的 maven 依赖引入，项目配置和 AT 模式相同，可以参考 seata+nacos 实现 AT 模式分布式事务的第 2 节，完成代码到 git 上下载，TCC 模式在 tcc 分支下，脚本在 script 目录下（和 AT 模式的数据库脚本一致，选择一个执行即可）\n\nhttps://gitee.com/WylLoveX/seata.git\n\n3、使用\nTM 端依然使用 @GlobalTransactional 注解标识\n', '0', 2, 4, 0, 0, 7, 1, 1, 1, NULL, '2022-04-01 23:40:54', '2022-04-01 23:40:54');
INSERT INTO `m_post` VALUES (1370683409914920993, '一条更新 SQL 是如何执行的？', '你执行语句前要先连接数据库，这是连接器的工作。\n\n在一个表上有更新的时候，跟这个表有关的查询缓存会失效，所以这条语句就会把表 T 上所有缓存结果都清空。这也就是我们一般不建议使用查询缓存的原因。\n\n接下来，分析器会通过词法和语法解析知道这是一条更新语句。优化器决定要使用 ID 这个索引。然后，执行器负责具体执行，找到这一行，然后更新。\n\n与查询流程不一样的是，更新流程还涉及两个重要的日志模块，它们正是我们今天要讨论的主角：redo log（重做日志）和 binlog（归档日志）。\n\n重要的日志模块：redo log\n例：酒店掌柜有一个粉板，专门用来记录客人的赊账记录。如果赊账的人不多，那么他可以把顾客名和账目写在板上。但如果赊账的人多了，粉板总会有记不下的时候，这个时候掌柜一定还有一个专门记录赊账的账本。\n\n如果有人要赊账或者还账的话，掌柜一般有两种做法：\n\n一种做法是直接把账本翻出来，把这次赊的账加上去或者扣除掉；\n另一种做法是先在粉板上记下这次的账，等打烊以后再把账本翻出来核算。\n在生意红火柜台很忙时，掌柜一定会选择后者，因为前者操作实在是太麻烦了。首先，你得找到这个人的赊账总额那条记录。你想想，密密麻麻几十页，掌柜要找到那个名字，可能还得带上老花镜慢慢找，找到之后再拿出算盘计算，最后再将结果写回到账本上。', '0', 1, 4, 0, 0, 5, 0, 0, 0, NULL, '2022-04-01 23:41:31', '2022-04-01 23:41:31');
INSERT INTO `m_post` VALUES (1370683409914920994, 'SpringShell 中文乱码', '请问大佬们,如何解决 SpringShell 打包后,在 CMD 输出中文乱码的问题. 网上的各种 -Dfile 这些我都试过了,并不起作用.\n\n我用的打包工具是 Gradle\n\n麻了.本来用的 Commons CLI 啥事儿没有. 一转到 SpringShell 各种问题.😂\n', '0', 1, 4, 0, 0, 3, 0, 0, 0, NULL, '2022-04-01 23:41:50', '2022-04-01 23:41:50');
INSERT INTO `m_post` VALUES (1370683409914920995, '为什么要给 MVC 分层架构再加一层 Manager 层？', 'MVC 三层架构\n我们在刚刚成为程序员的时候，就会被前辈们 “教育” 说系统的设计要遵循 MVC（Model-View-Controller）架构。它将整体的系统分成了 Model（模型），View（视图）和 Controller（控制器）三个层次，也就是将用户视图和业务处理隔离开，并且通过控制器连接起来，很好地实现了表现和逻辑的解耦，是一种标准的软件分层架构。\n\nMVC 分层架构是架构上最简单的一种分层方式。为了遵循这种分层架构我们在构建项目时往往会建立这样三个目录：controller、service 和 dao，它们分别对应了表现层、逻辑层还有数据访问层。\n\n每层的作用如下：\n\nController 层：主要是对访问控制进行转发，各类基本参数校验，或者不复用的业务简单处理。\nService 层：主要是处理业务逻辑和事务\nDao 层：负责与底层数据库 MySQL，Oracle 等进行数据交互\n可是随着我们的业务逻辑越来复杂，代码写的越来越多，这种简单的三层架构的问题也越来越明显。', '0', 1, 4, 0, 0, 11, 1, 1, 1, NULL, '2022-04-01 23:42:25', '2022-04-01 23:42:25');
INSERT INTO `m_post` VALUES (1370683409914920996, '集合类源码解析之 ArrayList', '上在一篇中我们已经介绍过了 ArrayList 集合类是 List 接口的实现类，所以它会默认具有 List 接口的相关特性。所以在这里我们就可以说 ArrayList 是一个能够保证元素的插入顺序并且可以保存重复元素的集合类。除了上述的特性外，ArrayList 和其它集合类相比还可以保存 null 元素到集合类中（并不是所有的集合类都支持此功能）。ArrayList 集合类底层是通过动态数组的方式实现的。动态数组的意思是说 ArrayList 的底层数组大小是可以动态改变的。我们知道在 Java 中数组的大小是不可以改变的，也就是说如果数组初始化成功，那么在使用时就一定是这么大的数组了。如果在使用时超过了数组的最大索引时，那么虚拟机就会抛出异常。既然 Java 中数组的大小是不可改变的，那么 ArrayList 底层是怎么实现动态数组功能的呢。\n\n初始化\n其实在 ArrayList 底层数组也是不可以改变的，底层动态数组的实现逻辑是通过重新创建新数组的方式来实现的。也就是说它底层处理的逻辑是当 ArrayList 发现底层数组的大小已经超过了数组默认初始化大小时，就会创建一个新数组，然后把原数组中的数据拷贝到新数组中，然后操作这个新数组使用。如果当发现新创建的数组大小还是不够我们存储时，继续重复上面的逻辑。所以我们在使用 ArrayList 集合类时，是不用考虑底层数组的大小的。下面我们通过 ArrayList 的源码来证明我们刚刚所说的动态数组的实现逻辑。\n', '0', 1, 4, 0, 0, 6, 1, 0, 0, NULL, '2022-04-01 23:42:42', '2022-04-01 23:42:42');
INSERT INTO `m_post` VALUES (1370683409914920997, '(源码)JDK8-JUC-AQS 结合 ReentrantLock ???????', 'AQS 作用\nAQS 能干嘛?加锁会导致阻塞，有阻塞就需要排队，实现排队必然需要有某种形式的队列进行管理。\n\n(AQS 使用一个 volatile 的 int 类型的成员变量来表示同步状态，通知内置的 FIFO 队列来完成资源获取的排队工作，将每条要去抢占资源的线程封装成一个 Node 节点来实现锁的分配，通过 CAS 完成对 state 值的修改)\n\n解释说明:抢到资源的线程直接使用处理业务逻辑，抢不到资源的必然涉及一种排队等候机制。抢占资源失败的线程继续去等待(类似银行业务办理窗口都满了，暂时没有受理窗口的顾客只能去候客区排队等候)，但等候线程仍然保留获取锁的可能且获取锁流程仍在继续(候客区的顾客也在等着叫号，轮到了再去受理窗口办理业务)。\n\n既然说到了排队等候机制，那么就一定会有某种队列形成，这样的队列是什么数据结构呢？\n\n如果共享资源被占用，那么就需要一定的阻塞等待唤醒机制来保证锁分配。这个机制主要用的是 CLH 队列的变体实现的，将暂时获取不到锁的线程加入到队列中，这个队列就是 AQS 的抽象表现。它将请求共享资源的线程封装成队列的节点(Node)，通过 CAS、自旋以及 LockSupport.park()的方式，维护 state 变量的状态，使并发达到同步的控制效果。\n\n----AQS 就是形成这样，唤醒，等待，加锁，释放，超时控制，取消等待的等等一系列操作。\n\n怎样又快又快的实现上述功能呢？\n\nAQS 是用来构建锁或者其他同步器组件的重量级基础框架及整个 JUC 体系的基石，通过内置的 FIFO 队列来完成资源获取线程的排队工作，并通过一个 int 类型变量表示持有锁的状态。', '0', 1, 4, 0, 0, 6, 0, 1, 1, NULL, '2022-04-01 23:43:05', '2022-04-01 23:43:05');
INSERT INTO `m_post` VALUES (1370683409914920998, 'mutex 分析', '在我们写多线程程序时，有些资源需要保证在同一时间内不会被多个线程访问和操作，这时候通常的做法是使用锁，具体的，对资源进行访问与操作的代码片段被称为临界区，通过锁的锁定，使得在同一时刻，只能有一个线程执行临界区的代码，这样保证了临界区代码的互斥性和原子性。\n\n在 C++ 中，为我们提供了互斥锁，用于对临界区的锁定，基本的定义都在头文件中，下面我们来看看 C++ 中如何通过 mutex 实现对临界区的保护。\n\n分类\n头文件中提供了两种类型的同步工具，一种是直接的同步原语，包括：\n\nmutex：独占，非递归的互斥锁\ntimed_mutex: 支持 timeout 的独占非递归的互斥锁\nrecursive_mutex：支持独占，递归的互斥锁\nrecursive_timed_mutex：支持 timeout 的独占递归的互斥锁\n另一类是锁的包装类，包括：\n\nlock_guard：实现严格基于作用域的互斥锁所有权包装器\nunique_lock：实现可移动的互斥锁所有权包装器\nscoped_lock：用于多个互斥锁的免死锁 RAII 封装器\n', '0', 1, 4, 0, 0, 10, 3, 0, 0, NULL, '2022-04-01 23:43:31', '2022-04-01 23:43:31');
INSERT INTO `m_post` VALUES (1370683409914920999, 'SpringBoot 生成接口文档，我用 smart-doc', '之前我在 SpringBoot 老鸟系列中专门花了大量的篇幅详细介绍如何集成 Swagger，以及如何对 Swagger 进行扩展让其支持接口参数分组功能。详情可见：SpringBoot 如何生成接口文档，老鸟们都这么玩的！\n\n可是当我接触到另一个接口文档工具 smart-doc 后，我觉得它比 Swagger 更适合集成在项目中，更适合老鸟们。今天我们就来介绍一下 smart-doc 组件的使用，作为对老鸟系列文章的一个补充。\n\nswagger vs smart-doc\n首先我们先看一下 Swagger 组件目前存在的主要问题：\n\nSwagger 的代码侵入性比较强\n\n这个很容易理解，要让 Swagger 生成接口文档必须要给方法或字段添加对应的注解，是存在代码侵入的。\n\n原生 swagger 不支持接口的参数分组\n\n对于有做参数分组的接口，原生的 Swagger 并未支持，虽然我们通过扩展其组件可以让其支持参数分组，但是毕竟要开发，而且还未支持最新的 Swagger3 版本。\n\n那作为对比，smart-doc 是基于接口源码分析来生成接口文档，完全做到零注解侵入，你只需要按照 java 标准注释的写，smart-doc 就能帮你生成一个简易明了的 markdown 或是一个像 GitBook 样式的静态 html 文档。官方地址：https://gitee.com/smart-doc-team/smart-doc\n\n简单罗列一下 smart-doc 的优点：\n\n零注解、零学习成本、只需要写标准 java 注释即可生成文档。\n基于源代码接口定义自动推导，强大的返回结构推导。\n支持 Spring MVC,Spring Boot,Spring Boot Web Flux(controller 书写方式)。\n支持 Callable,Future,CompletableFuture 等异步接口返回的推导。\n支持 JavaBean 上的 JSR303 参数校验规范，支持参数分组。\n对一些常用字段定义能够生成有效的模拟值。\n', '0', 2, 4, 0, 0, 16, 4, 1, 1, NULL, '2022-04-01 23:43:50', '2022-04-01 23:43:50');
INSERT INTO `m_post` VALUES (1370683409914921000, 'vue 里面路由传参的三种方式', '1、方式一\n\n通过 query 的方式也就是？的方式路径会显示传递的参数\n\n3、方式三\n\n通过：冒号的的形式传递传参\n\n在配置文件里以冒号的形式设置参数。我们在/src/router/index.js 文件里配置路由。', '0', 3, 1, 0, 0, 4, 0, 1, 1, NULL, '2022-04-01 23:59:00', '2022-04-01 23:59:00');
INSERT INTO `m_post` VALUES (1370683409914921001, 'vue 调用视频播放插件（vue-video-player）', 'vue 调用视频播放插件（vue-video-player）\n官方 github: https://github.com/surmon-china/vue-video-player\n安装依赖 npm install vue-video-player -S\n引入配置 二选一\n\n', '0', 3, 1, 0, 0, 3, 0, 1, 1, NULL, '2022-04-01 23:59:24', '2022-04-01 23:59:24');
INSERT INTO `m_post` VALUES (1370683409914921002, 'js 字符串操作函数', '4、获取字符串长度\n获取字符串的长度经常会用到，方法很简单：\n\n5、查询子字符串\n判断字符串内是否包含子串，不少开发者会使用 for 循环来判断，而忘记了 JavaScript 提供子串函数：', '0', 4, 1, 0, 0, 4, 0, 1, 1, NULL, '2022-04-02 00:00:31', '2022-04-02 00:00:31');
INSERT INTO `m_post` VALUES (1370683409914921003, '重绘和重排', '浏览器渲染过程\n\n发生 http 请求，建立 TCP 连接。\n\n处理 HTML 标记，并构造 DOM 树。\n\n在解析 HTML 时，遇到非阻塞资源，如图片资源，会请求这些资源并继续进行解析，css 文件也是一样的，但是遇到了 <script> 标签的话，会阻塞渲染并且停止解析 HTML。\n浏览器构建 DOM 树时，这个过程占用了主线程，当这种情况发生是，预加载扫描器将解析可用的内容并请求高优先级资源，如 CSS、JavaScript 和 Web 字体。有了预加载扫描器，我们就不用等到解析器找到对外部资源的引用再来请求，它将在后台检索资源，以便在 HTML 解析器到达请求的资源时，他们已经在运行或者已经下载完毕了。预加载扫描器减少了阻塞。\n处理 CSS 并构建 CSSOM 树，CSSOM 和 DOM 树是相似的，但是他们是独立的数据结构，浏览器将 CSS 规则转换为可以理解和使用的样式映射。浏览器根据遍历 CSS 的每个规则集，根据 CSS 选择器创建具有父、子和兄弟关系的节点树。\n\n将 CSSOM 和 DOM 树组合成一个 Render 树，计算样式树或渲染树从 DOM 树的根开始构建，遍历每个可见节点。\n\n', '0', 4, 1, 0, 0, 3, 0, 1, 1, NULL, '2022-04-02 00:01:05', '2022-04-02 00:01:05');

-- ----------------------------
-- Table structure for m_user
-- ----------------------------
DROP TABLE IF EXISTS `m_user`;
CREATE TABLE `m_user`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【昵称】',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【密码】',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【邮件】',
  `mobile` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【手机】',
  `point` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的【积分】',
  `sign` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【个性签名】',
  `gender` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【性别】:0代表男，1代表女',
  `wechat` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【微信号】',
  `vip_level` int(0) NULL DEFAULT NULL COMMENT '用户的【VIP等级】',
  `birthday` datetime(0) NULL DEFAULT NULL COMMENT '用户的【生日日期】',
  `comment_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的【评论数量】',
  `post_count` int(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户的【内容数量】',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【头像】',
  `status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '用户的【状态】:0代表登录成功，-1代表登录失败',
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
INSERT INTO `m_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', '11111@qq.com', '13599998888', 100, 'Don\'t let joy take you down !\n                                    \n                                    \n                                    \n                                    \n                                    \n                    \n   ', '0', 'visions', 0, '2020-09-05 04:23:27', 2, 20, '/upload/avatar/avatar_1.jpg', 0, '2022-04-01 23:56:36', '2020-04-28 14:37:24', '2020-12-08 12:25:11');
INSERT INTO `m_user` VALUES (2, 'admin2', 'e10adc3949ba59abbe56e057f20f883e', '22222@qq.com', '13599998888', 200, '勿因喜而轻诺！', '0', 'visions', 1, '2020-12-07 20:23:34', 3, 30, '/res/images/avatar/02_0051.jpg', 0, '2022-04-01 23:22:54', '2020-04-28 14:45:07', '2020-12-08 12:25:12');
INSERT INTO `m_user` VALUES (3, 'admin3', 'e10adc3949ba59abbe56e057f20f883e', '33333@qq.com', '13599998888', 300, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-08 04:23:36', 4, 40, '/res/images/avatar/03_0053.jpg', 1, '2022-04-01 23:32:49', '2020-04-28 14:48:26', '2020-12-08 12:25:13');
INSERT INTO `m_user` VALUES (4, 'admin4', 'e10adc3949ba59abbe56e057f20f883e', '44444@qq.com', '13599998888', 400, '勿因喜而轻诺！', '0', 'visions', 1, '2020-12-07 20:23:37', 5, 50, '/res/images/avatar/04_0054.jpg', 0, '2022-04-01 23:38:43', '2020-04-28 14:48:26', '2020-12-08 12:25:14');
INSERT INTO `m_user` VALUES (5, 'admin5', 'e10adc3949ba59abbe56e057f20f883e', '55555@qq.com', '13599998888', 500, '勿因喜而轻诺！', '1', 'visions', 0, '2020-12-08 12:23:37', 6, 60, '/res/images/avatar/05_0056.jpg', 0, '2020-12-08 12:24:26', '2020-04-28 14:53:49', '2020-12-08 12:25:15');
INSERT INTO `m_user` VALUES (6, 'halavah', 'e10adc3949ba59abbe56e057f20f883e', 'halavah@126.com', NULL, 0, NULL, '0', NULL, 0, NULL, 0, 0, '/res/images/avatar/default.jpg', 0, '2021-03-06 14:00:44', '2021-03-06 14:00:30', NULL);

-- ----------------------------
-- Table structure for m_user_action
-- ----------------------------
DROP TABLE IF EXISTS `m_user_action`;
CREATE TABLE `m_user_action`  (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '主键ID',
  `user_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活跃用户的【用户ID】',
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活跃用户的【动作类型】',
  `point` int(0) NULL DEFAULT NULL COMMENT '活跃用户的【用户得分】',
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
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(0) NOT NULL COMMENT '收藏的贴【当前用户ID】',
  `post_id` bigint(0) NOT NULL COMMENT '收藏的贴【收藏的文章ID】',
  `post_user_id` bigint(0) NOT NULL COMMENT '收藏的贴【收藏的文章-拥有者ID】',
  `created` datetime(0) NOT NULL COMMENT '收藏的贴【创建日期】',
  `modified` datetime(0) NOT NULL COMMENT '收藏的贴【更新日期】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1370686703538274306 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户中心-收藏的贴' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_collection
-- ----------------------------
INSERT INTO `m_user_collection` VALUES (1, 1, 2, 3, '2021-03-08 23:20:46', '2021-03-08 23:20:49');
INSERT INTO `m_user_collection` VALUES (2, 2, 3, 3, '2021-03-08 23:21:11', '2021-03-08 23:21:14');
INSERT INTO `m_user_collection` VALUES (4, 2, 5, 2, '2021-03-08 23:22:01', '2021-03-08 23:22:03');
INSERT INTO `m_user_collection` VALUES (5, 3, 6, 3, '2021-03-08 23:22:21', '2021-03-08 23:22:23');
INSERT INTO `m_user_collection` VALUES (1370178027908034561, 1, 16, 4, '2021-03-12 01:01:13', '2021-03-12 01:01:13');
INSERT INTO `m_user_collection` VALUES (1370686703538274307, 2, 1370683409914920967, 1, '2022-04-01 23:31:57', '2022-04-01 23:31:57');
INSERT INTO `m_user_collection` VALUES (1370686703538274308, 2, 1370683409914920966, 1, '2022-04-01 23:31:58', '2022-04-01 23:31:58');
INSERT INTO `m_user_collection` VALUES (1370686703538274309, 2, 1370683409914920965, 1, '2022-04-01 23:32:00', '2022-04-01 23:32:00');
INSERT INTO `m_user_collection` VALUES (1370686703538274310, 2, 1370683409914920964, 1, '2022-04-01 23:32:01', '2022-04-01 23:32:01');
INSERT INTO `m_user_collection` VALUES (1370686703538274311, 2, 1370683409914920963, 1, '2022-04-01 23:32:02', '2022-04-01 23:32:02');
INSERT INTO `m_user_collection` VALUES (1370686703538274312, 1, 1370683409914920999, 4, '2022-04-01 23:45:37', '2022-04-01 23:45:37');
INSERT INTO `m_user_collection` VALUES (1370686703538274313, 1, 1370683409914920998, 4, '2022-04-01 23:45:38', '2022-04-01 23:45:38');
INSERT INTO `m_user_collection` VALUES (1370686703538274314, 1, 1370683409914920997, 4, '2022-04-01 23:45:39', '2022-04-01 23:45:39');
INSERT INTO `m_user_collection` VALUES (1370686703538274315, 1, 1370683409914920996, 4, '2022-04-01 23:45:40', '2022-04-01 23:45:40');
INSERT INTO `m_user_collection` VALUES (1370686703538274316, 1, 1370683409914920995, 4, '2022-04-01 23:45:40', '2022-04-01 23:45:40');
INSERT INTO `m_user_collection` VALUES (1370686703538274317, 1, 1370683409914920994, 4, '2022-04-01 23:45:41', '2022-04-01 23:45:41');
INSERT INTO `m_user_collection` VALUES (1370686703538274318, 1, 1370683409914920993, 4, '2022-04-01 23:45:42', '2022-04-01 23:45:42');
INSERT INTO `m_user_collection` VALUES (1370686703538274319, 1, 1370683409914920992, 4, '2022-04-01 23:45:42', '2022-04-01 23:45:42');
INSERT INTO `m_user_collection` VALUES (1370686703538274320, 1, 1370683409914920991, 4, '2022-04-01 23:45:43', '2022-04-01 23:45:43');
INSERT INTO `m_user_collection` VALUES (1370686703538274321, 4, 1370683409914920964, 1, '2022-04-01 23:46:26', '2022-04-01 23:46:26');
INSERT INTO `m_user_collection` VALUES (1370686703538274322, 1, 1370683409914921002, 1, '2022-04-02 00:00:41', '2022-04-02 00:00:41');
INSERT INTO `m_user_collection` VALUES (1370686703538274323, 1, 1370683409914921003, 1, '2022-04-02 00:01:09', '2022-04-02 00:01:09');

-- ----------------------------
-- Table structure for m_user_message
-- ----------------------------
DROP TABLE IF EXISTS `m_user_message`;
CREATE TABLE `m_user_message`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `from_user_id` bigint(0) NULL DEFAULT NULL COMMENT '我的消息的【发送消息的用户ID】',
  `to_user_id` bigint(0) NULL DEFAULT NULL COMMENT '我的消息的【接收消息的用户ID】',
  `post_id` bigint(0) NULL DEFAULT NULL COMMENT '我的消息的【关联的文章ID】',
  `comment_id` bigint(0) NULL DEFAULT NULL COMMENT '我的消息的【关联的文章-对应的评论ID】',
  `type` tinyint(0) NULL DEFAULT NULL COMMENT '我的消息的【消息的类型】：0代表系统消息、1代表评论的文章、2代表回复的评论',
  `created` datetime(0) NOT NULL COMMENT '我的消息的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '我的消息的【更新日期】',
  `status` int(0) NULL DEFAULT NULL COMMENT '我的消息的【状态】：0代表未读、1代表已读',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '我的消息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of m_user_message
-- ----------------------------
INSERT INTO `m_user_message` VALUES (1, 1, 2, NULL, 2, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (2, 2, 1, 13, 13, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (3, 1, 3, 5, 4, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (4, 3, 4, NULL, 5, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (6, 2, 1, 3, 7, 2, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (7, 4, 5, 11, 8, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (8, 5, 4, 12, 9, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 0);
INSERT INTO `m_user_message` VALUES (14, 2, 1, 14, 14, 1, '2021-03-09 22:56:48', '2021-03-09 22:56:52', 1);
INSERT INTO `m_user_message` VALUES (15, 1, 4, 16, 1370759796466192387, 1, '2021-03-13 16:04:59', NULL, 0);
INSERT INTO `m_user_message` VALUES (16, 1, 4, 16, 1370759796466192388, 1, '2021-03-13 16:05:11', NULL, 0);
INSERT INTO `m_user_message` VALUES (17, 1, 4, 1370683409914920999, 1370759796466192390, 1, '2022-04-01 23:44:27', NULL, 0);
INSERT INTO `m_user_message` VALUES (18, 1, 4, 1370683409914920998, 1370759796466192391, 1, '2022-04-01 23:44:39', NULL, 0);
INSERT INTO `m_user_message` VALUES (19, 1, 4, 1370683409914920998, 1370759796466192392, 1, '2022-04-01 23:44:55', NULL, 0);
INSERT INTO `m_user_message` VALUES (20, 1, 4, 1370683409914920998, 1370759796466192393, 1, '2022-04-01 23:45:02', NULL, 0);
INSERT INTO `m_user_message` VALUES (21, 1, 4, 1370683409914920998, 1370759796466192393, 2, '2022-04-01 23:45:02', NULL, 0);
INSERT INTO `m_user_message` VALUES (22, 4, 1, 1370683409914920964, 1370759796466192394, 1, '2022-04-01 23:46:28', NULL, 1);
INSERT INTO `m_user_message` VALUES (23, 4, 1, 1370683409914920965, 1370759796466192395, 1, '2022-04-01 23:46:36', NULL, 1);
INSERT INTO `m_user_message` VALUES (24, 4, 1, 1370683409914920963, 1370759796466192396, 1, '2022-04-01 23:46:42', NULL, 1);
INSERT INTO `m_user_message` VALUES (25, 4, 1, 1370683409914920962, 1370759796466192397, 1, '2022-04-01 23:46:51', NULL, 1);
INSERT INTO `m_user_message` VALUES (26, 1, 4, 1370683409914920999, 1370759796466192398, 1, '2022-04-01 23:48:02', NULL, 0);
INSERT INTO `m_user_message` VALUES (27, 1, 4, 1370683409914920999, 1370759796466192399, 1, '2022-04-01 23:48:06', NULL, 0);
INSERT INTO `m_user_message` VALUES (28, 1, 4, 1370683409914920999, 1370759796466192400, 1, '2022-04-01 23:48:12', NULL, 0);
INSERT INTO `m_user_message` VALUES (29, 4, 1, 1370683409914920964, 1370759796466192401, 1, '2022-04-01 23:49:04', NULL, 0);
INSERT INTO `m_user_message` VALUES (30, 4, 1, 1370683409914920964, 1370759796466192402, 1, '2022-04-01 23:49:08', NULL, 0);
INSERT INTO `m_user_message` VALUES (31, 4, 1, 1370683409914920965, 1370759796466192403, 1, '2022-04-01 23:49:13', NULL, 0);
INSERT INTO `m_user_message` VALUES (32, 4, 1, 1370683409914920963, 1370759796466192404, 1, '2022-04-01 23:49:21', NULL, 0);
INSERT INTO `m_user_message` VALUES (33, 4, 1, 1370683409914920962, 1370759796466192405, 1, '2022-04-01 23:49:27', NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
