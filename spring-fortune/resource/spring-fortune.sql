/*
SQLyog Ultimate v11.11 (64 bit)
MySQL - 5.5.47-MariaDB : Database - spring-fortune
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`spring-fortune` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `spring-fortune`;

/*Table structure for table `bill` */

DROP TABLE IF EXISTS `bill`;

CREATE TABLE `bill` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LOCATION_NUMBER` varchar(50) DEFAULT NULL COMMENT '位置编号',
  `BILL_NUMBER` varchar(50) DEFAULT NULL COMMENT '账单编号',
  `STATUS` int(11) NOT NULL DEFAULT '1' COMMENT '状态1：未付 2：已付 9：删除',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `RECEIVE_TIME` datetime DEFAULT NULL COMMENT '收款时间',
  `RECEIVE_LONGIN_NAME` varchar(50) DEFAULT NULL COMMENT '收款人登录名',
  `AR_MONEY` decimal(18,2) DEFAULT NULL COMMENT '应收金额',
  `PAY_MONEY` decimal(18,2) DEFAULT '0.00' COMMENT '实收金额',
  `CREATOR` varchar(50) DEFAULT NULL COMMENT '创建人',
  `RECEIVE_NAME` varchar(50) DEFAULT NULL COMMENT '收款人',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '用户备注',
  `TYPE` int(11) DEFAULT NULL COMMENT '类型1:店内用餐 2：预约 3：外卖',
  `RECEIVE_TYPE` int(11) DEFAULT NULL COMMENT '收款类型1:现金 2：支付宝 3：微信 4：百付宝 5其它',
  `RECEIVE_WAY` int(11) DEFAULT NULL COMMENT '收款方式1:手动 2：系统',
  `USER_NUM` int(11) DEFAULT '0' COMMENT '用餐人数0:未输入',
  `BILL_MEMO` varchar(200) DEFAULT NULL COMMENT '收单备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `bill` */

insert  into `bill`(`ID`,`LOCATION_NUMBER`,`BILL_NUMBER`,`STATUS`,`CREATE_TIME`,`RECEIVE_TIME`,`RECEIVE_LONGIN_NAME`,`AR_MONEY`,`PAY_MONEY`,`CREATOR`,`RECEIVE_NAME`,`MEMO`,`TYPE`,`RECEIVE_TYPE`,`RECEIVE_WAY`,`USER_NUM`,`BILL_MEMO`) values (10,'1楼2号','20170119134158501888',2,'2017-01-19 13:41:58','2017-02-14 18:46:00','zhangxiang',252.80,760.80,NULL,NULL,'哈哈，不要辣的',2,1,1,5,'收款测试'),(12,'1楼大包','20170121094515315219',1,'2017-01-21 09:45:15',NULL,NULL,18.00,0.00,'zhangxiang',NULL,NULL,1,NULL,NULL,2,NULL),(15,'1楼1号','20170208112003833055',1,'2017-02-08 11:20:03',NULL,NULL,126.00,0.00,'zhangxiang',NULL,'ksks',1,NULL,NULL,0,NULL),(16,NULL,'20170208131010832669',1,'2017-02-08 13:10:10',NULL,NULL,140.00,0.00,'zhangxiang',NULL,'预约备注',2,NULL,NULL,0,''),(17,NULL,'20170208142400103440',1,'2017-02-14 14:24:00',NULL,NULL,158.00,0.00,'zhangxiang',NULL,'外卖备注',3,NULL,NULL,0,NULL),(18,NULL,'20170215144246095613',1,'2017-02-15 14:42:46',NULL,NULL,16.00,0.00,'zhangxiang',NULL,'单干',2,NULL,NULL,0,NULL),(19,NULL,'20170215171531076266',1,'2017-02-15 17:15:31',NULL,NULL,34.00,0.00,NULL,NULL,'预约的',2,NULL,NULL,0,NULL),(20,'1楼2号','20170218210217466174',1,'2017-02-18 21:02:17',NULL,NULL,94.80,0.00,'zhangxiang',NULL,'',1,NULL,NULL,4,NULL),(21,'102','20170218210359897251',1,'2017-02-18 21:03:59',NULL,NULL,142.80,0.00,'zhangxiang',NULL,'',1,NULL,NULL,6,''),(22,'1楼1号','20170301154114454793',1,'2017-03-01 15:41:14',NULL,NULL,28.00,0.00,'客户',NULL,'',1,NULL,NULL,0,NULL),(23,'顶替','20170301154646635480',9,'2017-03-01 15:46:46',NULL,NULL,16.00,0.00,'zhangxiang',NULL,'',1,NULL,NULL,0,NULL),(24,'sadf','20170301155215937680',1,'2017-03-01 15:52:15',NULL,NULL,44.00,0.00,'客户',NULL,'',1,NULL,NULL,0,NULL),(25,'1楼1号','20170301225723511574',1,'2017-03-01 22:57:23',NULL,NULL,192.00,0.00,'客户',NULL,'',1,NULL,NULL,0,NULL);

/*Table structure for table `ekh_annex` */

DROP TABLE IF EXISTS `ekh_annex`;

CREATE TABLE `ekh_annex` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ANNEX_CATEGORYCODE` bigint(20) NOT NULL COMMENT '附件分类代码',
  `OBJ_ID` bigint(20) NOT NULL COMMENT '对象ID',
  `FILE_PATH` varchar(200) DEFAULT NULL COMMENT '存放地址',
  `FILE_NAME` varchar(100) DEFAULT NULL COMMENT '文件名',
  `FILE_SIZE` bigint(20) DEFAULT NULL COMMENT '文件大小(K)',
  `FILE_TYPE` varchar(200) DEFAULT NULL COMMENT '文件类型',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATOR` varchar(100) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='附件表';

/*Data for the table `ekh_annex` */

/*Table structure for table `location` */

DROP TABLE IF EXISTS `location`;

CREATE TABLE `location` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LOCATION_NUMBER` varchar(50) DEFAULT NULL COMMENT '位置编号',
  `STATUS` int(11) DEFAULT '1' COMMENT '状态1:可用 2：用餐中 3：预定',
  `BILL_ID` bigint(20) DEFAULT NULL COMMENT '账单ID    预定后有账单才可用',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COMMENT='位置';

/*Data for the table `location` */

