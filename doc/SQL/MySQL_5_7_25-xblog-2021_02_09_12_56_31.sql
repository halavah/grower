-- MySQL dump 10.13  Distrib 5.7.25, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: xblog
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
-- Table structure for table `m_category`
--

DROP TABLE IF EXISTS `m_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_category` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(512) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` text COLLATE utf8mb4_unicode_ci COMMENT '内容描述',
  `summary` text COLLATE utf8mb4_unicode_ci,
  `icon` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '图标',
  `post_count` int(11) unsigned DEFAULT '0' COMMENT '该分类的内容数量',
  `order_num` int(11) DEFAULT NULL COMMENT '排序编码',
  `parent_id` bigint(32) unsigned DEFAULT NULL COMMENT '父级分类的ID',
  `meta_keywords` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO关键字',
  `meta_description` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO描述内容',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_category`
--

LOCK TABLES `m_category` WRITE;
/*!40000 ALTER TABLE `m_category` DISABLE KEYS */;
INSERT INTO `m_category` (`id`, `name`, `content`, `summary`, `icon`, `post_count`, `order_num`, `parent_id`, `meta_keywords`, `meta_description`, `created`, `modified`, `status`) VALUES (1,'提问','提问内容内容内容',NULL,NULL,30,3,4,'提问SEO关键字','提问SEO元信息','2020-04-28 22:36:48','2021-01-05 23:27:56',0),(2,'分享','分享内容内容内容',NULL,NULL,10,1,2,'分享SEO关键字','分享SEO元信息','2020-04-28 22:36:48','2021-01-05 23:27:54',0),(3,'讨论','讨论内容内容内容',NULL,NULL,40,4,1,'讨论SEO关键字','讨论SEO元信息','2020-04-28 22:36:48','2021-01-05 23:27:57',0),(4,'建议','建议内容内容内容',NULL,NULL,20,2,3,'建议SEO关键字','建议SEO元信息','2020-04-28 22:36:48','2021-01-05 23:27:55',0);
/*!40000 ALTER TABLE `m_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_comment`
--

DROP TABLE IF EXISTS `m_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_comment` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论的内容',
  `parent_id` bigint(32) DEFAULT NULL COMMENT '回复的评论ID',
  `post_id` bigint(32) NOT NULL COMMENT '评论的内容ID',
  `user_id` bigint(32) NOT NULL COMMENT '评论的用户ID',
  `vote_up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '“顶”的数量',
  `vote_down` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '“踩”的数量',
  `level` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '置顶等级',
  `status` tinyint(2) DEFAULT NULL COMMENT '评论的状态',
  `created` datetime NOT NULL COMMENT '评论的时间',
  `modified` datetime DEFAULT NULL COMMENT '评论的更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_comment`
--

LOCK TABLES `m_comment` WRITE;
/*!40000 ALTER TABLE `m_comment` DISABLE KEYS */;
INSERT INTO `m_comment` (`id`, `content`, `parent_id`, `post_id`, `user_id`, `vote_up`, `vote_down`, `level`, `status`, `created`, `modified`) VALUES (1,'评论1评论1评论1评论1评论1评论1',1,1,1,10,11,1,0,'2021-02-05 10:57:53','2021-02-05 10:57:53'),(2,'评论2评论2评论2评论2评论2评论2',2,2,1,20,22,0,1,'2021-02-06 10:57:53','2021-02-06 10:57:53'),(3,'评论3评论3评论3评论3评论3评论3',3,3,2,30,33,1,0,'2021-02-07 10:57:53','2021-02-07 10:57:53'),(4,'评论4评论4评论4评论4评论4评论4',4,4,2,40,44,0,1,'2021-02-08 10:57:53','2021-02-08 10:57:53'),(5,'评论5评论5评论5评论5评论5评论5',1,5,3,50,55,1,0,'2021-02-05 10:57:53','2021-02-05 10:57:53'),(6,'评论6评论6评论6评论6评论6评论6',2,6,3,60,66,0,1,'2021-02-06 10:57:53','2021-02-06 10:57:53'),(7,'评论7评论7评论7评论7评论7评论7',3,7,4,70,77,1,0,'2021-02-07 10:57:53','2021-02-07 10:57:53'),(8,'评论8评论8评论8评论8评论8评论8',4,8,4,80,88,0,1,'2021-02-08 10:57:53','2021-02-08 10:57:53'),(9,'评论9评论9评论9评论9评论9评论9',1,9,4,10,11,1,0,'2021-02-05 10:57:53','2021-02-05 10:57:53'),(10,'评论10评论10评论10评论10评论10',2,10,4,20,22,0,1,'2021-02-06 10:57:53','2021-02-06 10:57:53'),(11,'评论11评论11评论11评论11评论11',3,11,3,30,33,1,0,'2021-02-07 10:57:53','2021-02-07 10:57:53'),(12,'评论12评论12评论12评论12评论12',4,12,3,40,44,0,1,'2021-02-08 10:57:53','2021-02-08 10:57:53'),(13,'评论13评论13评论13评论13评论13',1,13,2,50,55,1,0,'2021-02-05 10:57:53','2021-02-05 10:57:53'),(14,'评论14评论14评论14评论14评论14',2,14,2,60,66,0,1,'2021-02-06 10:57:53','2021-02-06 10:57:53'),(15,'评论15评论15评论15评论15评论15',3,15,1,70,77,1,0,'2021-02-07 10:57:53','2021-02-07 10:57:53'),(16,'评论16评论16评论16评论16评论16',4,16,1,80,88,0,1,'2021-02-08 10:57:53','2021-02-08 10:57:53'),(17,'评论17评论17评论17评论17评论17',1,1,1,10,11,1,0,'2021-02-05 10:57:53','2021-02-05 10:57:53'),(18,'评论18评论18评论18评论18评论18',2,2,1,20,22,0,1,'2021-02-06 10:57:53','2021-02-06 10:57:53'),(19,'评论19评论19评论19评论19评论19',3,3,2,30,33,1,0,'2021-02-07 10:57:53','2021-02-07 10:57:53'),(20,'评论20评论20评论20评论20评论20',4,4,2,40,44,0,1,'2021-02-08 10:57:53','2021-02-08 10:57:53'),(21,'评论21评论21评论21评论21评论21',1,5,3,50,55,1,0,'2021-02-05 10:57:53','2021-02-05 10:57:53'),(22,'评论22评论22评论22评论22评论22',2,6,3,60,66,0,1,'2021-02-06 10:57:53','2021-02-06 10:57:53'),(23,'评论23评论23评论23评论23评论23',3,7,4,70,77,1,0,'2021-02-07 10:57:53','2021-02-07 10:57:53'),(24,'评论24评论24评论24评论24评论24',4,8,4,80,88,0,1,'2021-02-08 10:57:53','2021-02-08 10:57:53');
/*!40000 ALTER TABLE `m_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_post`
--

DROP TABLE IF EXISTS `m_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_post` (
  `id` bigint(32) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '标题',
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `edit_mode` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '编辑模式：html可视化，markdown ..',
  `category_id` bigint(32) DEFAULT NULL,
  `user_id` bigint(32) DEFAULT NULL COMMENT '用户ID',
  `vote_up` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '支持人数',
  `vote_down` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '反对人数',
  `view_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '访问量',
  `comment_count` int(11) NOT NULL DEFAULT '0' COMMENT '评论数量',
  `recommend` tinyint(1) DEFAULT NULL COMMENT '是否为精华',
  `level` tinyint(2) NOT NULL DEFAULT '0' COMMENT '置顶等级',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态',
  `created` datetime DEFAULT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '最后更新日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_post`
--

LOCK TABLES `m_post` WRITE;
/*!40000 ALTER TABLE `m_post` DISABLE KEYS */;
INSERT INTO `m_post` (`id`, `title`, `content`, `edit_mode`, `category_id`, `user_id`, `vote_up`, `vote_down`, `view_count`, `comment_count`, `recommend`, `level`, `status`, `created`, `modified`) VALUES (1,'文章1','文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1文章1','1',1,2,10,1,11,2,0,1,1,'2021-02-01 11:05:46','2021-02-01 11:05:46'),(2,'文章2','文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2文章2','1',1,2,20,2,22,2,1,0,1,'2021-02-02 11:05:46','2021-02-02 11:05:46'),(3,'文章3','文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3文章3','1',2,3,30,3,33,2,0,1,1,'2021-02-03 11:05:46','2021-02-03 11:05:46'),(4,'文章4','文章4文章4文章4文章4文章4文章4文章4文章4文章4文章4文章4文章4','1',2,3,40,4,44,2,1,0,1,'2021-02-04 11:05:46','2021-02-04 11:05:46'),(5,'文章5','文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5文章5','1',3,4,50,5,55,2,0,1,1,'2021-02-05 11:05:46','2021-02-05 11:05:46'),(6,'文章6','文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6文章6','1',3,4,60,6,66,2,1,0,1,'2021-02-06 11:05:46','2021-02-06 11:05:46'),(7,'文章7','文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7文章7','1',4,1,70,7,77,2,0,1,1,'2021-02-07 11:05:46','2021-02-07 11:05:46'),(8,'文章8','文章8文章8文章8文章8文章8文章8文章8文章8文章8文章8文章8文章8','1',4,1,80,8,105,2,1,0,1,'2021-02-08 11:05:46','2021-02-08 11:05:46'),(9,'文章9','文章9文章9文章9文章9文章9文章9文章9文章9文章9','1',4,3,10,1,11,1,0,1,1,'2021-02-01 11:05:46','2021-02-01 11:05:46'),(10,'文章10','文章10文章10文章10文章10文章10文章10文章10','1',4,3,20,2,22,1,1,0,1,'2021-02-02 11:05:46','2021-02-02 11:05:46'),(11,'文章11','文章11文章11文章11文章11文章11文章11文章11','1',3,2,30,3,33,1,0,1,1,'2021-02-03 11:05:46','2021-02-03 11:05:46'),(12,'文章12','文章12文章12文章12文章12文章12文章12文章12','1',3,2,40,4,44,1,1,0,1,'2021-02-04 11:05:46','2021-02-04 11:05:46'),(13,'文章13','文章13文章13文章13文章13文章13文章13文章13','1',2,1,50,5,55,1,0,1,1,'2021-02-05 11:05:46','2021-02-05 11:05:46'),(14,'文章14','文章14文章14文章14文章14文章14文章14文章14','1',2,1,60,6,66,1,1,0,1,'2021-02-06 11:05:46','2021-02-06 11:05:46'),(15,'文章15','文章15文章15文章15文章15文章15文章15文章15','1',1,4,70,7,77,1,0,1,1,'2021-02-07 11:05:46','2021-02-07 11:05:46'),(16,'文章16','文章16文章16文章16文章16文章16文章16文章16','1',1,4,80,8,95,1,1,0,1,'2021-02-08 11:05:46','2021-02-08 11:05:46');
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
  `username` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '昵称',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '密码',
  `email` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '邮件',
  `mobile` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '手机电话',
  `point` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '积分',
  `sign` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个性签名',
  `gender` varchar(16) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '性别',
  `wechat` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '微信号',
  `vip_level` int(32) DEFAULT NULL COMMENT 'vip等级',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `avatar` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '头像',
  `post_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '内容数量',
  `comment_count` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `lasted` datetime DEFAULT NULL COMMENT '最后的登陆时间',
  `created` datetime NOT NULL COMMENT '创建日期',
  `modified` datetime DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_user`
