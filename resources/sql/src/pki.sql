-- ----------------------------
-- Table structure for pki_cert_download
-- ----------------------------
DROP TABLE IF EXISTS `pki_cert_download`;
CREATE TABLE `pki_cert_download` (
  `pr_id` varchar(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'id',
  `pr_cer_serial` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '序列号',
  `pr_download_type` enum('JKS','PK12') CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '下载类型',
  `pr_download_data` varbinary(10240) NOT NULL COMMENT '下载byte内容',
  `pr_create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `pr_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `pr_creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'root' COMMENT '创建人',
  `pr_updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'root' COMMENT '修改人',
  PRIMARY KEY (`pr_id`) USING BTREE,
  UNIQUE KEY `idx_serial` (`pr_cer_serial`,`pr_download_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for pki_oidc_jwks
-- ----------------------------
DROP TABLE IF EXISTS `pki_oidc_jwks`;
CREATE TABLE `pki_oidc_jwks` (
  `pr_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `domain` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `alg_len` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jwks_use` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `key_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `jwks_algorithm` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `operation` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `key_ops` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `private_key_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `public_key_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `pr_update_time` datetime DEFAULT NULL,
  `pr_create_time` datetime DEFAULT NULL,
  `pr_creator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pr_updator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pr_status` bit(1) DEFAULT b'1',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `max_live_days` int DEFAULT NULL COMMENT '最大存活天数',
  PRIMARY KEY (`pr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='生成jwks保存表';

-- ----------------------------
-- Table structure for pki_revoke_history
-- ----------------------------
DROP TABLE IF EXISTS `pki_revoke_history`;
CREATE TABLE `pki_revoke_history` (
  `pr_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `pr_cer_serial` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '证书序列号',
  `pr_type` int NOT NULL COMMENT '证书类型，0根证书，1子证书',
  `pr_domain` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `pr_user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户id',
  `pr_creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '操作人',
  `pr_operate_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`pr_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='吊销历史表';

-- ----------------------------
-- Table structure for pki_revoke_history_details
-- ----------------------------
DROP TABLE IF EXISTS `pki_revoke_history_details`;
CREATE TABLE `pki_revoke_history_details` (
  `pr_id` int NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `pr_cer_serial` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '证书序列号',
  `pr_cer_details` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '证书详情',
  PRIMARY KEY (`pr_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='吊销证书详情';

-- ----------------------------
-- Table structure for pki_root_cer
-- ----------------------------
DROP TABLE IF EXISTS `pki_root_cer`;
CREATE TABLE `pki_root_cer` (
  `pr_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'id',
  `pr_issuer` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '颁发者',
  `pr_domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '域名',
  `pr_start_time` datetime DEFAULT NULL COMMENT '有效开始时间',
  `pr_end_time` datetime DEFAULT NULL COMMENT '有效截止时间',
  `pr_storepwd` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '证书解密密码',
  `pr_cer_alias` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '别名',
  `pr_cer_serial` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '序列号',
  `pr_finger_print` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '指纹',
  `pr_cer_content` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '证书文件内容',
  `pr_public_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '公钥',
  `pr_algorithm` enum('EC','RSA') CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'RSA',
  `pr_private_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '私钥',
  `pr_creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `pr_create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `pr_updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新人',
  `pr_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `pr_status` bit(1) DEFAULT b'1' COMMENT '状态 1启用0禁用',
  `pr_isrevoke` int DEFAULT '1' COMMENT '0：吊销  1：正常 ,-1:过期',
  `pr_cert_type` int NOT NULL COMMENT '0根证书，1服务端证书，2客户端证书，3签名证书，4中间证书',
  `pr_parent_cert_serial` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '0' COMMENT '父级证书 序列号',
  `pr_batch` int NOT NULL AUTO_INCREMENT COMMENT '批次号',
  `pr_key_pwd` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '私钥加密密码',
  `pr_handle_time` bigint unsigned NOT NULL DEFAULT '0' COMMENT '证书吊销时间与过期失效时间',
  `pr_subject_x500_principal` varbinary(1024) DEFAULT NULL,
  `pr_use_type` int DEFAULT '-1' COMMENT '国密使用类型, 1签名，2加密',
  PRIMARY KEY (`pr_batch`,`pr_id`) USING BTREE,
  UNIQUE KEY `pr_domain` (`pr_domain`,`pr_algorithm`,`pr_isrevoke`,`pr_handle_time`,`pr_use_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='根证书';

-- ----------------------------
-- Table structure for pki_saml
-- ----------------------------
DROP TABLE IF EXISTS `pki_saml`;
CREATE TABLE `pki_saml` (
  `pr_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `domain` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户信息或者域名',
  `encryption_crt` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密证书',
  `encryption_key` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '加密私钥',
  `sign_crt` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '签名证书',
  `sign_key` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '签名私钥',
  `pr_update_time` datetime DEFAULT NULL,
  `pr_status` bit(1) NOT NULL DEFAULT b'1',
  `pr_create_time` datetime DEFAULT NULL,
  `pr_creator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pr_updator` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`pr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SAML证书管理表';

-- ----------------------------
-- Table structure for pki_user
-- ----------------------------
DROP TABLE IF EXISTS `pki_user`;
CREATE TABLE `pki_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(255) CHARACTER SET hebrew COLLATE hebrew_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET hebrew COLLATE hebrew_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_name` (`user_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=hebrew ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for pki_user_cer
-- ----------------------------
DROP TABLE IF EXISTS `pki_user_cer`;
CREATE TABLE `pki_user_cer` (
  `pr_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'id',
  `pr_uid` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '用户名',
  `pr_issuer` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '颁发者',
  `pr_domain` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '域名',
  `pr_start_time` datetime DEFAULT NULL COMMENT '有效开始时间',
  `pr_end_time` datetime DEFAULT NULL COMMENT '有效截止时间',
  `pr_storepwd` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '存储密码',
  `pr_cer_alias` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '证书别名',
  `pr_cer_serial` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '证书序列号',
  `pr_finger_print` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '序列号指纹',
  `pr_cer_content` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '证书文件内容',
  `pr_public_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '公钥',
  `pr_private_key` text CHARACTER SET utf8 COLLATE utf8_bin COMMENT '私钥',
  `pr_algorithm` enum('EC','RSA') CHARACTER SET utf8 COLLATE utf8_bin DEFAULT 'RSA',
  `pr_parent_cert_serial` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '根证书id',
  `pr_creator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '创建人',
  `pr_create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `pr_updator` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '更新人',
  `pr_update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `pr_status` bit(1) DEFAULT b'1' COMMENT '状态 1启用0禁用',
  `pr_isrevoke` int DEFAULT '1' COMMENT '0：吊销  1：正常 ,-1:过期',
  `pr_batch` int NOT NULL AUTO_INCREMENT COMMENT '批次号',
  `pr_key_pwd` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '私钥加密密码',
  `pr_handle_time` bigint unsigned NOT NULL DEFAULT '0' COMMENT '吊销时间和过期处理时间',
  `pr_use_type` int DEFAULT NULL COMMENT '国密使用类型, 1签名，2加密',
  PRIMARY KEY (`pr_batch`,`pr_id`) USING BTREE,
  UNIQUE KEY `pr_uid` (`pr_uid`,`pr_algorithm`,`pr_isrevoke`,`pr_handle_time`,`pr_use_type`) USING BTREE,
  KEY `pr_serial` (`pr_cer_serial`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='客户端证书';

SET FOREIGN_KEY_CHECKS = 1;