insert  into `location`(`ID`,`LOCATION_NUMBER`,`STATUS`,`BILL_ID`,`MEMO`) values (1,'1楼1号',2,NULL,''),(2,'1楼2号',2,NULL,''),(3,'102',2,NULL,'sf'),(11,'sagd',1,NULL,''),(12,'dfg',1,NULL,'dh'),(13,'qqqqqqqqqq',1,NULL,''),(14,'sdffg',1,NULL,''),(16,'sg',1,NULL,''),(17,'sadf',2,NULL,''),(18,'顶替',2,NULL,'夺'),(32,'2.6',1,NULL,''),(33,'2.7',1,NULL,''),(34,'2.4',1,NULL,'');

/*Table structure for table `login_log` */

DROP TABLE IF EXISTS `login_log`;

CREATE TABLE `login_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LOGIN_NAME` varchar(50) NOT NULL COMMENT '登录名',
  `LOGIN_DATE` datetime NOT NULL COMMENT '登录时间',
  `LOGIN_IP` varchar(100) DEFAULT NULL COMMENT '登录IP',
  `BROWSER_INFO` varchar(200) DEFAULT NULL COMMENT '浏览器信息',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='登录日志';

/*Data for the table `login_log` */

/*Table structure for table `login_user` */

DROP TABLE IF EXISTS `login_user`;

CREATE TABLE `login_user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `LOGIN_NAME` varchar(50) DEFAULT NULL COMMENT '登录网站注册名',
  `PASSWORD` varchar(50) DEFAULT NULL COMMENT '登录网站密码',
  `PHONE` varchar(30) DEFAULT NULL COMMENT '手机号',
  `USER_TYPE` int(11) DEFAULT NULL COMMENT '用户类型 1：管理员 2：经理 3：厨师 4：前台 5：服务员',
  `LAST_LOGIN_TIME` datetime DEFAULT NULL COMMENT '最后登录时间',
  `LAST_LOGIN_IP` varchar(100) DEFAULT NULL COMMENT '最后登录IP',
  `STATUS` int(11) DEFAULT NULL COMMENT '状态 1-正常 8-冻结 9-删除',
  `REGSITER_TIME` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='注册用户';

/*Data for the table `login_user` */

insert  into `login_user`(`ID`,`LOGIN_NAME`,`PASSWORD`,`PHONE`,`USER_TYPE`,`LAST_LOGIN_TIME`,`LAST_LOGIN_IP`,`STATUS`,`REGSITER_TIME`) values (1,'zhangxiang','123456','17051023028',NULL,NULL,NULL,NULL,NULL),(2,'zhangxiang','fthhcc','11',NULL,NULL,NULL,NULL,NULL),(3,'zhangxiang','512','170',NULL,NULL,NULL,NULL,NULL),(4,'zhangxiang','1123','111111334788',NULL,NULL,NULL,NULL,NULL),(5,'zhangxiang','41234123','23432',NULL,NULL,NULL,NULL,NULL),(6,'zhangxiang','123456','zhangxiang',NULL,NULL,NULL,NULL,NULL),(7,'zhangxiang','123456','zhangxiang',NULL,NULL,NULL,NULL,NULL),(8,'zhangxiang','3556','15848273556',NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `menu_food` */

DROP TABLE IF EXISTS `menu_food`;

CREATE TABLE `menu_food` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) NOT NULL COMMENT '名称',
  `NAME_NUMBER` varchar(50) DEFAULT NULL COMMENT '名称编号',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '备注',
  `PRICE` decimal(18,2) DEFAULT NULL COMMENT '价格',
  `CREATOR` varchar(50) DEFAULT NULL COMMENT '创建人',
  `MODIFER` varchar(50) DEFAULT NULL COMMENT '修改人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `EDIT_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `MENU_TYPE_ID` bigint(20) DEFAULT NULL COMMENT '菜单类型ID',
  `STATUS` int(11) DEFAULT '0' COMMENT '状态0:正常1：缺料',
  `UNIT` int(11) DEFAULT '1' COMMENT '单位1:份2：串3：斤4:两 5：把 6：个 7：瓶8：箱',
  `MIN_LIMIT_UNIT` int(11) DEFAULT NULL COMMENT '最少单位量0:没有限制',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8 COMMENT='菜单';

/*Data for the table `menu_food` */

