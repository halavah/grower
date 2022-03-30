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

 Date: 19/11/2021 02:05:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for forum_article_type
-- ----------------------------
DROP TABLE IF EXISTS `forum_article_type`;
CREATE TABLE `forum_article_type`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `audit_state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '审核状态',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `ref_count` bigint(11) NOT NULL DEFAULT 0 COMMENT '引用统计',
  `scope` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '作用域',
  `creator_id` bigint(11) NOT NULL COMMENT '创建人',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_name_state`(`name`, `audit_state`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章类别表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_article_type
-- ----------------------------
INSERT INTO `forum_article_type` VALUES (1, 'PASS', '活动', '官方活动', 2, 'OFFICIAL', 16, 0, '2021-11-10 12:03:01', '2021-11-19 01:23:54');
INSERT INTO `forum_article_type` VALUES (2, 'PASS', '通知', '官方通知', 3, 'OFFICIAL', 16, 0, '2021-11-10 12:03:01', '2021-11-19 01:28:45');
INSERT INTO `forum_article_type` VALUES (3, 'PASS', '前端', '前端', 24, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-19 02:02:59');
INSERT INTO `forum_article_type` VALUES (4, 'PASS', '后端', '后端', 69, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-19 02:01:56');
INSERT INTO `forum_article_type` VALUES (6, 'PASS', '交易', '交易', 0, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-18 23:14:33');
INSERT INTO `forum_article_type` VALUES (7, 'PASS', '区块链', '区块链', 0, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-18 23:14:34');
INSERT INTO `forum_article_type` VALUES (8, 'PASS', '工作', '工作', 0, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-18 23:14:34');
INSERT INTO `forum_article_type` VALUES (9, 'PASS', '技术', '技术', 0, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-18 23:14:35');
INSERT INTO `forum_article_type` VALUES (10, 'PASS', '创意', '创意', 0, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-18 23:14:35');
INSERT INTO `forum_article_type` VALUES (11, 'PASS', '好玩', '好玩', 3, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-19 01:58:03');
INSERT INTO `forum_article_type` VALUES (12, 'PASS', '酷工作', '酷工作', 0, 'USER', 16, 0, '2021-11-10 12:03:01', '2021-11-18 23:14:39');

-- ----------------------------
-- Table structure for forum_cache
-- ----------------------------
DROP TABLE IF EXISTS `forum_cache`;
CREATE TABLE `forum_cache`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '缓存键',
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '缓存值',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '业务类型',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_key`(`key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '缓存表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_cache
-- ----------------------------
INSERT INTO `forum_cache` VALUES (43, 'USER_LOGIN_TOKEN:2', '{\"expire\":1637860085327,\"type\":\"USER_LOGIN_TOKEN\",\"value\":\"0fccb93416f54271a7b4dd7d3ed9af5a\"}', 'USER_LOGIN_TOKEN', 0, '2021-11-18 17:08:10', '2021-11-18 17:08:10');
INSERT INTO `forum_cache` VALUES (44, 'USER_LOGIN_TOKEN:0fccb93416f54271a7b4dd7d3ed9af5a', '{\"expire\":1637860085327,\"type\":\"USER_LOGIN_TOKEN\",\"value\":\"{\\\"avatar\\\":\\\"/avatar/02.jpg\\\",\\\"createAt\\\":1637241784000,\\\"email\\\":\\\"admin@163.com\\\",\\\"id\\\":2,\\\"lastLoginTime\\\":1637255285323,\\\"nickname\\\":\\\"admin\\\",\\\"password\\\":\\\"5243f205b7679b0f71bc4c7ffaa20224\\\",\\\"role\\\":\\\"ADMIN\\\",\\\"sex\\\":\\\"WOMAN\\\",\\\"signature\\\":\\\"管理员\\\",\\\"source\\\":\\\"REGISTER\\\",\\\"state\\\":\\\"ENABLE\\\",\\\"updateAt\\\":1637273495000}\"}', 'USER_LOGIN_TOKEN', 0, '2021-11-18 17:08:10', '2021-11-18 17:08:10');
INSERT INTO `forum_cache` VALUES (45, 'TAG_USED:all_used_tag', '{\"expire\":1637259965916,\"type\":\"TAG_USED\",\"value\":\"[{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" android 标签描述\\\",\\\"groupName\\\":\\\"Android 开发\\\",\\\"id\\\":260,\\\"name\\\":\\\"android\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284421000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" mysql 标签描述\\\",\\\"groupName\\\":\\\"数据库\\\",\\\"id\\\":265,\\\"name\\\":\\\"mysql\\\",\\\"refCount\\\":2,\\\"updateAt\\\":1637284421000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" apache 标签描述\\\",\\\"groupName\\\":\\\"PHP 开发\\\",\\\"id\\\":266,\\\"name\\\":\\\"apache\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284759000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" mvc 标签描述\\\",\\\"groupName\\\":\\\"PHP 开发\\\",\\\"id\\\":268,\\\"name\\\":\\\"mvc\\\",\\\"refCount\\\":2,\\\"updateAt\\\":1637284421000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" symfony 标签描述\\\",\\\"groupName\\\":\\\"PHP 开发\\\",\\\"id\\\":269,\\\"name\\\":\\\"symfony\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284759000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" composer 标签描述\\\",\\\"groupName\\\":\\\"PHP 开发\\\",\\\"id\\\":271,\\\"name\\\":\\\"composer\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284759000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" laravel 标签描述\\\",\\\"groupName\\\":\\\"PHP 开发\\\",\\\"id\\\":272,\\\"name\\\":\\\"laravel\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284759000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" redis 标签描述\\\",\\\"groupName\\\":\\\"数据库\\\",\\\"id\\\":277,\\\"name\\\":\\\"redis\\\",\\\"refCount\\\":2,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" postgresql 标签描述\\\",\\\"groupName\\\":\\\"数据库\\\",\\\"id\\\":280,\\\"name\\\":\\\"postgresql\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284421000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" visual-studio 标签描述\\\",\\\"groupName\\\":\\\".NET 开发\\\",\\\"id\\\":283,\\\"name\\\":\\\"visual-studio\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637284421000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" git 标签描述\\\",\\\"groupName\\\":\\\"开发工具\\\",\\\"id\\\":303,\\\"name\\\":\\\"git\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" docker 标签描述\\\",\\\"groupName\\\":\\\"开发工具\\\",\\\"id\\\":307,\\\"name\\\":\\\"docker\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" java 标签描述\\\",\\\"groupName\\\":\\\"开发语言\\\",\\\"id\\\":188,\\\"name\\\":\\\"java\\\",\\\"refCount\\\":16,\\\"updateAt\\\":1637284043000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" javascript 标签描述\\\",\\\"groupName\\\":\\\"开发语言\\\",\\\"id\\\":194,\\\"name\\\":\\\"javascript\\\",\\\"refCount\\\":18,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" node.js 标签描述\\\",\\\"groupName\\\":\\\"开发语言\\\",\\\"id\\\":199,\\\"name\\\":\\\"node.js\\\",\\\"refCount\\\":5,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" html 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":207,\\\"name\\\":\\\"html\\\",\\\"refCount\\\":4,\\\"updateAt\\\":1637284043000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" html5 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":208,\\\"name\\\":\\\"html5\\\",\\\"refCount\\\":6,\\\"updateAt\\\":1637284043000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" css 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":209,\\\"name\\\":\\\"css\\\",\\\"refCount\\\":2,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" css3 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":210,\\\"name\\\":\\\"css3\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" json 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":212,\\\"name\\\":\\\"json\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" ajax 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":213,\\\"name\\\":\\\"ajax\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" 正则表达式 标签描述\\\",\\\"groupName\\\":\\\"前端开发\\\",\\\"id\\\":214,\\\"name\\\":\\\"正则表达式\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" angular.js 标签描述\\\",\\\"groupName\\\":\\\"JavaScript 开发\\\",\\\"id\\\":219,\\\"name\\\":\\\"angular.js\\\",\\\"refCount\\\":3,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" vue.js 标签描述\\\",\\\"groupName\\\":\\\"JavaScript 开发\\\",\\\"id\\\":221,\\\"name\\\":\\\"vue.js\\\",\\\"refCount\\\":3,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" react.js 标签描述\\\",\\\"groupName\\\":\\\"JavaScript 开发\\\",\\\"id\\\":222,\\\"name\\\":\\\"react.js\\\",\\\"refCount\\\":5,\\\"updateAt\\\":1636545781000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" 人工智能 标签描述\\\",\\\"groupName\\\":\\\"人工智能\\\",\\\"id\\\":241,\\\"name\\\":\\\"人工智能\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637285034000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" 自然语言处理 标签描述\\\",\\\"groupName\\\":\\\"人工智能\\\",\\\"id\\\":242,\\\"name\\\":\\\"自然语言处理\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637285034000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" 自动驾驶 标签描述\\\",\\\"groupName\\\":\\\"人工智能\\\",\\\"id\\\":243,\\\"name\\\":\\\"自动驾驶\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637285034000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" 神经网络 标签描述\\\",\\\"groupName\\\":\\\"人工智能\\\",\\\"id\\\":244,\\\"name\\\":\\\"神经网络\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637285034000},{\\\"auditState\\\":\\\"PASS\\\",\\\"createAt\\\":1636545781000,\\\"creatorId\\\":25,\\\"description\\\":\\\" 数据挖掘 标签描述\\\",\\\"groupName\\\":\\\"人工智能\\\",\\\"id\\\":245,\\\"name\\\":\\\"数据挖掘\\\",\\\"refCount\\\":1,\\\"updateAt\\\":1637285034000}]\"}', 'TAG_USED', 0, '2021-11-18 17:26:10', '2021-11-18 17:26:10');
INSERT INTO `forum_cache` VALUES (46, 'USER_LOGIN_TOKEN:c8b006283e304e528f6874dd2a3ce9a1', '{\"expire\":1637861764359,\"type\":\"USER_LOGIN_TOKEN\",\"value\":\"{\\\"avatar\\\":\\\"/avatar/01.jpg\\\",\\\"createAt\\\":1637241784000,\\\"email\\\":\\\"super@163.com\\\",\\\"id\\\":1,\\\"lastLoginTime\\\":1637256964351,\\\"nickname\\\":\\\"super\\\",\\\"password\\\":\\\"5243f205b7679b0f71bc4c7ffaa20224\\\",\\\"role\\\":\\\"SUPER_ADMIN\\\",\\\"sex\\\":\\\"MAN\\\",\\\"signature\\\":\\\"超级管理员\\\",\\\"source\\\":\\\"REGISTER\\\",\\\"state\\\":\\\"ENABLE\\\",\\\"updateAt\\\":1637283689000}\"}', 'USER_LOGIN_TOKEN', 0, '2021-11-18 17:36:05', '2021-11-18 17:36:05');
INSERT INTO `forum_cache` VALUES (47, 'USER_LOGIN_TOKEN:1', '{\"expire\":1637861764355,\"type\":\"USER_LOGIN_TOKEN\",\"value\":\"c8b006283e304e528f6874dd2a3ce9a1\"}', 'USER_LOGIN_TOKEN', 0, '2021-11-18 17:36:05', '2021-11-18 17:36:05');
INSERT INTO `forum_cache` VALUES (48, 'USER_LOGIN_TOKEN:fccc4a07daa841b89f1a7fcb924a24f7', '{\"expire\":1637861851540,\"type\":\"USER_LOGIN_TOKEN\",\"value\":\"{\\\"avatar\\\":\\\"/avatar/03.jpg\\\",\\\"createAt\\\":1637241784000,\\\"email\\\":\\\"normal03@163.com\\\",\\\"id\\\":3,\\\"lastLoginTime\\\":1637257051535,\\\"nickname\\\":\\\"normal01\\\",\\\"password\\\":\\\"5243f205b7679b0f71bc4c7ffaa20224\\\",\\\"role\\\":\\\"USER\\\",\\\"sex\\\":\\\"WOMAN\\\",\\\"signature\\\":\\\"普通用户\\\",\\\"source\\\":\\\"REGISTER\\\",\\\"state\\\":\\\"ENABLE\\\",\\\"updateAt\\\":1637274316000}\"}', 'USER_LOGIN_TOKEN', 0, '2021-11-18 17:37:35', '2021-11-18 17:37:35');
INSERT INTO `forum_cache` VALUES (49, 'USER_LOGIN_TOKEN:3', '{\"expire\":1637861851540,\"type\":\"USER_LOGIN_TOKEN\",\"value\":\"fccc4a07daa841b89f1a7fcb924a24f7\"}', 'USER_LOGIN_TOKEN', 0, '2021-11-18 17:37:35', '2021-11-18 17:37:35');

-- ----------------------------
-- Table structure for forum_comment
-- ----------------------------
DROP TABLE IF EXISTS `forum_comment`;
CREATE TABLE `forum_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(11) NOT NULL COMMENT '评论人ID',
  `reply_id` bigint(11) NULL DEFAULT NULL COMMENT '被评论ID',
  `reply_reply_id` bigint(11) NULL DEFAULT NULL COMMENT '二次被评论ID',
  `posts_id` bigint(11) NOT NULL COMMENT '帖子ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `is_delete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_uid_pid`(`user_id`, `posts_id`) USING BTREE,
  INDEX `idx_postsid`(`posts_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_comment
-- ----------------------------
INSERT INTO `forum_comment` VALUES (1, 1, NULL, NULL, 1, '你这三脚架拍的针不戳trollface', 0, '2021-11-18 14:40:18', '2021-11-18 22:40:18');
INSERT INTO `forum_comment` VALUES (2, 1, NULL, NULL, 2, '你好', 0, '2021-11-18 15:06:46', '2021-11-18 23:06:45');
INSERT INTO `forum_comment` VALUES (3, 2, NULL, NULL, 3, '结束后发现的缺陷：\n1、没有对 MQ、或者 socket 进行模拟实现\n2、模拟缓存、没设置失效时间\n3、没有定时任务实时刷新缓存\n4、采用原生 java 写，没用 maven 进行管理，有些地方有很大优化\n5、由于没有对 mq 进行模拟实现，如果数据变化后，就会造成 fegin 与 cache 数据不一致情况\n6、因为说的是远程调用，没有考虑熔断降级的情况\n', 0, '2021-11-18 17:09:09', '2021-11-19 01:09:09');
INSERT INTO `forum_comment` VALUES (4, 1, 3, NULL, 3, '非常棒！！！', 0, '2021-11-18 17:09:44', '2021-11-19 01:09:44');
INSERT INTO `forum_comment` VALUES (5, 1, NULL, NULL, 4, '能不能把索引的两个字段换顺序？为什么？', 0, '2021-11-18 17:14:25', '2021-11-19 01:14:24');
INSERT INTO `forum_comment` VALUES (6, 2, 5, NULL, 4, '可以', 0, '2021-11-18 17:14:38', '2021-11-19 01:14:38');
INSERT INTO `forum_comment` VALUES (7, 2, NULL, NULL, 5, '能不能把索引的两个字段换顺序？为什么？', 0, '2021-11-18 17:20:00', '2021-11-19 01:20:00');
INSERT INTO `forum_comment` VALUES (8, 1, 7, NULL, 5, '不能', 0, '2021-11-18 17:20:10', '2021-11-19 01:20:09');
INSERT INTO `forum_comment` VALUES (9, 2, NULL, NULL, 6, '赞一个！！！', 0, '2021-11-18 17:25:17', '2021-11-19 01:25:16');
INSERT INTO `forum_comment` VALUES (10, 1, NULL, NULL, 8, '在线问答论坛', 0, '2021-11-18 17:36:47', '2021-11-19 01:36:47');
INSERT INTO `forum_comment` VALUES (11, 3, 10, NULL, 8, '支持', 0, '2021-11-18 17:37:46', '2021-11-19 01:37:45');

-- ----------------------------
-- Table structure for forum_config
-- ----------------------------
DROP TABLE IF EXISTS `forum_config`;
CREATE TABLE `forum_config`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类型',
  `name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `start_at` datetime(0) NOT NULL COMMENT '开始时间',
  `end_at` datetime(0) NOT NULL COMMENT '结束时间',
  `creator` bigint(11) NOT NULL COMMENT '创建人ID',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_config
-- ----------------------------
INSERT INTO `forum_config` VALUES (7, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/08.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/08.jpg\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (8, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/18.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/18.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (9, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/11.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/11.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (10, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/05.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/05.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (11, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/16.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/16.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (12, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/23.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/23.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (13, 'PASS', 'HOME_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/09.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/09.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2023-01-25 16:00:00', 1, 0, '2021-11-18 16:11:39', '2021-11-19 00:20:32');
INSERT INTO `forum_config` VALUES (14, 'PASS', 'SIDEBAR_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/09.jpg?t=1637251831756\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/09.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2025-11-13 16:00:00', 1, 0, '2021-11-18 16:16:45', '2021-11-19 00:19:44');
INSERT INTO `forum_config` VALUES (15, 'PASS', 'SIDEBAR_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/18.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/18.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2025-11-13 16:00:00', 1, 0, '2021-11-18 16:16:45', '2021-11-19 00:19:44');
INSERT INTO `forum_config` VALUES (16, 'PASS', 'SIDEBAR_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/11.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/11.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2025-11-13 16:00:00', 1, 0, '2021-11-18 16:16:45', '2021-11-19 00:19:44');
INSERT INTO `forum_config` VALUES (17, 'PASS', 'SIDEBAR_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/16.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/16.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2025-11-13 16:00:00', 1, 0, '2021-11-18 16:16:45', '2021-11-19 00:19:44');
INSERT INTO `forum_config` VALUES (18, 'PASS', 'SIDEBAR_CAROUSEL', '', '{\"imgUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/09.jpg?t=1637251831780\",\"actionUrl\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/background/09.jpg?t=1637251831780\"}', '2021-10-31 16:00:00', '2025-11-13 16:00:00', 1, 0, '2021-11-18 16:16:45', '2021-11-19 00:19:44');

-- ----------------------------
-- Table structure for forum_message
-- ----------------------------
DROP TABLE IF EXISTS `forum_message`;
CREATE TABLE `forum_message`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `channel` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送渠道',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '消息类型',
  `read` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '是否已读',
  `sender_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人类型',
  `sender` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送人',
  `receiver_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接收人类型',
  `receiver` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '接收人',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送内容类型',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '发送内容',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_sender`(`sender`) USING BTREE,
  INDEX `idx_receiver_type`(`receiver`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '消息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_message
-- ----------------------------
INSERT INTO `forum_message` VALUES (1, 'STATION_LETTER', 'FOLLOW_USER', 'YES', 'USER_ID', '2', 'USER_ID', '1', '', 'TEXT', '', 0, '2021-11-18 14:24:38', '2021-11-19 00:35:09');
INSERT INTO `forum_message` VALUES (2, 'STATION_LETTER', 'FOLLOW_USER', 'YES', 'USER_ID', '3', 'USER_ID', '1', '', 'TEXT', '', 0, '2021-11-18 14:25:26', '2021-11-19 00:35:07');
INSERT INTO `forum_message` VALUES (3, 'STATION_LETTER', 'FOLLOW_USER', 'NO', 'USER_ID', '3', 'USER_ID', '2', '', 'TEXT', '', 0, '2021-11-18 14:25:28', '2021-11-18 14:25:28');
INSERT INTO `forum_message` VALUES (4, 'STATION_LETTER', 'FOLLOW_USER', 'YES', 'USER_ID', '5', 'USER_ID', '1', '', 'TEXT', '', 0, '2021-11-18 14:25:57', '2021-11-19 00:35:08');
INSERT INTO `forum_message` VALUES (5, 'STATION_LETTER', 'FOLLOW_USER', 'NO', 'USER_ID', '5', 'USER_ID', '2', '', 'TEXT', '', 0, '2021-11-18 14:26:02', '2021-11-18 14:26:02');
INSERT INTO `forum_message` VALUES (6, 'STATION_LETTER', 'FOLLOW_USER', 'NO', 'USER_ID', '5', 'USER_ID', '3', '', 'TEXT', '', 0, '2021-11-18 14:26:07', '2021-11-18 14:26:07');
INSERT INTO `forum_message` VALUES (7, 'STATION_LETTER', 'FOLLOW_USER', 'YES', 'USER_ID', '6', 'USER_ID', '1', '', 'TEXT', '', 0, '2021-11-18 14:27:17', '2021-11-19 00:35:08');
INSERT INTO `forum_message` VALUES (8, 'STATION_LETTER', 'APPROVAL_FAQ', 'NO', 'USER_ID', '2', 'USER_ID', '1', '3', 'TEXT', '', 0, '2021-11-18 17:08:41', '2021-11-18 17:08:41');
INSERT INTO `forum_message` VALUES (9, 'STATION_LETTER', 'COMMENT_FAQ', 'NO', 'USER_ID', '2', 'USER_ID', '1', '3', 'TEXT', '', 0, '2021-11-18 17:09:09', '2021-11-18 17:09:09');
INSERT INTO `forum_message` VALUES (10, 'STATION_LETTER', 'COMMENT_FAQ', 'NO', 'USER_ID', '1', 'USER_ID', '2', '3', 'TEXT', '', 0, '2021-11-18 17:09:44', '2021-11-18 17:09:44');
INSERT INTO `forum_message` VALUES (11, 'STATION_LETTER', 'COMMENT_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '4', 'TEXT', '', 0, '2021-11-18 17:14:38', '2021-11-18 17:14:38');
INSERT INTO `forum_message` VALUES (12, 'STATION_LETTER', 'COMMENT_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '4', 'TEXT', '', 0, '2021-11-18 17:14:38', '2021-11-18 17:14:38');
INSERT INTO `forum_message` VALUES (13, 'STATION_LETTER', 'APPROVAL_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '4', 'TEXT', '', 0, '2021-11-18 17:14:41', '2021-11-18 17:14:41');
INSERT INTO `forum_message` VALUES (14, 'STATION_LETTER', 'COMMENT_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '5', 'TEXT', '', 0, '2021-11-18 17:20:00', '2021-11-18 17:20:00');
INSERT INTO `forum_message` VALUES (15, 'STATION_LETTER', 'COMMENT_ARTICLE', 'NO', 'USER_ID', '1', 'USER_ID', '2', '5', 'TEXT', '', 0, '2021-11-18 17:20:10', '2021-11-18 17:20:10');
INSERT INTO `forum_message` VALUES (16, 'STATION_LETTER', 'APPROVAL_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '5', 'TEXT', '', 0, '2021-11-18 17:20:15', '2021-11-18 17:20:15');
INSERT INTO `forum_message` VALUES (17, 'STATION_LETTER', 'APPROVAL_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '6', 'TEXT', '', 0, '2021-11-18 17:25:11', '2021-11-18 17:25:11');
INSERT INTO `forum_message` VALUES (18, 'STATION_LETTER', 'COMMENT_ARTICLE', 'NO', 'USER_ID', '2', 'USER_ID', '1', '6', 'TEXT', '', 0, '2021-11-18 17:25:17', '2021-11-18 17:25:17');
INSERT INTO `forum_message` VALUES (19, 'STATION_LETTER', 'COMMENT_FAQ', 'NO', 'USER_ID', '3', 'USER_ID', '1', '8', 'TEXT', '', 0, '2021-11-18 17:37:46', '2021-11-18 17:37:46');
INSERT INTO `forum_message` VALUES (20, 'STATION_LETTER', 'COMMENT_FAQ', 'NO', 'USER_ID', '3', 'USER_ID', '1', '8', 'TEXT', '', 0, '2021-11-18 17:37:46', '2021-11-18 17:37:46');
INSERT INTO `forum_message` VALUES (21, 'STATION_LETTER', 'APPROVAL_FAQ', 'NO', 'USER_ID', '3', 'USER_ID', '1', '8', 'TEXT', '', 0, '2021-11-18 17:37:47', '2021-11-18 17:37:47');
INSERT INTO `forum_message` VALUES (22, 'STATION_LETTER', 'APPROVAL_FAQ', 'NO', 'USER_ID', '1', 'USER_ID', '3', '9', 'TEXT', '', 0, '2021-11-18 17:40:25', '2021-11-18 17:40:25');

-- ----------------------------
-- Table structure for forum_opt_log
-- ----------------------------
DROP TABLE IF EXISTS `forum_opt_log`;
CREATE TABLE `forum_opt_log`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作类型',
  `operator_id` bigint(11) NOT NULL COMMENT '操作人ID',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '操作内容',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_operator_id`(`operator_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '操作日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_opt_log
-- ----------------------------
INSERT INTO `forum_opt_log` VALUES (1, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"a66abb5684c45962d887564f08346e8d\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 13:22:14', '2021-11-18 13:22:14');
INSERT INTO `forum_opt_log` VALUES (2, 'USER_LOGOUT', 1, '{\"ip\":\"127.0.0.1\",\"token\":\"5a01accc8f744ae798433f2ef87c8e5a\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 13:22:46', '2021-11-18 13:22:46');
INSERT INTO `forum_opt_log` VALUES (3, 'USER_REGISTER', 3, '{\"avatar\":\"https://sdn.geekzu.org/avatar/1e13b550a5aaa957b17ce2831a4ed785?d=retro\",\"email\":\"normal01@163.com\",\"id\":3,\"lastLoginTime\":1637241784446,\"nickname\":\"normal01\",\"password\":\"5243f205b7679b0f71bc4c7ffaa20224\",\"role\":\"USER\",\"sex\":\"UNKNOWN\",\"signature\":\"\",\"source\":\"REGISTER\",\"state\":\"UN_ACTIVATION\"}', 0, '2021-11-18 13:23:04', '2021-11-18 13:23:04');
INSERT INTO `forum_opt_log` VALUES (4, 'USER_LOGIN', 3, '{\"email\":\"normal01@163.com\",\"ip\":\"127.0.0.1\",\"nickname\":\"normal01\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 13:23:04', '2021-11-18 13:23:04');
INSERT INTO `forum_opt_log` VALUES (5, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"a66abb5684c45962d887564f08346e8d\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 13:24:07', '2021-11-18 13:24:07');
INSERT INTO `forum_opt_log` VALUES (6, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 13:28:57', '2021-11-18 13:28:57');
INSERT INTO `forum_opt_log` VALUES (7, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 14:09:35', '2021-11-18 14:09:35');
INSERT INTO `forum_opt_log` VALUES (8, 'USER_LOGIN', 2, '{\"email\":\"admin@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 14:11:35', '2021-11-18 14:11:35');
INSERT INTO `forum_opt_log` VALUES (9, 'USER_LOGIN', 3, '{\"email\":\"normal03@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\"}', 0, '2021-11-18 14:25:17', '2021-11-18 14:25:17');
INSERT INTO `forum_opt_log` VALUES (10, 'USER_LOGOUT', 1, '{\"ip\":\"127.0.0.1\",\"token\":\"2fb16bb5a9c4404cb3bb85759287e011\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 14:25:42', '2021-11-18 14:25:42');
INSERT INTO `forum_opt_log` VALUES (11, 'USER_LOGIN', 5, '{\"email\":\"normal04@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 14:25:52', '2021-11-18 14:25:52');
INSERT INTO `forum_opt_log` VALUES (12, 'USER_LOGIN', 6, '{\"email\":\"normal05@163.com\",\"ip\":\"0:0:0:0:0:0:0:1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\"}', 0, '2021-11-18 14:26:58', '2021-11-18 14:26:58');
INSERT INTO `forum_opt_log` VALUES (13, 'USER_LOGIN', 6, '{\"email\":\"normal05@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\"}', 0, '2021-11-18 14:27:16', '2021-11-18 14:27:16');
INSERT INTO `forum_opt_log` VALUES (14, 'USER_LOGOUT', 6, '{\"ip\":\"127.0.0.1\",\"token\":\"921c3bfbefe0436596287e6c23fa4cc0\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\"}', 0, '2021-11-18 14:29:41', '2021-11-18 14:29:41');
INSERT INTO `forum_opt_log` VALUES (15, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/95.0.4638.69 Safari/537.36\"}', 0, '2021-11-18 14:29:51', '2021-11-18 14:29:51');
INSERT INTO `forum_opt_log` VALUES (16, 'USER_LOGOUT', 5, '{\"ip\":\"127.0.0.1\",\"token\":\"7fd1e0996a2e469e99e35202b1795b0a\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 14:39:04', '2021-11-18 14:39:04');
INSERT INTO `forum_opt_log` VALUES (17, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 14:39:13', '2021-11-18 14:39:13');
INSERT INTO `forum_opt_log` VALUES (18, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 15:35:25', '2021-11-18 15:35:25');
INSERT INTO `forum_opt_log` VALUES (19, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 16:07:08', '2021-11-18 16:07:08');
INSERT INTO `forum_opt_log` VALUES (20, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 16:27:26', '2021-11-18 16:27:26');
INSERT INTO `forum_opt_log` VALUES (21, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 16:34:49', '2021-11-18 16:34:49');
INSERT INTO `forum_opt_log` VALUES (22, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 16:46:23', '2021-11-18 16:46:23');
INSERT INTO `forum_opt_log` VALUES (23, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 16:51:28', '2021-11-18 16:51:28');
INSERT INTO `forum_opt_log` VALUES (24, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 17:01:30', '2021-11-18 17:01:30');
INSERT INTO `forum_opt_log` VALUES (25, 'USER_LOGIN', 2, '{\"email\":\"admin@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 17:08:05', '2021-11-18 17:08:05');
INSERT INTO `forum_opt_log` VALUES (26, 'USER_LOGIN', 1, '{\"email\":\"super@163.com\",\"ip\":\"127.0.0.1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 17:36:04', '2021-11-18 17:36:04');
INSERT INTO `forum_opt_log` VALUES (27, 'USER_LOGIN', 3, '{\"email\":\"normal03@163.com\",\"ip\":\"0:0:0:0:0:0:0:1\",\"password\":\"e10adc3949ba59abbe56e057f20f883e\",\"ua\":\"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/96.0.4664.45 Safari/537.36\"}', 0, '2021-11-18 17:37:32', '2021-11-18 17:37:32');

-- ----------------------------
-- Table structure for forum_posts
-- ----------------------------
DROP TABLE IF EXISTS `forum_posts`;
CREATE TABLE `forum_posts`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `audit_state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '审核状态',
  `category` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类别',
  `author_id` bigint(11) NOT NULL COMMENT '作者ID',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容类型',
  `markdown_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'markdown内容',
  `html_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'html内容',
  `views` bigint(11) NOT NULL DEFAULT 0 COMMENT '浏览量',
  `approvals` bigint(11) NOT NULL DEFAULT 0 COMMENT '点赞量/收藏量',
  `comments` bigint(11) NOT NULL DEFAULT 0 COMMENT '评论量',
  `type_id` bigint(11) NOT NULL DEFAULT 0 COMMENT '文章类型ID',
  `head_img` varchar(8192) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文章头图',
  `official` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '官方',
  `top` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '置顶',
  `sort` int(4) NOT NULL DEFAULT 1000 COMMENT '排序',
  `marrow` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '精华',
  `comment_id` bigint(11) NOT NULL COMMENT '问答最佳答案ID',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_author`(`author_id`) USING BTREE,
  INDEX `idx_category_state_views`(`category`, `audit_state`, `views`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_posts
-- ----------------------------
INSERT INTO `forum_posts` VALUES (3, 'PASS', 'FAQ', 1, '蚂蚁开放性笔试题 -- 最短时间的支付方式组合', 'MARKDOWN', '## 题目\n用户有多种支付方式（余额、红包、优惠券，代金券等），假如每种支付方式通过调用远程服务获取可用性。\n在外部资源环境不变情况下，请设计程序以最短响应时间获得尽可能多的可用支付方式列表。\n\n假定支付方式可用性咨询接口定义：PaymentRemoteSerivce\n接口方法：ConsultResult isEnabled(String paymentType);\n返回结果：\n```\npublic ConsultResult (boolean isEnable,String  errorCode){\n    this.isEnable = isEnable;\n    this.errorCode= errorCode;\n}\n\n/** 咨询结果是否可用*/\nprivate boolean isEnable;\n\n/** 错误码 */\nprivate String errorCode;\n\npublic boolean getIsEnable(){\n    return isEnable;\n}\n\npublic String getErrorCode(){\n    return errorCode;\n}\n}\n```\n## 解题思路\n1、进行远程调用\n2、远程调用后存缓存\n3、发生变化通过 socket 或者 mq 进行通知，刷新缓存\n4、定时刷新缓存、防止某时刻大量请求过来而没得缓存', '<h2><a id=\"_0\"></a>题目</h2>\n<p>用户有多种支付方式（余额、红包、优惠券，代金券等），假如每种支付方式通过调用远程服务获取可用性。<br />\n在外部资源环境不变情况下，请设计程序以最短响应时间获得尽可能多的可用支付方式列表。</p>\n<p>假定支付方式可用性咨询接口定义：PaymentRemoteSerivce<br />\n接口方法：ConsultResult isEnabled(String paymentType);<br />\n返回结果：</p>\n<pre><code class=\"lang-\">public ConsultResult (boolean isEnable,String  errorCode){\n    this.isEnable = isEnable;\n    this.errorCode= errorCode;\n}\n\n/** 咨询结果是否可用*/\nprivate boolean isEnable;\n\n/** 错误码 */\nprivate String errorCode;\n\npublic boolean getIsEnable(){\n    return isEnable;\n}\n\npublic String getErrorCode(){\n    return errorCode;\n}\n}\n</code></pre>\n<h2><a id=\"_28\"></a>解题思路</h2>\n<p>1、进行远程调用<br />\n2、远程调用后存缓存<br />\n3、发生变化通过 socket 或者 mq 进行通知，刷新缓存<br />\n4、定时刷新缓存、防止某时刻大量请求过来而没得缓存</p>\n', 6, 1, 2, 0, '', 0, 0, 1000, 0, 3, 0, '2021-11-18 17:07:23', '2021-11-19 01:09:35');
INSERT INTO `forum_posts` VALUES (4, 'PASS', 'ARTICLE', 1, 'Java 监听 Mac 键盘输入实现快捷键功能', 'MARKDOWN', '# 背景需求\n当你想使用 Java 给 Mac 上注册快捷键时，你百度到可以通过 jnativehook 进行实现。然后你发现，下载下来的例子进行运行不了，这篇文章说的就是怎么解决这个问题，以及如果通过这个 jnativehook 实现 Mac 上的系统级快捷键。\n\n## jnativehook\nJNativeHook 为 Java 程序提供全局的键盘和鼠标事件侦听功能。你可以来处理程序外的键盘输入和鼠标动作。当然 JNativeHook 使用了 JNI 技术调用了系统的方法来实现该功能。\n\n## 注册全局快捷键\nok，完成以上内容之后，现在我们该说说代码了。在使用的过程中 jnativehook 似乎没有具体对于快捷键的实现，也就是这一部分需要我们进行完成。\n\n当然在完成上面那个小 demo 之后我猜你也应该猜到怎么做了，既然我们能监听到 mac 的所有输入了，那假如连续输入对应的键然后触发相应的功能就是实现了快捷键的功能。\n\nok，来一个小功能先，就是知道怎么只监听所有的键盘输入\n', '<h1><a id=\"_0\"></a>背景需求</h1>\n<p>当你想使用 Java 给 Mac 上注册快捷键时，你百度到可以通过 jnativehook 进行实现。然后你发现，下载下来的例子进行运行不了，这篇文章说的就是怎么解决这个问题，以及如果通过这个 jnativehook 实现 Mac 上的系统级快捷键。</p>\n<h2><a id=\"jnativehook_3\"></a>jnativehook</h2>\n<p>JNativeHook 为 Java 程序提供全局的键盘和鼠标事件侦听功能。你可以来处理程序外的键盘输入和鼠标动作。当然 JNativeHook 使用了 JNI 技术调用了系统的方法来实现该功能。</p>\n<h2><a id=\"_6\"></a>注册全局快捷键</h2>\n<p>ok，完成以上内容之后，现在我们该说说代码了。在使用的过程中 jnativehook 似乎没有具体对于快捷键的实现，也就是这一部分需要我们进行完成。</p>\n<p>当然在完成上面那个小 demo 之后我猜你也应该猜到怎么做了，既然我们能监听到 mac 的所有输入了，那假如连续输入对应的键然后触发相应的功能就是实现了快捷键的功能。</p>\n<p>ok，来一个小功能先，就是知道怎么只监听所有的键盘输入</p>\n', 5, 2, 2, 4, '', 1, 1, 1, 0, 0, 0, '2021-11-18 17:13:42', '2021-11-19 01:29:16');
INSERT INTO `forum_posts` VALUES (5, 'PASS', 'ARTICLE', 1, '面试题之数据库篇', 'MARKDOWN', '# 渐进式问题\n\n有两个表：学生 student（id,name,age,class_id）和班级 class(id,name)。\n\n## 口述查询语句：查询人数大于 10 的班级，及其人数\n- select class.id, count(*) from class join student on class.id = student.class_id group by class.id having count(*) > 10;\n\n## 左连接，右连接和内连接的区别\n\n连接分为内连接和外连接，外连接又分为左外连接和右外连接。比如表 1 join 表 2，在字段 a 上做关联，如果是左外连接，会把所有表 1 的记录查询出来，对应字段 a 的值，如果在表 2 中没有记录，表 2 相关字段会都是 null；而如果是右外连接，会把表 2 的记录都查询出来，对应字段 a 的值，如果在表 1 中没有记录，表 1 相关字段会都是 null；如果是内连接，会把这类只有一个表里有的记录过滤掉。\n\n## MySQL 数据库，同一条查询语句，第一次执行较慢，第二次很快返回结果，可能的原因是什么？\n\n可能是第二次查询时命中了查询缓存\n如果开启了查询缓存，且在第一次查询后没有对查询相关表做任何修改操作，则第二次查询时会直接返回缓存的第一次查询的结果\n只有在更新不频繁的场景才建议开启查询缓存，因为缓存查询结果会占用一定内存，且有性能损失，如果更新频繁，缓存往往不能命中，则会白白浪费内存和性能', '<h1><a id=\"_0\"></a>渐进式问题</h1>\n<p>有两个表：学生 student（id,name,age,class_id）和班级 class(id,name)。</p>\n<h2><a id=\"_10__4\"></a>口述查询语句：查询人数大于 10 的班级，及其人数</h2>\n<ul>\n<li>select class.id, count(<em>) from class join student on class.id = student.class_id group by class.id having count(</em>) &gt; 10;</li>\n</ul>\n<h2><a id=\"_7\"></a>左连接，右连接和内连接的区别</h2>\n<p>连接分为内连接和外连接，外连接又分为左外连接和右外连接。比如表 1 join 表 2，在字段 a 上做关联，如果是左外连接，会把所有表 1 的记录查询出来，对应字段 a 的值，如果在表 2 中没有记录，表 2 相关字段会都是 null；而如果是右外连接，会把表 2 的记录都查询出来，对应字段 a 的值，如果在表 1 中没有记录，表 1 相关字段会都是 null；如果是内连接，会把这类只有一个表里有的记录过滤掉。</p>\n<h2><a id=\"MySQL__11\"></a>MySQL 数据库，同一条查询语句，第一次执行较慢，第二次很快返回结果，可能的原因是什么？</h2>\n<p>可能是第二次查询时命中了查询缓存<br />\n如果开启了查询缓存，且在第一次查询后没有对查询相关表做任何修改操作，则第二次查询时会直接返回缓存的第一次查询的结果<br />\n只有在更新不频繁的场景才建议开启查询缓存，因为缓存查询结果会占用一定内存，且有性能损失，如果更新频繁，缓存往往不能命中，则会白白浪费内存和性能</p>\n', 7, 2, 2, 3, '', 1, 1, 1, 1, 0, 0, '2021-11-18 17:19:19', '2021-11-19 01:29:15');
INSERT INTO `forum_posts` VALUES (6, 'PASS', 'ARTICLE', 1, '思源笔记限时永久会员', 'MARKDOWN', '\n![思源笔记](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/6.png?t=1637257450583)\n## 订阅推荐码有什么用？\n- 订阅时使用别人的推荐码你可以增加 500 MB 云端空间和 7 天使用时长\n- 别人使用了你的推荐码你自己也可以增加 500 MB 云端空间和 7 天使用时长\n- 💔 使用订阅推荐码后不支持 7 天内无理由退款\n- 👑 限量活动：每推荐 7 人订阅后可获赠终身会员激活码 \n思源笔记推荐订阅送终身会员，512 个名额送完即止\n\n## 订阅后是否支持退款？\n- 💔 使用订阅推荐码后不支持 7 天内无理由退款\n- 订阅 7 天内支持无理由全额退款，7 天后不再支持退款\n- 不支持重复退款，请理性按需购买\n- 退款后云端数据会被立即清空\n- 退款请发邮件至 845765@qq.com\n\n## 中断过订阅之后重新订阅价格怎么算？\n- 续订价格终身按第一次订阅时的价格\n- 如果退款过，则只能按最新价格订阅\n\n## 学生用户订阅有教育优惠吗？\n- 目前已经暂停教育优惠订阅，具体请看 \n- 关于思源笔记暂停教育优惠的公告', '<p><img src=\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/6.png?t=1637257450583\" alt=\"思源笔记\" /></p>\n<h2><a id=\"_2\"></a>订阅推荐码有什么用？</h2>\n<ul>\n<li>订阅时使用别人的推荐码你可以增加 500 MB 云端空间和 7 天使用时长</li>\n<li>别人使用了你的推荐码你自己也可以增加 500 MB 云端空间和 7 天使用时长</li>\n<li>💔 使用订阅推荐码后不支持 7 天内无理由退款</li>\n<li>👑 限量活动：每推荐 7 人订阅后可获赠终身会员激活码<br />\n思源笔记推荐订阅送终身会员，512 个名额送完即止</li>\n</ul>\n<h2><a id=\"_9\"></a>订阅后是否支持退款？</h2>\n<ul>\n<li>💔 使用订阅推荐码后不支持 7 天内无理由退款</li>\n<li>订阅 7 天内支持无理由全额退款，7 天后不再支持退款</li>\n<li>不支持重复退款，请理性按需购买</li>\n<li>退款后云端数据会被立即清空</li>\n<li>退款请发邮件至 845765@qq.com</li>\n</ul>\n<h2><a id=\"_16\"></a>中断过订阅之后重新订阅价格怎么算？</h2>\n<ul>\n<li>续订价格终身按第一次订阅时的价格</li>\n<li>如果退款过，则只能按最新价格订阅</li>\n</ul>\n<h2><a id=\"_20\"></a>学生用户订阅有教育优惠吗？</h2>\n<ul>\n<li>目前已经暂停教育优惠订阅，具体请看</li>\n<li>关于思源笔记暂停教育优惠的公告</li>\n</ul>\n', 14, 1, 1, 1, '[{\"alt\":\"思源笔记\",\"url\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/6.png?t=1637257450583\"}]', 1, 1, 1, 0, 0, 0, '2021-11-18 17:23:54', '2021-11-19 01:45:22');
INSERT INTO `forum_posts` VALUES (7, 'PASS', 'ARTICLE', 1, '【净坛行动】论坛禁止发布任何翻墙软件和违法犯罪程序！！！', 'MARKDOWN', '国家严打网络违法犯罪越来越严格，上次也因为有人在论坛发布一些不和谐的程序导致论坛域名被HOLD，出现几天无法访问的情况，虽然我们曾经发过公告说明。\n\n但依然有同学我行我素，在此特别强调一下，不要在论坛发布任何翻墙软件、国外代理程序、国外节点加速器、VPN代理、HOST翻墙等一些列可以提供访问国外网站的方法和工具，在论坛交流就要遵守论坛规定，如果再出现发布类似程序或者擦边球将直接给予封号处分，也许就因为你的一个帖子可能论坛都不存在了，我们希望论坛可以继续给大家提供一个安全公开的技术交流社区。\n\n不止上述软件，还有各种黑客攻击程序和任何违法犯罪程序都禁止发布，擦边球也不可以有，出现同样做以封号处罚。\n\n我们这次就叫【净坛行动】吧，管理会将之前发布的不合符要求的内容给予删除（如果收到删除消息请周知），为了论坛能活下来，如果大家发现有人发布类似程序，请大家积极举报，为了论坛请大家一定要注意。\n\n2021.11.19\n在线问答论坛系统-管理员发', '<p>国家严打网络违法犯罪越来越严格，上次也因为有人在论坛发布一些不和谐的程序导致论坛域名被HOLD，出现几天无法访问的情况，虽然我们曾经发过公告说明。</p>\n<p>但依然有同学我行我素，在此特别强调一下，不要在论坛发布任何翻墙软件、国外代理程序、国外节点加速器、VPN代理、HOST翻墙等一些列可以提供访问国外网站的方法和工具，在论坛交流就要遵守论坛规定，如果再出现发布类似程序或者擦边球将直接给予封号处分，也许就因为你的一个帖子可能论坛都不存在了，我们希望论坛可以继续给大家提供一个安全公开的技术交流社区。</p>\n<p>不止上述软件，还有各种黑客攻击程序和任何违法犯罪程序都禁止发布，擦边球也不可以有，出现同样做以封号处罚。</p>\n<p>我们这次就叫【净坛行动】吧，管理会将之前发布的不合符要求的内容给予删除（如果收到删除消息请周知），为了论坛能活下来，如果大家发现有人发布类似程序，请大家积极举报，为了论坛请大家一定要注意。</p>\n<p>2021.11.19<br />\n在线问答论坛系统-管理员发</p>\n', 0, 0, 0, 2, '', 1, 1, 1, 1, 0, 0, '2021-11-18 17:28:46', '2021-11-19 01:29:13');
INSERT INTO `forum_posts` VALUES (8, 'PASS', 'FAQ', 1, '有哪些值得学习的国内 c++ 开源项目？', 'MARKDOWN', '# 一、基础\n## 1.1 一个项目入门 C++ 足以：CPlusPlusThings\nCPlusPlusThings 是国人开源一个 C++ 学习项目。它系统地将 C++ 学习分为了【基础进阶】、【实战系列】、【C++2.0 新特性】、【设计模式】和【STL 源码剖析】、【并发编程】、【C++ 惯用法】、【学习课程】、【工具】、【拓展】。\n\n作为一个全面系统的 C++ 学习项目，CPlusPlusThings 是优秀的，它合理地安排了 10 Days 的实战部分，在实战中了解语法和函数用法，唯一不足的是，在注释部分有些不尽人意，对部分新手程序员并不是很友好。【基础进阶】部分内容：\n\n## 1.2 基础部分之算法：C-Plus-Plus\nC-Plus-Plus 是收录用 C++ 实现的各种算法的集合，并按照 MIT 许可协议进行授权。这些算法涵盖了计算机科学、数学和统计学、数据科学、机器学习、工程等各种主题。除外，你可能会发现针对同一目标的多个实现使用不同的算法策略和优化。\n\n## 1.3 现代 C++：modern-cpp-tutorial\n[知乎](https://pic1.zhimg.com/50/v2-ae692cc65059a7e1d469fbdc67b97570_720w.jpg?source=1940ef5c)\n\n适合熟悉 C++ 的基本语法、使用过 STL、熟悉一些常用的算法，以及递归等程序设计方法的 C++ 学习者阅读。虽然项目章节文章写的深入浅出，不过唯一的遗憾是尚未完成所有章节内容。进度如下：\n\n- 0.前言\n- 1.Template 的基本语法\n- 2.模板元编程基础\n- 3.深入理解特化与偏特化\n- 4.元编程下的数据结构与算法 （尚未开始）\n- 5.模板的进阶技巧（尚未开始）\n- 6.模板的威力：从 foreach, transform 到 Linq（尚未开始）\n- 7.结语：讨论有益，争端无用（尚未开始）', '<h1><a id=\"_0\"></a>一、基础</h1>\n<h2><a id=\"11__C_CPlusPlusThings_1\"></a>1.1 一个项目入门 C++ 足以：CPlusPlusThings</h2>\n<p>CPlusPlusThings 是国人开源一个 C++ 学习项目。它系统地将 C++ 学习分为了【基础进阶】、【实战系列】、【C<ins>2.0 新特性】、【设计模式】和【STL 源码剖析】、【并发编程】、【C</ins> 惯用法】、【学习课程】、【工具】、【拓展】。</p>\n<p>作为一个全面系统的 C++ 学习项目，CPlusPlusThings 是优秀的，它合理地安排了 10 Days 的实战部分，在实战中了解语法和函数用法，唯一不足的是，在注释部分有些不尽人意，对部分新手程序员并不是很友好。【基础进阶】部分内容：</p>\n<h2><a id=\"12_CPlusPlus_6\"></a>1.2 基础部分之算法：C-Plus-Plus</h2>\n<p>C-Plus-Plus 是收录用 C++ 实现的各种算法的集合，并按照 MIT 许可协议进行授权。这些算法涵盖了计算机科学、数学和统计学、数据科学、机器学习、工程等各种主题。除外，你可能会发现针对同一目标的多个实现使用不同的算法策略和优化。</p>\n<h2><a id=\"13__Cmoderncpptutorial_9\"></a>1.3 现代 C++：modern-cpp-tutorial</h2>\n<p><a href=\"https://pic1.zhimg.com/50/v2-ae692cc65059a7e1d469fbdc67b97570_720w.jpg?source=1940ef5c\" target=\"_blank\">知乎</a></p>\n<p>适合熟悉 C++ 的基本语法、使用过 STL、熟悉一些常用的算法，以及递归等程序设计方法的 C++ 学习者阅读。虽然项目章节文章写的深入浅出，不过唯一的遗憾是尚未完成所有章节内容。进度如下：</p>\n<ul>\n<li>0.前言</li>\n<li>1.Template 的基本语法</li>\n<li>2.模板元编程基础</li>\n<li>3.深入理解特化与偏特化</li>\n<li>4.元编程下的数据结构与算法 （尚未开始）</li>\n<li>5.模板的进阶技巧（尚未开始）</li>\n<li>6.模板的威力：从 foreach, transform 到 Linq（尚未开始）</li>\n<li>7.结语：讨论有益，争端无用（尚未开始）</li>\n</ul>\n', 4, 2, 2, 0, '', 0, 0, 1000, 0, 10, 0, '2021-11-18 17:33:34', '2021-11-19 01:36:48');
INSERT INTO `forum_posts` VALUES (9, 'PASS', 'FAQ', 3, '一条更新 SQL 是如何执行的？', 'MARKDOWN', '# 前言\n\n比如说这个表有一个主键 ID 和一个整型字段 c：\n```\nmysql> create table T(ID int primary key, c int);\n```\n如果要将 ID=2 这一行的值加 1，SQL 语句就会这么写：\n```\nmysql> update T set c=c+1 where ID=2;\n```\n\n', '<h1><a id=\"_0\"></a>前言</h1>\n<p>比如说这个表有一个主键 ID 和一个整型字段 c：</p>\n<pre><code class=\"lang-\">mysql&gt; create table T(ID int primary key, c int);\n</code></pre>\n<p>如果要将 ID=2 这一行的值加 1，SQL 语句就会这么写：</p>\n<pre><code class=\"lang-\">mysql&gt; update T set c=c+1 where ID=2;\n</code></pre>\n', 2, 1, 0, 0, '', 0, 0, 1000, 0, 0, 0, '2021-11-18 17:39:23', '2021-11-19 01:39:30');
INSERT INTO `forum_posts` VALUES (10, 'PASS', 'ARTICLE', 1, 'iTab 新标签页，自定义你的热爱', 'MARKDOWN', '# iTab 新标签页，自定义你的热爱\n\nHi, 你好！初来乍到，自我介绍一下。\n\n我是一名前端工程师，因为用了很多浏览器默认起始页，要么广告太多，要么呆板无趣，都满足不了我对美观和实用兼顾的需求，所以就纯粹凭着一股热情动手做了一个。前前后后我一个人从设计产品到前后端开发连着熬夜肝了一个多月上架了这个 iTab 新标签页，没想到意外收获了非常多用户喜欢，稳定版上线 10 天下载就超四千。说实话，我完全没想到会有这么多人跟我一样，苦浏览器起始页不好用久矣。\n\n## iTab 新标签页是什么？\n\niTab 标签页是一款美化和管理浏览器主页的插件。支持 Chrome，Edge，Bing，Firefox 和 360 浏览器直接安装（其他浏览器可以安装离线包）。这个标签页除了具备基本的搜索，常用网站图标，书签管理等功能外，还内置常用工具，更换壁纸，自定义图标样式，图标分组，多端同步，快速翻译，深色模式等等功能。是一个将美观和实用完美结合的桌面管理工具。\n\n![照片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/7.png?t=1637257736049)\n', '<h1><a id=\"iTab__0\"></a>iTab 新标签页，自定义你的热爱</h1>\n<p>Hi, 你好！初来乍到，自我介绍一下。</p>\n<p>我是一名前端工程师，因为用了很多浏览器默认起始页，要么广告太多，要么呆板无趣，都满足不了我对美观和实用兼顾的需求，所以就纯粹凭着一股热情动手做了一个。前前后后我一个人从设计产品到前后端开发连着熬夜肝了一个多月上架了这个 iTab 新标签页，没想到意外收获了非常多用户喜欢，稳定版上线 10 天下载就超四千。说实话，我完全没想到会有这么多人跟我一样，苦浏览器起始页不好用久矣。</p>\n<h2><a id=\"iTab__6\"></a>iTab 新标签页是什么？</h2>\n<p>iTab 标签页是一款美化和管理浏览器主页的插件。支持 Chrome，Edge，Bing，Firefox 和 360 浏览器直接安装（其他浏览器可以安装离线包）。这个标签页除了具备基本的搜索，常用网站图标，书签管理等功能外，还内置常用工具，更换壁纸，自定义图标样式，图标分组，多端同步，快速翻译，深色模式等等功能。是一个将美观和实用完美结合的桌面管理工具。</p>\n<p><img src=\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/7.png?t=1637257736049\" alt=\"照片\" /></p>\n', 0, 0, 0, 11, '[{\"alt\":\"照片\",\"url\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/7.png?t=1637257736049\"}]', 0, 1, 1, 0, 0, 0, '2021-11-18 17:49:29', '2021-11-19 01:49:41');
INSERT INTO `forum_posts` VALUES (11, 'PASS', 'ARTICLE', 1, '日本 东北 鸣子峡红叶见倾 地狱谷煮温泉蛋 山形総合公园银杏大道', 'MARKDOWN', '这一天我们的出发时间是九点，特别早起到了车站附近的咖啡厅-TsukiCafe 山形駅前吃早餐。\n![图片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/8.jpeg?t=1637257900201)\n\n![图片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/9.jpg?t=1637257905580)\n\n', '<p>这一天我们的出发时间是九点，特别早起到了车站附近的咖啡厅-TsukiCafe 山形駅前吃早餐。<br />\n<img src=\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/8.jpeg?t=1637257900201\" alt=\"图片\" /></p>\n<p><img src=\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/9.jpg?t=1637257905580\" alt=\"图片\" /></p>\n', 0, 0, 0, 4, '[{\"alt\":\"图片\",\"url\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/8.jpeg?t=1637257900201\"},{\"alt\":\"图片\",\"url\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/9.jpg?t=1637257905580\"}]', 0, 0, 1000, 0, 0, 0, '2021-11-18 17:52:47', '2021-11-19 01:53:20');
INSERT INTO `forum_posts` VALUES (12, 'PASS', 'ARTICLE', 1, '和一个小妹妹一起写了一个浏览器插件', 'MARKDOWN', '她刚刚高考完，有一天问我会不会写浏览器插件。我刚好刚写了一个浏览器插件，还没写完，虽然还不是很了解浏览器插件的开发。但是她让我帮帮她，于是我就帮帮她了。最后我们两个人折腾好一会完成了这个插件。\n\n大家如果有用这个功能的，可以参与到开源中，添加你需要的搜索引擎 💖\n\n## 功能\n- 为列表中的网站添加 OpenSearch，来让浏览器将其添加到搜索引擎\n- 搜索引擎添加完成后，在地址栏中输入网站地址，按下 空格键 或 Tab 即可快速搜索\n- 在 Firefox 浏览器中，需要手动点击带有加号的网站图标将其添加至搜索引擎中。\n\n', '<p>她刚刚高考完，有一天问我会不会写浏览器插件。我刚好刚写了一个浏览器插件，还没写完，虽然还不是很了解浏览器插件的开发。但是她让我帮帮她，于是我就帮帮她了。最后我们两个人折腾好一会完成了这个插件。</p>\n<p>大家如果有用这个功能的，可以参与到开源中，添加你需要的搜索引擎 💖</p>\n<h2><a id=\"_4\"></a>功能</h2>\n<ul>\n<li>为列表中的网站添加 OpenSearch，来让浏览器将其添加到搜索引擎</li>\n<li>搜索引擎添加完成后，在地址栏中输入网站地址，按下 空格键 或 Tab 即可快速搜索</li>\n<li>在 Firefox 浏览器中，需要手动点击带有加号的网站图标将其添加至搜索引擎中。</li>\n</ul>\n', 0, 0, 0, 4, '', 0, 0, 1000, 0, 0, 0, '2021-11-18 17:55:16', '2021-11-19 01:55:30');
INSERT INTO `forum_posts` VALUES (13, 'PASS', 'ARTICLE', 1, '在荒野大镖客 2 中看剧院表演，你为 R 星花的每一分钱都物超所值', 'MARKDOWN', '断断续续终于打到游戏的第四章了，第三章末尾范德林德帮派一行八人去救被布雷切斯特家族绑架的约翰儿子杰克的剧情实在是太热血了\n\n![图片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/10.png?t=1637258224322)\n\n', '<p>断断续续终于打到游戏的第四章了，第三章末尾范德林德帮派一行八人去救被布雷切斯特家族绑架的约翰儿子杰克的剧情实在是太热血了</p>\n<p><img src=\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/10.png?t=1637258224322\" alt=\"图片\" /></p>\n', 0, 0, 0, 11, '[{\"alt\":\"图片\",\"url\":\"https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/10.png?t=1637258224322\"}]', 0, 0, 1000, 0, 0, 0, '2021-11-18 17:58:04', '2021-11-19 01:58:30');
INSERT INTO `forum_posts` VALUES (14, 'PASS', 'ARTICLE', 1, 'SDB ：纯 golang 开发、数据结构丰富、持久化的 NoSQL 数据库', 'MARKDOWN', '## 为什么需要 SDB？\n\n试想以下业务场景：\n\n计数服务：对内容的点赞、播放等数据进行统计\n评论服务：发布评论后，查看某个内容的评论列表\n推荐服务：每个用户有一个包含内容和权重的推荐列表\n以上几个业务场景，都可以通过 MySQL + Redis 的方式实现。 这里的问题是：MySQL 更多的是充当持久化的能力，Redis 充当的是在线服务的读写能力。\n\n那么只使用 Redis 行不行？ 答案是否定的，因为 Redis 无法保证数据不丢失。\n\n那有没有一种存储能够支持高级的数据结构，并能够将数据进行持久化的呢？\n\n答案是：非常少的。有些数据库要么是支持的数据结构不够丰富，要么是接入成本太高，要么是不可控。\n\n```\npackage main\n\nimport (\n	\"fmt\"\n	pb \"github.com/yemingfeng/sdb/server/proto\"\n	\"golang.org/x/net/context\"\n	\"google.golang.org/grpc\"\n	\"log\"\n)\n\nfunc main() {\n	conn, err := grpc.Dial(\":9000\", grpc.WithInsecure())\n	if err != nil {\n		fmt.Printf(\"faild to connect: %v\", err)\n	}\n	defer conn.Close()\n\n	// 连接服务器\n	c := pb.NewSDBClient(conn)\n	setResponse, err := c.Set(context.Background(),\n		&pb.SetRequest{Key: \"hello\", Val: \"world\"})\n	log.Printf(\"setResponse: %v, err: %v\", setResponse, err)\n	getResponse, err := c.Get(context.Background(), \n		&pb.GetRequest{Key: \"hello\"})\n	log.Printf(\"getResponse: %v, err: %v\", getResponse, err)\n}\n```', '<h2><a id=\"_SDB_0\"></a>为什么需要 SDB？</h2>\n<p>试想以下业务场景：</p>\n<p>计数服务：对内容的点赞、播放等数据进行统计<br />\n评论服务：发布评论后，查看某个内容的评论列表<br />\n推荐服务：每个用户有一个包含内容和权重的推荐列表<br />\n以上几个业务场景，都可以通过 MySQL + Redis 的方式实现。 这里的问题是：MySQL 更多的是充当持久化的能力，Redis 充当的是在线服务的读写能力。</p>\n<p>那么只使用 Redis 行不行？ 答案是否定的，因为 Redis 无法保证数据不丢失。</p>\n<p>那有没有一种存储能够支持高级的数据结构，并能够将数据进行持久化的呢？</p>\n<p>答案是：非常少的。有些数据库要么是支持的数据结构不够丰富，要么是接入成本太高，要么是不可控。</p>\n<pre><code class=\"lang-\">package main\n\nimport (\n	&quot;fmt&quot;\n	pb &quot;github.com/yemingfeng/sdb/server/proto&quot;\n	&quot;golang.org/x/net/context&quot;\n	&quot;google.golang.org/grpc&quot;\n	&quot;log&quot;\n)\n\nfunc main() {\n	conn, err := grpc.Dial(&quot;:9000&quot;, grpc.WithInsecure())\n	if err != nil {\n		fmt.Printf(&quot;faild to connect: %v&quot;, err)\n	}\n	defer conn.Close()\n\n	// 连接服务器\n	c := pb.NewSDBClient(conn)\n	setResponse, err := c.Set(context.Background(),\n		&amp;pb.SetRequest{Key: &quot;hello&quot;, Val: &quot;world&quot;})\n	log.Printf(&quot;setResponse: %v, err: %v&quot;, setResponse, err)\n	getResponse, err := c.Get(context.Background(), \n		&amp;pb.GetRequest{Key: &quot;hello&quot;})\n	log.Printf(&quot;getResponse: %v, err: %v&quot;, getResponse, err)\n}\n</code></pre>\n', 0, 0, 0, 4, '', 0, 0, 1000, 0, 0, 0, '2021-11-18 17:59:06', '2021-11-19 01:59:30');
INSERT INTO `forum_posts` VALUES (15, 'PASS', 'ARTICLE', 1, 'seata+nacos 实现 TCC 模式分布式事务', 'MARKDOWN', '## 简介\nAT 模式（参考链接 TBD）基于 支持本地 ACID 事务 的 关系型数据库 ：\nTCC 模式，不依赖于底层数据资源的事务支持。\n\n## 建立项目\nTCC 模式的 maven 依赖引入，项目配置和 AT 模式相同，可以参考 seata+nacos 实现 AT 模式分布式事务的第 2 节，完成代码到 git 上下载，TCC 模式在 tcc 分支下，脚本在 script 目录下（和 AT 模式的数据库脚本一致，选择一个执行即可）\n\n```\n/**\n * @author Mr.Wen\n * @version 1.0\n * @date 2021-10-25 14:03\n */\n@LocalTCC\npublic interface BankUserService {\n    @TwoPhaseBusinessAction(name = \"reduceAccount\",commitMethod = \"commitReduceAccount\",rollbackMethod = \"rollbackReduceAccount\")\n    int reduceAccount(\n            @BusinessActionContextParameter(paramName =\"id\") String id,\n            @BusinessActionContextParameter(paramName =\"num\") Integer num);\n    boolean commitReduceAccount(BusinessActionContext context);\n    boolean rollbackReduceAccount(BusinessActionContext context);\n}\n\n\n作者：wenyl\n链接：https://ld246.com/article/1635916035380\n来源：链滴\n协议：CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/\n```', '<h2><a id=\"_0\"></a>简介</h2>\n<p>AT 模式（参考链接 TBD）基于 支持本地 ACID 事务 的 关系型数据库 ：<br />\nTCC 模式，不依赖于底层数据资源的事务支持。</p>\n<h2><a id=\"_4\"></a>建立项目</h2>\n<p>TCC 模式的 maven 依赖引入，项目配置和 AT 模式相同，可以参考 seata+nacos 实现 AT 模式分布式事务的第 2 节，完成代码到 git 上下载，TCC 模式在 tcc 分支下，脚本在 script 目录下（和 AT 模式的数据库脚本一致，选择一个执行即可）</p>\n<pre><code class=\"lang-\">/**\n * @author Mr.Wen\n * @version 1.0\n * @date 2021-10-25 14:03\n */\n@LocalTCC\npublic interface BankUserService {\n    @TwoPhaseBusinessAction(name = &quot;reduceAccount&quot;,commitMethod = &quot;commitReduceAccount&quot;,rollbackMethod = &quot;rollbackReduceAccount&quot;)\n    int reduceAccount(\n            @BusinessActionContextParameter(paramName =&quot;id&quot;) String id,\n            @BusinessActionContextParameter(paramName =&quot;num&quot;) Integer num);\n    boolean commitReduceAccount(BusinessActionContext context);\n    boolean rollbackReduceAccount(BusinessActionContext context);\n}\n\n\n作者：wenyl\n链接：https://ld246.com/article/1635916035380\n来源：链滴\n协议：CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/\n</code></pre>\n', 0, 0, 0, 4, '', 0, 0, 1000, 0, 0, 0, '2021-11-18 18:01:56', '2021-11-19 02:02:00');
INSERT INTO `forum_posts` VALUES (16, 'PASS', 'ARTICLE', 1, '从 Icalingua 项目谈 SQL 数据库结构的最佳实践', 'MARKDOWN', '## 一、万恶之源——不当的数据组织方式\n\n存储消息时，每个房间都建一个表（名为 msg${roomId}）。这是 Il 在用 json 存记录时的某种优化，却在随后的 MongoDB 存储方式中也被继承，并影响到了 SQLStorageProvider 和 RedisStorageProvider 的编写。在 MongoDB 和 Redis 这样的 NoSQL 数据库中，这么做并不会增加太多复杂度。然而在 SQLStorageProvider 中，这种“表名与表数量都不固定”的结构却成倍增加了代码量和复杂度。\n\n## 二、水土不服——SQL 相关代码的编写\nNoSQL 数据库中，尝试向表（只有 Mongo 有对应“表”的概念——Collections，但我在 Redis 里也实现了这一层，姑且这么叫吧）中写入数据时，若表不存在，它会被自动创建。然而，SQL 数据库并没有类似 insertOrReplace 和 createTableIfNotExist 这样的功能（除了 PostgreSQL，但我用 knex 实现的 SQLStorageProvider 在功能上取三个 SQL 的交集以保证兼容性）。\n\n同时，因为 SQL 的 column 有较为严格的限制，我们需要对数据库版本进行管理，当 columns 有改动时，运行升级函数去 alter 各表，改动它们的 columns。然而，由于表名与表数量都不固定，我只好另建一表（表名为 msgTableNameTable，是不是有屎山的感觉了？），表中存储各 msg 表的表名。\n\n于是我实现了一个 createMsgTable 方法，在每次对表进行操作以前调用该方法检查目标表是否存在，若不存在则先创建，创建时也向 msgTableNameTable 写入 msg 表的表名，以便此后进行升级操作时能修改它们的 columns。\n', '<h2><a id=\"_0\"></a>一、万恶之源——不当的数据组织方式</h2>\n<p>存储消息时，每个房间都建一个表（名为 msg${roomId}）。这是 Il 在用 json 存记录时的某种优化，却在随后的 MongoDB 存储方式中也被继承，并影响到了 SQLStorageProvider 和 RedisStorageProvider 的编写。在 MongoDB 和 Redis 这样的 NoSQL 数据库中，这么做并不会增加太多复杂度。然而在 SQLStorageProvider 中，这种“表名与表数量都不固定”的结构却成倍增加了代码量和复杂度。</p>\n<h2><a id=\"SQL__4\"></a>二、水土不服——SQL 相关代码的编写</h2>\n<p>NoSQL 数据库中，尝试向表（只有 Mongo 有对应“表”的概念——Collections，但我在 Redis 里也实现了这一层，姑且这么叫吧）中写入数据时，若表不存在，它会被自动创建。然而，SQL 数据库并没有类似 insertOrReplace 和 createTableIfNotExist 这样的功能（除了 PostgreSQL，但我用 knex 实现的 SQLStorageProvider 在功能上取三个 SQL 的交集以保证兼容性）。</p>\n<p>同时，因为 SQL 的 column 有较为严格的限制，我们需要对数据库版本进行管理，当 columns 有改动时，运行升级函数去 alter 各表，改动它们的 columns。然而，由于表名与表数量都不固定，我只好另建一表（表名为 msgTableNameTable，是不是有屎山的感觉了？），表中存储各 msg 表的表名。</p>\n<p>于是我实现了一个 createMsgTable 方法，在每次对表进行操作以前调用该方法检查目标表是否存在，若不存在则先创建，创建时也向 msgTableNameTable 写入 msg 表的表名，以便此后进行升级操作时能修改它们的 columns。</p>\n', 0, 0, 0, 3, '', 0, 0, 1000, 0, 0, 0, '2021-11-18 18:03:00', '2021-11-19 02:03:00');

-- ----------------------------
-- Table structure for forum_search
-- ----------------------------
DROP TABLE IF EXISTS `forum_search`;
CREATE TABLE `forum_search`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '类型',
  `entity_id` bigint(11) NOT NULL COMMENT '实体ID',
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_type_title`(`type`, `title`(191)) USING BTREE,
  INDEX `idx_type_create`(`type`, `create_at`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '搜索内容表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_search
-- ----------------------------
INSERT INTO `forum_search` VALUES (8, 'POSTS', 3, '蚂蚁开放性笔试题 -- 最短时间的支付方式组合', '## 题目\n用户有多种支付方式（余额、红包、优惠券，代金券等），假如每种支付方式通过调用远程服务获取可用性。\n在外部资源环境不变情况下，请设计程序以最短响应时间获得尽可能多的可用支付方式列表。\n\n假定支付方式可用性咨询接口定义：PaymentRemoteSerivce\n接口方法：ConsultResult isEnabled(String paymentType);\n返回结果：\n```\npublic ConsultResult (boolean isEnable,String  errorCode){\n    this.isEnable = isEnable;\n    this.errorCode= errorCode;\n}\n\n/** 咨询结果是否可用*/\nprivate boolean isEnable;\n\n/** 错误码 */\nprivate String errorCode;\n\npublic boolean getIsEnable(){\n    return isEnable;\n}\n\npublic String getErrorCode(){\n    return errorCode;\n}\n}\n```\n## 解题思路\n1、进行远程调用\n2、远程调用后存缓存\n3、发生变化通过 socket 或者 mq 进行通知，刷新缓存\n4、定时刷新缓存、防止某时刻大量请求过来而没得缓存', 0, '2021-11-18 17:07:23', '2021-11-19 01:07:23');
INSERT INTO `forum_search` VALUES (9, 'POSTS', 4, 'Java 监听 Mac 键盘输入实现快捷键功能', '# 背景需求\n当你想使用 Java 给 Mac 上注册快捷键时，你百度到可以通过 jnativehook 进行实现。然后你发现，下载下来的例子进行运行不了，这篇文章说的就是怎么解决这个问题，以及如果通过这个 jnativehook 实现 Mac 上的系统级快捷键。\n\n## jnativehook\nJNativeHook 为 Java 程序提供全局的键盘和鼠标事件侦听功能。你可以来处理程序外的键盘输入和鼠标动作。当然 JNativeHook 使用了 JNI 技术调用了系统的方法来实现该功能。\n\n## 注册全局快捷键\nok，完成以上内容之后，现在我们该说说代码了。在使用的过程中 jnativehook 似乎没有具体对于快捷键的实现，也就是这一部分需要我们进行完成。\n\n当然在完成上面那个小 demo 之后我猜你也应该猜到怎么做了，既然我们能监听到 mac 的所有输入了，那假如连续输入对应的键然后触发相应的功能就是实现了快捷键的功能。\n\nok，来一个小功能先，就是知道怎么只监听所有的键盘输入\n', 0, '2021-11-18 17:13:42', '2021-11-19 01:13:41');
INSERT INTO `forum_search` VALUES (10, 'POSTS', 5, '面试题之数据库篇', '# 渐进式问题\n\n有两个表：学生 student（id,name,age,class_id）和班级 class(id,name)。\n\n## 口述查询语句：查询人数大于 10 的班级，及其人数\n- select class.id, count(*) from class join student on class.id = student.class_id group by class.id having count(*) > 10;\n\n## 左连接，右连接和内连接的区别\n\n连接分为内连接和外连接，外连接又分为左外连接和右外连接。比如表 1 join 表 2，在字段 a 上做关联，如果是左外连接，会把所有表 1 的记录查询出来，对应字段 a 的值，如果在表 2 中没有记录，表 2 相关字段会都是 null；而如果是右外连接，会把表 2 的记录都查询出来，对应字段 a 的值，如果在表 1 中没有记录，表 1 相关字段会都是 null；如果是内连接，会把这类只有一个表里有的记录过滤掉。\n\n## MySQL 数据库，同一条查询语句，第一次执行较慢，第二次很快返回结果，可能的原因是什么？\n\n可能是第二次查询时命中了查询缓存\n如果开启了查询缓存，且在第一次查询后没有对查询相关表做任何修改操作，则第二次查询时会直接返回缓存的第一次查询的结果\n只有在更新不频繁的场景才建议开启查询缓存，因为缓存查询结果会占用一定内存，且有性能损失，如果更新频繁，缓存往往不能命中，则会白白浪费内存和性能', 0, '2021-11-18 17:19:19', '2021-11-19 01:19:19');
INSERT INTO `forum_search` VALUES (12, 'POSTS', 7, '【净坛行动】论坛禁止发布任何翻墙软件和违法犯罪程序！！！', '国家严打网络违法犯罪越来越严格，上次也因为有人在论坛发布一些不和谐的程序导致论坛域名被HOLD，出现几天无法访问的情况，虽然我们曾经发过公告说明。\n\n但依然有同学我行我素，在此特别强调一下，不要在论坛发布任何翻墙软件、国外代理程序、国外节点加速器、VPN代理、HOST翻墙等一些列可以提供访问国外网站的方法和工具，在论坛交流就要遵守论坛规定，如果再出现发布类似程序或者擦边球将直接给予封号处分，也许就因为你的一个帖子可能论坛都不存在了，我们希望论坛可以继续给大家提供一个安全公开的技术交流社区。\n\n不止上述软件，还有各种黑客攻击程序和任何违法犯罪程序都禁止发布，擦边球也不可以有，出现同样做以封号处罚。\n\n我们这次就叫【净坛行动】吧，管理会将之前发布的不合符要求的内容给予删除（如果收到删除消息请周知），为了论坛能活下来，如果大家发现有人发布类似程序，请大家积极举报，为了论坛请大家一定要注意。\n\n2021.11.19\n在线问答论坛系统-管理员发', 0, '2021-11-18 17:28:46', '2021-11-19 01:28:45');
INSERT INTO `forum_search` VALUES (13, 'POSTS', 8, '有哪些值得学习的国内 c++ 开源项目？', '# 一、基础\n## 1.1 一个项目入门 C++ 足以：CPlusPlusThings\nCPlusPlusThings 是国人开源一个 C++ 学习项目。它系统地将 C++ 学习分为了【基础进阶】、【实战系列】、【C++2.0 新特性】、【设计模式】和【STL 源码剖析】、【并发编程】、【C++ 惯用法】、【学习课程】、【工具】、【拓展】。\n\n作为一个全面系统的 C++ 学习项目，CPlusPlusThings 是优秀的，它合理地安排了 10 Days 的实战部分，在实战中了解语法和函数用法，唯一不足的是，在注释部分有些不尽人意，对部分新手程序员并不是很友好。【基础进阶】部分内容：\n\n## 1.2 基础部分之算法：C-Plus-Plus\nC-Plus-Plus 是收录用 C++ 实现的各种算法的集合，并按照 MIT 许可协议进行授权。这些算法涵盖了计算机科学、数学和统计学、数据科学、机器学习、工程等各种主题。除外，你可能会发现针对同一目标的多个实现使用不同的算法策略和优化。\n\n## 1.3 现代 C++：modern-cpp-tutorial\n[知乎](https://pic1.zhimg.com/50/v2-ae692cc65059a7e1d469fbdc67b97570_720w.jpg?source=1940ef5c)\n\n适合熟悉 C++ 的基本语法、使用过 STL、熟悉一些常用的算法，以及递归等程序设计方法的 C++ 学习者阅读。虽然项目章节文章写的深入浅出，不过唯一的遗憾是尚未完成所有章节内容。进度如下：\n\n- 0.前言\n- 1.Template 的基本语法\n- 2.模板元编程基础\n- 3.深入理解特化与偏特化\n- 4.元编程下的数据结构与算法 （尚未开始）\n- 5.模板的进阶技巧（尚未开始）\n- 6.模板的威力：从 foreach, transform 到 Linq（尚未开始）\n- 7.结语：讨论有益，争端无用（尚未开始）', 0, '2021-11-18 17:33:34', '2021-11-19 01:33:34');
INSERT INTO `forum_search` VALUES (14, 'POSTS', 9, '一条更新 SQL 是如何执行的？', '# 前言\n\n比如说这个表有一个主键 ID 和一个整型字段 c：\n```\nmysql> create table T(ID int primary key, c int);\n```\n如果要将 ID=2 这一行的值加 1，SQL 语句就会这么写：\n```\nmysql> update T set c=c+1 where ID=2;\n```\n\n', 0, '2021-11-18 17:39:23', '2021-11-19 01:39:23');
INSERT INTO `forum_search` VALUES (15, 'POSTS', 6, '思源笔记限时永久会员', '\n![思源笔记](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/6.png?t=1637257450583)\n## 订阅推荐码有什么用？\n- 订阅时使用别人的推荐码你可以增加 500 MB 云端空间和 7 天使用时长\n- 别人使用了你的推荐码你自己也可以增加 500 MB 云端空间和 7 天使用时长\n- 💔 使用订阅推荐码后不支持 7 天内无理由退款\n- 👑 限量活动：每推荐 7 人订阅后可获赠终身会员激活码 \n思源笔记推荐订阅送终身会员，512 个名额送完即止\n\n## 订阅后是否支持退款？\n- 💔 使用订阅推荐码后不支持 7 天内无理由退款\n- 订阅 7 天内支持无理由全额退款，7 天后不再支持退款\n- 不支持重复退款，请理性按需购买\n- 退款后云端数据会被立即清空\n- 退款请发邮件至 845765@qq.com\n\n## 中断过订阅之后重新订阅价格怎么算？\n- 续订价格终身按第一次订阅时的价格\n- 如果退款过，则只能按最新价格订阅\n\n## 学生用户订阅有教育优惠吗？\n- 目前已经暂停教育优惠订阅，具体请看 \n- 关于思源笔记暂停教育优惠的公告', 0, '2021-11-18 17:45:07', '2021-11-19 01:45:06');
INSERT INTO `forum_search` VALUES (16, 'POSTS', 10, 'iTab 新标签页，自定义你的热爱', '# iTab 新标签页，自定义你的热爱\n\nHi, 你好！初来乍到，自我介绍一下。\n\n我是一名前端工程师，因为用了很多浏览器默认起始页，要么广告太多，要么呆板无趣，都满足不了我对美观和实用兼顾的需求，所以就纯粹凭着一股热情动手做了一个。前前后后我一个人从设计产品到前后端开发连着熬夜肝了一个多月上架了这个 iTab 新标签页，没想到意外收获了非常多用户喜欢，稳定版上线 10 天下载就超四千。说实话，我完全没想到会有这么多人跟我一样，苦浏览器起始页不好用久矣。\n\n## iTab 新标签页是什么？\n\niTab 标签页是一款美化和管理浏览器主页的插件。支持 Chrome，Edge，Bing，Firefox 和 360 浏览器直接安装（其他浏览器可以安装离线包）。这个标签页除了具备基本的搜索，常用网站图标，书签管理等功能外，还内置常用工具，更换壁纸，自定义图标样式，图标分组，多端同步，快速翻译，深色模式等等功能。是一个将美观和实用完美结合的桌面管理工具。\n\n![照片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/7.png?t=1637257736049)\n', 0, '2021-11-18 17:49:29', '2021-11-19 01:49:29');
INSERT INTO `forum_search` VALUES (17, 'POSTS', 11, '日本 东北 鸣子峡红叶见倾 地狱谷煮温泉蛋 山形総合公园银杏大道', '这一天我们的出发时间是九点，特别早起到了车站附近的咖啡厅-TsukiCafe 山形駅前吃早餐。\n![图片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/8.jpeg?t=1637257900201)\n\n![图片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/9.jpg?t=1637257905580)\n\n', 0, '2021-11-18 17:52:47', '2021-11-19 01:52:46');
INSERT INTO `forum_search` VALUES (18, 'POSTS', 12, '和一个小妹妹一起写了一个浏览器插件', '她刚刚高考完，有一天问我会不会写浏览器插件。我刚好刚写了一个浏览器插件，还没写完，虽然还不是很了解浏览器插件的开发。但是她让我帮帮她，于是我就帮帮她了。最后我们两个人折腾好一会完成了这个插件。\n\n大家如果有用这个功能的，可以参与到开源中，添加你需要的搜索引擎 💖\n\n## 功能\n- 为列表中的网站添加 OpenSearch，来让浏览器将其添加到搜索引擎\n- 搜索引擎添加完成后，在地址栏中输入网站地址，按下 空格键 或 Tab 即可快速搜索\n- 在 Firefox 浏览器中，需要手动点击带有加号的网站图标将其添加至搜索引擎中。\n\n', 0, '2021-11-18 17:55:16', '2021-11-19 01:55:15');
INSERT INTO `forum_search` VALUES (19, 'POSTS', 13, '在荒野大镖客 2 中看剧院表演，你为 R 星花的每一分钱都物超所值', '断断续续终于打到游戏的第四章了，第三章末尾范德林德帮派一行八人去救被布雷切斯特家族绑架的约翰儿子杰克的剧情实在是太热血了\n\n![图片](https://cdn.jsdelivr.net/gh/halavah/PicGo@master/forum/10.png?t=1637258224322)\n\n', 0, '2021-11-18 17:58:04', '2021-11-19 01:58:03');
INSERT INTO `forum_search` VALUES (20, 'POSTS', 14, 'SDB ：纯 golang 开发、数据结构丰富、持久化的 NoSQL 数据库', '## 为什么需要 SDB？\n\n试想以下业务场景：\n\n计数服务：对内容的点赞、播放等数据进行统计\n评论服务：发布评论后，查看某个内容的评论列表\n推荐服务：每个用户有一个包含内容和权重的推荐列表\n以上几个业务场景，都可以通过 MySQL + Redis 的方式实现。 这里的问题是：MySQL 更多的是充当持久化的能力，Redis 充当的是在线服务的读写能力。\n\n那么只使用 Redis 行不行？ 答案是否定的，因为 Redis 无法保证数据不丢失。\n\n那有没有一种存储能够支持高级的数据结构，并能够将数据进行持久化的呢？\n\n答案是：非常少的。有些数据库要么是支持的数据结构不够丰富，要么是接入成本太高，要么是不可控。\n\n```\npackage main\n\nimport (\n	\"fmt\"\n	pb \"github.com/yemingfeng/sdb/server/proto\"\n	\"golang.org/x/net/context\"\n	\"google.golang.org/grpc\"\n	\"log\"\n)\n\nfunc main() {\n	conn, err := grpc.Dial(\":9000\", grpc.WithInsecure())\n	if err != nil {\n		fmt.Printf(\"faild to connect: %v\", err)\n	}\n	defer conn.Close()\n\n	// 连接服务器\n	c := pb.NewSDBClient(conn)\n	setResponse, err := c.Set(context.Background(),\n		&pb.SetRequest{Key: \"hello\", Val: \"world\"})\n	log.Printf(\"setResponse: %v, err: %v\", setResponse, err)\n	getResponse, err := c.Get(context.Background(), \n		&pb.GetRequest{Key: \"hello\"})\n	log.Printf(\"getResponse: %v, err: %v\", getResponse, err)\n}\n```', 0, '2021-11-18 17:59:06', '2021-11-19 01:59:05');
INSERT INTO `forum_search` VALUES (21, 'POSTS', 15, 'seata+nacos 实现 TCC 模式分布式事务', '## 简介\nAT 模式（参考链接 TBD）基于 支持本地 ACID 事务 的 关系型数据库 ：\nTCC 模式，不依赖于底层数据资源的事务支持。\n\n## 建立项目\nTCC 模式的 maven 依赖引入，项目配置和 AT 模式相同，可以参考 seata+nacos 实现 AT 模式分布式事务的第 2 节，完成代码到 git 上下载，TCC 模式在 tcc 分支下，脚本在 script 目录下（和 AT 模式的数据库脚本一致，选择一个执行即可）\n\n```\n/**\n * @author Mr.Wen\n * @version 1.0\n * @date 2021-10-25 14:03\n */\n@LocalTCC\npublic interface BankUserService {\n    @TwoPhaseBusinessAction(name = \"reduceAccount\",commitMethod = \"commitReduceAccount\",rollbackMethod = \"rollbackReduceAccount\")\n    int reduceAccount(\n            @BusinessActionContextParameter(paramName =\"id\") String id,\n            @BusinessActionContextParameter(paramName =\"num\") Integer num);\n    boolean commitReduceAccount(BusinessActionContext context);\n    boolean rollbackReduceAccount(BusinessActionContext context);\n}\n\n\n作者：wenyl\n链接：https://ld246.com/article/1635916035380\n来源：链滴\n协议：CC BY-SA 4.0 https://creativecommons.org/licenses/by-sa/4.0/\n```', 0, '2021-11-18 18:01:56', '2021-11-19 02:01:56');
INSERT INTO `forum_search` VALUES (22, 'POSTS', 16, '从 Icalingua 项目谈 SQL 数据库结构的最佳实践', '## 一、万恶之源——不当的数据组织方式\n\n存储消息时，每个房间都建一个表（名为 msg${roomId}）。这是 Il 在用 json 存记录时的某种优化，却在随后的 MongoDB 存储方式中也被继承，并影响到了 SQLStorageProvider 和 RedisStorageProvider 的编写。在 MongoDB 和 Redis 这样的 NoSQL 数据库中，这么做并不会增加太多复杂度。然而在 SQLStorageProvider 中，这种“表名与表数量都不固定”的结构却成倍增加了代码量和复杂度。\n\n## 二、水土不服——SQL 相关代码的编写\nNoSQL 数据库中，尝试向表（只有 Mongo 有对应“表”的概念——Collections，但我在 Redis 里也实现了这一层，姑且这么叫吧）中写入数据时，若表不存在，它会被自动创建。然而，SQL 数据库并没有类似 insertOrReplace 和 createTableIfNotExist 这样的功能（除了 PostgreSQL，但我用 knex 实现的 SQLStorageProvider 在功能上取三个 SQL 的交集以保证兼容性）。\n\n同时，因为 SQL 的 column 有较为严格的限制，我们需要对数据库版本进行管理，当 columns 有改动时，运行升级函数去 alter 各表，改动它们的 columns。然而，由于表名与表数量都不固定，我只好另建一表（表名为 msgTableNameTable，是不是有屎山的感觉了？），表中存储各 msg 表的表名。\n\n于是我实现了一个 createMsgTable 方法，在每次对表进行操作以前调用该方法检查目标表是否存在，若不存在则先创建，创建时也向 msgTableNameTable 写入 msg 表的表名，以便此后进行升级操作时能修改它们的 columns。\n', 0, '2021-11-18 18:03:00', '2021-11-19 02:02:59');

-- ----------------------------
-- Table structure for forum_tag
-- ----------------------------
DROP TABLE IF EXISTS `forum_tag`;
CREATE TABLE `forum_tag`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `audit_state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '审核状态',
  `group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '所属分组',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `description` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '描述',
  `ref_count` bigint(11) NOT NULL DEFAULT 0 COMMENT '引用统计',
  `creator_id` bigint(11) NOT NULL COMMENT '创建人',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_name_state`(`name`, `audit_state`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 380 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_tag
-- ----------------------------
INSERT INTO `forum_tag` VALUES (188, 'PASS', '开发语言', 'java', ' java 标签描述', 16, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:07:23');
INSERT INTO `forum_tag` VALUES (189, 'PASS', '开发语言', 'c', ' c 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:02:59');
INSERT INTO `forum_tag` VALUES (190, 'PASS', '开发语言', 'c++', ' c++ 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:02:59');
INSERT INTO `forum_tag` VALUES (191, 'PASS', '开发语言', 'php', ' php 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (192, 'PASS', '开发语言', 'perl', ' perl 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (193, 'PASS', '开发语言', 'python', ' python 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (194, 'PASS', '开发语言', 'javascript', ' javascript 标签描述', 18, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (195, 'PASS', '开发语言', 'c#', ' c# 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (196, 'PASS', '开发语言', 'ruby', ' ruby 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (197, 'PASS', '开发语言', 'go', ' go 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (198, 'PASS', '开发语言', 'lua', ' lua 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (199, 'PASS', '开发语言', 'node.js', ' node.js 标签描述', 5, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (200, 'PASS', '开发语言', 'erlang', ' erlang 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (201, 'PASS', '开发语言', 'scala', ' scala 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (202, 'PASS', '开发语言', 'bash', ' bash 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (203, 'PASS', '开发语言', 'actionscript', ' actionscript 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (204, 'PASS', '开发语言', 'golang', ' golang 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (205, 'PASS', '开发语言', 'typescript', ' typescript 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (206, 'PASS', '开发语言', 'flutter', ' flutter 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (207, 'PASS', '前端开发', 'html', ' html 标签描述', 4, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:07:23');
INSERT INTO `forum_tag` VALUES (208, 'PASS', '前端开发', 'html5', ' html5 标签描述', 6, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:07:23');
INSERT INTO `forum_tag` VALUES (209, 'PASS', '前端开发', 'css', ' css 标签描述', 3, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:58:03');
INSERT INTO `forum_tag` VALUES (210, 'PASS', '前端开发', 'css3', ' css3 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:58:03');
INSERT INTO `forum_tag` VALUES (211, 'PASS', '前端开发', 'jquery', ' jquery 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:58:03');
INSERT INTO `forum_tag` VALUES (212, 'PASS', '前端开发', 'json', ' json 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:58:03');
INSERT INTO `forum_tag` VALUES (213, 'PASS', '前端开发', 'ajax', ' ajax 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (214, 'PASS', '前端开发', '正则表达式', ' 正则表达式 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:58:03');
INSERT INTO `forum_tag` VALUES (215, 'PASS', '前端开发', 'bootstrap', ' bootstrap 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (216, 'PASS', 'JavaScript 开发', 'chrome', ' chrome 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:49:29');
INSERT INTO `forum_tag` VALUES (217, 'PASS', 'JavaScript 开发', 'firefox', ' firefox 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:55:15');
INSERT INTO `forum_tag` VALUES (218, 'PASS', 'JavaScript 开发', 'internet-explorer', ' internet-explorer 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:49:29');
INSERT INTO `forum_tag` VALUES (219, 'PASS', 'JavaScript 开发', 'angular.js', ' angular.js 标签描述', 5, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:55:15');
INSERT INTO `forum_tag` VALUES (220, 'PASS', 'JavaScript 开发', 'ecmascript', ' ecmascript 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:55:15');
INSERT INTO `forum_tag` VALUES (221, 'PASS', 'JavaScript 开发', 'vue.js', ' vue.js 标签描述', 4, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:55:15');
INSERT INTO `forum_tag` VALUES (222, 'PASS', 'JavaScript 开发', 'react.js', ' react.js 标签描述', 6, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:55:15');
INSERT INTO `forum_tag` VALUES (223, 'PASS', '小程序开发', '小程序', ' 小程序 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:33:34');
INSERT INTO `forum_tag` VALUES (224, 'PASS', '小程序开发', '微信小程序', ' 微信小程序 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:33:34');
INSERT INTO `forum_tag` VALUES (225, 'PASS', '小程序开发', '支付宝小程序', ' 支付宝小程序 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:33:34');
INSERT INTO `forum_tag` VALUES (226, 'PASS', '小程序开发', '百度智能小程序', ' 百度智能小程序 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:33:34');
INSERT INTO `forum_tag` VALUES (227, 'PASS', '小程序开发', '微信开发者工具', ' 微信开发者工具 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:33:34');
INSERT INTO `forum_tag` VALUES (228, 'PASS', '小程序开发', '头条小程序', ' 头条小程序 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (229, 'PASS', '小程序开发', '小程序云开发', ' 小程序云开发 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:39:23');
INSERT INTO `forum_tag` VALUES (230, 'PASS', '小程序开发', 'wepy', ' wepy 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:39:23');
INSERT INTO `forum_tag` VALUES (231, 'PASS', '小程序开发', 'mpvue', ' mpvue 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (232, 'PASS', '小程序开发', 'taro', ' taro 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:39:23');
INSERT INTO `forum_tag` VALUES (233, 'PASS', '小程序开发', 'uni-app', ' uni-app 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:39:23');
INSERT INTO `forum_tag` VALUES (234, 'PASS', '小程序开发', 'mpx', ' mpx 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:39:23');
INSERT INTO `forum_tag` VALUES (235, 'PASS', '区块链', '比特币', ' 比特币 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:28:45');
INSERT INTO `forum_tag` VALUES (236, 'PASS', '区块链', '区块链', ' 区块链 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:28:45');
INSERT INTO `forum_tag` VALUES (237, 'PASS', '区块链', 'ico', ' ico 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:28:45');
INSERT INTO `forum_tag` VALUES (238, 'PASS', '区块链', '智能合约', ' 智能合约 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:28:45');
INSERT INTO `forum_tag` VALUES (239, 'PASS', '区块链', '以太坊', ' 以太坊 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:28:45');
INSERT INTO `forum_tag` VALUES (240, 'PASS', '区块链', '数字化货币', ' 数字化货币 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (241, 'PASS', '人工智能', '人工智能', ' 人工智能 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:45:06');
INSERT INTO `forum_tag` VALUES (242, 'PASS', '人工智能', '自然语言处理', ' 自然语言处理 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:45:06');
INSERT INTO `forum_tag` VALUES (243, 'PASS', '人工智能', '自动驾驶', ' 自动驾驶 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:45:06');
INSERT INTO `forum_tag` VALUES (244, 'PASS', '人工智能', '神经网络', ' 神经网络 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:45:06');
INSERT INTO `forum_tag` VALUES (245, 'PASS', '人工智能', '数据挖掘', ' 数据挖掘 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:45:06');
INSERT INTO `forum_tag` VALUES (246, 'PASS', '人工智能', '机器学习', ' 机器学习 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (247, 'PASS', '人工智能', '深度学习', ' 深度学习 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (248, 'PASS', '人工智能', 'tensorflow', ' tensorflow 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (249, 'PASS', 'iOS 开发', 'ios', ' ios 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:01:56');
INSERT INTO `forum_tag` VALUES (250, 'PASS', 'iOS 开发', 'objective-c', ' objective-c 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (251, 'PASS', 'iOS 开发', 'sqlite', ' sqlite 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (252, 'PASS', 'iOS 开发', 'safari', ' safari 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (253, 'PASS', 'iOS 开发', 'xcode', ' xcode 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (254, 'PASS', 'iOS 开发', 'phonegap', ' phonegap 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:01:56');
INSERT INTO `forum_tag` VALUES (255, 'PASS', 'iOS 开发', 'cocoa', ' cocoa 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:01:56');
INSERT INTO `forum_tag` VALUES (256, 'PASS', 'iOS 开发', 'macos', ' macos 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (257, 'PASS', 'iOS 开发', 'iphone', ' iphone 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:01:56');
INSERT INTO `forum_tag` VALUES (258, 'PASS', 'iOS 开发', 'ipad', ' ipad 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:01:56');
INSERT INTO `forum_tag` VALUES (259, 'PASS', 'iOS 开发', 'swift', ' swift 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (260, 'PASS', 'Android 开发', 'android', ' android 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:59:05');
INSERT INTO `forum_tag` VALUES (261, 'PASS', 'Android 开发', 'eclipse', ' eclipse 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:59:05');
INSERT INTO `forum_tag` VALUES (262, 'PASS', 'Android 开发', 'xml', ' xml 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:59:05');
INSERT INTO `forum_tag` VALUES (263, 'PASS', 'Android 开发', 'webview', ' webview 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:59:05');
INSERT INTO `forum_tag` VALUES (264, 'PASS', 'Android 开发', 'android-studio', ' android-studio 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:59:05');
INSERT INTO `forum_tag` VALUES (265, 'PASS', '数据库', 'mysql', ' mysql 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:13:41');
INSERT INTO `forum_tag` VALUES (266, 'PASS', 'PHP 开发', 'apache', ' apache 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:19:19');
INSERT INTO `forum_tag` VALUES (267, 'PASS', 'PHP 开发', 'nginx', ' nginx 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:19:19');
INSERT INTO `forum_tag` VALUES (268, 'PASS', 'PHP 开发', 'mvc', ' mvc 标签描述', 2, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:13:41');
INSERT INTO `forum_tag` VALUES (269, 'PASS', 'PHP 开发', 'symfony', ' symfony 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:19:19');
INSERT INTO `forum_tag` VALUES (270, 'PASS', 'PHP 开发', 'zend-framework', ' zend-framework 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (271, 'PASS', 'PHP 开发', 'composer', ' composer 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:19:19');
INSERT INTO `forum_tag` VALUES (272, 'PASS', 'PHP 开发', 'laravel', ' laravel 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:19:19');
INSERT INTO `forum_tag` VALUES (273, 'PASS', '数据库', '数据库', ' 数据库 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (274, 'PASS', '数据库', 'oracle', ' oracle 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (275, 'PASS', '数据库', 'sql', ' sql 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:52:46');
INSERT INTO `forum_tag` VALUES (276, 'PASS', '数据库', 'nosql', ' nosql 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:52:46');
INSERT INTO `forum_tag` VALUES (277, 'PASS', '数据库', 'redis', ' redis 标签描述', 3, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:52:46');
INSERT INTO `forum_tag` VALUES (278, 'PASS', '数据库', 'mongodb', ' mongodb 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:52:46');
INSERT INTO `forum_tag` VALUES (279, 'PASS', '数据库', 'memcached', ' memcached 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:52:46');
INSERT INTO `forum_tag` VALUES (280, 'PASS', '数据库', 'postgresql', ' postgresql 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:13:41');
INSERT INTO `forum_tag` VALUES (281, 'PASS', '.NET 开发', '.net', ' .net 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (282, 'PASS', '.NET 开发', 'asp.net', ' asp.net 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (283, 'PASS', '.NET 开发', 'visual-studio', ' visual-studio 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 01:13:41');
INSERT INTO `forum_tag` VALUES (284, 'PASS', '.NET 开发', 'microsoft', ' microsoft 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (285, 'PASS', 'Python 开发', 'List', ' List 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (286, 'PASS', 'Python 开发', 'django', ' django 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (287, 'PASS', 'Python 开发', 'flask', ' flask 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (288, 'PASS', 'Python 开发', 'tornado', ' tornado 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (289, 'PASS', 'Python 开发', 'web.py', ' web.py 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (290, 'PASS', 'Python 开发', 'sqlalchemy', ' sqlalchemy 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (291, 'PASS', 'Python 开发', 'virtualenv', ' virtualenv 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (292, 'PASS', 'Ruby 开发', 'ruby-on-rails', ' ruby-on-rails 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (293, 'PASS', 'Ruby 开发', 'rubygems', ' rubygems 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (294, 'PASS', 'Ruby 开发', 'rvm', ' rvm 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (295, 'PASS', 'Ruby 开发', 'macosx', ' macosx 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (296, 'PASS', 'Ruby 开发', 'bundle', ' bundle 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (297, 'PASS', '开发工具', 'vim', ' vim 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (298, 'PASS', '开发工具', 'emacs', ' emacs 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (299, 'PASS', '开发工具', 'ide', ' ide 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (300, 'PASS', '开发工具', 'intellij-idea', ' intellij-idea 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (301, 'PASS', '开发工具', 'textmate', ' textmate 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (302, 'PASS', '开发工具', 'sublime-text', ' sublime-text 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (303, 'PASS', '开发工具', 'git', ' git 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (304, 'PASS', '开发工具', 'github', ' github 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (305, 'PASS', '开发工具', 'svn', ' svn 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (306, 'PASS', '开发工具', 'hg', ' hg 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (307, 'PASS', '开发工具', 'docker', ' docker 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (308, 'PASS', '开发工具', 'ci', ' ci 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (309, 'PASS', '云计算', '云计算', ' 云计算 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:02:59');
INSERT INTO `forum_tag` VALUES (310, 'PASS', '云计算', '又拍云存储', ' 又拍云存储 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (311, 'PASS', '云计算', '七牛云存储', ' 七牛云存储 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:02:59');
INSERT INTO `forum_tag` VALUES (312, 'PASS', '云计算', 'amazon-web-services', ' amazon-web-services 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (313, 'PASS', '云计算', '百度云', ' 百度云 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (314, 'PASS', '云计算', '金山云', ' 金山云 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (315, 'PASS', '云计算', '美团云', ' 美团云 标签描述', 0, 25, 0, '2021-11-10 12:03:01', '2021-11-10 12:03:01');
INSERT INTO `forum_tag` VALUES (316, 'PASS', '云计算', '腾讯云', ' 腾讯云 标签描述', 1, 25, 0, '2021-11-10 12:03:01', '2021-11-19 02:02:59');

-- ----------------------------
-- Table structure for forum_tag_posts_mapping
-- ----------------------------
DROP TABLE IF EXISTS `forum_tag_posts_mapping`;
CREATE TABLE `forum_tag_posts_mapping`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tag_id` bigint(11) NOT NULL COMMENT '标签ID',
  `posts_id` bigint(11) NOT NULL COMMENT '帖子ID',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_posts_tag`(`posts_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '标签-帖子关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_tag_posts_mapping
-- ----------------------------
INSERT INTO `forum_tag_posts_mapping` VALUES (3, 268, 2, 0, '2021-11-18 15:06:28', '2021-11-18 23:06:28');
INSERT INTO `forum_tag_posts_mapping` VALUES (4, 267, 2, 0, '2021-11-18 15:06:28', '2021-11-18 23:06:28');
INSERT INTO `forum_tag_posts_mapping` VALUES (8, 376, 1, 0, '2021-11-18 16:49:06', '2021-11-19 00:49:05');
INSERT INTO `forum_tag_posts_mapping` VALUES (9, 207, 3, 0, '2021-11-18 17:07:23', '2021-11-19 01:07:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (10, 188, 3, 0, '2021-11-18 17:07:23', '2021-11-19 01:07:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (11, 208, 3, 0, '2021-11-18 17:07:23', '2021-11-19 01:07:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (12, 265, 4, 0, '2021-11-18 17:13:42', '2021-11-19 01:13:41');
INSERT INTO `forum_tag_posts_mapping` VALUES (13, 280, 4, 0, '2021-11-18 17:13:42', '2021-11-19 01:13:41');
INSERT INTO `forum_tag_posts_mapping` VALUES (14, 268, 4, 0, '2021-11-18 17:13:42', '2021-11-19 01:13:41');
INSERT INTO `forum_tag_posts_mapping` VALUES (15, 283, 4, 0, '2021-11-18 17:13:42', '2021-11-19 01:13:41');
INSERT INTO `forum_tag_posts_mapping` VALUES (16, 260, 4, 0, '2021-11-18 17:13:42', '2021-11-19 01:13:41');
INSERT INTO `forum_tag_posts_mapping` VALUES (17, 266, 5, 0, '2021-11-18 17:19:19', '2021-11-19 01:19:19');
INSERT INTO `forum_tag_posts_mapping` VALUES (18, 267, 5, 0, '2021-11-18 17:19:19', '2021-11-19 01:19:19');
INSERT INTO `forum_tag_posts_mapping` VALUES (19, 271, 5, 0, '2021-11-18 17:19:19', '2021-11-19 01:19:19');
INSERT INTO `forum_tag_posts_mapping` VALUES (20, 272, 5, 0, '2021-11-18 17:19:19', '2021-11-19 01:19:19');
INSERT INTO `forum_tag_posts_mapping` VALUES (21, 269, 5, 0, '2021-11-18 17:19:19', '2021-11-19 01:19:19');
INSERT INTO `forum_tag_posts_mapping` VALUES (27, 238, 7, 0, '2021-11-18 17:28:46', '2021-11-19 01:28:45');
INSERT INTO `forum_tag_posts_mapping` VALUES (28, 236, 7, 0, '2021-11-18 17:28:46', '2021-11-19 01:28:45');
INSERT INTO `forum_tag_posts_mapping` VALUES (29, 239, 7, 0, '2021-11-18 17:28:46', '2021-11-19 01:28:45');
INSERT INTO `forum_tag_posts_mapping` VALUES (30, 235, 7, 0, '2021-11-18 17:28:46', '2021-11-19 01:28:45');
INSERT INTO `forum_tag_posts_mapping` VALUES (31, 237, 7, 0, '2021-11-18 17:28:46', '2021-11-19 01:28:45');
INSERT INTO `forum_tag_posts_mapping` VALUES (32, 223, 8, 0, '2021-11-18 17:33:34', '2021-11-19 01:33:34');
INSERT INTO `forum_tag_posts_mapping` VALUES (33, 224, 8, 0, '2021-11-18 17:33:34', '2021-11-19 01:33:34');
INSERT INTO `forum_tag_posts_mapping` VALUES (34, 225, 8, 0, '2021-11-18 17:33:34', '2021-11-19 01:33:34');
INSERT INTO `forum_tag_posts_mapping` VALUES (35, 227, 8, 0, '2021-11-18 17:33:34', '2021-11-19 01:33:34');
INSERT INTO `forum_tag_posts_mapping` VALUES (36, 226, 8, 0, '2021-11-18 17:33:34', '2021-11-19 01:33:34');
INSERT INTO `forum_tag_posts_mapping` VALUES (37, 229, 9, 0, '2021-11-18 17:39:23', '2021-11-19 01:39:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (38, 233, 9, 0, '2021-11-18 17:39:23', '2021-11-19 01:39:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (39, 234, 9, 0, '2021-11-18 17:39:23', '2021-11-19 01:39:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (40, 232, 9, 0, '2021-11-18 17:39:23', '2021-11-19 01:39:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (41, 230, 9, 0, '2021-11-18 17:39:23', '2021-11-19 01:39:23');
INSERT INTO `forum_tag_posts_mapping` VALUES (42, 244, 6, 0, '2021-11-18 17:45:07', '2021-11-19 01:45:06');
INSERT INTO `forum_tag_posts_mapping` VALUES (43, 245, 6, 0, '2021-11-18 17:45:07', '2021-11-19 01:45:06');
INSERT INTO `forum_tag_posts_mapping` VALUES (44, 243, 6, 0, '2021-11-18 17:45:07', '2021-11-19 01:45:06');
INSERT INTO `forum_tag_posts_mapping` VALUES (45, 241, 6, 0, '2021-11-18 17:45:07', '2021-11-19 01:45:06');
INSERT INTO `forum_tag_posts_mapping` VALUES (46, 242, 6, 0, '2021-11-18 17:45:07', '2021-11-19 01:45:06');
INSERT INTO `forum_tag_posts_mapping` VALUES (47, 216, 10, 0, '2021-11-18 17:49:29', '2021-11-19 01:49:29');
INSERT INTO `forum_tag_posts_mapping` VALUES (48, 218, 10, 0, '2021-11-18 17:49:29', '2021-11-19 01:49:29');
INSERT INTO `forum_tag_posts_mapping` VALUES (49, 217, 10, 0, '2021-11-18 17:49:29', '2021-11-19 01:49:29');
INSERT INTO `forum_tag_posts_mapping` VALUES (50, 220, 10, 0, '2021-11-18 17:49:29', '2021-11-19 01:49:29');
INSERT INTO `forum_tag_posts_mapping` VALUES (51, 219, 10, 0, '2021-11-18 17:49:29', '2021-11-19 01:49:29');
INSERT INTO `forum_tag_posts_mapping` VALUES (52, 275, 11, 0, '2021-11-18 17:52:47', '2021-11-19 01:52:46');
INSERT INTO `forum_tag_posts_mapping` VALUES (53, 279, 11, 0, '2021-11-18 17:52:47', '2021-11-19 01:52:46');
INSERT INTO `forum_tag_posts_mapping` VALUES (54, 276, 11, 0, '2021-11-18 17:52:47', '2021-11-19 01:52:46');
INSERT INTO `forum_tag_posts_mapping` VALUES (55, 277, 11, 0, '2021-11-18 17:52:47', '2021-11-19 01:52:46');
INSERT INTO `forum_tag_posts_mapping` VALUES (56, 278, 11, 0, '2021-11-18 17:52:47', '2021-11-19 01:52:46');
INSERT INTO `forum_tag_posts_mapping` VALUES (57, 217, 12, 0, '2021-11-18 17:55:16', '2021-11-19 01:55:15');
INSERT INTO `forum_tag_posts_mapping` VALUES (58, 219, 12, 0, '2021-11-18 17:55:16', '2021-11-19 01:55:15');
INSERT INTO `forum_tag_posts_mapping` VALUES (59, 221, 12, 0, '2021-11-18 17:55:16', '2021-11-19 01:55:15');
INSERT INTO `forum_tag_posts_mapping` VALUES (60, 222, 12, 0, '2021-11-18 17:55:16', '2021-11-19 01:55:15');
INSERT INTO `forum_tag_posts_mapping` VALUES (61, 220, 12, 0, '2021-11-18 17:55:16', '2021-11-19 01:55:15');
INSERT INTO `forum_tag_posts_mapping` VALUES (62, 212, 13, 0, '2021-11-18 17:58:04', '2021-11-19 01:58:03');
INSERT INTO `forum_tag_posts_mapping` VALUES (63, 211, 13, 0, '2021-11-18 17:58:04', '2021-11-19 01:58:03');
INSERT INTO `forum_tag_posts_mapping` VALUES (64, 209, 13, 0, '2021-11-18 17:58:04', '2021-11-19 01:58:03');
INSERT INTO `forum_tag_posts_mapping` VALUES (65, 210, 13, 0, '2021-11-18 17:58:04', '2021-11-19 01:58:03');
INSERT INTO `forum_tag_posts_mapping` VALUES (66, 214, 13, 0, '2021-11-18 17:58:04', '2021-11-19 01:58:03');
INSERT INTO `forum_tag_posts_mapping` VALUES (67, 264, 14, 0, '2021-11-18 17:59:06', '2021-11-19 01:59:05');
INSERT INTO `forum_tag_posts_mapping` VALUES (68, 262, 14, 0, '2021-11-18 17:59:06', '2021-11-19 01:59:05');
INSERT INTO `forum_tag_posts_mapping` VALUES (69, 260, 14, 0, '2021-11-18 17:59:06', '2021-11-19 01:59:05');
INSERT INTO `forum_tag_posts_mapping` VALUES (70, 261, 14, 0, '2021-11-18 17:59:06', '2021-11-19 01:59:05');
INSERT INTO `forum_tag_posts_mapping` VALUES (71, 263, 14, 0, '2021-11-18 17:59:06', '2021-11-19 01:59:05');
INSERT INTO `forum_tag_posts_mapping` VALUES (72, 257, 15, 0, '2021-11-18 18:01:56', '2021-11-19 02:01:56');
INSERT INTO `forum_tag_posts_mapping` VALUES (73, 254, 15, 0, '2021-11-18 18:01:56', '2021-11-19 02:01:56');
INSERT INTO `forum_tag_posts_mapping` VALUES (74, 255, 15, 0, '2021-11-18 18:01:56', '2021-11-19 02:01:56');
INSERT INTO `forum_tag_posts_mapping` VALUES (75, 249, 15, 0, '2021-11-18 18:01:56', '2021-11-19 02:01:56');
INSERT INTO `forum_tag_posts_mapping` VALUES (76, 258, 15, 0, '2021-11-18 18:01:56', '2021-11-19 02:01:56');
INSERT INTO `forum_tag_posts_mapping` VALUES (77, 309, 16, 0, '2021-11-18 18:03:00', '2021-11-19 02:02:59');
INSERT INTO `forum_tag_posts_mapping` VALUES (78, 311, 16, 0, '2021-11-18 18:03:00', '2021-11-19 02:02:59');
INSERT INTO `forum_tag_posts_mapping` VALUES (79, 189, 16, 0, '2021-11-18 18:03:00', '2021-11-19 02:02:59');
INSERT INTO `forum_tag_posts_mapping` VALUES (80, 190, 16, 0, '2021-11-18 18:03:00', '2021-11-19 02:02:59');
INSERT INTO `forum_tag_posts_mapping` VALUES (81, 316, 16, 0, '2021-11-18 18:03:00', '2021-11-19 02:02:59');

-- ----------------------------
-- Table structure for forum_user
-- ----------------------------
DROP TABLE IF EXISTS `forum_user`;
CREATE TABLE `forum_user`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `nickname` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `role` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色',
  `state` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '状态',
  `sex` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '性别',
  `source` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'REGISTER' COMMENT '来源',
  `avatar` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `signature` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '个人简介',
  `ext` blob NULL COMMENT '扩展信息',
  `last_login_time` datetime(0) NOT NULL COMMENT '最后登录时间',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_user
-- ----------------------------
INSERT INTO `forum_user` VALUES (1, 'super@163.com', 'super', '5243f205b7679b0f71bc4c7ffaa20224', 'SUPER_ADMIN', 'ENABLE', 'MAN', 'REGISTER', '/avatar/01.jpg', '超级管理员', 0x7B7D, '2021-11-18 17:36:04', 0, '2021-11-18 13:23:04', '2021-11-19 01:36:04');
INSERT INTO `forum_user` VALUES (2, 'admin@163.com', 'admin', '5243f205b7679b0f71bc4c7ffaa20224', 'ADMIN', 'ENABLE', 'WOMAN', 'REGISTER', '/avatar/02.jpg', '管理员', 0x7B7D, '2021-11-18 17:08:05', 0, '2021-11-18 13:23:04', '2021-11-19 01:08:05');
INSERT INTO `forum_user` VALUES (3, 'normal03@163.com', 'normal01', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'WOMAN', 'REGISTER', '/avatar/03.jpg', '普通用户', 0x7B7D, '2021-11-18 17:37:32', 0, '2021-11-18 13:23:04', '2021-11-19 01:37:31');
INSERT INTO `forum_user` VALUES (5, 'normal04@163.com', 'normal02', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'MAN', 'REGISTER', '/avatar/04.jpg', '普通用户', 0x7B7D, '2021-11-18 14:25:52', 0, '2021-11-18 13:23:04', '2021-11-18 22:25:51');
INSERT INTO `forum_user` VALUES (6, 'normal05@163.com', 'normal03', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'MAN', 'REGISTER', '/avatar/05.jpg', '普通用户', 0x7B7D, '2021-11-18 14:27:16', 0, '2021-11-18 13:23:04', '2021-11-18 22:27:16');
INSERT INTO `forum_user` VALUES (7, 'normal06@163.com', 'normal04', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'MAN', 'REGISTER', '/avatar/06.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (8, 'normal07@163.com', 'normal05', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'UN_ACTIVATION', 'MAN', 'REGISTER', '/avatar/07.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (9, 'normal08@163.com', 'normal06', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'WOMAN', 'REGISTER', '/avatar/08.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (10, 'normal09@163.com', 'normal07', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'UN_ACTIVATION', 'WOMAN', 'REGISTER', '/avatar/09.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (11, 'normal10@163.com', 'normal08', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'WOMAN', 'REGISTER', '/avatar/10.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (12, 'normal11@163.com', 'normal09', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'ENABLE', 'MAN', 'REGISTER', '/avatar/11.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (13, 'normal12@163.com', 'normal10', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'UN_ACTIVATION', 'MAN', 'REGISTER', '/avatar/12.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');
INSERT INTO `forum_user` VALUES (14, 'normal13@163.com', 'normal11', '5243f205b7679b0f71bc4c7ffaa20224', 'USER', 'UN_ACTIVATION', 'MAN', 'REGISTER', '/avatar/13.jpg', '普通用户', 0x7B7D, '2021-11-18 13:23:04', 0, '2021-11-18 13:23:04', '2021-11-18 22:10:42');

-- ----------------------------
-- Table structure for forum_user_follow
-- ----------------------------
DROP TABLE IF EXISTS `forum_user_follow`;
CREATE TABLE `forum_user_follow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `followed` bigint(11) NOT NULL COMMENT '被关注主体',
  `followed_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '被关注主体类型',
  `follower` bigint(11) NOT NULL COMMENT '关注人',
  `is_delete` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_followed_follower`(`followed`, `followed_type`, `follower`) USING BTREE,
  INDEX `idx_follower`(`follower`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户关注表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_user_follow
-- ----------------------------
INSERT INTO `forum_user_follow` VALUES (1, 1, 'USER', 1, 0, '2021-11-18 14:09:43', '2021-11-18 22:09:42');
INSERT INTO `forum_user_follow` VALUES (2, 2, 'USER', 2, 0, '2021-11-18 14:24:32', '2021-11-18 22:24:31');
INSERT INTO `forum_user_follow` VALUES (3, 1, 'USER', 2, 0, '2021-11-18 14:24:38', '2021-11-18 22:24:38');
INSERT INTO `forum_user_follow` VALUES (4, 1, 'USER', 3, 0, '2021-11-18 14:25:26', '2021-11-18 22:25:26');
INSERT INTO `forum_user_follow` VALUES (5, 2, 'USER', 3, 0, '2021-11-18 14:25:28', '2021-11-18 22:25:27');
INSERT INTO `forum_user_follow` VALUES (6, 1, 'USER', 5, 0, '2021-11-18 14:25:57', '2021-11-18 22:25:56');
INSERT INTO `forum_user_follow` VALUES (7, 2, 'USER', 5, 0, '2021-11-18 14:26:02', '2021-11-18 22:26:02');
INSERT INTO `forum_user_follow` VALUES (8, 3, 'USER', 5, 0, '2021-11-18 14:26:07', '2021-11-18 22:26:06');
INSERT INTO `forum_user_follow` VALUES (9, 5, 'USER', 5, 0, '2021-11-18 14:26:16', '2021-11-18 22:26:15');
INSERT INTO `forum_user_follow` VALUES (10, 1, 'USER', 6, 0, '2021-11-18 14:27:17', '2021-11-18 22:27:17');
INSERT INTO `forum_user_follow` VALUES (11, 2, 'USER', 1, 0, '2021-11-18 14:27:17', '2021-11-18 22:27:17');
INSERT INTO `forum_user_follow` VALUES (12, 3, 'USER', 1, 0, '2021-11-18 14:27:17', '2021-11-18 22:27:17');
INSERT INTO `forum_user_follow` VALUES (13, 2, 'POSTS', 1, 0, '2021-11-18 15:07:39', '2021-11-18 23:07:39');
INSERT INTO `forum_user_follow` VALUES (14, 1, 'POSTS', 1, 0, '2021-11-18 15:20:45', '2021-11-18 23:20:44');
INSERT INTO `forum_user_follow` VALUES (15, 3, 'POSTS', 2, 0, '2021-11-18 17:08:41', '2021-11-19 01:08:40');
INSERT INTO `forum_user_follow` VALUES (16, 4, 'POSTS', 1, 0, '2021-11-18 17:14:06', '2021-11-19 01:14:05');
INSERT INTO `forum_user_follow` VALUES (17, 4, 'POSTS', 2, 0, '2021-11-18 17:14:41', '2021-11-19 01:14:41');
INSERT INTO `forum_user_follow` VALUES (19, 5, 'POSTS', 1, 0, '2021-11-18 17:20:13', '2021-11-19 01:20:13');
INSERT INTO `forum_user_follow` VALUES (20, 5, 'POSTS', 2, 0, '2021-11-18 17:20:15', '2021-11-19 01:20:15');
INSERT INTO `forum_user_follow` VALUES (21, 6, 'POSTS', 2, 0, '2021-11-18 17:25:11', '2021-11-19 01:25:10');
INSERT INTO `forum_user_follow` VALUES (22, 8, 'POSTS', 1, 0, '2021-11-18 17:36:32', '2021-11-19 01:36:31');
INSERT INTO `forum_user_follow` VALUES (23, 8, 'POSTS', 3, 0, '2021-11-18 17:37:47', '2021-11-19 01:37:47');
INSERT INTO `forum_user_follow` VALUES (24, 9, 'POSTS', 1, 0, '2021-11-18 17:40:25', '2021-11-19 01:40:25');

-- ----------------------------
-- Table structure for forum_user_food
-- ----------------------------
DROP TABLE IF EXISTS `forum_user_food`;
CREATE TABLE `forum_user_food`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint(11) NOT NULL COMMENT '用户ID',
  `posts_id` bigint(11) NOT NULL COMMENT '帖子ID',
  `is_delete` tinyint(2) UNSIGNED NOT NULL DEFAULT 0 COMMENT '删除标识（0:未删除、1:已删除）',
  `create_at` datetime(0) NOT NULL COMMENT '记录创建时间',
  `update_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '记录修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uniq_uid_pid`(`user_id`, `posts_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户关注表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of forum_user_food
-- ----------------------------
INSERT INTO `forum_user_food` VALUES (1, 1, 1, 0, '2021-11-18 14:40:18', '2021-11-18 14:40:18');
INSERT INTO `forum_user_food` VALUES (2, 1, 2, 0, '2021-11-18 15:06:46', '2021-11-18 15:06:46');
INSERT INTO `forum_user_food` VALUES (3, 2, 3, 0, '2021-11-18 17:08:41', '2021-11-18 17:08:41');
INSERT INTO `forum_user_food` VALUES (5, 1, 3, 0, '2021-11-18 17:09:44', '2021-11-18 17:09:44');
INSERT INTO `forum_user_food` VALUES (6, 1, 4, 0, '2021-11-18 17:14:06', '2021-11-18 17:14:06');
INSERT INTO `forum_user_food` VALUES (8, 2, 4, 0, '2021-11-18 17:14:38', '2021-11-18 17:14:38');
INSERT INTO `forum_user_food` VALUES (10, 1, 5, 0, '2021-11-18 17:19:44', '2021-11-18 17:19:44');
INSERT INTO `forum_user_food` VALUES (11, 2, 5, 0, '2021-11-18 17:20:00', '2021-11-18 17:20:00');
INSERT INTO `forum_user_food` VALUES (15, 2, 6, 0, '2021-11-18 17:25:11', '2021-11-18 17:25:11');
INSERT INTO `forum_user_food` VALUES (17, 1, 8, 0, '2021-11-18 17:36:32', '2021-11-18 17:36:32');
INSERT INTO `forum_user_food` VALUES (19, 3, 8, 0, '2021-11-18 17:37:46', '2021-11-18 17:37:46');
INSERT INTO `forum_user_food` VALUES (21, 1, 9, 0, '2021-11-18 17:40:25', '2021-11-18 17:40:25');

SET FOREIGN_KEY_CHECKS = 1;
