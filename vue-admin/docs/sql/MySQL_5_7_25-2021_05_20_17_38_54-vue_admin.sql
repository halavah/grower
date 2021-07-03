-- MySQL dump 10.13  Distrib 5.7.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: vue_admin
-- ------------------------------------------------------
-- Server version	5.7.25

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES UTF8MB4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `sys_menu`
--

DROP TABLE IF EXISTS `sys_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menu` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `parent_id` bigint(32) DEFAULT NULL COMMENT '菜单的【上级菜单】：0代表父菜单，1开始依次代表子菜单',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单的【标题】',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单的【名称】',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单的【路径】',
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单的【图标】',
  `perms` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单的【权限】',
  `component` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单的【组件】',
  `sorted` tinyint(2) DEFAULT NULL COMMENT '菜单的【排列】：1代表first、2代表second',
  `type` tinyint(2) DEFAULT NULL COMMENT '菜单的【类型】：0代表目录、1代表菜单、2代表按钮',
  `status` tinyint(2) DEFAULT NULL COMMENT '菜单的【状态】：0代表正常、1代表禁用',
  `created` datetime DEFAULT NULL COMMENT '菜单的【创建日期】',
  `modified` datetime DEFAULT NULL COMMENT '菜单的【更新日期】',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menu`
--

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;
INSERT INTO `sys_menu` VALUES (1,0,'系统管理','SysManage','','el-icon-s-operation','sys:manage','',1,0,0,'2021-01-15 18:58:18','2021-01-15 18:58:18'),(2,1,'用户管理','SysUser','/sys/users','el-icon-s-custom','sys:user:list','sys/User',1,1,0,'2021-01-15 19:03:45','2021-01-15 19:03:45'),(3,1,'角色管理','SysRole','/sys/roles','el-icon-rank','sys:role:list','sys/Role',2,1,0,'2021-01-15 19:03:45','2021-01-15 19:03:45'),(4,1,'菜单管理','SysMenu','/sys/menus','el-icon-menu','sys:menu:list','sys/Menu',3,1,0,'2021-01-15 19:03:45','2021-01-15 19:03:45'),(5,0,'系统工具','SysTools','','el-icon-s-tools','sys:tools',NULL,2,0,0,'2021-01-15 19:06:11','2021-01-15 19:06:11'),(6,5,'数字字典','SysDicts','/sys/dicts','el-icon-s-order','sys:dict:list','sys/Dict',1,1,0,'2021-01-15 19:07:18','2021-01-15 19:07:18'),(7,3,'添加角色','SysRoleSave','','','sys:role:save','',1,2,0,'2021-01-15 23:02:25','2021-01-15 23:02:25'),(9,2,'添加用户','SysUserSave',NULL,NULL,'sys:user:save',NULL,1,2,0,'2021-01-17 21:48:32','2021-01-17 21:48:32'),(10,2,'修改用户','SysUserUpdate',NULL,NULL,'sys:user:update',NULL,2,2,0,'2021-01-17 21:49:03','2021-01-17 21:49:03'),(11,2,'删除用户','SysUserDelete',NULL,NULL,'sys:user:delete',NULL,3,2,0,'2021-01-17 21:49:21','2021-01-17 21:49:21'),(12,2,'分配角色','SysUserRole',NULL,NULL,'sys:user:role',NULL,4,2,0,'2021-01-17 21:49:58','2021-01-17 21:49:58'),(13,2,'重置密码','SysUserRepass',NULL,NULL,'sys:user:repass',NULL,5,2,0,'2021-01-17 21:50:36','2021-01-17 21:50:36'),(14,3,'修改角色','SysRoleUpdate',NULL,NULL,'sys:role:update',NULL,2,2,0,'2021-01-17 21:51:14','2021-01-17 21:51:14'),(15,3,'删除角色','SysRoleDelete',NULL,NULL,'sys:role:delete',NULL,3,2,0,'2021-01-17 21:51:39','2021-01-17 21:51:39'),(16,3,'分配权限','SysRolePerm',NULL,NULL,'sys:role:perm',NULL,5,2,0,'2021-01-17 21:52:02','2021-01-17 21:52:02'),(17,4,'添加菜单','SysMenuSave',NULL,NULL,'sys:menu:save',NULL,1,2,0,'2021-01-17 21:53:53','2021-01-17 21:53:53'),(18,4,'修改菜单','SysMenuUpdate',NULL,NULL,'sys:menu:update',NULL,2,2,0,'2021-01-17 21:56:12','2021-01-17 21:56:12'),(19,4,'删除菜单','SysMenuDelete',NULL,NULL,'sys:menu:delete',NULL,3,2,0,'2021-01-17 21:56:36','2021-01-17 21:56:36');
/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role`
--