insert  into `menu_food`(`ID`,`NAME`,`NAME_NUMBER`,`MEMO`,`PRICE`,`CREATOR`,`MODIFER`,`CREATE_TIME`,`EDIT_TIME`,`MENU_TYPE_ID`,`STATUS`,`UNIT`,`MIN_LIMIT_UNIT`) values (18,'麻辣牛肚丝','101','',28.00,'zhangxiang',NULL,'2017-01-24 00:57:14','2017-01-24 00:57:14',7,0,1,NULL),(19,'洋葱木耳','102','',10.00,'zhangxiang',NULL,'2017-01-24 01:00:08','2017-01-24 01:00:08',7,0,1,NULL),(20,'野薄荷黄瓜','103','',16.00,'zhangxiang',NULL,'2017-01-24 01:00:44','2017-01-24 01:00:44',7,0,1,NULL),(21,'川味老变蛋','104','',16.00,'zhangxiang',NULL,'2017-01-24 01:01:32','2017-01-24 01:01:32',7,0,1,NULL),(22,'秘制凉皮','105','',8.00,'zhangxiang',NULL,'2017-01-24 01:02:11','2017-01-24 01:02:11',7,0,1,NULL),(23,'酸辣莜面卷','106','',16.00,'zhangxiang',NULL,'2017-01-24 01:02:55','2017-01-24 01:02:55',7,0,1,NULL),(24,'特色海笋','107','',18.00,'zhangxiang',NULL,'2017-01-24 01:03:18','2017-01-24 01:03:18',7,0,1,NULL),(25,'蒜泥茄子','108','',12.00,'zhangxiang',NULL,'2017-01-24 01:03:43','2017-01-24 01:03:43',7,0,1,NULL),(26,'天然海蛰丝','109','',18.00,'zhangxiang',NULL,'2017-01-24 01:04:12','2017-01-24 01:04:12',7,0,1,NULL),(27,'木耳桃仁','110','',16.00,'zhangxiang',NULL,'2017-01-24 01:04:43','2017-01-24 01:04:43',7,0,1,NULL),(28,'爽口萝卜丝','111','',12.00,'zhangxiang',NULL,'2017-01-24 01:05:19','2017-01-24 01:05:19',7,0,1,NULL),(29,'自制香肠','112','',28.00,'zhangxiang',NULL,'2017-01-24 01:05:53','2017-01-24 01:05:53',7,0,1,NULL),(30,'香椿苗拌云丝','113','',16.00,'zhangxiang',NULL,'2017-01-24 01:07:15','2017-01-24 01:07:15',7,0,1,NULL),(31,'小葱拌豆腐','114','',12.00,'zhangxiang',NULL,'2017-01-24 01:07:41','2017-01-24 01:07:41',7,0,1,NULL),(32,'凉拌生蒿','115','',12.00,'zhangxiang',NULL,'2017-01-24 01:08:10','2017-01-24 01:08:10',7,0,1,NULL),(33,'冰糖芦荟','116','',15.00,'zhangxiang',NULL,'2017-01-24 01:08:30','2017-01-24 01:08:30',7,0,1,NULL),(34,'卤汁豆腐干','117','',12.00,'zhangxiang',NULL,'2017-01-24 01:09:05','2017-01-24 01:09:05',7,0,1,NULL),(35,'凉拌田七','118','',16.00,'zhangxiang',NULL,'2017-01-24 01:09:42','2017-01-24 01:09:42',7,0,1,NULL),(36,'咸食菜','119','',18.00,'zhangxiang',NULL,'2017-01-24 01:10:07','2017-01-24 01:10:07',7,0,1,NULL),(37,'老虎拌菜','120','',12.00,'zhangxiang',NULL,'2017-01-24 01:10:31','2017-01-24 01:10:31',7,0,1,NULL),(38,'烧汁香豆腐','121','',16.00,'zhangxiang',NULL,'2017-01-24 01:13:41','2017-01-24 01:13:41',7,0,1,NULL),(39,'干炸野生小鱼','122','',28.00,'zhangxiang',NULL,'2017-01-24 01:14:52','2017-01-24 01:14:52',7,0,1,NULL),(40,'蒜香小黄鱼','123','',28.00,'zhangxiang',NULL,'2017-01-24 01:15:35','2017-01-24 01:15:35',7,0,1,NULL),(41,'豆芽面筋','124','',10.00,'zhangxiang',NULL,'2017-01-24 01:16:04','2017-01-24 01:16:04',7,0,1,NULL),(42,'山野菜','125','',12.00,'zhangxiang',NULL,'2017-01-24 01:16:28','2017-01-24 01:16:28',7,0,1,NULL),(43,'炝莲菜','126','',12.00,'zhangxiang',NULL,'2017-01-24 01:16:51','2017-01-24 01:16:51',7,0,1,NULL),(44,'干煸马面鱼','127','',22.00,'zhangxiang',NULL,'2017-01-24 01:17:21','2017-01-24 01:17:21',7,0,1,NULL),(45,'农家搅团','128','',12.00,'zhangxiang',NULL,'2017-01-24 10:14:06','2017-01-24 10:14:06',7,0,1,NULL),(46,'苦瓜杏仁','129','',16.00,'zhangxiang',NULL,'2017-01-24 10:14:23','2017-01-24 10:14:23',7,0,1,NULL),(47,'酸辣蕨根粉','130','',12.00,'zhangxiang',NULL,'2017-01-24 10:14:50','2017-01-24 10:14:50',7,0,1,NULL),(48,'葱香腐丝','131','',12.00,'zhangxiang',NULL,'2017-01-24 10:15:18','2017-01-24 10:15:18',7,0,1,NULL),(49,'麻辣鸡胗','132','',26.00,'zhangxiang',NULL,'2017-01-24 10:15:57','2017-01-24 10:15:57',7,0,1,NULL),(50,'蒜泥黄瓜','133','',12.00,'zhangxiang',NULL,'2017-01-24 10:16:27','2017-01-24 10:16:27',7,0,1,NULL),(51,'酸辣苕皮','134','',16.00,'zhangxiang',NULL,'2017-01-24 10:17:09','2017-01-24 10:17:09',7,0,1,NULL),(52,'苦菊沙拉','135','',18.00,'zhangxiang',NULL,'2017-01-24 10:17:42','2017-01-24 10:17:42',7,0,1,NULL),(53,'田园花生','136','',16.00,'zhangxiang',NULL,'2017-01-24 10:18:07','2017-01-24 10:18:07',7,0,1,NULL),(54,'老醋花生','137','',12.00,'zhangxiang',NULL,'2017-01-24 10:18:50','2017-01-24 10:18:50',7,0,1,NULL),(55,'下酒素菜丸','138','',18.00,'zhangxiang',NULL,'2017-01-24 10:19:33','2017-01-24 10:19:33',7,0,1,NULL),(56,'西芹腐竹','139','',12.00,'zhangxiang',NULL,'2017-01-24 10:19:52','2017-01-24 10:19:52',7,0,1,NULL),(57,'农家浆水菜','140','',10.00,'zhangxiang',NULL,'2017-01-24 10:20:33','2017-01-24 10:20:33',7,0,1,NULL),(58,'蜜汁萝卜干','141','',10.00,'zhangxiang','zhangxiang','2017-01-24 10:21:05','2017-01-24 10:22:17',7,0,1,NULL),(59,'丁香鱼拌菠菜','142','',16.00,'zhangxiang',NULL,'2017-01-24 10:26:13','2017-01-24 10:26:13',7,0,1,NULL),(60,'红油泡菜','143','',10.00,'zhangxiang',NULL,'2017-01-24 10:26:51','2017-01-24 10:26:51',7,0,1,NULL),(61,'原味香芹','144','',10.00,'zhangxiang',NULL,'2017-01-24 10:29:05','2017-01-24 10:29:05',7,0,1,NULL),(62,'莴丝白菜','145','',10.00,'zhangxiang',NULL,'2017-01-24 10:29:24','2017-01-24 10:29:24',7,0,1,NULL),(63,'芥辣葫芦丝','146','',12.00,'zhangxiang',NULL,'2017-01-24 10:29:57','2017-01-24 10:29:57',7,0,1,NULL),(64,'红油耳片','147','',26.00,'zhangxiang',NULL,'2017-01-24 10:30:43','2017-01-24 10:30:43',7,0,1,NULL),(65,'蓝田饸饹','148','',10.00,'zhangxiang',NULL,'2017-01-24 10:33:36','2017-01-24 10:33:36',7,0,1,NULL),(66,'自制冻肉','149','',18.00,'zhangxiang',NULL,'2017-01-24 10:33:56','2017-01-24 10:33:56',7,0,1,NULL),(67,'茴香煎饼','150','',16.00,'zhangxiang',NULL,'2017-01-24 10:34:43','2017-02-08 16:53:12',7,0,1,NULL),(68,'椒盐香菇','301','',18.00,'zhangxiang',NULL,'2017-01-24 10:38:09','2017-01-24 10:38:09',8,0,1,NULL),(69,'椒盐蘑菇','302','',18.00,'zhangxiang',NULL,'2017-01-24 10:38:24','2017-01-24 10:38:24',8,0,1,NULL),(70,'炝拌腰花','303','',28.00,'zhangxiang',NULL,'2017-01-24 10:39:01','2017-01-24 10:39:01',8,0,1,NULL),(71,'藤椒毛肚','304','',26.00,'zhangxiang',NULL,'2017-01-24 10:39:44','2017-01-24 10:39:44',8,0,1,NULL),(72,'香酥无骨鱼','305','',26.00,'zhangxiang',NULL,'2017-01-24 10:40:28','2017-01-24 10:40:28',8,0,1,NULL),(73,'营养多籽鱼','306','',28.00,'zhangxiang',NULL,'2017-01-24 10:40:47','2017-01-24 10:40:47',8,0,1,NULL),(74,'美味掌中宝','307','',26.00,'zhangxiang',NULL,'2017-01-24 10:42:08','2017-01-24 10:42:08',8,0,1,NULL),(75,'水煮鱼','308','',48.00,'zhangxiang',NULL,'2017-01-24 10:42:36','2017-01-24 10:42:36',8,0,1,NULL),(76,'酸菜鱼','309','',48.00,'zhangxiang',NULL,'2017-01-24 10:43:16','2017-01-24 10:43:16',8,0,1,NULL),(77,'香菇青菜','310','',10.00,'zhangxiang',NULL,'2017-01-24 10:43:40','2017-01-24 10:43:40',8,0,1,NULL),(78,'五香炒凉粉','311','',18.00,'zhangxiang',NULL,'2017-01-24 10:44:03','2017-01-24 10:44:03',8,0,1,NULL),(79,'山菌炒肉片','312','',28.00,'zhangxiang',NULL,'2017-01-24 10:44:38','2017-01-24 10:44:38',8,0,1,NULL),(80,'农家煎豆腐','313','',16.00,'zhangxiang',NULL,'2017-01-24 10:45:04','2017-01-24 10:45:04',8,0,1,NULL),(81,'西芹腊肉','314','',38.00,'zhangxiang',NULL,'2017-01-24 10:45:24','2017-01-24 10:45:24',8,0,1,NULL),(82,'酸辣白菜','315','',10.00,'zhangxiang',NULL,'2017-01-24 10:45:43','2017-01-24 10:45:43',8,0,1,NULL),(83,'山槐花炒鸡蛋','316','',18.00,'zhangxiang',NULL,'2017-01-24 10:46:34','2017-01-24 10:46:34',8,0,1,NULL),(84,'农家小炒肉','317','',18.00,'zhangxiang',NULL,'2017-01-24 10:47:03','2017-01-24 10:47:03',8,0,1,NULL),(85,'香辣路蹄花','318','',58.00,'zhangxiang',NULL,'2017-01-24 10:47:42','2017-01-24 10:47:42',8,0,1,NULL),(86,'香辣鲜鱿鱼','319','',58.00,'zhangxiang',NULL,'2017-01-24 10:49:32','2017-01-24 10:49:32',8,0,1,NULL),(87,'韭菜鸡蛋炒豆芽','320','',18.00,'zhangxiang',NULL,'2017-01-24 10:50:11','2017-01-24 10:50:11',8,0,1,NULL),(88,'小炒木耳','321','',18.00,'zhangxiang',NULL,'2017-01-24 14:33:15','2017-01-24 14:33:15',8,0,1,NULL),(89,'自家煎焖子','322','',18.00,'zhangxiang',NULL,'2017-01-24 14:33:47','2017-01-24 14:33:47',8,0,1,NULL),(90,'麻辣豆腐','323','',16.00,'zhangxiang',NULL,'2017-01-24 14:34:15','2017-01-24 14:34:15',8,0,1,NULL),(91,'香辣小河虾','324','',22.00,'zhangxiang',NULL,'2017-01-24 14:34:43','2017-01-24 14:34:43',8,0,1,NULL),(92,'木耳山药','325','',18.00,'zhangxiang',NULL,'2017-01-24 14:35:09','2017-01-24 14:35:09',8,0,1,NULL),(93,'苜蓿炒肉','326','',22.00,'zhangxiang',NULL,'2017-01-24 14:35:32','2017-01-24 14:35:32',8,0,1,NULL),(94,'鱼香肉丝','327','',22.00,'zhangxiang',NULL,'2017-01-24 14:36:03','2017-01-24 14:36:03',8,0,1,NULL),(95,'香辣大虾','328','',58.00,'zhangxiang',NULL,'2017-01-24 14:36:40','2017-01-24 14:36:40',8,0,1,NULL),(96,'红烧肉','329','',38.00,'zhangxiang',NULL,'2017-01-24 14:37:13','2017-01-24 14:37:13',8,0,1,NULL),(97,'火爆腰花','330','',38.00,'zhangxiang',NULL,'2017-01-24 14:37:42','2017-01-24 14:37:42',8,0,1,NULL),(98,'酸菜炒软饼','331','',18.00,'zhangxiang',NULL,'2017-01-24 14:38:17','2017-01-24 14:38:17',8,0,1,NULL),(99,'红烧带鱼','332','',28.00,'zhangxiang',NULL,'2017-01-24 14:38:42','2017-01-24 14:38:42',8,0,1,NULL),(100,'酸菜炒魔芋','333','',18.00,'zhangxiang',NULL,'2017-01-24 14:39:17','2017-01-24 14:39:17',8,0,1,NULL),(101,'蒜苗炒羊血','334','',18.00,'zhangxiang',NULL,'2017-01-24 14:40:04','2017-01-24 14:40:04',8,0,1,NULL),(102,'双椒爆鱼肚','335','',48.00,'zhangxiang',NULL,'2017-01-24 14:40:44','2017-01-24 14:40:44',8,0,1,NULL),(103,'酸菜煎豆腐','336','',16.00,'zhangxiang',NULL,'2017-01-24 14:41:35','2017-01-24 14:41:35',8,0,1,NULL),(104,'红烧茄子','337','',16.00,'zhangxiang',NULL,'2017-01-24 14:41:55','2017-01-24 14:41:55',8,0,1,NULL),(105,'虎皮青椒','338','',22.00,'zhangxiang',NULL,'2017-01-24 14:42:21','2017-01-24 14:42:21',8,0,1,NULL),(106,'泡椒墨鱼仔','339','',58.00,'zhangxiang',NULL,'2017-01-24 14:42:50','2017-01-24 14:42:50',8,0,1,NULL),(107,'红烧武昌鱼','340','',38.00,'zhangxiang',NULL,'2017-01-24 14:43:40','2017-01-24 14:43:40',8,0,1,NULL),(108,'手撕包菜','341','',10.00,'zhangxiang',NULL,'2017-01-24 14:44:06','2017-01-24 14:44:06',8,0,1,NULL),(109,'葱烧皮肚','342','',28.00,'zhangxiang',NULL,'2017-01-24 14:44:57','2017-01-24 14:44:57',8,0,1,NULL),(110,'豆腐炒茼蒿','343','',16.00,'zhangxiang',NULL,'2017-01-24 14:45:24','2017-01-24 14:45:24',8,0,1,NULL),(111,'烧三鲜','344','',36.00,'zhangxiang',NULL,'2017-01-24 14:45:41','2017-01-24 14:45:41',8,0,1,NULL),(112,'大盘莲菜','347','',18.00,'zhangxiang',NULL,'2017-01-24 14:46:15','2017-01-24 14:46:15',8,0,1,NULL),(113,'尖椒肥肠','348','',28.00,'zhangxiang',NULL,'2017-01-24 14:46:53','2017-01-24 14:46:53',8,0,1,NULL),(114,'韭菜炒青椒','349','',16.00,'zhangxiang',NULL,'2017-01-24 14:47:54','2017-01-24 14:47:54',8,0,1,NULL),(115,'大碗有机菜花','350','',18.00,'zhangxiang',NULL,'2017-01-24 14:48:35','2017-01-24 14:48:35',8,0,1,NULL),(116,'爆毛肚','351','',48.00,'zhangxiang',NULL,'2017-01-24 14:49:11','2017-01-24 14:49:11',8,0,1,NULL),(117,'爆炒黄喉','352','',58.00,'zhangxiang',NULL,'2017-01-24 14:49:43','2017-01-24 14:49:43',8,0,1,NULL),(118,'家常土豆丝','353','',10.00,'zhangxiang',NULL,'2017-01-24 14:50:12','2017-01-24 14:50:12',8,0,1,NULL),(119,'风味土豆片','354','',18.00,'zhangxiang',NULL,'2017-01-24 14:50:41','2017-01-24 14:50:41',8,0,1,NULL),(120,'宫爆鸡丁','355','',22.00,'zhangxiang',NULL,'2017-01-24 14:51:07','2017-01-24 14:51:07',8,0,1,NULL),(121,'豆芽炒粉条','356','',16.00,'zhangxiang',NULL,'2017-01-24 14:51:26','2017-01-24 14:51:26',8,0,1,NULL),(122,'春和发小炒','357','',18.00,'zhangxiang',NULL,'2017-01-24 14:51:49','2017-01-24 14:51:49',8,0,1,NULL),(123,'川味回锅肉','358','',22.00,'zhangxiang',NULL,'2017-01-24 14:52:23','2017-01-24 14:52:23',8,0,1,NULL),(124,'豆腐黄鱼','359','',38.00,'zhangxiang',NULL,'2017-01-24 14:52:45','2017-01-24 14:52:45',8,0,1,NULL),(125,'葱爆羊肉','360','',48.00,'zhangxiang',NULL,'2017-01-24 14:53:30','2017-01-24 14:53:30',8,0,1,NULL),(126,'红烧鱼民、块','361','',48.00,'zhangxiang',NULL,'2017-01-24 14:53:59','2017-01-24 14:53:59',8,0,1,NULL),(127,'松仁玉米','362','',18.00,'zhangxiang',NULL,'2017-01-24 14:54:36','2017-01-24 14:54:36',8,0,1,NULL),(128,'糖醋里脊','363','',28.00,'zhangxiang',NULL,'2017-01-24 14:55:43','2017-01-24 14:55:43',8,0,1,NULL),(129,'煎辣子卷烙馍','364','',18.00,'zhangxiang',NULL,'2017-01-24 14:56:39','2017-01-24 14:56:39',8,0,1,NULL),(130,'萝卜干炒肉','365','',22.00,'zhangxiang',NULL,'2017-01-24 14:57:06','2017-01-24 14:57:06',8,0,1,NULL),(131,'豆角烧茄子','366','',16.00,'zhangxiang',NULL,'2017-01-24 14:57:29','2017-01-24 14:57:29',8,0,1,NULL),(132,'蒸老豆角','367','',16.00,'zhangxiang',NULL,'2017-01-24 14:58:15','2017-01-24 14:58:15',8,0,1,NULL),(133,'爆炸皮肚','368','',38.00,'zhangxiang',NULL,'2017-01-24 14:58:42','2017-01-24 14:58:42',8,0,1,NULL),(134,'农家洋芋丝','369','',16.00,'zhangxiang',NULL,'2017-01-24 15:00:12','2017-01-24 15:00:12',8,0,1,NULL),(135,'红红火火','370','',16.00,'zhangxiang',NULL,'2017-01-24 15:00:34','2017-01-24 15:00:34',8,0,1,NULL),(136,'小酥肉','371','',28.00,'zhangxiang',NULL,'2017-01-24 15:01:06','2017-01-24 15:01:06',8,0,1,NULL),(137,'农家条子肉','372','',28.00,'zhangxiang',NULL,'2017-01-24 15:01:31','2017-01-24 15:01:31',8,0,1,NULL),(138,'粉蒸肉','373','',28.00,'zhangxiang',NULL,'2017-01-24 15:02:09','2017-01-24 15:02:09',8,0,1,NULL),(139,'海带炖排骨','501','',38.00,'zhangxiang',NULL,'2017-01-24 15:03:29','2017-01-24 15:03:29',9,0,1,NULL),(140,'萝卜炖羊肉','502','',48.00,'zhangxiang',NULL,'2017-01-24 15:05:02','2017-01-24 15:05:02',9,0,1,NULL),(141,'西红柿炖牛腩','503','',48.00,'zhangxiang',NULL,'2017-01-24 15:06:01','2017-01-24 15:06:01',9,0,1,NULL),(142,'白菜炖豆腐','504','',16.00,'zhangxiang',NULL,'2017-01-24 15:06:31','2017-01-24 15:06:31',9,0,1,NULL),(143,'白芸豆炖蹄花','505','',38.00,'zhangxiang',NULL,'2017-01-24 15:07:29','2017-01-24 15:07:29',9,0,1,NULL),(144,'家常丸子汤','601','',26.00,'zhangxiang',NULL,'2017-01-24 15:08:37','2017-01-24 15:08:37',10,0,1,NULL),(145,'西湖牛肉养羹','602','',18.00,'zhangxiang',NULL,'2017-01-24 15:09:20','2017-01-24 15:09:20',10,0,1,NULL),(146,'肉片汤','603','',18.00,'zhangxiang',NULL,'2017-01-24 15:09:40','2017-01-24 15:09:40',10,0,1,NULL),(147,'野菜豆腐羹','604','',16.00,'zhangxiang',NULL,'2017-01-24 15:10:21','2017-01-24 15:10:21',10,0,1,NULL),(148,'肉丁湖辣汤','605','',18.00,'zhangxiang',NULL,'2017-01-24 15:10:52','2017-01-24 15:10:52',10,0,1,NULL),(149,'酸辣酥肉汤','606','',28.00,'zhangxiang',NULL,'2017-01-24 15:11:37','2017-01-24 15:11:37',10,0,1,NULL),(150,'西红柿鸡蛋汤','607','',12.00,'zhangxiang',NULL,'2017-01-24 15:12:21','2017-01-24 15:12:21',10,0,1,NULL),(151,'酸辣肚丝汤','608','',18.00,'zhangxiang',NULL,'2017-01-24 15:13:24','2017-01-24 15:13:24',10,0,1,NULL),(152,'烩三鲜','609','',18.00,'zhangxiang',NULL,'2017-01-24 15:13:45','2017-01-24 15:13:45',10,0,1,NULL),(153,'玉米羹','610','',16.00,'zhangxiang',NULL,'2017-01-24 15:14:04','2017-01-24 15:14:04',10,0,1,NULL),(154,'卤面','701','',10.00,'zhangxiang',NULL,'2017-01-24 15:15:10','2017-01-24 15:15:10',11,0,1,NULL),(155,'蒸饺','702','',10.00,'zhangxiang',NULL,'2017-01-24 15:15:42','2017-01-24 15:15:42',11,0,1,NULL),(156,'锅盔辣子','703','',18.00,'zhangxiang',NULL,'2017-01-24 15:16:02','2017-01-24 15:16:02',11,0,1,NULL),(157,'葱花饼','704','',8.00,'zhangxiang',NULL,'2017-01-24 15:16:35','2017-01-24 15:16:35',11,0,1,NULL);

