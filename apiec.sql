-- phpMyAdmin SQL Dump
-- version 4.4.15.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 2017-07-05 10:07:19
-- 服务器版本： 5.5.48-log
-- PHP Version: 7.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apiec`
--

-- --------------------------------------------------------

--
-- 表的结构 `admin`
--

CREATE TABLE IF NOT EXISTS `admin` (
  `AdminID` int(11) NOT NULL COMMENT '管理员ID',
  `UserID` int(11) NOT NULL COMMENT '用户ID',
  `UName` varchar(15) NOT NULL COMMENT '用户姓名',
  `CivilID` varchar(20) NOT NULL COMMENT '教职工账号',
  `SchoolID` varchar(11) NOT NULL COMMENT '学校ID',
  `Gender` char(2) NOT NULL COMMENT '性别',
  `Phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `Email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `Address` varchar(100) DEFAULT NULL COMMENT '住址',
  `Birthday` varchar(50) DEFAULT NULL
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `admin`
--

INSERT INTO `admin` (`AdminID`, `UserID`, `UName`, `CivilID`, `SchoolID`, `Gender`, `Phone`, `Email`, `Address`, `Birthday`) VALUES
(1, 3, 'aa', '', '1', '', NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `answerinfo`
--

CREATE TABLE IF NOT EXISTS `answerinfo` (
  `ExNO` int(11) NOT NULL COMMENT '课堂活动编号',
  `StuID` int(11) NOT NULL COMMENT '学生ID',
  `ItemIndex` tinyint(4) NOT NULL COMMENT '题号',
  `Score` float DEFAULT NULL COMMENT '成绩',
  `Selection` varchar(255) NOT NULL COMMENT '学生选择的选项',
  `SpendTime` smallint(6) DEFAULT NULL COMMENT '花费时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `classes`
--

CREATE TABLE IF NOT EXISTS `classes` (
  `ClassID` int(11) NOT NULL COMMENT '班级ID',
  `SchoolID` int(11) NOT NULL COMMENT '学校ID',
  `TID` varchar(20) NOT NULL COMMENT '班主任ID',
  `CreatTime` varchar(6255) NOT NULL COMMENT '创建班级时间',
  `ClassName` varchar(20) NOT NULL COMMENT '班级名称'
) ENGINE=MyISAM AUTO_INCREMENT=74 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `classes`
--

INSERT INTO `classes` (`ClassID`, `SchoolID`, `TID`, `CreatTime`, `ClassName`) VALUES
(52, 1, '8', '7年级', '初一二班'),
(58, 1, '8', '7年级', '初一二班'),
(54, 1, '5', '08级', '高二3班'),
(55, 1, '8', '7年级', '初一二班'),
(56, 1, '8', '7年级', '初一二班'),
(57, 1, '8', '7年级', '初一二班'),
(59, 1, '8', '2016', '1603'),
(60, 1, '8', '7年级', '初一二班'),
(61, 1, '8', '7年级', '初一二班'),
(62, 1, '8', '7年级', '初一二班'),
(63, 1, '8', '7年级', '初一二班'),
(64, 1, '8', '7年级', '初一二班'),
(65, 1, '8', '7年级', '初一二班'),
(66, 1, '8', '7年级', '初一二班'),
(73, 1, '12', '2016', '2');

-- --------------------------------------------------------

--
-- 表的结构 `course`
--

CREATE TABLE IF NOT EXISTS `course` (
  `CourseID` int(11) NOT NULL COMMENT '课程ID',
  `TID` int(11) NOT NULL COMMENT '任课老师ID',
  `ClassID` int(11) NOT NULL COMMENT '班级ID',
  `SNO` smallint(6) NOT NULL COMMENT '学期编号',
  `CourseName` varchar(50) NOT NULL COMMENT '课程名称',
  `SchoolID` int(11) NOT NULL COMMENT '学校ID'
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `course`
--

INSERT INTO `course` (`CourseID`, `TID`, `ClassID`, `SNO`, `CourseName`, `SchoolID`) VALUES
(2, 8, 52, 1, '语文课', 1),
(3, 8, 52, 1, '语文课1', 1),
(4, 8, 52, 1, '语文课12', 1),
(5, 8, 52, 1, '语文课123', 1),
(6, 8, 52, 1, '语文课1234', 1);

-- --------------------------------------------------------

--
-- 表的结构 `exercise`
--

CREATE TABLE IF NOT EXISTS `exercise` (
  `ExNO` int(11) NOT NULL COMMENT '课堂活动编号',
  `TID` int(11) NOT NULL COMMENT '课堂活动老师ID',
  `CourseID` int(11) NOT NULL COMMENT '课程ID',
  `ClassID` int(11) NOT NULL COMMENT '班级ID',
  `SNO` smallint(6) NOT NULL COMMENT '学期编号',
  `ExType` char(1) NOT NULL COMMENT '活动类型',
  `ExName` varchar(50) NOT NULL COMMENT '活动名称',
  `EndTime` datetime NOT NULL COMMENT '活动结束时间',
  `ExTime` datetime DEFAULT NULL COMMENT '活动开始时间',
  `QNumber` tinyint(4) NOT NULL COMMENT '活动题目个数',
  `StuCount` tinyint(4) NOT NULL COMMENT '参与活动的学生个数',
  `AvgScore` float NOT NULL COMMENT '全班活动平均成绩',
  `AnsNum` smallint(6) NOT NULL COMMENT '全班答题总数',
  `TrueNum` smallint(6) NOT NULL COMMENT '全班答对题总数',
  `TrueRate` float NOT NULL COMMENT '全班答对率',
  `TotalSpendTime` smallint(6) NOT NULL COMMENT '总花费时间',
  `AvgSpendTime` float NOT NULL COMMENT '全班平均花费时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `exerciseitem`
--

CREATE TABLE IF NOT EXISTS `exerciseitem` (
  `ExNO` int(11) NOT NULL COMMENT '课程活动编号',
  `ItemIndex` tinyint(4) NOT NULL COMMENT '题号',
  `Question` varchar(255) NOT NULL COMMENT '题目内容',
  `Type` varchar(20) NOT NULL COMMENT '题目类型',
  `Answer` varchar(255) NOT NULL COMMENT '正确答案',
  `Url` varchar(255) NOT NULL COMMENT '题目图片',
  `AnsNum` tinyint(4) NOT NULL COMMENT '回答该题人数',
  `TrueNum` tinyint(4) DEFAULT NULL COMMENT '答对该题人数',
  `TrueRate` float NOT NULL COMMENT '该题答对率',
  `AnsSpendTime` smallint(6) NOT NULL COMMENT '答题时间',
  `AvgSpendTime` float NOT NULL COMMENT '该题平均花费时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `exscore`
--

CREATE TABLE IF NOT EXISTS `exscore` (
  `ExNO` int(11) NOT NULL COMMENT '课堂活动编号',
  `StuID` int(11) NOT NULL COMMENT '学生ID',
  `SNO` smallint(6) NOT NULL,
  `SubmitTime` datetime NOT NULL COMMENT '提交活动时间',
  `Score` float DEFAULT NULL COMMENT '活动成绩',
  `AnsNum` tinyint(4) NOT NULL COMMENT '答题总数',
  `TrueNum` tinyint(4) NOT NULL COMMENT '答对题数',
  `TrueRate` float NOT NULL COMMENT '答对率',
  `SpendTime` smallint(6) DEFAULT NULL COMMENT '活动花费时间'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `school`
--

CREATE TABLE IF NOT EXISTS `school` (
  `SchoolID` int(11) NOT NULL COMMENT '学校id',
  `SchoolName` varchar(50) NOT NULL COMMENT '学校名称',
  `SchoolCode` varchar(20) DEFAULT NULL COMMENT '学校编号',
  `Address` varchar(100) DEFAULT NULL COMMENT '学校地址',
  `Telephone` varchar(100) DEFAULT NULL COMMENT '学校电话'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `school`
--

INSERT INTO `school` (`SchoolID`, `SchoolName`, `SchoolCode`, `Address`, `Telephone`) VALUES
(1, '清华大学', '000001', '北京', '010-222332323');

-- --------------------------------------------------------

--
-- 表的结构 `semester`
--

CREATE TABLE IF NOT EXISTS `semester` (
  `SNO` smallint(6) NOT NULL COMMENT '学期编号',
  `AcademicYear` smallint(6) NOT NULL COMMENT '当前学年',
  `SOrder` char(1) NOT NULL COMMENT '学期',
  `SchoolID` int(11) NOT NULL COMMENT '学校ID'
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `semester`
--

INSERT INTO `semester` (`SNO`, `AcademicYear`, `SOrder`, `SchoolID`) VALUES
(1, 2016, '上', 1),
(2, 22, '', 0);

-- --------------------------------------------------------

--
-- 表的结构 `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `StuID` int(11) NOT NULL COMMENT '学生ID',
  `UserID` int(11) NOT NULL COMMENT '用户ID',
  `UName` varchar(15) NOT NULL COMMENT '用户名',
  `CivilID` varchar(20) NOT NULL COMMENT '学号',
  `SchoolID` int(11) NOT NULL COMMENT '学校ID',
  `ClassID` int(11) NOT NULL COMMENT '班级ID',
  `SeatNO` varchar(50) NOT NULL COMMENT '座号',
  `Gender` char(2) NOT NULL COMMENT '性别',
  `Phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `Email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `Address` varchar(100) DEFAULT NULL COMMENT '住址',
  `Birthday` varchar(50) DEFAULT NULL COMMENT '出生日期'
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `student`
--