DROP TABLE IF EXISTS `sys_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色的【名称】',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '角色的【编码】',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色的【描述】',
  `status` tinyint(2) DEFAULT NULL COMMENT '角色的【状态】：0代表正常、1代表禁用',
  `modified` datetime DEFAULT NULL COMMENT '角色的【更新日期】',
  `created` datetime DEFAULT NULL COMMENT '角色的【创建日期】',
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role`
--

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;
INSERT INTO `sys_role` VALUES (1,'超级管理员','admin','系统默认最高权限，不可以编辑和任意修改',0,'2021-01-17 15:50:45','2021-01-16 13:29:03'),(2,'普通用户','normal','只有基本查看功能',0,'2021-01-30 08:19:52','2021-01-04 10:09:14');
/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_role_menu`
--

DROP TABLE IF EXISTS `sys_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_role_menu` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_id` bigint(32) NOT NULL COMMENT '角色-菜单【角色ID】',
  `menu_id` bigint(32) NOT NULL COMMENT '角色-菜单【菜单ID】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='角色_菜单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_role_menu`
--

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;
INSERT INTO `sys_role_menu` VALUES (60,6,1),(61,6,2),(62,6,9),(63,6,10),(64,6,11),(65,6,12),(66,6,13),(67,6,3),(68,6,7),(69,6,14),(70,6,15),(71,6,16),(72,6,4),(73,6,17),(74,6,18),(75,6,19),(76,6,5),(77,6,6),(96,3,1),(97,3,2),(98,3,3),(99,3,4),(100,3,5),(101,3,6);
/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user`
--

DROP TABLE IF EXISTS `sys_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【昵称】',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【密码】',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的【邮件】',
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的【手机】',
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的【头像】',
  `status` tinyint(2) DEFAULT NULL COMMENT '用户的【状态】：0代表登录成功、-1代表登录失败',
  `modified` datetime DEFAULT NULL COMMENT '用户的【更新日期】',
  `created` datetime DEFAULT NULL COMMENT '用户的【创建日期】',
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_USERNAME` (`username`),
  UNIQUE KEY `sys_user_email_uindex` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user`
--

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;
INSERT INTO `sys_user` VALUES (1,'admin','$2a$10$R7zegeWzOXPw871CmNuJ6upC0v8D373GuLuTw8jn6NET4BkPRZfgK','123456@qq.com','12345678901','https://raw.githubusercontent.com/halavah/PinGo/master/avatar/01.jpg',0,'2021-01-16 16:57:32','2021-01-12 22:13:53'),(2,'test02','$2a$10$0ilP4ZD1kLugYwLCs4pmb.ZT9cFqzOZTNaMiHxrBnVIQUGUwEvBIO','159263@qq.com','12345678901','https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',0,'2021-01-30 08:55:57','2021-01-30 08:20:22');
/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_user_role`
--

DROP TABLE IF EXISTS `sys_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_user_role` (
  `id` int(64) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(32) NOT NULL COMMENT '用户-角色【用户ID】',
  `role_id` bigint(32) NOT NULL COMMENT '用户-角色【角色ID】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户_角色';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_user_role`
--

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;
INSERT INTO `sys_user_role` VALUES (4,1,6),(7,1,3),(13,2,3);
/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-20 17:38:54