/*Table structure for table `menu_type` */

DROP TABLE IF EXISTS `menu_type`;

CREATE TABLE `menu_type` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TYPE_NAME` varchar(50) DEFAULT NULL COMMENT '类型',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '描述',
  `CREATOR` varchar(50) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='菜单类型';

/*Data for the table `menu_type` */

insert  into `menu_type`(`ID`,`TYPE_NAME`,`MEMO`,`CREATOR`) values (7,'凉菜','','zhangxiang'),(8,'热菜','','zhangxiang'),(9,'大炖菜','','zhangxiang'),(10,'汤羹','','zhangxiang'),(11,'主食','','zhangxiang');

/*Table structure for table `order_foods` */

DROP TABLE IF EXISTS `order_foods`;

CREATE TABLE `order_foods` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `TYPE_NAME` varchar(50) DEFAULT NULL COMMENT '类型',
  `NAME` varchar(50) DEFAULT NULL COMMENT '名称',
  `NAME_NUMBER` varchar(50) DEFAULT NULL COMMENT '名称编号',
  `NUM` decimal(18,2) DEFAULT NULL COMMENT '数量',
  `PRICE` decimal(18,2) DEFAULT NULL COMMENT '价格',
  `STATUS` int(11) DEFAULT NULL COMMENT '状态和1：待处理 2:处理中：3：做好  4：已上 9：取消',
  `CREATOR` varchar(50) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '备注',
  `BILL_ID` bigint(20) DEFAULT NULL COMMENT '账单ID',
  `MENU_ID` bigint(20) DEFAULT NULL COMMENT '菜单ID(暂不用)',
  `UNIT` int(11) DEFAULT '1' COMMENT '单位1:份2：串3：斤',
  `OPERATION_PERSON` varchar(50) DEFAULT NULL COMMENT '操作人',
  `DEL_PERSON` varchar(50) DEFAULT NULL COMMENT '删除人',
  `PAY_STATUS` int(11) DEFAULT '1' COMMENT '支付状态1:未付 2：已付',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8 COMMENT='订单(订单基本信息直接写入本表，避免删除菜单、菜单类型带来的麻烦，日后好做分析)';

/*Data for the table `order_foods` */

insert  into `order_foods`(`ID`,`TYPE_NAME`,`NAME`,`NAME_NUMBER`,`NUM`,`PRICE`,`STATUS`,`CREATOR`,`CREATE_TIME`,`MEMO`,`BILL_ID`,`MENU_ID`,`UNIT`,`OPERATION_PERSON`,`DEL_PERSON`,`PAY_STATUS`) values (1,'顶替','新品','55',1.00,88.00,4,NULL,'2017-01-19 13:41:58',NULL,10,16,1,'nullzhangxiang','zhangxiang',2),(2,'顶替','456578','789',1.00,558.00,9,NULL,'2017-01-19 13:41:58',NULL,10,15,1,NULL,'zhangxiang',2),(3,'顶替','456','45785',1.00,54.00,1,NULL,'2017-01-19 13:41:58',NULL,10,14,1,NULL,'zhangxiang',2),(4,'凉菜','茴香煎饼','150',1.00,16.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,67,1,NULL,NULL,1),(5,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,66,1,NULL,NULL,1),(6,'凉菜','蓝田饸饹','148',1.00,10.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,65,1,NULL,NULL,1),(7,'凉菜','红油耳片','147',1.00,26.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,64,1,NULL,NULL,1),(8,'凉菜','莴丝白菜','145',1.00,10.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,62,1,NULL,NULL,1),(9,'凉菜','原味香芹','144',1.00,10.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,61,1,NULL,NULL,1),(10,'凉菜','红油泡菜','143',1.00,10.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,60,1,NULL,NULL,1),(11,'凉菜','丁香鱼拌菠菜','142',1.00,16.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,59,1,NULL,NULL,1),(12,'凉菜','蜜汁萝卜干','141',1.00,10.00,1,'zhangxiang','2017-02-08 11:20:03',NULL,15,58,1,NULL,NULL,1),(13,'凉菜','茴香煎饼','150',1.00,16.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,67,1,NULL,NULL,1),(14,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,66,1,NULL,NULL,1),(15,'凉菜','蒜泥茄子','108',1.00,12.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,25,1,NULL,NULL,1),(16,'凉菜','木耳桃仁','110',1.00,16.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,27,1,NULL,NULL,1),(17,'凉菜','特色海笋','107',1.00,18.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,24,1,NULL,NULL,1),(18,'凉菜','秘制凉皮','105',1.00,8.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,22,1,NULL,NULL,1),(19,'凉菜','川味老变蛋','104',1.00,16.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,21,1,NULL,NULL,1),(20,'凉菜','野薄荷黄瓜','103',1.00,16.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,20,1,NULL,NULL,1),(21,'凉菜','洋葱木耳','102',1.00,10.00,1,'zhangxiang','2017-02-08 13:10:10',NULL,16,19,1,NULL,NULL,1),(22,'凉菜','茴香煎饼','150',4.00,16.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,67,1,NULL,NULL,1),(23,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,66,1,NULL,NULL,1),(24,'凉菜','秘制凉皮','105',1.00,8.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,22,1,NULL,NULL,1),(25,'凉菜','酸辣莜面卷','106',1.00,16.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,23,1,NULL,NULL,1),(26,'凉菜','特色海笋','107',1.00,18.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,24,1,NULL,NULL,1),(27,'凉菜','木耳桃仁','110',1.00,16.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,27,1,NULL,NULL,1),(28,'凉菜','天然海蛰丝','109',2.00,18.00,1,'zhangxiang','2017-02-08 14:24:00',NULL,17,26,1,NULL,NULL,1),(43,'凉菜','猪头肉','705',1.00,28.80,1,'zhangxiang','2017-02-13 16:02:13',NULL,10,158,3,NULL,'zhangxiang',2),(44,'凉菜','丁香鱼拌菠菜','142',1.00,16.00,1,'zhangxiang','2017-02-13 16:05:49',NULL,10,59,1,NULL,NULL,2),(69,'凉菜','茴香煎饼','150',1.00,16.00,1,'zhangxiang','2017-02-13 17:19:59',NULL,10,67,1,NULL,NULL,2),(70,'凉菜','茴香煎饼','150',1.00,16.00,9,'zhangxiang','2017-02-14 15:01:50',NULL,10,67,1,'nullzhangxiang','zhangxiang',2),(71,'凉菜','茴香煎饼','150',1.00,16.00,9,'zhangxiang','2017-02-14 15:03:28',NULL,10,67,1,'nullzhangxiang','zhangxiang',2),(72,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-14 15:26:41',NULL,12,66,1,NULL,NULL,1),(73,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-14 15:27:23',NULL,10,66,1,NULL,NULL,2),(74,'凉菜','蓝田饸饹','148',1.00,10.00,1,NULL,'2017-02-14 18:41:27',NULL,10,65,1,NULL,NULL,2),(75,'凉菜','红油泡菜','143',1.00,10.00,1,NULL,'2017-02-14 18:44:13',NULL,10,60,1,NULL,NULL,2),(76,'凉菜','芥辣葫芦丝','146',1.00,12.00,1,NULL,'2017-02-14 18:46:05',NULL,10,63,1,NULL,NULL,1),(77,'凉菜','丁香鱼拌菠菜','142',1.00,16.00,1,'zhangxiang','2017-02-15 14:42:46',NULL,18,59,1,NULL,NULL,1),(78,'凉菜','原味香芹','144',1.00,10.00,1,NULL,'2017-02-15 16:36:06',NULL,16,61,1,NULL,NULL,1),(79,'凉菜','蓝田饸饹','148',1.00,10.00,9,NULL,'2017-02-15 16:43:06',NULL,18,65,1,NULL,NULL,1),(80,'凉菜','茴香煎饼','150',1.00,16.00,1,NULL,'2017-02-15 17:15:31',NULL,19,67,1,NULL,NULL,1),(81,'凉菜','自制冻肉','149',1.00,18.00,1,NULL,'2017-02-15 17:15:31',NULL,19,66,1,NULL,NULL,1),(82,'凉菜','猪头肉','705',1.00,28.80,1,'zhangxiang','2017-02-18 21:02:17',NULL,20,158,1,NULL,NULL,1),(83,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-18 21:02:17',NULL,20,66,1,NULL,NULL,1),(84,'凉菜','蓝田饸饹','148',1.00,10.00,1,'zhangxiang','2017-02-18 21:02:17',NULL,20,65,1,NULL,NULL,1),(85,'凉菜','红油耳片','147',1.00,26.00,1,'zhangxiang','2017-02-18 21:02:17',NULL,20,64,1,NULL,NULL,1),(86,'凉菜','芥辣葫芦丝','146',1.00,12.00,1,'zhangxiang','2017-02-18 21:02:17',NULL,20,63,1,NULL,NULL,1),(87,'凉菜','猪头肉','705',1.00,28.80,1,'zhangxiang','2017-02-18 21:03:59',NULL,21,158,1,NULL,NULL,1),(88,'凉菜','茴香煎饼','150',5.00,16.00,1,'zhangxiang','2017-02-18 21:03:59',NULL,21,67,1,NULL,NULL,1),(89,'凉菜','自制冻肉','149',1.00,18.00,1,'zhangxiang','2017-02-18 21:03:59',NULL,21,66,1,NULL,NULL,1),(90,'凉菜','茴香煎饼','150',1.00,16.00,1,'zhangxiang','2017-03-01 15:17:34',NULL,21,67,1,NULL,NULL,1),(91,'凉菜','酸辣蕨根粉','130',1.00,12.00,1,'客户','2017-03-01 15:41:14',NULL,22,47,1,NULL,NULL,1),(92,'凉菜','苦瓜杏仁','129',1.00,16.00,1,'客户','2017-03-01 15:41:14',NULL,22,46,1,NULL,NULL,1),(93,'凉菜','茴香煎饼','150',1.00,16.00,1,'zhangxiang','2017-03-01 15:46:46',NULL,23,67,1,NULL,NULL,1),(94,'凉菜','苦瓜杏仁','129',1.00,16.00,1,'客户','2017-03-01 15:52:15',NULL,24,46,1,NULL,NULL,1),(95,'凉菜','苦瓜杏仁','129',1.00,16.00,1,'客户','2017-03-01 15:53:11',NULL,24,46,1,NULL,NULL,1),(96,'凉菜','酸辣蕨根粉','130',1.00,12.00,1,'客户','2017-03-01 15:53:11',NULL,24,47,1,NULL,NULL,1),(97,'热菜','小炒木耳','321',1.00,18.00,1,'客户','2017-03-01 22:57:23',NULL,25,88,1,NULL,NULL,1),(98,'热菜','自家煎焖子','322',1.00,18.00,1,'客户','2017-03-01 22:57:23',NULL,25,89,1,NULL,NULL,1),(99,'热菜','香酥无骨鱼','305',1.00,26.00,1,'客户','2017-03-01 22:57:23',NULL,25,72,1,NULL,NULL,1),(100,'热菜','酸菜鱼','309',1.00,48.00,1,'客户','2017-03-01 22:57:23',NULL,25,76,1,NULL,NULL,1),(101,'热菜','香辣路蹄花','318',1.00,58.00,1,'客户','2017-03-01 22:57:23',NULL,25,85,1,NULL,NULL,1),(102,'凉菜','秘制凉皮','105',1.00,8.00,1,'客户','2017-03-01 22:57:23',NULL,25,22,1,NULL,NULL,1),(103,'凉菜','苦瓜杏仁','129',1.00,16.00,1,'客户','2017-03-01 22:57:23',NULL,25,46,1,NULL,NULL,1);

/*Table structure for table `reservation_info` */

DROP TABLE IF EXISTS `reservation_info`;

CREATE TABLE `reservation_info` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `PHONE` varchar(50) DEFAULT NULL COMMENT '电话',
  `ORDER_TIME_START` datetime DEFAULT NULL COMMENT '预约时间',
  `ORDER_TIME_END` datetime DEFAULT NULL COMMENT '预约时间(终)',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '备注',
  `BILL_ID` bigint(20) DEFAULT NULL COMMENT '账单ID',
  `STATUS` int(11) DEFAULT '1' COMMENT '状态 1：正常 9:删除',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COMMENT='预约信息';

/*Data for the table `reservation_info` */

insert  into `reservation_info`(`ID`,`NAME`,`PHONE`,`ORDER_TIME_START`,`ORDER_TIME_END`,`CREATE_TIME`,`MEMO`,`BILL_ID`,`STATUS`) values (6,'张祥','17051023028','2017-01-18 00:00:00','2017-02-01 00:00:00','2017-01-19 13:41:58','大厦',10,1),(7,'张祥','17051023028','2017-02-14 00:00:00','2017-02-15 17:00:00','2017-02-08 13:10:10','预约备注',16,1),(14,'18165366402','18165366402',NULL,NULL,'2017-02-15 14:58:40','18165366402',NULL,1),(15,'大','18165366402',NULL,NULL,'2017-02-15 14:59:14','',NULL,1),(16,'林','18165366402',NULL,NULL,'2017-02-15 14:59:38','18165366402',NULL,1),(17,'在城','18165366402',NULL,NULL,'2017-02-15 15:00:17','',NULL,1),(18,'大厦大厦大厦大','18165366402',NULL,NULL,'2017-02-15 15:00:43','',18,1),(19,'磊','18165366402',NULL,NULL,'2017-02-15 15:02:51','',NULL,1),(20,'预约','17051023028',NULL,NULL,'2017-02-15 17:15:31','预约的',19,1);

/*Table structure for table `sys_role` */

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_NAME` varchar(100) NOT NULL COMMENT '角色名称',
  `ROLE_MEMO` varchar(500) DEFAULT NULL COMMENT '角色描述',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATOR` varchar(100) DEFAULT NULL COMMENT '创建人',
  `MODIFY_TIME` datetime DEFAULT NULL COMMENT '修改时间',
  `MODIFIER` varchar(100) DEFAULT NULL COMMENT '修改人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理-角色信息';

/*Data for the table `sys_role` */

/*Table structure for table `sys_role_action` */

DROP TABLE IF EXISTS `sys_role_action`;

CREATE TABLE `sys_role_action` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ACTION_CODE` bigint(20) NOT NULL COMMENT '功能权限代码',
  `ROLE_ID` bigint(20) NOT NULL COMMENT '角色ID',
  `CREATOR` varchar(100) DEFAULT NULL COMMENT '创建人',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理-角色功能权限关系';