INSERT INTO `student` (`StuID`, `UserID`, `UName`, `CivilID`, `SchoolID`, `ClassID`, `SeatNO`, `Gender`, `Phone`, `Email`, `Address`, `Birthday`) VALUES
(16, 34, '小明同学', '2222222444', 1, 52, '四排5号1', '男', NULL, NULL, NULL, NULL),
(17, 35, '小明同学', '2222222441', 1, 52, '四排5号1', '男', NULL, NULL, NULL, NULL),
(20, 45, '王刚', '1902144', 1, 66, '14', '男', '253453446', '5474576', NULL, NULL);

-- --------------------------------------------------------

--
-- 表的结构 `teacher`
--

CREATE TABLE IF NOT EXISTS `teacher` (
  `TID` int(11) NOT NULL COMMENT '教师ID',
  `UserID` int(11) NOT NULL COMMENT '用户ID',
  `UName` varchar(15) NOT NULL,
  `CivilID` varchar(20) NOT NULL COMMENT '教职工账号',
  `SchoolID` int(11) NOT NULL COMMENT '学校ID',
  `Gender` char(2) NOT NULL COMMENT '性别',
  `Phone` varchar(50) DEFAULT NULL COMMENT '电话',
  `Email` varchar(50) DEFAULT NULL COMMENT '电子邮件',
  `Address` varchar(100) DEFAULT NULL COMMENT '住址',
  `Birthday` varchar(50) DEFAULT NULL COMMENT '出生日期'
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `teacher`
--

INSERT INTO `teacher` (`TID`, `UserID`, `UName`, `CivilID`, `SchoolID`, `Gender`, `Phone`, `Email`, `Address`, `Birthday`) VALUES
(8, 40, '小明同学', '11112', 1, '男', '3232323', '3333', NULL, NULL),
(11, 43, '王文', '3454523', 1, '女', '243145', '241', '', ''),
(12, 44, '吴红', '543256', 1, '女', '444', '4454', '', '');

-- --------------------------------------------------------

--
-- 表的结构 `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `UserID` int(11) NOT NULL COMMENT '用户id',
  `LoginID` varchar(32) NOT NULL COMMENT '登录账号',
  `password` varchar(32) NOT NULL DEFAULT '' COMMENT '登录密码',
  `IDLevel` char(1) NOT NULL COMMENT '身份',
  `token` varchar(255) DEFAULT NULL COMMENT '令牌',
  `LoginTime` varchar(32) DEFAULT NULL COMMENT '登陆时间',
  `LastLoginTime` varchar(32) DEFAULT NULL COMMENT '最新一次访问服务器时间'
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user`
--

INSERT INTO `user` (`UserID`, `LoginID`, `password`, `IDLevel`, `token`, `LoginTime`, `LastLoginTime`) VALUES
(3, 'admin', '96e79218965eb72c92a549dd5a330112', 'U', 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjMsImlzcyI6Imh0dHA6Ly9hcGkubG92ZXRkLmNuL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNDk5MjIwMzQ1LCJleHAiOjE0OTk0MzYzNDUsIm5iZiI6MTQ5OTIyMDM0NSwianRpIjoid1VkQkl3MzNXTGh5WEh5eSJ9.PC8wl8QiD_CLyVWI9XU7bF4NZbWVW0R6fv4z0ufihn4', '1499220345', '1499220345'),
(34, '2222222444', '7fa8282ad93047a4d6fe6111c93b308a', 'S', NULL, NULL, NULL),
(35, '2222222441', '7fa8282ad93047a4d6fe6111c93b308a', 'S', NULL, NULL, NULL),
(40, '11112', '7fa8282ad93047a4d6fe6111c93b308a', 'S', NULL, NULL, NULL),
(45, '1902144', '23eea58882a093b8dc3019ddbd1ace98', 'S', NULL, NULL, NULL),
(43, '3454523', 'fce2bae82e012f92bcb63a9cdc1a0f81', 'S', NULL, NULL, NULL),
(44, '543256', '6c7cd7ebf8187f1ed9adf08d6e995595', 'S', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`AdminID`);

--
-- Indexes for table `answerinfo`
--
ALTER TABLE `answerinfo`
  ADD PRIMARY KEY (`ExNO`,`StuID`,`ItemIndex`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`ClassID`);

--
-- Indexes for table `course`
--
ALTER TABLE `course`
  ADD PRIMARY KEY (`CourseID`);

--
-- Indexes for table `exercise`
--
ALTER TABLE `exercise`
  ADD PRIMARY KEY (`ExNO`);

--
-- Indexes for table `exerciseitem`
--
ALTER TABLE `exerciseitem`
  ADD PRIMARY KEY (`ExNO`,`ItemIndex`);

--
-- Indexes for table `exscore`
--
ALTER TABLE `exscore`
  ADD PRIMARY KEY (`ExNO`,`StuID`);

--
-- Indexes for table `semester`
--
ALTER TABLE `semester`
  ADD PRIMARY KEY (`SNO`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`StuID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`TID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `AdminID` int(11) NOT NULL AUTO_INCREMENT COMMENT '管理员ID',AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `ClassID` int(11) NOT NULL AUTO_INCREMENT COMMENT '班级ID',AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT for table `course`
--
ALTER TABLE `course`
  MODIFY `CourseID` int(11) NOT NULL AUTO_INCREMENT COMMENT '课程ID',AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `exercise`
--
ALTER TABLE `exercise`
  MODIFY `ExNO` int(11) NOT NULL AUTO_INCREMENT COMMENT '课堂活动编号';
--
-- AUTO_INCREMENT for table `semester`
--
ALTER TABLE `semester`
  MODIFY `SNO` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '学期编号',AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `StuID` int(11) NOT NULL AUTO_INCREMENT COMMENT '学生ID',AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `teacher`
--
ALTER TABLE `teacher`
  MODIFY `TID` int(11) NOT NULL AUTO_INCREMENT COMMENT '教师ID',AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',AUTO_INCREMENT=46;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