--

LOCK TABLES `m_user` WRITE;
/*!40000 ALTER TABLE `m_user` DISABLE KEYS */;
INSERT INTO `m_user` (`id`, `username`, `password`, `email`, `mobile`, `point`, `sign`, `gender`, `wechat`, `vip_level`, `birthday`, `avatar`, `post_count`, `comment_count`, `status`, `lasted`, `created`, `modified`) VALUES (1,'admin','96e79218965eb72c92a549dd5a330112','11111@qq.com','13599998888',100,'勿因喜而轻诺！','1','visions',0,'2020-12-09 12:23:27','/res/images/avatar/default.png',20,2,0,'2020-12-04 12:17:31','2020-04-28 14:37:24','2020-12-08 12:25:11'),(2,'test01','96e79218965eb72c92a549dd5a330112','22222@qq.com','13599998888',200,'勿因喜而轻诺！','0','visions',1,'2020-12-08 12:23:34','/res/images/avatar/1.jpg',30,3,0,'2020-12-08 12:24:22','2020-04-28 14:45:07','2020-12-08 12:25:12'),(3,'test02','96e79218965eb72c92a549dd5a330112','33333@qq.com','13599998888',300,'勿因喜而轻诺！','1','visions',0,'2020-12-08 12:23:36','/res/images/avatar/2.jpg',40,4,1,'2020-12-08 12:24:23','2020-04-28 14:48:26','2020-12-08 12:25:13'),(4,'test03','96e79218965eb72c92a549dd5a330112','44444@qq.com','13599998888',400,'勿因喜而轻诺！','0','visions',1,'2020-12-08 12:23:37','/res/images/avatar/3.jpg',50,5,0,'2020-12-08 12:24:25','2020-04-28 14:48:26','2020-12-08 12:25:14'),(5,'test04','96e79218965eb72c92a549dd5a330112','55555@qq.com','13599998888',500,'勿因喜而轻诺！','1','visions',0,'2020-12-08 12:23:37','/res/images/avatar/4.jpg',60,6,0,'2020-12-08 12:24:26','2020-04-28 14:53:49','2020-12-08 12:25:15');
/*!40000 ALTER TABLE `m_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_user_action`
--

DROP TABLE IF EXISTS `m_user_action`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_user_action` (
  `id` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `user_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户ID',
  `action` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '动作类型',
  `point` int(11) DEFAULT NULL COMMENT '得分',
  `post_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联的帖子ID',
  `comment_id` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '关联的评论ID',
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_user_action`
--

LOCK TABLES `m_user_action` WRITE;
/*!40000 ALTER TABLE `m_user_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_user_action` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_user_collection`
--

DROP TABLE IF EXISTS `m_user_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_user_collection` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `post_id` bigint(20) NOT NULL,
  `post_user_id` bigint(20) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_user_collection`
--

LOCK TABLES `m_user_collection` WRITE;
/*!40000 ALTER TABLE `m_user_collection` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_user_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `m_user_message`
--

DROP TABLE IF EXISTS `m_user_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `m_user_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `from_user_id` bigint(20) NOT NULL COMMENT '发送消息的用户ID',
  `to_user_id` bigint(20) NOT NULL COMMENT '接收消息的用户ID',
  `post_id` bigint(20) DEFAULT NULL COMMENT '消息可能关联的帖子',
  `comment_id` bigint(20) DEFAULT NULL COMMENT '消息可能关联的评论',
  `content` text COLLATE utf8mb4_unicode_ci,
  `type` tinyint(2) DEFAULT NULL COMMENT '消息类型',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `m_user_message`
--

LOCK TABLES `m_user_message` WRITE;
/*!40000 ALTER TABLE `m_user_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `m_user_message` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-02-09 12:56:31
