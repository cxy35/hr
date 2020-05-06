/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1_mysql(3306)
Source Server Version : 50545
Source Host           : 127.0.0.1:3306
Source Database       : hr

Target Server Type    : MYSQL
Target Server Version : 50545
File Encoding         : 65001

Date: 2020-05-05 17:23:12
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adjustsalary
-- ----------------------------
DROP TABLE IF EXISTS `adjustsalary`;
CREATE TABLE `adjustsalary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `asDate` date DEFAULT NULL COMMENT '调薪日期',
  `beforeSalary` int(11) DEFAULT NULL COMMENT '调前薪资',
  `afterSalary` int(11) DEFAULT NULL COMMENT '调后薪资',
  `reason` varchar(255) DEFAULT NULL COMMENT '调薪原因',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `adjustsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adjustsalary
-- ----------------------------

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `appDate` date DEFAULT NULL COMMENT '考评日期',
  `appResult` varchar(32) DEFAULT NULL COMMENT '考评结果',
  `appContent` varchar(255) DEFAULT NULL COMMENT '考评内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `appraise_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appraise
-- ----------------------------

-- ----------------------------
-- Table structure for employeeec
-- ----------------------------
DROP TABLE IF EXISTS `employeeec`;
CREATE TABLE `employeeec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL COMMENT '员工编号',
  `ecDate` date DEFAULT NULL COMMENT '奖罚日期',
  `ecReason` varchar(255) DEFAULT NULL COMMENT '奖罚原因',
  `ecPoint` int(11) DEFAULT NULL COMMENT '奖罚分',
  `ecType` int(11) DEFAULT NULL COMMENT '奖罚类别，0：奖，1：罚',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `employeeec_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employeeec
-- ----------------------------

-- ----------------------------
-- Table structure for employeeremove
-- ----------------------------
DROP TABLE IF EXISTS `employeeremove`;
CREATE TABLE `employeeremove` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `afterDepId` int(11) DEFAULT NULL COMMENT '调动后部门',
  `afterJobId` int(11) DEFAULT NULL COMMENT '调动后职位',
  `removeDate` date DEFAULT NULL COMMENT '调动日期',
  `reason` varchar(255) DEFAULT NULL COMMENT '调动原因',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `employeeremove_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employeeremove
-- ----------------------------

-- ----------------------------
-- Table structure for employeetrain
-- ----------------------------
DROP TABLE IF EXISTS `employeetrain`;
CREATE TABLE `employeetrain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL COMMENT '员工编号',
  `trainDate` date DEFAULT NULL COMMENT '培训日期',
  `trainContent` varchar(255) DEFAULT NULL COMMENT '培训内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `employeetrain_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `t_employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employeetrain
-- ----------------------------

