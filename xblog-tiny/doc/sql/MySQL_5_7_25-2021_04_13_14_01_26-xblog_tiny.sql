-- MySQL dump 10.13  Distrib 5.7.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: xblog_tiny
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
-- Table structure for table `m_post`
--

DROP TABLE IF EXISTS `m_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_post` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint(32) DEFAULT NULL COMMENT '文章的【用户ID】',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【标题】',
  `description` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【描述】',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章的【内容】',
  `status` tinyint(2) DEFAULT NULL COMMENT '文章的【状态】',
  `created` datetime DEFAULT NULL COMMENT '文章的【创建日期】',
  `modified` datetime DEFAULT NULL COMMENT '文章的【更新日期】',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户文章';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_post`
--

LOCK TABLES `m_post` WRITE;
/*!40000 ALTER TABLE `m_post` DISABLE KEYS */;
INSERT INTO `m_post` (`id`, `user_id`, `title`, `description`, `content`, `status`, `created`, `modified`) VALUES (1,1,'文章1文章1文章1文章1','描述1描述1描述1描述1','内容1内容1内容1内容1内容1',0,'2021-04-06 13:27:57','2021-04-06 13:27:57'),(2,1,'文章2文章2文章2文章2','描述2描述2描述2描述2','内容2内容2内容2内容2内容2',0,'2021-04-07 20:49:51','2021-04-07 20:49:51'),(3,1,'文章3文章3文章3文章3','描述3描述3描述3描述3','内容3内容3内容3内容3内容3',0,'2021-04-08 20:49:51','2021-04-08 20:49:51'),(4,1,'文章4文章4文章4文章4','描述4描述4描述4描述4','内容4内容4内容4内容4内容4',0,'2021-04-09 13:51:40','2021-04-09 13:51:40'),(5,1,'文章5文章5文章5文章5','描述5描述5描述5描述5','内容5内容5内容5内容5内容5',0,'2021-04-10 15:25:18','2021-04-10 15:25:18'),(6,1,'文章6文章6文章6文章6','描述6描述6描述6描述6','内容6内容6内容6内容6内容6',0,'2021-04-11 06:50:56','2021-04-11 06:50:56'),(7,1,'文章7文章7文章7文章7','描述7描述7描述7描述7','内容7内容7内容7内容7内容7',0,'2021-04-12 06:50:59','2021-04-12 06:50:59'),(8,1,'文章8文章8文章8文章8','描述8描述8描述8描述8','内容8内容8内容8内容8内容8',0,'2021-04-13 01:25:06','2021-04-13 01:25:06'),(9,1,'文章9文章9文章9文章9','描述9描述9描述9描述9','内容9内容9内容9内容9内容9',0,'2021-04-14 01:25:06','2021-04-14 01:25:06'),(10,1,'文章10文章10文章10','描述10描述10描述10','内容10内容10内容10内容10',0,'2021-04-15 01:25:06','2021-04-15 01:25:06'),(11,1,'文章11文章11文章11','描述11描述11描述11','内容11内容11内容11内容11',0,'2021-04-16 01:25:06','2021-04-16 01:25:06'),(12,1,'文章12文章12文章12','描述12描述12描述12','内容12内容12内容12内容12',0,'2021-04-17 01:25:06','2021-04-17 01:25:06'),(15,1,'md文档md文档md文档','md文档md文档md文档','### 介绍\n练习项目：前后端分离的博客\n\n### 软件架构\n- `springmvc` ：网页开发\n- `mybatis-plus、druid、mysql、mp-generator、p6spy、freemarker` ：数据库\n- `shiro、jwt` ：身份验证、会话管理\n- `lombok、hutool、commons` ：工具类\n- `devtools、test` ：热部署、单元测试\n\n### 项目文档\n\n\n### 使用说明\n- 访问网址：http://localhost:8080/\n- 测试账户：11111@qq.com\n- 测试密码：123456',0,'2021-04-13 05:15:26','2021-04-13 05:15:26');
/*!40000 ALTER TABLE `m_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_user`
--

DROP TABLE IF EXISTS `m_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_user` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `username` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【昵称】',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【密码】',
  `email` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的【邮件】',
  `gender` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户的【性别】:0代表男，1代表女',
  `avatar` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户的【头像】',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '用户的【状态】:0代表登录成功，-1代表登录失败',
  `lasted` datetime DEFAULT NULL COMMENT '用户的【近期登陆日期】',
  `created` datetime NOT NULL COMMENT '用户的【创建日期】',
  `modified` datetime DEFAULT NULL COMMENT '用户的【更新日期】',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_user`
--

LOCK TABLES `m_user` WRITE;
/*!40000 ALTER TABLE `m_user` DISABLE KEYS */;
INSERT INTO `m_user` (`id`, `username`, `password`, `email`, `gender`, `avatar`, `status`, `lasted`, `created`, `modified`) VALUES (1,'admin','e10adc3949ba59abbe56e057f20f883e','11111@qq.com','0','https://raw.githubusercontent.com/halavah/PinGo/master/avatar/02.jpg',0,'2021-03-31 15:35:51','2021-03-31 15:35:53','2021-03-31 15:36:00');
/*!40000 ALTER TABLE `m_user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-04-13 14:01:26
