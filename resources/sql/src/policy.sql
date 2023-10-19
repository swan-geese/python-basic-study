-- ----------------------------
-- Table structure for policy_import
-- ----------------------------
DROP TABLE IF EXISTS `policy_import`;
CREATE TABLE `policy_import` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `classification_id` bigint NOT NULL COMMENT '分类ID',
  `policy_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '策略名称',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NORMAL' COMMENT '状态，NORMAL-正常，EXCEPTION-异常',
  `forms` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `is_default` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否默认策略',
  `is_deleted` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否删除，YES-是，NO-否',
  `creator` bigint NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_classification_id` (`tenant_id`,`classification_id`) USING BTREE,
  KEY `idx_policy_name` (`tenant_id`,`policy_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='导入策略表';

-- ----------------------------
-- Table structure for policy_login
-- ----------------------------
DROP TABLE IF EXISTS `policy_login`;
CREATE TABLE `policy_login` (
  `id` bigint NOT NULL,
  `tenant_id` bigint NOT NULL,
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `login_mode` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'CHECK_CODE：短信验证码，PWD_PHONE：密码登陆_手机号，PWD_USERNAME：密码登陆_用户名，PWD_EMAIL：密码登陆_邮箱，QR_CODE：app扫码登陆，OTP_CODE：OPT口令，FIDO：FIDO',
  `login_button` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'PIC_CODE：图形验证码，REM_CODE：记住密码，FORGET_CODE：忘记密码，SERV_AGREEMENT：服务协议',
  `protocol_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `custom_protocol_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '自定义协议内容',
  `login_authentication` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'CHECK_CODE_AUTH：短信验证码认证，OTP_AUTH：OPT口令认证，FIDO_AUTH：FIDO认证',
  `login_authentication_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否开启用户登录强认证 ENABLE/DISABLE',
  `third_party_login_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否开启三方快捷登录 ENABLE/DISABLE',
  `lock_rule` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码错误锁定限制：MIN{1}_CNT{2}_MIN{3}. 限定周期{1}分钟内，密码密码错误频次{2}次，锁定{}3分钟',
  `lock_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '锁定类型 SYSTEM:内置, CUSTOM:自定义',
  `permanent_lock_rule` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '永久锁定：DAY{1}_CNT{2}_FOREVER. 限定周期{1}天内，密码连续锁定{2}次，永久锁定',
  `permanent_lock_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '永久锁定类型 SYSTEM:内置, CUSTOM:自定义',
  `powerful_lock_rule` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '强认证错误锁定限制：\n5MIN_5CNT_30MIN. 限定周期5分钟内，密码密码错误频次5次，锁定30分钟\n5MIN_5CNT_60MIN. 限定周期5分钟内，密码密码错误频次5次，锁定1小时\n10MIN_5CNT_60MIN. 限定周期10分钟内，密码密码错误频次5次，锁定1小时\n30MIN_10CNT_120MIN. 限定周期30分钟内，密码密码错误频次10次，锁定2小时',
  `login_modify_password_rule` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NOT_MODIFY' COMMENT '首次登录强制用户修改密码配置 NOT_MODIFY:首次登录不强制修改密码 (默认), MODIFY_ALL:首次登录强制所有用户修改密码, MODIFY_EXCLUDE:首次登录强制系统自动生成密码的用户修改密码',
  `notify_list` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码锁定通知：\nPHONE_MSG. 手机短信\nEMAIL. 邮件\nTENANT_ADMIN. 通知租户管理员，逗号分隔',
  `login_session_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idtoken_rotation_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `I_TENANT_ID` (`tenant_id`) USING BTREE COMMENT '租户id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='登陆策略配置表';

-- ----------------------------
-- Table structure for policy_password
-- ----------------------------
DROP TABLE IF EXISTS `policy_password`;
CREATE TABLE `policy_password` (
  `id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL,
  `classification_id` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户分类id列表，多个用英文逗号隔开',
  `policy_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '策略名称',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'ENABLE/DISABLE 状态',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '备注',
  `password_strength` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '密码强度：DEFAULT/HIGH/SUPER',
  `pwd_policy_custom_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `pwd_policy_weak_password_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `force_modify` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `force_modify_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DISABLE' COMMENT 'ENABLE/DISABLE 状态',
  `repeat_period` int DEFAULT NULL COMMENT '密码不可重复周期：\r\n1:1次；2:2次；3:3次；4:4次；5:5次',
  `recycling_period` int DEFAULT NULL COMMENT '账号回收失效周期：\r\n1:一年，2:2年， 3:3年，4:4年， 5:5年',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否删除，YES-是，NO-否',
  `is_default` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'NO' COMMENT '是否默认 ，YES-是，NO-否',
  `creator` bigint DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `I_TENANTID` (`tenant_id`) USING BTREE COMMENT '租户索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='密码策略配置表';

-- ----------------------------
-- Table structure for policy_register
-- ----------------------------
DROP TABLE IF EXISTS `policy_register`;
CREATE TABLE `policy_register` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `classification_id` bigint NOT NULL COMMENT '分类ID',
  `policy_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '策略名称',
  `is_open_apply` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否开启注册申请，YES-是，NO-否',
  `register_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'B' COMMENT '注册场景 (C-C端注册场景, B-B端注册场景)',
  `org_id` bigint DEFAULT NULL COMMENT '组织ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'ENABLE' COMMENT '状态，ENABLE-启用，DISABLE-禁用',
  `is_exception` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否异常，YES-是，NO-否',
  `is_display` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否显示，YES-是，NO-否',
  `forms` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `is_default` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否默认策略',
  `is_deleted` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否删除，YES-是，NO-否',
  `creator` bigint NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `open_email_active` varchar(10) COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO',
  `email_active_link_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE,
  KEY `idx_classification_id` (`tenant_id`,`classification_id`) USING BTREE,
  KEY `idx_policy_name` (`tenant_id`,`policy_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='注册策略表';

-- ----------------------------
-- Table structure for policy_register_link
-- ----------------------------
DROP TABLE IF EXISTS `policy_register_link`;
CREATE TABLE `policy_register_link` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `policy_id` bigint NOT NULL COMMENT '策略ID',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '链接码',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '前端路由地址',
  `creator` bigint NOT NULL COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_policy_id` (`policy_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_p_r_l_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='注册链接';

-- ----------------------------
-- Table structure for sys_i18n_error_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n_error_message`;
CREATE TABLE `sys_i18n_error_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `msg` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `lang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `app_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `updater` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=325 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for worker_node
-- ----------------------------
DROP TABLE IF EXISTS `worker_node`;
CREATE TABLE `worker_node` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'auto increment id',
  `host_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'host name',
  `port` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'port',
  `type` int NOT NULL COMMENT 'node type: CONTAINER(1), ACTUAL(2), FAKE(3)',
  `launch_date` date NOT NULL COMMENT 'launch date',
  `modified` timestamp NOT NULL COMMENT 'modified time',
  `created` timestamp NOT NULL COMMENT 'created time',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_host_port` (`host_name`,`port`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='DB WorkerID Assigner for UID Generator';

SET FOREIGN_KEY_CHECKS = 1;