-- ----------------------------
-- Table structure for msgcontent
-- ----------------------------
DROP TABLE IF EXISTS `msgcontent`;
CREATE TABLE `msgcontent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msgcontent
-- ----------------------------
INSERT INTO `msgcontent` VALUES ('14', '2222222222', '11111111111111111', '2018-02-02 20:46:19');
INSERT INTO `msgcontent` VALUES ('15', '22222222', '3333333333333333333333', '2018-02-02 21:45:57');
INSERT INTO `msgcontent` VALUES ('16', '通知标题1', '通知内容1', '2018-02-03 11:41:39');
INSERT INTO `msgcontent` VALUES ('17', '通知标题2', '通知内容2', '2018-02-03 11:52:37');
INSERT INTO `msgcontent` VALUES ('18', '通知标题3', '通知内容3', '2018-02-03 12:19:41');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addDate` date DEFAULT NULL COMMENT '添加日期',
  `operate` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `hrid` int(11) DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`id`),
  KEY `hrid` (`hrid`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oplog
-- ----------------------------

-- ----------------------------
-- Table structure for sysmsg
-- ----------------------------
DROP TABLE IF EXISTS `sysmsg`;
CREATE TABLE `sysmsg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL COMMENT '消息id',
  `type` int(11) DEFAULT '0' COMMENT '0表示群发消息',
  `hrid` int(11) DEFAULT NULL COMMENT '这条消息是给谁的',
  `state` int(11) DEFAULT '0' COMMENT '0 未读 1 已读',
  PRIMARY KEY (`id`),
  KEY `hrid` (`hrid`),
  KEY `sysmsg_ibfk_1` (`mid`),
  CONSTRAINT `sysmsg_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `msgcontent` (`id`),
  CONSTRAINT `sysmsg_ibfk_2` FOREIGN KEY (`hrid`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysmsg
-- ----------------------------
INSERT INTO `sysmsg` VALUES ('57', '14', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('58', '14', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('59', '14', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('60', '14', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('61', '14', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('62', '15', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('63', '15', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('64', '15', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('65', '15', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('66', '15', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('67', '16', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('68', '16', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('69', '16', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('70', '16', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('71', '16', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('72', '17', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('73', '17', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('74', '17', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('75', '17', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('76', '17', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('77', '18', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('78', '18', '0', '5', '0');
INSERT INTO `sysmsg` VALUES ('79', '18', '0', '10', '0');
INSERT INTO `sysmsg` VALUES ('80', '18', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('81', '18', '0', '12', '0');

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '部门名称',
  `parentId` int(11) DEFAULT NULL,
  `depPath` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `isParent` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of t_department
-- ----------------------------
INSERT INTO `t_department` VALUES ('1', '股东会', '-1', '.1', '1', '1');
INSERT INTO `t_department` VALUES ('4', '董事会', '1', '.1.4', '1', '1');
INSERT INTO `t_department` VALUES ('5', '总办', '4', '.1.4.5', '1', '1');
INSERT INTO `t_department` VALUES ('8', '财务部', '5', '.1.4.5.8', '1', '0');
INSERT INTO `t_department` VALUES ('78', '市场部', '5', '.1.4.5.78', '1', '1');
INSERT INTO `t_department` VALUES ('81', '华北市场部', '78', '.1.4.5.78.81', '1', '1');
INSERT INTO `t_department` VALUES ('82', '华南市场部', '78', '.1.4.5.78.82', '1', '0');
INSERT INTO `t_department` VALUES ('85', '石家庄市场部', '81', '.1.4.5.78.81.85', '1', '0');
INSERT INTO `t_department` VALUES ('86', '西北市场部', '78', '.1.4.5.78.86', '1', '1');
INSERT INTO `t_department` VALUES ('87', '西安市场', '86', '.1.4.5.78.86.87', '1', '1');
INSERT INTO `t_department` VALUES ('89', '莲湖区市场', '87', '.1.4.5.78.86.87.89', '1', '0');
INSERT INTO `t_department` VALUES ('91', '技术部', '5', '.1.4.5.91', '1', '0');
INSERT INTO `t_department` VALUES ('92', '运维部', '5', '.1.4.5.92', '1', '1');
INSERT INTO `t_department` VALUES ('93', '运维1部', '92', '.1.4.5.92.93', '1', '0');
INSERT INTO `t_department` VALUES ('94', '运维2部', '92', '.1.4.5.92.94', '1', '0');
INSERT INTO `t_department` VALUES ('115', '测试部门1', '1', '.1.115', '1', '1');
INSERT INTO `t_department` VALUES ('124', 'aa', '115', '.1.115.124', '1', '1');
INSERT INTO `t_department` VALUES ('125', 'bb', '115', '.1.115.125', '1', '0');
INSERT INTO `t_department` VALUES ('126', 'a1', '124', '.1.115.124.126', '1', '0');

-- ----------------------------
-- Table structure for t_employee
-- ----------------------------
DROP TABLE IF EXISTS `t_employee`;
CREATE TABLE `t_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(10) DEFAULT NULL COMMENT '姓名',
  `gender` char(4) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `idCard` char(18) DEFAULT NULL COMMENT '身份证号码',
  `wedlock` enum('已婚','未婚','离异') DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(20) DEFAULT NULL COMMENT '籍贯',
  `politicsStatusId` int(8) DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(20) DEFAULT NULL COMMENT '电子邮箱',
  `phone` varchar(11) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(11) DEFAULT NULL COMMENT '所属部门',
  `jobTitleId` int(11) DEFAULT NULL COMMENT '职称',
  `positionId` int(11) DEFAULT NULL COMMENT '职位',
  `salaryId` int(11) DEFAULT NULL COMMENT '工资账套',
  `engageForm` varchar(8) DEFAULT NULL COMMENT '聘用形式',
  `tiptopDegree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) DEFAULT NULL COMMENT '专业',
  `school` varchar(32) DEFAULT NULL COMMENT '毕业院校',
  `beginDate` date DEFAULT NULL COMMENT '入职日期',
  `workState` enum('在职','离职') DEFAULT '在职' COMMENT '在职状态',
  `workId` char(8) DEFAULT NULL COMMENT '工号',
  `contractTerm` double DEFAULT NULL COMMENT '合同期限',
  `conversionTime` date DEFAULT NULL COMMENT '转正日期',
  `notWorkDate` date DEFAULT NULL COMMENT '离职日期',
  `beginContract` date DEFAULT NULL COMMENT '合同起始日期',
  `endContract` date DEFAULT NULL COMMENT '合同终止日期',
  `workAge` int(11) DEFAULT NULL COMMENT '工龄',
  PRIMARY KEY (`id`),
  KEY `idx_departmentId` (`departmentId`) USING BTREE,
  KEY `idx_nationId` (`nationId`) USING BTREE,
  KEY `idx_jobTitleId` (`jobTitleId`) USING BTREE,
  KEY `idx_positonId` (`positionId`) USING BTREE,
  KEY `idx_politicsStatusId` (`politicsStatusId`) USING BTREE,
  KEY `idx_workId` (`workId`),
  KEY `idx_salaryId` (`salaryId`) USING BTREE,
  CONSTRAINT `fk_emp_departmentId` FOREIGN KEY (`departmentId`) REFERENCES `t_department` (`id`),
  CONSTRAINT `fk_emp_jobTitleId` FOREIGN KEY (`jobTitleId`) REFERENCES `t_jobtitle` (`id`),
  CONSTRAINT `fk_emp_nationId` FOREIGN KEY (`nationId`) REFERENCES `t_nation` (`id`),
  CONSTRAINT `fk_emp_politicsStatusId` FOREIGN KEY (`politicsStatusId`) REFERENCES `t_politicsstatus` (`id`),
  CONSTRAINT `fk_emp_positonId` FOREIGN KEY (`positionId`) REFERENCES `t_position` (`id`),
  CONSTRAINT `fk_emp_salaryId` FOREIGN KEY (`salaryId`) REFERENCES `t_salary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1967 DEFAULT CHARSET=utf8 COMMENT='员工';

-- ----------------------------
-- Records of t_employee
-- ----------------------------
INSERT INTO `t_employee` VALUES ('1', '程序员35', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '5', '9', '29', '19', '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', '2', '2018-04-01', null, '2018-01-01', '2020-01-01', null);
INSERT INTO `t_employee` VALUES ('2', '陈静', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '91', '12', '29', '13', '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('3', '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', '10', '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('4', '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', '9', '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('5', '姚森', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', '19', '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('6', '云星', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('7', '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('8', '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('9', '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', '6', '2018-04-01', null, '2018-01-01', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('10', '张洁', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', null, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', '1', '2018-01-31', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('11', '程序员35-2', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '91', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('12', '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('13', '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('14', '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('15', '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('16', '云星2', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('17', '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('18', '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('19', '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('20', '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', null, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', '1', '2018-01-31', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('21', '程序员35-3', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('22', '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('24', '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('25', '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('26', '云星3', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('27', '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('28', '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('29', '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', '6', '2018-04-01', null, '2018-01-01', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('31', '程序员35-4', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('32', '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('33', '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('34', '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('35', '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('36', '云星4', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('37', '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('38', '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('39', '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', '6', '2018-04-01', null, '2018-01-01', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('40', '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', null, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', '1', '2018-01-31', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('41', '程序员35-5', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('42', '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('43', '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('44', '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('45', '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('46', '云星5', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('47', '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('48', '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('49', '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', '6', '2018-04-01', null, '2018-01-01', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('50', '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', null, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', '1', '2018-01-31', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('51', '程序员35-6', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000051', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('52', '陈静6', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000052', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('53', '赵琳浩6', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000053', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('54', '鹿存亮6', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000054', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('55', '姚森6', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000055', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('56', '云星6', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000056', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1351', '程序员35', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1352', '陈静', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', '3', null, null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('1353', '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1354', '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1355', '姚森', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', '7', null, null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1357', '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1358', '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', '7', null, null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('1359', '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', '6', null, null, '2018-01-01', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1360', '张洁', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', null, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1361', '程序员35-2', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1362', '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', '3', null, null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('1363', '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1364', '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1365', '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', '7', null, null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1366', '云星2', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1367', '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1368', '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', '7', null, null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('1369', '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1370', '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', null, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1371', '程序员35-3', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1372', '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', '3', null, null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('1373', '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1374', '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', '7', null, null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1375', '云星3', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1376', '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1377', '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', null, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', '7', null, null, '2018-01-01', '2025-01-30', null);
INSERT INTO `t_employee` VALUES ('1378', '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', null, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', '6', null, null, '2018-01-01', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1379', '程序员35-4', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '8', '9', '29', null, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', '1', null, null, '2018-01-01', '2019-01-01', null);
INSERT INTO `t_employee` VALUES ('1380', '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', '3', null, null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('1381', '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1382', '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1383', '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', '7', null, null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1384', '云星4', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1385', '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1411', '谢工', '女', '1970-01-01', '618177197001011234', '离异', '1', '江苏', '1', '584991843@qq.com', '18558887788', '北京', '85', '12', '29', null, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', '5', '2019-01-01', null, '2018-01-01', '2023-01-01', null);
INSERT INTO `t_employee` VALUES ('1412', '林昭亮', '男', '1990-01-01', '610122199809091234', '已婚', '1', '广东', '13', '584991843@qq.com', '16767776654', '广东深圳', '91', '15', '33', null, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', '5', '2018-04-01', null, '2018-01-01', '2023-01-01', null);
INSERT INTO `t_employee` VALUES ('1942', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '2', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '81', '10', '30', null, '劳务合同', '大专', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000066', '1.75', '2018-03-31', null, '2017-12-31', '2019-09-30', null);
INSERT INTO `t_employee` VALUES ('1943', '测试员工2', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '1', 'laowang@qq.com', '18565558897', '深圳市南山区', '91', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000067', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1944', '测试员工3', '男', '1989-12-31', '610122199001011256', '已婚', '2', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '81', '10', '30', null, '劳务合同', '大专', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000066', '1.75', '2018-03-31', null, '2017-12-31', '2019-09-30', null);
INSERT INTO `t_employee` VALUES ('1945', '测试员工4', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '1', 'laowang@qq.com', '18565558897', '深圳市南山区', '91', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000067', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1946', '测试员工5', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '82', '12', '30', null, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', '3', null, null, '2015-06-09', '2018-06-08', null);
INSERT INTO `t_employee` VALUES ('1947', '测试员工6', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', null, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1948', '测试员工7', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', null, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', '3.5', null, null, '2018-01-01', '2021-07-14', null);
INSERT INTO `t_employee` VALUES ('1949', '测试员工8', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', null, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', '7', null, null, '2017-01-02', '2024-01-17', null);
INSERT INTO `t_employee` VALUES ('1950', '测试员工9', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', null, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1951', '测试员工10', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', null, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', '5.25', null, null, '2018-01-01', '2023-04-13', null);
INSERT INTO `t_employee` VALUES ('1952', '测试员工11', '女', '1970-01-01', '618177197001011234', '离异', '1', '江苏', '1', '584991843@qq.com', '18558887788', '北京', '85', '12', '29', null, '劳动合同', '本科', '计算机软件', '南华大学', '2018-01-01', '在职', '00000038', '5', '2019-01-01', null, '2018-01-01', '2023-01-01', null);
INSERT INTO `t_employee` VALUES ('1953', '测试员工12', '男', '1990-01-01', '610122199809091234', '已婚', '1', '广东', '13', '584991843@qq.com', '16767776654', '广东深圳', '91', '15', '33', null, '劳动合同', '大专', '计算机软件', '广东职业技术学院', '2018-01-01', '在职', '00000039', '5', '2018-04-01', null, '2018-01-01', '2023-01-01', null);
INSERT INTO `t_employee` VALUES ('1954', '测试员工3', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '454407628@qq.com', '18565558897', '深圳市南山区', '91', '10', '36', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000068', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1955', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '454407628@qq.com', '18565558897', '深圳市南山区', '91', '10', '36', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000069', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1956', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '454407628@qq.com', '18565558897', '深圳市南山区', '78', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000070', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1957', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '454407628@qq.com', '18565558897', '深圳市南山区', '89', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000071', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1958', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '124', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000072', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1959', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '8', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000073', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1960', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '85', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000074', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1961', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '91', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000075', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1962', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '126', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000076', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1963', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '93', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000077', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1964', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '115', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000078', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1965', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '89', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000079', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);
INSERT INTO `t_employee` VALUES ('1966', '测试员工', '男', '1989-12-31', '610122199001011256', '已婚', '1', '陕西', '13', '799737179@qq.com', '13888888888', '深圳市南山区', '91', '9', '29', null, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2017-12-31', '在职', '00000080', '2', '2018-03-31', null, '2017-12-31', '2019-12-31', null);

-- ----------------------------
-- Table structure for t_jobtitle
-- ----------------------------
DROP TABLE IF EXISTS `t_jobtitle`;
CREATE TABLE `t_jobtitle` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '职称名称',
  `level` enum('正高级','副高级','中级','初级','员级') DEFAULT NULL COMMENT '职称等级',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COMMENT='职称';

-- ----------------------------
-- Records of t_jobtitle
-- ----------------------------
INSERT INTO `t_jobtitle` VALUES ('9', '教授', '正高级', '2018-01-11 00:00:00', '1');
INSERT INTO `t_jobtitle` VALUES ('10', '副教授', '副高级', '2018-01-11 21:19:20', '1');
INSERT INTO `t_jobtitle` VALUES ('12', '助教', '初级', '2018-01-11 21:35:39', '1');
INSERT INTO `t_jobtitle` VALUES ('13', '讲师', '中级', '2018-01-11 00:00:00', '1');
INSERT INTO `t_jobtitle` VALUES ('14', '初级工程师', '初级', '2018-01-14 00:00:00', '1');
INSERT INTO `t_jobtitle` VALUES ('15', '中级工程师66', '中级', '2018-01-14 00:00:00', '1');
INSERT INTO `t_jobtitle` VALUES ('16', '高级工程师', '副高级', '2018-01-14 16:19:14', '1');
INSERT INTO `t_jobtitle` VALUES ('17', '骨灰级工程师', '正高级', '2018-01-14 16:19:24', '1');
INSERT INTO `t_jobtitle` VALUES ('18', '测试职称1', '副高级', '2020-01-02 13:19:21', '0');

-- ----------------------------
-- Table structure for t_mail_send_log
-- ----------------------------
DROP TABLE IF EXISTS `t_mail_send_log`;
CREATE TABLE `t_mail_send_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `msgId` varchar(255) DEFAULT NULL,
  `empId` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '0' COMMENT '0投递中 1投递成功 2投递失败',
  `routeKey` varchar(255) DEFAULT NULL,
  `exchange` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT '0' COMMENT '重试次数',
  `tryTime` datetime DEFAULT NULL COMMENT '第一次重试时间',
  `createTime` datetime DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of t_mail_send_log
-- ----------------------------
INSERT INTO `t_mail_send_log` VALUES ('1', '625dc524-f643-4816-81ae-ec72b1c5e979', '1961', '1', 'hr.mail.employee.welcome.routingKey', 'hr.mail.employee.welcome.exchange', '0', '2020-05-05 17:00:37', '2020-05-05 16:59:37', '2020-05-05 16:59:37');
INSERT INTO `t_mail_send_log` VALUES ('2', '2d6632f8-4070-4cbe-afc8-c91399025fc6', '1963', '1', 'hr.mail.employee.welcome.routingKey', 'hr.mail.employee.welcome.exchange', '1', '2020-05-05 17:06:58', '2020-05-05 17:05:58', '2020-05-05 17:10:40');
INSERT INTO `t_mail_send_log` VALUES ('3', '1bd38c7d-2795-467b-9f21-86f70df58370', '1964', '2', 'hr.mail.employee.welcome.routingKey', 'hr.mail.employee.welcome.exchange', '3', '2020-05-05 17:13:19', '2020-05-05 17:12:19', '2020-05-05 17:13:40');
INSERT INTO `t_mail_send_log` VALUES ('4', '007ce125-3059-4017-9f27-b699fa307448', '1965', '2', 'hr.mail.employee.welcome.routingKey', 'hr.mail.employee.welcome.exchange', '3', '2020-05-05 17:19:36', '2020-05-05 17:18:36', '2020-05-05 17:20:00');
INSERT INTO `t_mail_send_log` VALUES ('5', 'a12078d1-a30b-4897-92f1-df293fcd13ad', '1966', '1', 'hr.mail.employee.welcome.routingKey', 'hr.mail.employee.welcome.exchange', '0', '2020-05-05 17:21:53', '2020-05-05 17:20:53', '2020-05-05 17:20:53');

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `url` varchar(64) DEFAULT NULL,
  `path` varchar(64) DEFAULT NULL,
  `component` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `iconCls` varchar(64) DEFAULT NULL,
  `keepAlive` tinyint(1) DEFAULT NULL,
  `requireAuth` tinyint(1) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `idx_parentId` (`parentId`) USING BTREE,
  CONSTRAINT `fk_m_parentId` FOREIGN KEY (`parentId`) REFERENCES `t_menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES ('1', '/', null, null, '所有', null, null, null, null, '1');
INSERT INTO `t_menu` VALUES ('2', '/', '/home', 'Home', '员工资料', 'fa fa-user-circle-o', null, '1', '1', '1');
INSERT INTO `t_menu` VALUES ('3', '/', '/home', 'Home', '人事管理', 'fa fa-address-card-o', null, '1', '1', '1');
INSERT INTO `t_menu` VALUES ('4', '/', '/home', 'Home', '薪资管理', 'fa fa-money', null, '1', '1', '1');
INSERT INTO `t_menu` VALUES ('5', '/', '/home', 'Home', '统计管理', 'fa fa-bar-chart', null, '1', '1', '1');
INSERT INTO `t_menu` VALUES ('6', '/', '/home', 'Home', '系统管理', 'fa fa-windows', null, '1', '1', '1');
INSERT INTO `t_menu` VALUES ('7', '/employee/basic/**', '/emp/basic', 'EmpBasic', '基本资料', null, null, '1', '2', '1');
INSERT INTO `t_menu` VALUES ('8', '/employee/advanced/**', '/emp/adv', 'EmpAdv', '高级资料', null, null, '1', '2', '1');
INSERT INTO `t_menu` VALUES ('9', '/personnel/emp/**', '/per/emp', 'PerEmp', '员工资料', null, null, '1', '3', '1');
INSERT INTO `t_menu` VALUES ('10', '/personnel/ec/**', '/per/ec', 'PerEc', '员工奖惩', null, null, '1', '3', '1');
INSERT INTO `t_menu` VALUES ('11', '/personnel/train/**', '/per/train', 'PerTrain', '员工培训', null, null, '1', '3', '1');
INSERT INTO `t_menu` VALUES ('12', '/personnel/salary/**', '/per/salary', 'PerSalary', '员工调薪', null, null, '1', '3', '1');
INSERT INTO `t_menu` VALUES ('13', '/personnel/remove/**', '/per/mv', 'PerMv', '员工调动', null, null, '1', '3', '1');
INSERT INTO `t_menu` VALUES ('14', '/salary/sob/**', '/sal/sob', 'SalSob', '工资账套管理', null, null, '1', '4', '1');
INSERT INTO `t_menu` VALUES ('15', '/salary/sobcfg/**', '/sal/sobcfg', 'SalSobCfg', '员工账套设置', null, null, '1', '4', '1');
INSERT INTO `t_menu` VALUES ('16', '/salary/table/**', '/sal/table', 'SalTable', '工资表管理', null, null, '1', '4', '1');
INSERT INTO `t_menu` VALUES ('17', '/salary/month/**', '/sal/month', 'SalMonth', '月末处理', null, null, '1', '4', '1');
INSERT INTO `t_menu` VALUES ('18', '/salary/search/**', '/sal/search', 'SalSearch', '工资表查询', null, null, '1', '4', '1');
INSERT INTO `t_menu` VALUES ('19', '/statistics/all/**', '/sta/all', 'StaAll', '综合信息统计', null, null, '1', '5', '1');
INSERT INTO `t_menu` VALUES ('20', '/statistics/score/**', '/sta/score', 'StaScore', '员工积分统计', null, null, '1', '5', '1');
INSERT INTO `t_menu` VALUES ('21', '/statistics/personnel/**', '/sta/pers', 'StaPers', '人事信息统计', null, null, '1', '5', '1');
INSERT INTO `t_menu` VALUES ('22', '/statistics/recored/**', '/sta/record', 'StaRecord', '人事记录统计', null, null, '1', '5', '1');
INSERT INTO `t_menu` VALUES ('23', '/system/basic/**', '/sys/basic', 'SysBasic', '基础信息设置', null, null, '1', '6', '1');
INSERT INTO `t_menu` VALUES ('24', '/system/cfg/**', '/sys/cfg', 'SysCfg', '系统管理', null, null, '1', '6', '1');
INSERT INTO `t_menu` VALUES ('25', '/system/log/**', '/sys/log', 'SysLog', '操作日志管理', null, null, '1', '6', '1');
INSERT INTO `t_menu` VALUES ('26', '/system/user/**', '/sys/user', 'SysUser', '用户管理', null, null, '1', '6', '1');
INSERT INTO `t_menu` VALUES ('27', '/system/data/**', '/sys/data', 'SysData', '备份恢复数据库', null, null, '1', '6', '1');
INSERT INTO `t_menu` VALUES ('28', '/system/init/**', '/sys/init', 'SysInit', '初始化数据库', null, null, '1', '6', '1');

-- ----------------------------
-- Table structure for t_menu_role
-- ----------------------------
DROP TABLE IF EXISTS `t_menu_role`;
CREATE TABLE `t_menu_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `mid` int(11) DEFAULT NULL COMMENT '菜单id',
  `rid` int(11) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `idx_mid` (`mid`) USING BTREE,
  KEY `idx_rid` (`rid`) USING BTREE,
  CONSTRAINT `fk_mr_mid` FOREIGN KEY (`mid`) REFERENCES `t_menu` (`id`),
  CONSTRAINT `fk_mr_rid` FOREIGN KEY (`rid`) REFERENCES `t_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8 COMMENT='菜单与角色';

-- ----------------------------
-- Records of t_menu_role
-- ----------------------------
INSERT INTO `t_menu_role` VALUES ('161', '7', '3');
INSERT INTO `t_menu_role` VALUES ('162', '7', '6');
INSERT INTO `t_menu_role` VALUES ('163', '9', '6');
INSERT INTO `t_menu_role` VALUES ('164', '10', '6');
INSERT INTO `t_menu_role` VALUES ('165', '11', '6');
INSERT INTO `t_menu_role` VALUES ('166', '12', '6');
INSERT INTO `t_menu_role` VALUES ('167', '13', '6');
INSERT INTO `t_menu_role` VALUES ('168', '14', '6');
INSERT INTO `t_menu_role` VALUES ('169', '15', '6');
INSERT INTO `t_menu_role` VALUES ('170', '16', '6');
INSERT INTO `t_menu_role` VALUES ('171', '17', '6');
INSERT INTO `t_menu_role` VALUES ('172', '18', '6');
INSERT INTO `t_menu_role` VALUES ('173', '19', '6');
INSERT INTO `t_menu_role` VALUES ('174', '20', '6');
INSERT INTO `t_menu_role` VALUES ('175', '21', '6');
INSERT INTO `t_menu_role` VALUES ('176', '22', '6');
INSERT INTO `t_menu_role` VALUES ('177', '23', '6');
INSERT INTO `t_menu_role` VALUES ('178', '25', '6');
INSERT INTO `t_menu_role` VALUES ('179', '26', '6');
INSERT INTO `t_menu_role` VALUES ('180', '27', '6');
INSERT INTO `t_menu_role` VALUES ('181', '28', '6');
INSERT INTO `t_menu_role` VALUES ('182', '24', '6');
INSERT INTO `t_menu_role` VALUES ('247', '7', '4');
INSERT INTO `t_menu_role` VALUES ('248', '8', '4');
INSERT INTO `t_menu_role` VALUES ('249', '11', '4');
INSERT INTO `t_menu_role` VALUES ('250', '7', '2');
INSERT INTO `t_menu_role` VALUES ('251', '8', '2');
INSERT INTO `t_menu_role` VALUES ('252', '9', '2');
INSERT INTO `t_menu_role` VALUES ('253', '10', '2');
INSERT INTO `t_menu_role` VALUES ('254', '12', '2');
INSERT INTO `t_menu_role` VALUES ('255', '13', '2');
INSERT INTO `t_menu_role` VALUES ('256', '7', '1');
INSERT INTO `t_menu_role` VALUES ('257', '8', '1');
INSERT INTO `t_menu_role` VALUES ('258', '9', '1');
INSERT INTO `t_menu_role` VALUES ('259', '10', '1');
INSERT INTO `t_menu_role` VALUES ('260', '11', '1');
INSERT INTO `t_menu_role` VALUES ('261', '12', '1');
INSERT INTO `t_menu_role` VALUES ('262', '13', '1');
INSERT INTO `t_menu_role` VALUES ('263', '14', '1');
INSERT INTO `t_menu_role` VALUES ('264', '15', '1');
INSERT INTO `t_menu_role` VALUES ('265', '16', '1');
INSERT INTO `t_menu_role` VALUES ('266', '17', '1');
INSERT INTO `t_menu_role` VALUES ('267', '18', '1');
INSERT INTO `t_menu_role` VALUES ('268', '19', '1');
INSERT INTO `t_menu_role` VALUES ('269', '20', '1');
INSERT INTO `t_menu_role` VALUES ('270', '21', '1');
INSERT INTO `t_menu_role` VALUES ('271', '22', '1');
INSERT INTO `t_menu_role` VALUES ('272', '23', '1');
INSERT INTO `t_menu_role` VALUES ('273', '24', '1');
INSERT INTO `t_menu_role` VALUES ('274', '25', '1');
INSERT INTO `t_menu_role` VALUES ('275', '26', '1');
INSERT INTO `t_menu_role` VALUES ('276', '27', '1');
INSERT INTO `t_menu_role` VALUES ('277', '28', '1');

-- ----------------------------
-- Table structure for t_nation
-- ----------------------------
DROP TABLE IF EXISTS `t_nation`;
CREATE TABLE `t_nation` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='民族';

-- ----------------------------
-- Records of t_nation
-- ----------------------------
INSERT INTO `t_nation` VALUES ('1', '汉族');
INSERT INTO `t_nation` VALUES ('2', '蒙古族');
INSERT INTO `t_nation` VALUES ('3', '回族');
INSERT INTO `t_nation` VALUES ('4', '藏族');
INSERT INTO `t_nation` VALUES ('5', '维吾尔族');
INSERT INTO `t_nation` VALUES ('6', '苗族');
INSERT INTO `t_nation` VALUES ('7', '彝族');
INSERT INTO `t_nation` VALUES ('8', '壮族');
INSERT INTO `t_nation` VALUES ('9', '布依族');
INSERT INTO `t_nation` VALUES ('10', '朝鲜族');
INSERT INTO `t_nation` VALUES ('11', '满族');
INSERT INTO `t_nation` VALUES ('12', '侗族');
INSERT INTO `t_nation` VALUES ('13', '瑶族');
INSERT INTO `t_nation` VALUES ('14', '白族');
INSERT INTO `t_nation` VALUES ('15', '土家族');
INSERT INTO `t_nation` VALUES ('16', '哈尼族');
INSERT INTO `t_nation` VALUES ('17', '哈萨克族');
INSERT INTO `t_nation` VALUES ('18', '傣族');
INSERT INTO `t_nation` VALUES ('19', '黎族');
INSERT INTO `t_nation` VALUES ('20', '傈僳族');
INSERT INTO `t_nation` VALUES ('21', '佤族');
INSERT INTO `t_nation` VALUES ('22', '畲族');
INSERT INTO `t_nation` VALUES ('23', '高山族');
INSERT INTO `t_nation` VALUES ('24', '拉祜族');
INSERT INTO `t_nation` VALUES ('25', '水族');
INSERT INTO `t_nation` VALUES ('26', '东乡族');
INSERT INTO `t_nation` VALUES ('27', '纳西族');
INSERT INTO `t_nation` VALUES ('28', '景颇族');
INSERT INTO `t_nation` VALUES ('29', '柯尔克孜族');
INSERT INTO `t_nation` VALUES ('30', '土族');
INSERT INTO `t_nation` VALUES ('31', '达斡尔族');
INSERT INTO `t_nation` VALUES ('32', '仫佬族');
INSERT INTO `t_nation` VALUES ('33', '羌族');
INSERT INTO `t_nation` VALUES ('34', '布朗族');
INSERT INTO `t_nation` VALUES ('35', '撒拉族');
INSERT INTO `t_nation` VALUES ('36', '毛难族');
INSERT INTO `t_nation` VALUES ('37', '仡佬族');
INSERT INTO `t_nation` VALUES ('38', '锡伯族');
INSERT INTO `t_nation` VALUES ('39', '阿昌族');
INSERT INTO `t_nation` VALUES ('40', '普米族');
INSERT INTO `t_nation` VALUES ('41', '塔吉克族');
INSERT INTO `t_nation` VALUES ('42', '怒族');
INSERT INTO `t_nation` VALUES ('43', '乌孜别克族');
INSERT INTO `t_nation` VALUES ('44', '俄罗斯族');
INSERT INTO `t_nation` VALUES ('45', '鄂温克族');
INSERT INTO `t_nation` VALUES ('46', '崩龙族');
INSERT INTO `t_nation` VALUES ('47', '保安族');
INSERT INTO `t_nation` VALUES ('48', '裕固族');
INSERT INTO `t_nation` VALUES ('49', '京族');
INSERT INTO `t_nation` VALUES ('50', '塔塔尔族');
INSERT INTO `t_nation` VALUES ('51', '独龙族');
INSERT INTO `t_nation` VALUES ('52', '鄂伦春族');
INSERT INTO `t_nation` VALUES ('53', '赫哲族');
INSERT INTO `t_nation` VALUES ('54', '门巴族');
INSERT INTO `t_nation` VALUES ('55', '珞巴族');
INSERT INTO `t_nation` VALUES ('56', '基诺族');

-- ----------------------------
-- Table structure for t_politicsstatus
-- ----------------------------
DROP TABLE IF EXISTS `t_politicsstatus`;
CREATE TABLE `t_politicsstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='政治面貌';

-- ----------------------------
-- Records of t_politicsstatus
-- ----------------------------
INSERT INTO `t_politicsstatus` VALUES ('1', '中共党员');
INSERT INTO `t_politicsstatus` VALUES ('2', '中共预备党员');
INSERT INTO `t_politicsstatus` VALUES ('3', '共青团员');
INSERT INTO `t_politicsstatus` VALUES ('4', '民革党员');
INSERT INTO `t_politicsstatus` VALUES ('5', '民盟盟员');
INSERT INTO `t_politicsstatus` VALUES ('6', '民建会员');
INSERT INTO `t_politicsstatus` VALUES ('7', '民进会员');
INSERT INTO `t_politicsstatus` VALUES ('8', '农工党党员');
INSERT INTO `t_politicsstatus` VALUES ('9', '致公党党员');
INSERT INTO `t_politicsstatus` VALUES ('10', '九三学社社员');
INSERT INTO `t_politicsstatus` VALUES ('11', '台盟盟员');
INSERT INTO `t_politicsstatus` VALUES ('12', '无党派民主人士');
INSERT INTO `t_politicsstatus` VALUES ('13', '普通公民');

-- ----------------------------
-- Table structure for t_position
-- ----------------------------
DROP TABLE IF EXISTS `t_position`;
CREATE TABLE `t_position` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '职位名称',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8 COMMENT='职位';

-- ----------------------------
-- Records of t_position
-- ----------------------------
INSERT INTO `t_position` VALUES ('29', '技术总监', '2018-01-11 21:13:42', '1');
INSERT INTO `t_position` VALUES ('30', '运营总监', '2018-01-11 21:13:48', '1');
INSERT INTO `t_position` VALUES ('31', '市场总监', '2018-01-11 00:00:00', '1');
INSERT INTO `t_position` VALUES ('33', '研发工程师', '2018-01-14 00:00:00', '1');
INSERT INTO `t_position` VALUES ('34', '运维工程师', '2018-01-14 16:11:41', '1');
INSERT INTO `t_position` VALUES ('36', 'Java研发经理', '2019-10-01 00:00:00', '1');
INSERT INTO `t_position` VALUES ('41', '测试职位1', '2020-01-02 10:06:03', '0');
INSERT INTO `t_position` VALUES ('42', 'aa', '2020-01-18 10:33:11', '1');
INSERT INTO `t_position` VALUES ('45', 'bb', '2020-01-18 10:36:32', '1');
INSERT INTO `t_position` VALUES ('47', '11', '2020-01-18 10:39:02', '1');
INSERT INTO `t_position` VALUES ('48', 'aaa', '2020-01-18 10:39:22', '1');
INSERT INTO `t_position` VALUES ('49', 'aaccc', '2020-01-18 10:51:15', '1');

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `nameZh` varchar(64) DEFAULT NULL COMMENT '角色中文名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('1', 'ROLE_manager', '部门经理');
INSERT INTO `t_role` VALUES ('2', 'ROLE_personnel', '人事专员');
INSERT INTO `t_role` VALUES ('3', 'ROLE_recruiter', '招聘主管');
INSERT INTO `t_role` VALUES ('4', 'ROLE_train', '培训主管');
INSERT INTO `t_role` VALUES ('5', 'ROLE_performance', '薪酬绩效主管');
INSERT INTO `t_role` VALUES ('6', 'ROLE_admin', '系统管理员');
INSERT INTO `t_role` VALUES ('14', 'ROLE_test1', '测试角色1');
INSERT INTO `t_role` VALUES ('15', 'ROLE_test2', '测试角色2');

-- ----------------------------
-- Table structure for t_salary
-- ----------------------------
DROP TABLE IF EXISTS `t_salary`;
CREATE TABLE `t_salary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '账套名称',
  `basicSalary` int(11) DEFAULT NULL COMMENT '基本工资',
  `bonus` int(11) DEFAULT NULL COMMENT '奖金',
  `lunchSalary` int(11) DEFAULT NULL COMMENT '午餐补助',
  `trafficSalary` int(11) DEFAULT NULL COMMENT '交通补助',
  `allSalary` int(11) DEFAULT NULL COMMENT '应发工资',
  `pensionBase` int(11) DEFAULT NULL COMMENT '养老金基数',
  `pensionPer` float DEFAULT NULL COMMENT '养老金比率',
  `medicalBase` int(11) DEFAULT NULL COMMENT '医疗保险基数',
  `medicalPer` float DEFAULT NULL COMMENT '医疗保险比率',
  `accumulationFundBase` int(11) DEFAULT NULL COMMENT '公积金基数',
  `accumulationFundPer` float DEFAULT NULL COMMENT '公积金比率',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COMMENT='工资账套';

-- ----------------------------
-- Records of t_salary
-- ----------------------------
INSERT INTO `t_salary` VALUES ('9', '市场部工资账套', '9000', '4000', '800', '500', null, '2000', '0.07', '2000', '0.07', '2000', '0.07', '2018-01-24 00:00:00');
INSERT INTO `t_salary` VALUES ('10', '人事部工资账套', '2000', '2000', '400', '1000', null, '2000', '0.07', '2000', '0.07', '2000', '0.07', '2018-01-01 00:00:00');
INSERT INTO `t_salary` VALUES ('13', '运维部工资账套', '20000', '3000', '500', '500', null, '4000', '0.07', '4000', '0.07', '4000', '0.07', '2018-01-25 00:00:00');
INSERT INTO `t_salary` VALUES ('19', '测试工资账套', '8888', '700', '600', '500', null, '5000', '0.05', '6000', '0.06', '7000', '0.07', '2020-01-23 20:18:21');

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `phone` char(11) DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) DEFAULT NULL COMMENT '地址',
  `enabled` tinyint(1) DEFAULT '1',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `userface` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('3', '系统管理员', '18568887789', '029-82881234', '深圳南山', '1', 'admin', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', '');
INSERT INTO `t_user` VALUES ('5', '李白', '18568123489', '029-82123434', '海口美兰', '1', 'libai', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', '');
INSERT INTO `t_user` VALUES ('10', '韩愈', '18568123666', '029-82111555', '广州番禺', '1', 'hanyu', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', '');
INSERT INTO `t_user` VALUES ('11', '柳宗元', '18568123377', '029-82111333', '广州天河', '1', 'liuzongyuan', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515233756&di=0856d923a0a37a87fd26604a2c871370&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.qqzhi.com%2Fuploadpic%2F2014-09-27%2F041716704.jpg', '');
INSERT INTO `t_user` VALUES ('12', '曾巩', '18568128888', '029-82111222', '广州越秀', '1', 'zenggong', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', '');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `rid` int(11) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  KEY `idx_rid` (`rid`) USING BTREE,
  KEY `idx_uid` (`uid`) USING BTREE,
  CONSTRAINT `fk_ur_rid` FOREIGN KEY (`rid`) REFERENCES `t_role` (`id`),
  CONSTRAINT `fk_ur_uid` FOREIGN KEY (`uid`) REFERENCES `t_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COMMENT='用户与角色';

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES ('1', '3', '6');
INSERT INTO `t_user_role` VALUES ('35', '12', '4');
INSERT INTO `t_user_role` VALUES ('36', '12', '3');
INSERT INTO `t_user_role` VALUES ('37', '12', '2');
INSERT INTO `t_user_role` VALUES ('43', '11', '3');
INSERT INTO `t_user_role` VALUES ('44', '11', '2');
INSERT INTO `t_user_role` VALUES ('45', '11', '4');
INSERT INTO `t_user_role` VALUES ('46', '11', '5');
INSERT INTO `t_user_role` VALUES ('48', '10', '3');
INSERT INTO `t_user_role` VALUES ('49', '10', '4');
INSERT INTO `t_user_role` VALUES ('61', '5', '1');
INSERT INTO `t_user_role` VALUES ('62', '5', '3');

-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
  -- 未使用，已经改成service实现
  declare did int;
  declare pDepPath varchar(64);
  insert into t_department set name=depName,parentId=parentId,enabled=enabled;
  select row_count() into result;
  select last_insert_id() into did;
  set result2=did;
  select depPath into pDepPath from t_department where id=parentId;
  update t_department set depPath=concat(pDepPath,'.',did) where id=did;
  update t_department set isParent=true where id=parentId;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDep`(in did int,out result int)
begin
  -- 未使用，已经改成service实现
  declare ecount int;
  declare pid int;
  declare pcount int;
  declare a int;
  select count(*) into a from t_department where id=did and isParent=false;
  if a=0 then set result=-2;
  else
  select count(*) into ecount from t_employee where departmentId=did;
  if ecount>0 then set result=-1;
  else 
  select parentId into pid from t_department where id=did;
  delete from t_department where id=did and isParent=false;
  select row_count() into result;
  select count(*) into pcount from t_department where parentId=pid;
  if pcount=0 then update t_department set isParent=false where id=pid;
  end if;
  end if;
  end if;
end
;;
DELIMITER ;