/*Data for the table `sys_role_action` */

/*Table structure for table `sys_role_user` */

DROP TABLE IF EXISTS `sys_role_user`;

CREATE TABLE `sys_role_user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ROLE_ID` bigint(20) NOT NULL COMMENT '角色ID',
  `USER_ID` bigint(20) NOT NULL COMMENT '人员ID',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATOR` varchar(100) DEFAULT NULL COMMENT '创建人',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统管理-角色人员关系';

/*Data for the table `sys_role_user` */

/*Table structure for table `take_out_info` */

DROP TABLE IF EXISTS `take_out_info`;

CREATE TABLE `take_out_info` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `NAME` varchar(50) DEFAULT NULL COMMENT '姓名',
  `PNHONE` varchar(50) DEFAULT NULL COMMENT '手机',
  `ADDRESS` varchar(100) DEFAULT NULL COMMENT '地址',
  `MEMO` varchar(200) DEFAULT NULL COMMENT '备注',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `BILL_ID` bigint(20) DEFAULT NULL COMMENT '账单ID',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='外卖信息';

/*Data for the table `take_out_info` */

insert  into `take_out_info`(`ID`,`NAME`,`PNHONE`,`ADDRESS`,`MEMO`,`CREATE_TIME`,`BILL_ID`) values (1,'张祥','17051023028','浦东新区居家桥1030弄603室','外卖备注','2017-02-08 14:24:00',17);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
