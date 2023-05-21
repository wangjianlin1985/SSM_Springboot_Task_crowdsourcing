/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : task_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2019-05-22 15:19:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_notice`
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `noticeId` int(11) NOT NULL auto_increment COMMENT '公告id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`noticeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '任务众包平台成立了', '<p>还在为找不到人才发愁吗，在这个平台，发布你的任务，就会有一大批人才帮你做任务，你也在本平台接任务赚钱！</p>', '2019-05-19 17:55:28');
INSERT INTO `t_notice` VALUES ('2', '利用空闲时间赚点生活费', '<p>还在为你的无聊时间发愁吗，你可以来这里，把你的剩余时间利用起来，创造价值，造福家庭和社会！</p>', '2019-05-22 14:58:29');

-- ----------------------------
-- Table structure for `t_task`
-- ----------------------------
DROP TABLE IF EXISTS `t_task`;
CREATE TABLE `t_task` (
  `taskId` int(11) NOT NULL auto_increment COMMENT '任务id',
  `taskClassObj` int(11) NOT NULL COMMENT '任务分类',
  `taskName` varchar(80) NOT NULL COMMENT '任务标题',
  `taskContent` varchar(8000) NOT NULL COMMENT '任务内容',
  `taskFile` varchar(60) NOT NULL COMMENT '任务文件',
  `taskMoney` float NOT NULL COMMENT '任务赏金',
  `taskStateObj` int(11) NOT NULL COMMENT '任务状态',
  `userObj` varchar(30) NOT NULL COMMENT '任务发布人',
  `publishTime` varchar(20) default NULL COMMENT '任务发布时间',
  PRIMARY KEY  (`taskId`),
  KEY `taskClassObj` (`taskClassObj`),
  KEY `taskStateObj` (`taskStateObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_task_ibfk_1` FOREIGN KEY (`taskClassObj`) REFERENCES `t_taskclass` (`taskClassId`),
  CONSTRAINT `t_task_ibfk_2` FOREIGN KEY (`taskStateObj`) REFERENCES `t_taskstate` (`taskStateId`),
  CONSTRAINT `t_task_ibfk_3` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_task
-- ----------------------------
INSERT INTO `t_task` VALUES ('1', '1', '给一个食品企业做一个网站', '<p>本企业是一个食品加工厂家，加工各种小吃零食，食品种类繁多，商品多样化，需要技术人员开发一个企业网站，展示我们企业的所有产品信息，用户可以通过网上下单购买，我们发物流！</p>', 'upload/a9f4bbea-3d54-4b65-9921-c8763efa839e.doc', '1200', '2', 'user1', '2019-05-19 17:54:28');
INSERT INTO `t_task` VALUES ('2', '2', '食品企业Logo设计', '<p>本企业是开发零食食品产品的厂家，需要设计一个公司Logo!</p>', '', '500', '2', 'user1', '2019-05-22 13:54:03');

-- ----------------------------
-- Table structure for `t_taskclass`
-- ----------------------------
DROP TABLE IF EXISTS `t_taskclass`;
CREATE TABLE `t_taskclass` (
  `taskClassId` int(11) NOT NULL auto_increment COMMENT '任务分类id',
  `taskClassName` varchar(20) NOT NULL COMMENT '任务分类名称',
  PRIMARY KEY  (`taskClassId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_taskclass
-- ----------------------------
INSERT INTO `t_taskclass` VALUES ('1', '网站开发类');
INSERT INTO `t_taskclass` VALUES ('2', '企业Logo设计');
INSERT INTO `t_taskclass` VALUES ('3', '商业活动策划');

-- ----------------------------
-- Table structure for `t_taskget`
-- ----------------------------
DROP TABLE IF EXISTS `t_taskget`;
CREATE TABLE `t_taskget` (
  `taskGetId` int(11) NOT NULL auto_increment COMMENT '领取id',
  `taskObj` int(11) NOT NULL COMMENT '领取的任务',
  `userObj` varchar(30) NOT NULL COMMENT '领取用户',
  `getTime` varchar(20) default NULL COMMENT '领取任务时间',
  `handleState` varchar(20) NOT NULL COMMENT '处理状态',
  `getTaskMemo` varchar(500) NOT NULL COMMENT '领取任务说明',
  PRIMARY KEY  (`taskGetId`),
  KEY `taskObj` (`taskObj`),
  KEY `userObj` (`userObj`),
  CONSTRAINT `t_taskget_ibfk_1` FOREIGN KEY (`taskObj`) REFERENCES `t_task` (`taskId`),
  CONSTRAINT `t_taskget_ibfk_2` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_taskget
-- ----------------------------
INSERT INTO `t_taskget` VALUES ('1', '1', 'user2', '2019-05-19 17:54:51', '进行中', '我正在开发中！预计5天完成');
INSERT INTO `t_taskget` VALUES ('2', '2', 'user3', '2019-05-22 14:24:33', '进行中', '--');

-- ----------------------------
-- Table structure for `t_taskstate`
-- ----------------------------
DROP TABLE IF EXISTS `t_taskstate`;
CREATE TABLE `t_taskstate` (
  `taskStateId` int(11) NOT NULL auto_increment COMMENT '状态id',
  `taskStateName` varchar(20) NOT NULL COMMENT '状态名称',
  PRIMARY KEY  (`taskStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_taskstate
-- ----------------------------
INSERT INTO `t_taskstate` VALUES ('1', '待领取');
INSERT INTO `t_taskstate` VALUES ('2', '已领取');
INSERT INTO `t_taskstate` VALUES ('3', '已结束');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `skillContent` varchar(8000) NOT NULL COMMENT '个人能力',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '王夏丽', '女', '2019-05-10', 'upload/4efd49c7-5c7a-4e9a-a3db-5eb90350bf80.jpg', '13508084035', 'wangxiali@163.com', '四川成都红星路13号', '<p>本人在广告公司从业多年，精通Photoshop平面图形设计</p>', '2019-05-19 17:53:35');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张晓霞', '女', '2019-05-10', 'upload/20256387-3a02-4541-a6fe-4883cf714222.jpg', '13573598343', 'zhangxiaoxia@163.com', '四川南充滨江路', '<p>本人精通各种网站开发语言，包括asp.net, jsp, php等等，需要开发网站找我</p>', '2019-05-22 13:26:02');
INSERT INTO `t_userinfo` VALUES ('user3', '123', '王甜甜', '女', '2019-05-17', 'upload/f99fd575-5a04-4878-861e-f604898ce7a6.jpg', '13980308435', 'wangtiantian@163.com', '四川成都红星路13号bbb', '<p>我在平面设计公司服务多年，拥有丰富的图片处理经验，特别是处理企业Logo设计这块是大神！<br/></p>', '2019-05-22 15:05:38');
