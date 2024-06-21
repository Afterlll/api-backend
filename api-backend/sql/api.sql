/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50740 (5.7.40-log)
 Source Host           : localhost:3306
 Source Schema         : api

 Target Server Type    : MySQL
 Target Server Version : 50740 (5.7.40-log)
 File Encoding         : 65001

 Date: 17/06/2024 08:53:58
*/
DROP DATABASE IF EXISTS `api`;
CREATE DATABASE `api`;
USE `api`;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for interface_info
-- ----------------------------
DROP TABLE IF EXISTS `interface_info`;
CREATE TABLE `interface_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '名称',
  `description` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `avatarUrl` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'api 图片',
  `host` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口服务器地址',
  `protocol` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '接口协议',
  `uri` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '接口uri地址',
  `requestParams` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求参数',
  `requestHeader` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '请求头',
  `responseHeader` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '响应头',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '接口状态（0-关闭，1-开启）',
  `method` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '请求类型',
  `userId` bigint(20) NOT NULL COMMENT '创建人',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '接口信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for love_quotes
-- ----------------------------
DROP TABLE IF EXISTS `love_quotes`;
CREATE TABLE `love_quotes`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '自增 ID',
  `quote` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '情话内容',
  `category` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情话分类',
  `sentiment` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情感倾向',
  `emotion` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '情感标签',
  `author` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `likes` int(11) NULL DEFAULT 0 COMMENT '点赞数',
  `favorites` int(11) NULL DEFAULT 0 COMMENT '收藏数',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10325 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userName` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `userAccount` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '账号',
  `userAvatar` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户头像',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '性别',
  `userRole` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT 'user' COMMENT '用户角色：user / admin',
  `userPassword` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `accessKey` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'ak密钥',
  `secretKey` varchar(256) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'sk密钥',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uni_userAccount`(`userAccount`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_interface_info
-- ----------------------------
DROP TABLE IF EXISTS `user_interface_info`;
CREATE TABLE `user_interface_info`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` bigint(20) NOT NULL COMMENT '调用用户 id',
  `interfaceInfoId` bigint(20) NOT NULL COMMENT '接口 id',
  `totalNum` int(11) NOT NULL DEFAULT 0 COMMENT '总调用次数',
  `leftNum` int(11) NOT NULL DEFAULT 0 COMMENT '剩余调用次数',
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0-正常，1-禁用',
  `createTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint(4) NOT NULL DEFAULT 0 COMMENT '是否删除(0-未删, 1-已删)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1802235075219259395 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户调用接口关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of interface_info
-- ----------------------------
INSERT INTO `interface_info` VALUES (1, 'getName', '获取输入的名称', 'https://img.zcool.cn/community/0131cd5849226da8012060c8cba1fd.jpg@2o.jpg', 'localhost', 'http', '/api/service/name/user', '[\n  {\n    \"fieldName\": \"name\",\n    \"required\": \"是\",\n    \"type\": \"String\",\n    \"desc\": \"用户名\"\n  }\n]', '{\"content-type\":\"application/json\"}', '{\"content-type\":\"application/json\"}', 1, 'POST', 1, '2024-05-26 20:40:52', '2024-06-11 22:04:22', 0);
INSERT INTO `interface_info` VALUES (2, '随机土味情话', '获取土味情话', 'https://img.qimuu.icu/interface_avatar/1698354419367571457/g8FTal0P-love.png', 'localhost', 'http', '/api/service/v1/loveQuotes/random', '[]', '{\n  \"content-type\": \"application/json\"\n}', '{\"content-type\":\"application/json\"}', 1, 'GET', 1, '2024-06-03 21:32:43', '2024-06-11 21:59:03', 0);
INSERT INTO `interface_info` VALUES (3, '获取天气信息', '获取每日每周的天气信息', 'https://img.qimuu.icu/interface_avatar/1698354419367571457/gYNay1Y0-weather.png', 'localhost', 'http', '/api/service/v1/weather', '[\n  {\n    \"fieldName\": \"city\",\n    \"required\": \"否\",\n    \"type\": \"String\",\n    \"desc\": \"输入城市或县区\"\n  },\n  {\n    \"fieldName\": \"ip\",\n    \"required\": \"否\",\n    \"type\": \"String\",\n    \"desc\": \"输入IP\"\n  },\n  {\n    \"fieldName\": \"type\",\n    \"required\": \"否\",\n    \"type\": \"String\",\n    \"desc\": \"默认一天，可配置 week获取周\"\n  }\n]', '{\n  \"content-type\": \"application/json\"\n}', '{\"content-type\":\"application/json\"}', 1, 'GET', 1, '2024-06-08 21:32:43', '2024-06-11 21:58:42', 0);
INSERT INTO `interface_info` VALUES (4, '获取IP信息归属地', '获取IP信息归属地详细版', 'https://marketplace.canva.cn/m_XWI/MAE1Cpm_XWI/2/tl/canva-MAE1Cpm_XWI.png', 'localhost', 'http', '/api/service/v1/ipInfo', '[\n  {\n    \"fieldName\": \"ip\",\n    \"required\": \"是\",\n    \"type\": \"String\",\n    \"desc\": \"输入IP地址\"\n  }\n]', '{\n  \"content-type\": \"application/json\"\n}', '{\"content-type\":\"application/json\"}', 1, 'GET', 1, '2024-05-03 21:32:43', '2024-06-11 21:51:59', 0);
INSERT INTO `interface_info` VALUES (5, '每日星座运势', '获取每日星座运势', 'https://pic.616pic.com/ys_bnew_img/00/35/28/yqKPCdMHmE.jpg', 'localhost', 'http', '/api/service/v1/horoscope', '[\n  {\n    \"fieldName\": \"type\",\n    \"required\": \"是\",\n    \"type\": \"String\",\n    \"desc\": \"十二星座对应英文小写，aries, taurus, gemini, cancer, leo, virgo, libra, scorpio, sagittarius, capricorn, aquarius, pisces\"\n  },\n  {\n    \"fieldName\": \"time\",\n    \"required\": \"是\",\n    \"type\": \"String\",\n    \"desc\": \"今日明日一周等运势,today, nextday, week, month, year, love\"\n  }\n]', '{\n  \"content-type\": \"application/json\"\n}', '{\"content-type\":\"application/json\"}', 1, 'GET', 1, '2024-05-24 21:32:43', '2024-06-11 21:57:38', 0);
INSERT INTO `interface_info` VALUES (6, '随机壁纸', '获取随机的壁纸', 'https://www.keaitupian.cn/cjpic/frombd/1/253/1546911602/2019783489.jpg', 'localhost', 'http', '/api/service/v1/randomWallpaper', '[\n  {\n    \"fieldName\": \"method\",\n    \"required\": \"否\",\n    \"type\": \"String\",\n    \"desc\": \"输出壁纸端[mobile|pc|zsy]默认为pc\"\n  },\n  {\n    \"fieldName\": \"lx\",\n    \"required\": \"否\",\n    \"type\": \"String\",\n    \"desc\": \"选择输出分类[meizi|dongman|fengjing|suiji]，为空随机输出\"\n  }\n]', '{\n  \"content-type\": \"application/json\"\n}', '{\"content-type\":\"application/json\"}', 1, 'GET', 1, '2024-06-09 21:32:43', '2024-06-11 22:02:14', 0);
INSERT INTO `interface_info` VALUES (7, '每日毒鸡汤', '随机毒鸡汤', 'https://img.zcool.cn/community/0117f45d197584a8012051cdf30817.png@3000w_1l_2o_100sh.png', 'localhost', 'http', '/api/service/v1/poisonousChickenSoup', '[]', '{\n  \"content-type\": \"application/json\"\n}', '{\"content-type\":\"application/json\"}', 1, 'GET', 1, '2024-06-03 21:32:43', '2024-06-11 22:00:25', 0);

-- ----------------------------
-- Records of love_quotes
-- ----------------------------
INSERT INTO `love_quotes` VALUES (1, '你是我的小确幸，也是我的大总和。', '甜蜜', '甜蜜', '喜悦', '张三', 100, 50, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (2, '我喜欢你，就像喜欢一个人会喜欢的所有东西。', '浪漫', '喜欢', '迷恋', '李四', 80, 30, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (3, '你是我从前的天蓝色，现在的粉红色。', '唯美', '温柔', '怀念', '王五', 120, 70, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (4, '你是我眼里最美丽的风景。', '甜蜜', '喜悦', '赞美', '赵六', 90, 40, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (5, '我想把你装进口袋里，带在身边。', '可爱', '思念', '宠溺', '孙七', 60, 20, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (6, '你是我生命里最美好的意外。', '深情', '感恩', '幸福', '周八', 110, 60, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (7, '你是我心里装不下的宇宙。', '唯美', '迷恋', '向往', '吴九', 70, 25, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (8, '你是我此生最大的幸运。', '深情', '感动', '珍惜', '郑十', 100, 55, '2024-06-03 11:12:57', '2024-06-03 11:12:57', 0);
INSERT INTO `love_quotes` VALUES (9, '你知道我喜欢谁吗，不知道就看看第一个字。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (10, '我有超能力，超喜欢你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (11, '我喜欢夏天的雨，雨后的光，和任何时候的你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (12, '“做我女朋友行不行?不行我再想想办法。”“你的口红我包了，但以后记得每天还我一点点。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (13, '我路过很多很美的风景，最后却只想在你这里停留。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (14, '我的手被划了一道口子 你也划一下 这样我们就是两口子了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (15, '“请管好你的嘴。”“为什么?”“因为我随时会亲它。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (16, '最近有谣言说我喜欢你，我要澄清一下，那不是谣言', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (17, '“你猜我想吃什么?” “不知道啊。” “痴痴地望着你。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (18, '“我觉得你这个人不适合谈恋爱。”“为什么?”“适合结婚。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (19, '人生呐，最美好的两件事，就是睡你——睡觉，和你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (20, '“甜有100钟方式，你知道吗？” “不知道” “吃糖，蛋糕，还有每天98次的想你。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (21, '好好照顾自己，不行就让我来照顾你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (22, '我还是喜欢你，像小时候吃辣条，从不看日期', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (23, '给你的表白话是抄的，但是我对你的爱是24K纯真的。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:55', '2024-06-03 14:53:55', 0);
INSERT INTO `love_quotes` VALUES (24, '别人再好都是别人的，我不一样，我是你的', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (25, '我有笔好几亿的生意，想和你谈谈', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (26, '你上辈子一定是碳酸饮料吧，为什么我一看到你就能开心的冒泡。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (27, '喜欢你已经超过两分钟，不能撤回了', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (28, '我想你一定很忙，所以只看前三个字就好啦', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (29, '“你有男朋友吗”“没有”“那恭喜你，现在有了。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (30, '我想和你一房二人三餐四季。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (31, '答案很长，我准备用一生的时间来回答，你准备要听了吗？', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (32, '你今天特别讨厌，讨人喜欢和百看不厌。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (33, '听闻先生治家有方，小女余生愿闻其详', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (34, '何以解忧，唯有暴… ?嗯? …抱抱你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (35, '“你知道世界上最冷的地方是哪吗?”“是没有你的地方”。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (36, '天再冷只要感受到你掌心里的温度就好。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (37, '“天气这么冷，你知道怎么取暖吗？”“不知道。”“我也不知道，但我知道怎么娶你。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (38, '对你，我已经无条件投降了', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (39, '陪迩去看细水长流', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (40, '你的过去我没来得及参与，但是你的未来我一定至死不渝。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (41, '从今以后我只能称呼你为您了，因为，你在我心上。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (42, '“嘿，我想像一首歌给你听” “什么歌?” “打呼噜”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (43, '希望有一天，你来到这个城市，是因为想起了我', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (44, '你有没有闻到烧焦的味道 ！那是我的心在燃烧', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (45, '你是我最初也是最后爱的人。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (46, '你和所有的前任比起来，他们不过是前戏，你才是我想要的高潮', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (47, '你生是我的猪，死是我的五花肉', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (48, '你知道我的缺点是什么吗? 是缺点你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (49, '“我想买一块地。”“什么地?”“你的死心塌地。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (50, '我在找一匹马。什么马?你的微信号码。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (51, '“我掐指一算，你五行缺我。”“我是迷人的男人，你是迷人。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (52, '你长得很像我一个亲戚，我妈的女婿。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (53, '无事献殷勤，非  非常喜欢你。会当凌绝顶，一', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (54, '“你知道现在几点吗?”“六点。”“不，是我们幸福的起点。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (55, '我想你看看我的眼睛，其实我的眼里，只有你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (56, '我的爱情在你这里，永远不会离去', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:56', '2024-06-03 14:53:56', 0);
INSERT INTO `love_quotes` VALUES (57, '你知道你和星星有什么区别吗?星星在天上，你在我心里。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (58, '“你为什么要害我?”“害你什么?”“害我那么喜欢你!”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (59, '“你知道你现在像什么吗?”“像什么?”“像地球。”“为什么?”“因为你对我有吸引力。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (60, '你说「好想有个完全属于自己的空间啊！」却没注意到我早已为你腾空心房，面积虽小，冷暖可调，租期你定，眼神解锁，费用「一次心动」，欢迎拎包入住。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (61, '你可以笑一下吗？我的咖啡没加糖', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (62, '你眼瞎吗?撞我心口上了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (63, '不管今世也来世也好，我所要的只有你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (64, '“我想在你那里买一块地。”“买什么地?”“买你的死心塌地。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (65, '“游乐园那个，可以骑在上面的”“有音乐的叫旋转什么?”“木马。”“mua”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (66, '“我喜欢上一个小哥哥。”“那他一定很帅。”“你太自恋了。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (67, '你是水，我是鱼，相伴相知。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (68, '你无需开口，我和天地万物便通通奔向你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (69, '我对你的爱，就像拖拉机上山，轰轰烈烈……', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (70, '我对你的爱很宽，愿你在我的爱里，一生都迷路。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (71, '我能陪你熬夜也会劝你早睡。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (72, '我对你的喜欢可以绕地球很多很多圈', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (73, '用情，去珍惜你一生。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (74, '“妈我爱你，倒过来怎么说?”“你爱我吗”“爱。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (75, '脑子真神奇，忙的要死，也要留个小缝儿想你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (76, '“你好宅啊。”“没有啊。”“可你呆在我的心里就没动过。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (77, '我喜欢你这件事，太直接了，没办法拐弯。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (78, '冬天到了喝点什么，不知道 呵护你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (79, '“我这么胖，你为什么还这么喜欢我”“你瘦的时候进我心里，胖的时候就卡住了，出不来了”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (80, '我不需要什么奇迹奇迹，我现在就需要你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (81, '“你知道你和星星有什么区别吗?”“有什么区别”“星星在天上，而你在我心里。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (82, '我喜欢你，心就特别软，平淡也浪漫，无语也温暖。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (83, '你近视吗?(不近视啊)那你怎么看不出我喜欢你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (84, '我知道没有能让你一见钟情的脸，但是很多事靠感觉不是吗。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (85, '“你累不累啊?”“不累。”“可是你都在我脑里跑了一天了！”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (86, '你不爱我又如何，我爱你就够了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (87, '你是我最爱的女孩，再多奶茶都不换那种。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (88, '“喂，知道风灌进胸膛是什么感觉么”“不知道啊”“就知道不知道，因为进入的人是你啊。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (89, '可爱不是长久之计，可爱我是长久之计', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (90, '我就是喜欢你，怎样了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (91, '客户虐我千百遍，我待客户如初恋，还不是因为客户是你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (92, '“你最近是不是又胖了?” “没有啊，为什么这么说?” “那为什么在我心里的分量越来越重了?”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (93, '“我背你好吗？”“', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (94, '立刻有=like you', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:57', '2024-06-03 14:53:57', 0);
INSERT INTO `love_quotes` VALUES (95, '你是别人眼中的小恶魔，却是我心中的大天使。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (96, '遇见你之后，灵魂不再孤独', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (97, '除了你，我没人要。除了你，我谁都不要。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (98, '我觉得你好像一款游戏。什么游戏?我的世界。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (99, '我想去取一下东西，你等一下，我来娶你了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (100, '“这辈子就跟我在一起吧，不行的话我再等等，还不行的话我再想想别的办法。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (101, '说简单点是熬夜，说实在点是失眠，说具体的是想你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (102, '如果爱不疯狂就不是爱了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:58', '2024-06-03 14:53:58', 0);
INSERT INTO `love_quotes` VALUES (103, '这是我的手背，这是我的脚背，你是我的宝贝。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (104, '别嫌弃我什么都不会，但是我只会娶你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (105, '“我结婚你一定要来”“为什么？”“因为没有新娘会很尴尬。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (106, '你知道这道菜怎么吃最好吃吗? 趁热吗? 我喂你吃。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (107, '有机会把耳机分你一个，然后开启网易云的心动模式。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (108, '我生在南方，活在南方，栽在你手里，总算是去过不一样的地方。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (109, '你猜我什么座？我是为你量身定做', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (110, '你是我唯一，我是你什么。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (111, '游乐场那个旋转的，有音乐会转的是什么？木马？嗯，mua', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (112, '自从爱你以后，才知爱的甜美。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (113, '有你在的地方，天气明朗，万物可爱。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (114, '“我重要吗？”“再重都要”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (115, '今年的冬天，我可不可以拥抱你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:53:59', '2024-06-03 14:53:59', 0);
INSERT INTO `love_quotes` VALUES (116, '我还是喜欢你，像小时候吃辣条，不看日期。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (117, '你是我的唯一。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (118, '我不想做好人或坏人，只想做你心上人。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (119, '你笑的时候我就好像拥有了全世界。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (120, '你有没有问到什么烧焦的味道?那是我的心在燃烧。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (121, '你给我的爱在心窝窝。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (122, '我是九你是三，除了你还是你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (123, '“帮我看看我眼睛怎么了?”“没看到有什么啊”“没吗?再仔细找找”“真的没有”“有，我的眼睛里有你啊”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (124, '因为我爱你，所以纵容你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (125, '我给你备注为一行…因为干一行，爱一行', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (126, '“你猜我什么星座” “白羊?” “错，我是为你量身定做”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (127, '“我怀疑你是碳酸饮料。”“为什么?”“因为一遇见你，我就开心地冒泡泡。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (128, '我会永远永远记住你给的浪漫惊喜。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (129, '你闻到什么味道了吗?没有啊！怎么你一出来空气都是甜的了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (130, '跟着我，别走丢。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (131, '风止于秋水，我止于你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (132, '没有你，就像热干面没有芝麻酱，毫无滋味', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (133, '“你左手有几个手指”“5”“你有几个眼睛”“2”“你有几个嘴巴”“1”“嗯 我也爱你”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (134, '我房租到期了，可以去你心里住吗', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (135, '“孔子 孟子 老子，你知道你最适合当什么子吗?”“不知道。”“我的妻子。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (136, '番茄和西红柿，土豆和马铃薯，我喜欢的人和你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (137, '来者何人？你的人', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (138, '“要是我和你生一个孩子你觉得他会是什么座？”“什么座？双子座？”“不，我们的杰作。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (139, '你出现的那一刻起	就是我全部的风景-', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (140, '情话都是学来的，但爱你是真的', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (141, '最近有谣言说我喜欢你，我要澄清一下那不是谣言', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (142, '你可以帮我个忙么? 什么忙? 帮忙快点爱上我!', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (143, '喜欢上你不在我的计划之中，只是刚好发生。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:00', '2024-06-03 14:54:00', 0);
INSERT INTO `love_quotes` VALUES (144, '我们，是我遇见的最美好的字眼', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (145, '关关雎鸠，在河之洲，窈窕淑女，what*s you qq？', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (146, '“你永远也看不到我寂寞的样子”“为什么了”“因为只有你不在我身边的时候，我才是最寂寞的”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (147, '眼里都是你，亿万星辰犹不及', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (148, '你最近是不是又胖了？那为什么在我心里份量越来越重了？', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (149, '想送你很多很多口红，让你每天还我一点点', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (150, '你要你在我身边，我会爱你爱的无法无天。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (151, '东风夜放花千树，我想去你家里住', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (152, '你知道我喜欢喝什么吗？ 呵护你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (153, '你从一个陌生人，变成了我最不舍的离开的人。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (154, '“我好像找不到方向了”“你要去哪里”“通往你的心里，该怎么走?”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (155, '你是我一生中上天最唯美的安排', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (156, '我的眼睛一定有问题，我的视线无法自你身上离开。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (157, '近朱者赤，近你者甜。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (158, '你会弹吉他吗 不会 那你为什么能拨动我的心弦', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (159, '“我饮料都喝无糖的，你知道你适合和什么糖的么?” “微糖吧” “不对，是我的胸膛”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (160, '我想在老的时候，吻你光光的牙床', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (161, '你是甜筒吗？为什么我想舔遍你全身', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (162, '我的身体24小时都营业，只等待你的进入', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (163, '“你能不能闭嘴?”“我没有说话啊”“那为什么我满脑子都是你的声音?”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (164, '我骄傲了十几年看见你我就怂了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (165, '你上辈子一定是碳酸饮料吧，为什么我一看到你就能开心的冒泡？', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (166, '玫瑰是我偷的，但我爱你是真的。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (167, '您好，您有新的恋爱订单，请及时收取我', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (168, '你问我多喜欢你，我说不出来。但是我心里明白，我宁愿和你吵架，也不愿意去爱别人', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (169, '无论你在哪，我的心永远追随着你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (170, '你的脸上有点东西，有什么?有点漂亮。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (171, '情人眼里出什么？西施？不，是出现你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (172, '“我们现在是朋友吗?”“是啊”“那以后就不是了，因为你是我女朋友”;', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (173, '我的爱情一生只有一次，一次就是一生！', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (174, '“你是什么血型？” “A型啊！” “不，你是我的理想型！”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (175, '只许州官放火，不许你离开我。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (176, '我可以不为别人难过，但你不是别人，你是我的人。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (177, '你把你的缺点给我我来包容你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:01', '2024-06-03 14:54:01', 0);
INSERT INTO `love_quotes` VALUES (178, '我怀疑你的本质是一本书，不然为什么让我越看越想睡。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (179, '不要抱怨，抱我。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (180, '余生很长，想和你没完没了', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (181, '“你是心你是肝你是我的四分之三”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (182, '你猜我爱喝酒还是爱打王者 爱打王者吧? 不，爱你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (183, '每天只想和你做四件事——一日三餐', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (184, '我能对你说上一世情话不带重样的。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (185, '你知道现在是几点嘛？是我们幸福的起点', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (186, '你陪我走过一无所有，我陪你走到岁月尽头。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (187, '你开心吗？开啊，不开你怎么进来', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (188, '你知道吗？咋两都挺过分的，你过分美丽，我过分着迷', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (189, '你上辈子一定是碳酸饮料吧，为什么我一看到你就开心的冒泡', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (190, '和你聊天就像考试，事后想想总是觉没有发挥好。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (191, '我喜欢你，你喜欢我吗？不喜欢的话，我再想想办法。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (192, '说不过你但喜欢你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (193, '你不要仗着我爱你，你就刻意为所欲为。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (194, '我以为我过得还挺好的，吃得饱，穿的好，有钱花。只是还差一点什么，还差一个你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (195, '我与世界只差一个你，因为是你，晚一点没关系。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (196, '你知不知道为什么我怕你？”“不知道”“因为我怕老婆', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (197, '“别人都说你的脸很圆，但我觉得你的脸还蛮方的” “为什么?” “不然怎么那么正”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (198, '我们来玩木头人不许动吧 好!我输了，心动了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (199, '很感谢在最美的时光遇见最美的你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (200, '随时都想吻你，也很想听你的心跳。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (201, '你若一直在我便一直爱', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (202, '“咱俩友情到头了，该发展成爱情了。”“别人是喜欢你，而我是只喜欢你。”“我可以称呼你为您吗?这样我就可以把你放在心上。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (203, '“你可以笑一个吗?”“为什么啊?”“因为我的咖啡忘加糖了。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (204, '全世界还有谁比我们更般配。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (205, '我努力不是为了你而是因为你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (206, '传闻人有206根骨头，一遇见你呀，我就有207根啦', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (207, '我这个人没见过什么世面，见见你就已经足够了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (208, '对你这种人，除了恋爱，我没什么和你谈的！', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (209, '我最美的年华，不是你，而是爱你的年华里那些甜蜜的小心情。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (210, '“你是哪里人” “杭州人” “不，你是我的心上人。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (211, '前半生到处浪荡，后半生为你煲汤。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (212, '一直想说，无论走到哪里，最想去的是你的身边。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (213, '既然你已经把我的心弄乱了，那么你准备什么时候来弄乱我的床', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (214, '有一天我会拉着你的手，带你去看你最喜欢的星空。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (215, '你最可爱了。我说的时候来不及思索，我仔细想过之后，还是会这么说', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (216, '莫文蔚的阴天，孙燕姿的雨天，周杰伦的晴天，都不如你和我聊天。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:02', '2024-06-03 14:54:02', 0);
INSERT INTO `love_quotes` VALUES (217, '我身体很好，可以扛米袋子，抗煤气罐，就是扛不住想你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (218, '把你的名字写在烟上吸进肺里，让你保持在离我心脏最近的地方。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (219, '有趣的地方都想去掺和一下，比如你的世界', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (220, '野心不大，有你就拥有天下！', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (221, '我喜欢你，喜欢得无可救药。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (222, '“你觉得你适合穿什么衣服？”“好看的衣服？”“不，是被我征服。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (223, '“孔子 孟子 老子，你知道你最适合当什么子吗？”“不知道。”“我的妻子。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (224, '你今天干嘛打扮成这个样子，好看不说，偏偏是我喜欢的样子', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (225, '但愿我和你，是一支唱不完的歌。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (226, '你的眼睛真漂亮里面只适合装我', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (227, '现在几点了?(12点)不，是我们幸福的起点。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (228, '“最近我看到你就觉得头很晕”“为什么?”“因为爱情使人头昏脑胀”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (229, '“你可以做我的奥利奥吗？”“为什么？”“因为我想泡你。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (230, '此刻我很挂念你，请为我小心照顾自己。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (231, '“我觉得你长得像我一个亲戚。”“谁？”“我妈的儿媳妇。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (232, '你喜欢喝水吗?那你已经喜欢上70%的我了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (233, '你知道你和星星的区别吗？星星在天上 你在我心里', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (234, '“你知道这牛肉要怎么吃才好吃吗？我喂你吃。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (235, '爱你在我心窝窝里~', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (236, '你的酒窝没有酒，我却醉的像条狗', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (237, '等下可以帮我洗一下东西吗？”“可以啊，洗什么？”“喜欢我。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (238, '我最大的缺点，就是缺点你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (239, '春雨初生，春树初盛，春风十里，不如你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (240, '我的心脏只够装下你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (241, '今天我想你想的，连续换了五条小内裤', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (242, '我很能干但有一件事不会。什么?不会离开你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (243, '天冷了 有什么事 到我被窝里说。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (244, '我没什么事儿，就想听听你的声音。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (245, '因为你，我懂得了爱。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (246, '“我感觉地震了，怎么老是在动。” “没有啊” “', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (247, '被你赞过的朋友圈，叫甜甜圈。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (248, '“你属什么？”“我属狗。”“你不要再骗人了，你属于我。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (249, '我愿意做你最温馨的避风港。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (250, '有些事不用在一晚内做完的，我们又不赶时间，可以每晚都做一做', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (251, '我发现昨天很喜欢你，今天也很喜欢你，而且有预感明天也会喜欢你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (252, '跟你说一个坏消息 什么坏消息 我对你的思想已经不单纯了', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (253, '不思进取，思你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (254, '既然你把我的心已经弄乱了，那你打算什么时候来弄乱我的床？', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (255, '我已经规划好你的新身份了，那就是老婆大人。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (256, '喜欢你就是见不得你与别人交谈甚欢。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (257, '如果说最奢侈的事，我愿用我整个青春去等你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (258, '“你会看手相吗?”“会一点，你命里缺我”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (259, '我爱你，就会爱你的一切。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:03', '2024-06-03 14:54:03', 0);
INSERT INTO `love_quotes` VALUES (260, '愿意跟我体验一下不单身的感觉吗。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (261, '“先生你要点什么？”“我想点开你的心。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (262, '最好的时光里有了你，才能成为我所谓的最好的时光。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (263, '“我觉得你长得像我一个亲戚。”“？？？”“我妈的儿媳妇。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (264, '“你知道情人眼里出什么吗？”“西施啊。”“不，出现你。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (265, '最近有谣言说我喜欢你，我要澄清一下，那不是谣言。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (266, '“你知道我为什么感冒了吗?”“因为着凉了?”“不，因为我对你完全没有抵抗力。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (267, '迩是莪一辈子旳宝贝。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (268, '爱你如初是假的，因为我一天比一天更爱你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (269, '“我在找一条路”“春熙路？”“不是，阿姨洗铁路。”（日语我爱你的意思）', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (270, '三十晚上的鞭炮再响，都没有我想想你那么想。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (271, '如果我丢了怎么办? 报警就好了 什么?', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (272, '愿你为我你穿上婚纱，我陪你笑傲天下。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (273, '“如果人也有尾巴的话，这么说还真有点难为情呢。因为和你在一起的时候，我想，我会忍不住摇尾巴。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (274, '“你可以笑一个吗？”“为什么啊？”“因为我的咖啡忘加糖了。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (275, '你知道我最爱的是什么吗？现在看这句话第一个字就知道了', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (276, '我想吃碗面 什么面 你的心里面。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (277, '我发现昨天很喜欢你，今天也很喜欢你，而且有预感明天也会喜欢你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (278, '我是九你是三，除了你还是你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (279, '你知道墙壁，眼睛，膝盖的英文怎么说么? wall,eye,knee 我也是，我爱你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (280, '我觉得你接近我就是在害我，害得我好喜欢你呀', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (281, '吃烧烤是先考海鲜还是烤肉 烤肉 先考虑你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (282, '你的心，是我去到世界尽头还想再回来的地方。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (283, '我唯一没有做好的事，就是说了“我爱你”。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (284, '“既然你把我的心已经弄乱了，那你打算什么时候来弄乱我的床?”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (285, '我想买一块地…你的死心塌地', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (286, '“面对你，我不仅善解人意，我还善解人衣。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (287, '你若一直在，我便一直爱。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (288, '最近手头有点紧，想借你的手牵一牵', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (289, '前半生到处浪荡，后半身为你煲汤', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (290, '其实我有超能力，超级喜欢你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (291, '“n 55lw !n', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (292, '对你最初的印象，久久难以忘怀。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (293, '人总是会变的，从一开始的喜欢你，到后来的更喜欢你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (294, '“你是不是喜欢我?”找出这句话中重复的字。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (295, '你是我的梦想	，以梦开始	，以想终止', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (296, '猜猜我的心在哪边?左边。错了，在你那边。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (297, '你不爱我没事，让我心疼你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (298, '“请管好你的嘴。”“为什么？”“因为我随时会亲它。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (299, '我用尽了全部的运气，只为遇到你的那个瞬间，生命在那刻点亮。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (300, '万千人之中我也能一眼便认出你，因为别人走在路上，你走在我心上～', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (301, '你过来 我有个天想跟你聊一下', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (302, '甜有100种方式，吃糖，蛋糕，还有每天98次的想你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (303, '我只是爱你，没说非要在一起。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:04', '2024-06-03 14:54:04', 0);
INSERT INTO `love_quotes` VALUES (304, '我不喜欢等，我只喜欢你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (305, '每日每夜都想你，每时每刻都恋你，一生一世只爱你。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (306, '“你想养狗吗？”“什么狗？”“单身的那种”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (307, '别让我看见你，不然我见你一次，就喜欢你一次。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (308, '女孩，我十拿九稳 只差你一吻。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (309, '“我觉得你这个人不适合谈恋爱” “为什么?” “适合结婚。”', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (310, '我们不再适合谈恋爱了，我们更适合结婚了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (311, '你忙归忙，什么时候有空嫁给我？', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (312, '知道我和唐僧什么区别吗？唐僧取经我娶你', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (313, '你会喜欢我吗？不会我教你啊', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (314, '跟你捉迷藏的话我肯定输，因为爱你的心怎么也藏不住', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (315, '我喜欢你超过来两分钟了，不可以撤回了。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (316, '我本已百毒不侵，偏偏你是第101种，而且无药可解。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (317, '有了你，黑暗不再是黑暗', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (318, '心在你那里，疼不疼你说了算。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (319, '咱们应当在一起，否则就太伤天害理啦。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (320, '情书是我抄的但我愛你是真的', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (321, '没什么特别的事，只想听听你的声音。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (322, '因为知道不能没有你，所以我会更珍惜。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (323, '只有70件事最令我开心，一件是你，一件是69', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);
INSERT INTO `love_quotes` VALUES (324, '你知道你像什么人吗?(什么人?)我的女人。', NULL, NULL, NULL, NULL, 0, 0, '2024-06-03 14:54:05', '2024-06-03 14:54:05', 0);

-- ----------------------------
-- Records of user_interface_info
-- ----------------------------
INSERT INTO `user_interface_info` VALUES (1801851648531865312, 1, 1, 106, 9994, 0, '2024-05-26 22:31:12', '2024-06-16 15:04:15', 0);
INSERT INTO `user_interface_info` VALUES (1801851648531865602, 1, 2, 1520, 9998, 0, '2024-06-15 13:38:04', '2024-06-15 14:14:30', 0);
INSERT INTO `user_interface_info` VALUES (1801858300433768450, 1, 3, 1120, 9999, 0, '2024-06-15 14:04:30', '2024-06-15 14:24:51', 0);
INSERT INTO `user_interface_info` VALUES (1801858994050015233, 1, 4, 590, 9998, 0, '2024-06-15 14:07:15', '2024-06-15 14:14:30', 0);
INSERT INTO `user_interface_info` VALUES (1801860326009970690, 1, 5, 422, 10000, 0, '2024-06-15 14:12:33', '2024-06-15 14:24:51', 0);
INSERT INTO `user_interface_info` VALUES (1801860426727792641, 1, 6, 755, 9999, 0, '2024-06-15 14:12:57', '2024-06-15 14:24:51', 0);
INSERT INTO `user_interface_info` VALUES (1801860543480438786, 1, 7, 999, 10000, 0, '2024-06-15 14:13:25', '2024-06-15 14:24:01', 0);
INSERT INTO `user_interface_info` VALUES (1802235075219259394, 2, 1, 9, 9992, 0, '2024-06-16 15:01:40', '2024-06-16 15:02:09', 0);

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '江喜原', 'Afterlll', 'https://img.qimuu.icu/user_avatar/1705751115380944897/igxbAv0W-xky.png', 1, 'admin', '3bde3d5b0fabb4c368527b83393f8ff7', 'jxy', '1234', '2024-05-25 17:53:27', '2024-06-16 15:07:13', 0);
INSERT INTO `user` VALUES (2, 'jxy', 'jxy1', 'https://img.qimuu.icu/user_avatar/1705751115380944897/igxbAv0W-xky.png', 1, 'admin', '3bde3d5b0fabb4c368527b83393f8ff7', 'anh5anh5Meidme+ksuOpp+KWhw==', 'anh5M2JkZTNkNWIwZmFiYjRjMzY4NTI3YjgzMzkzZjhmZjfnt57wn6ir8KSYquyFsvCYl6U=', '2024-06-01 14:39:21', '2024-06-15 15:50:45', 0);

SET FOREIGN_KEY_CHECKS = 1;
