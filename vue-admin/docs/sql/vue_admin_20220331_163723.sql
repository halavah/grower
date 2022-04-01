/*
 Navicat Premium Data Transfer

 Source Server         : MySQL-5.7.25
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : vue_admin

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 31/03/2022 16:37:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint(32) NULL DEFAULT NULL COMMENT '菜单的【上级菜单】：0代表父菜单，1开始依次代表子菜单',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单的【标题】',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单的【名称】',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单的【路径】',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单的【图标】',
  `perms` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单的【权限】',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单的【组件】',
  `sorted` tinyint(2) NULL DEFAULT NULL COMMENT '菜单的【排列】：1代表first、2代表second',
  `type` tinyint(2) NULL DEFAULT NULL COMMENT '菜单的【类型】：0代表目录、1代表菜单、2代表按钮',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '菜单的【状态】：0代表正常、1代表禁用',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '菜单的【创建日期】',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '菜单的【更新日期】',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', 'SysManage', NULL, 'el-icon-s-operation', 'sys:manage', NULL, 2, 0, NULL, '2021-01-15 19:03:45', '2021-01-15 19:03:45');
INSERT INTO `sys_menu` VALUES (2, 1, '用户管理', 'SysUser', '/sys/users', 'el-icon-s-custom', 'sys:user:list', 'sys/User', 1, 1, 0, '2021-01-15 19:03:45', '2021-01-15 19:03:45');
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', 'SysRole', '/sys/roles', 'el-icon-rank', 'sys:role:list', 'sys/Role', 2, 1, 0, '2021-01-15 19:03:45', '2021-01-15 19:03:45');
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', 'SysMenu', '/sys/menus', 'el-icon-menu', 'sys:menu:list', 'sys/Menu', 3, 1, 0, '2021-01-15 19:03:45', '2021-01-15 19:03:45');
INSERT INTO `sys_menu` VALUES (5, 0, '系统工具', 'SysTools', '', 'el-icon-s-tools', 'sys:tools', NULL, 2, 0, 0, '2021-01-15 19:06:11', '2021-01-15 19:06:11');
INSERT INTO `sys_menu` VALUES (6, 5, '数字字典', 'SysDicts', '/sys/dicts', 'el-icon-s-order', 'sys:dict:list', 'sys/Dict', 1, 1, 0, '2021-01-15 19:07:18', '2021-01-15 19:07:18');
INSERT INTO `sys_menu` VALUES (7, 3, '添加角色', 'SysRoleSave', '', '', 'sys:role:save', '', 1, 2, 0, '2021-01-15 23:02:25', '2021-01-15 23:02:25');
INSERT INTO `sys_menu` VALUES (9, 2, '添加用户', 'SysUserSave', NULL, NULL, 'sys:user:save', NULL, 1, 2, 0, '2021-01-17 21:48:32', '2021-01-17 21:48:32');
INSERT INTO `sys_menu` VALUES (10, 2, '修改用户', 'SysUserUpdate', NULL, NULL, 'sys:user:update', NULL, 2, 2, 0, '2021-01-17 21:49:03', '2021-01-17 21:49:03');
INSERT INTO `sys_menu` VALUES (11, 2, '删除用户', 'SysUserDelete', NULL, NULL, 'sys:user:delete', NULL, 3, 2, 0, '2021-01-17 21:49:21', '2021-01-17 21:49:21');
INSERT INTO `sys_menu` VALUES (12, 2, '分配角色', 'SysUserRole', NULL, NULL, 'sys:user:role', NULL, 4, 2, 0, '2021-01-17 21:49:58', '2021-01-17 21:49:58');
INSERT INTO `sys_menu` VALUES (13, 2, '重置密码', 'SysUserRepass', NULL, NULL, 'sys:user:repass', NULL, 5, 2, 0, '2021-01-17 21:50:36', '2021-01-17 21:50:36');
INSERT INTO `sys_menu` VALUES (14, 3, '修改角色', 'SysRoleUpdate', NULL, NULL, 'sys:role:update', NULL, 2, 2, 0, '2021-01-17 21:51:14', '2021-01-17 21:51:14');
INSERT INTO `sys_menu` VALUES (15, 3, '删除角色', 'SysRoleDelete', NULL, NULL, 'sys:role:delete', NULL, 3, 2, 0, '2021-01-17 21:51:39', '2021-01-17 21:51:39');
INSERT INTO `sys_menu` VALUES (16, 3, '分配权限', 'SysRolePerm', NULL, NULL, 'sys:role:perm', NULL, 5, 2, 0, '2021-01-17 21:52:02', '2021-01-17 21:52:02');
INSERT INTO `sys_menu` VALUES (17, 4, '添加菜单', 'SysMenuSave', NULL, NULL, 'sys:menu:save', NULL, 1, 2, 0, '2021-01-17 21:53:53', '2021-01-17 21:53:53');
INSERT INTO `sys_menu` VALUES (18, 4, '修改菜单', 'SysMenuUpdate', NULL, NULL, 'sys:menu:update', NULL, 2, 2, 0, '2021-01-17 21:56:12', '2021-01-17 21:56:12');
INSERT INTO `sys_menu` VALUES (19, 4, '删除菜单', 'SysMenuDelete', NULL, NULL, 'sys:menu:delete', NULL, 3, 2, 0, '2021-01-17 21:56:36', '2021-01-17 21:56:36');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色的【名称】',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色的【编码】',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '角色的【描述】',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '角色的【状态】：0代表正常、1代表禁用',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '角色的【更新日期】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '角色的【创建日期】',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', '系统默认最高权限，不可以编辑和任意修改', 0, '2021-01-17 15:50:45', '2021-01-16 13:29:03');
INSERT INTO `sys_role` VALUES (2, '普通用户', 'normal', '只有基本查看功能', 0, '2021-01-30 08:19:52', '2021-01-04 10:09:14');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` bigint(32) NOT NULL COMMENT '角色-菜单【角色ID】',
  `menu_id` bigint(32) NOT NULL COMMENT '角色-菜单【菜单ID】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 102 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '角色_菜单' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (60, 1, 1);
INSERT INTO `sys_role_menu` VALUES (61, 1, 2);
INSERT INTO `sys_role_menu` VALUES (62, 1, 9);
INSERT INTO `sys_role_menu` VALUES (63, 1, 10);
INSERT INTO `sys_role_menu` VALUES (64, 1, 11);
INSERT INTO `sys_role_menu` VALUES (65, 1, 12);
INSERT INTO `sys_role_menu` VALUES (66, 1, 13);
INSERT INTO `sys_role_menu` VALUES (67, 1, 3);
INSERT INTO `sys_role_menu` VALUES (68, 1, 7);
INSERT INTO `sys_role_menu` VALUES (69, 1, 14);
INSERT INTO `sys_role_menu` VALUES (70, 2, 15);
INSERT INTO `sys_role_menu` VALUES (71, 2, 16);
INSERT INTO `sys_role_menu` VALUES (72, 2, 4);
INSERT INTO `sys_role_menu` VALUES (73, 2, 17);
INSERT INTO `sys_role_menu` VALUES (74, 2, 18);
INSERT INTO `sys_role_menu` VALUES (75, 1, 19);
INSERT INTO `sys_role_menu` VALUES (76, 1, 5);
INSERT INTO `sys_role_menu` VALUES (77, 1, 6);
INSERT INTO `sys_role_menu` VALUES (96, 1, 1);
INSERT INTO `sys_role_menu` VALUES (97, 1, 2);
INSERT INTO `sys_role_menu` VALUES (98, 1, 3);
INSERT INTO `sys_role_menu` VALUES (99, 1, 4);
INSERT INTO `sys_role_menu` VALUES (100, 1, 5);
INSERT INTO `sys_role_menu` VALUES (101, 1, 6);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【昵称】',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【密码】',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【邮件】',
  `mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【手机】',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户的【头像】',
  `status` tinyint(2) NULL DEFAULT NULL COMMENT '用户的【状态】：0代表登录成功、-1代表登录失败',
  `modified` datetime(0) NULL DEFAULT NULL COMMENT '用户的【更新日期】',
  `created` datetime(0) NULL DEFAULT NULL COMMENT '用户的【创建日期】',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `UK_USERNAME`(`username`) USING BTREE,
  UNIQUE INDEX `sys_user_email_uindex`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '$2a$10$Z//8tuBx0QnjNio1gYmbV.S4CHjVna3TVic4CudT21WqZACZrvcD6', '123456@qq.com', '12345678901', 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg', 0, '2021-01-16 16:57:32', '2021-01-12 22:13:53');
INSERT INTO `sys_user` VALUES (2, 'test02', '$2a$10$Z//8tuBx0QnjNio1gYmbV.S4CHjVna3TVic4CudT21WqZACZrvcD6', '159263@qq.com', '12345678901', 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg', 0, '2021-01-30 08:55:57', '2021-01-30 08:20:22');
INSERT INTO `sys_user` VALUES (3, 'test03', '$2a$10$Z//8tuBx0QnjNio1gYmbV.S4CHjVna3TVic4CudT21WqZACZrvcD6', '123457@qq.com', '15926347996', 'https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg', 0, '2021-01-30 08:55:57', '2021-01-30 08:20:22');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(32) NOT NULL COMMENT '用户-角色【用户ID】',
  `role_id` bigint(32) NOT NULL COMMENT '用户-角色【角色ID】',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户_角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1);
INSERT INTO `sys_user_role` VALUES (2, 1, 2);
INSERT INTO `sys_user_role` VALUES (3, 2, 3);
INSERT INTO `sys_user_role` VALUES (4, 2, 3);

SET FOREIGN_KEY_CHECKS = 1;
