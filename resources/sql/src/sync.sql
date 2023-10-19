-- ----------------------------
-- Table structure for sync_bind_mapping_log
-- ----------------------------
DROP TABLE IF EXISTS `sync_bind_mapping_log`;
CREATE TABLE `sync_bind_mapping_log` (
  `id` bigint NOT NULL,
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `plugin_unique_field_id` bigint NOT NULL COMMENT '插件唯一字段回收配置表ID',
  `data_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据分类：USER，ORG',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户名',
  `phone` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '手机号',
  `email` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `org_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组织名称',
  `org_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组织code',
  `org_path` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '组织路径',
  `mapping_result` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '回收结果:SUCCESS,FAIL',
  `mapping_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '回收信息',
  `mapping_original_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT '回收数据源数据',
  `update_time` datetime DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步回收日志';

-- ----------------------------
-- Table structure for sync_config
-- ----------------------------
DROP TABLE IF EXISTS `sync_config`;
CREATE TABLE `sync_config` (
  `id` bigint NOT NULL COMMENT 'ID',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '版本',
  `config_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型',
  `config_json` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `creator` bigint DEFAULT '0' COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='SCIM Schema 配置表';

-- ----------------------------
-- Table structure for sync_consumer
-- ----------------------------
DROP TABLE IF EXISTS `sync_consumer`;
CREATE TABLE `sync_consumer` (
  `id` bigint NOT NULL COMMENT 'ID',
  `topic` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消费主题',
  `group_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '消费组',
  `creator` bigint DEFAULT '0' COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `topic_UNIQUE` (`topic`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步服务MQ消费者配置表';

-- ----------------------------
-- Table structure for sync_org
-- ----------------------------
DROP TABLE IF EXISTS `sync_org`;
CREATE TABLE `sync_org` (
  `idaas_application_id` bigint DEFAULT NULL COMMENT 'idaas新建的集成应用ID',
  `task_id` bigint DEFAULT NULL COMMENT '同步任务ID',
  `batch_id` bigint DEFAULT NULL COMMENT '同步任务批次ID',
  `scene_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场景类型：上游，下游，回收',
  `operation_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据操作类型',
  `original_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '上游拉取原始数据',
  `id` bigint DEFAULT NULL COMMENT 'ID',
  `app_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '下游插件：三方应用组织ID',
  `org_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `org_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '组织编码',
  `org_level` int DEFAULT NULL COMMENT '组织层级',
  `app_org_level` int NOT NULL COMMENT '三方应用组织层级',
  `parent_id` bigint DEFAULT NULL COMMENT '父id',
  `app_parent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '三方应用父组织id',
  `org_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '路径',
  `app_org_path` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '路径',
  `classification_id` bigint DEFAULT NULL COMMENT '分类ID',
  `attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `scim_attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `auto_create_account` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否自动创建用户',
  `address_book_display` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否显示通讯录',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '状态',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint DEFAULT NULL COMMENT '创建人id',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NO' COMMENT '是否删除, YES-是，NO-否',
  `data_source` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据来源',
  `original_app_org_path` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '三方组织原始路径',
  `charge_id_list` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'IDaaS部门负责人ID',
  `app_charge_id_list` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方应用的部门负责人ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sync_plugin_unique_field
-- ----------------------------
DROP TABLE IF EXISTS `sync_plugin_unique_field`;
CREATE TABLE `sync_plugin_unique_field` (
  `id` bigint NOT NULL COMMENT 'ID',
  `config_id` bigint NOT NULL COMMENT '集成应用配置ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `plugin_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '插件ID',
  `data_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据分类：USER，ORG',
  `plugin_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '插件类型：UPSTREAM,DOWNSTREAM',
  `enable_mapping_user` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否映射用户数据：YES，NO',
  `enable_mapping_org` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否映射组织数据：YES，NO',
  `unique_field` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '唯一属性',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `job_id` bigint NOT NULL COMMENT 'xxl jobID',
  `third_exclude_org_prefix_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '第三方应用需要排除的组织路径前缀',
  `bind_mapping_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '回收状态：未启动INIT，进行中RUNNING，完成FINISH，中断INTERRUPT',
  `error_msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '回收任务中断错误信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Table structure for sync_task_info_ext
-- ----------------------------
DROP TABLE IF EXISTS `sync_task_info_ext`;
CREATE TABLE `sync_task_info_ext` (
  `id` bigint NOT NULL,
  `task_id` bigint NOT NULL COMMENT '同步任务ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `last_exec_user_properties_mapping` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '上次执行用户字段映射',
  `last_exec_org_properties_mapping` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '上次执行组织字段映射',
  `last_exec_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='同步任务扩展信息表';

-- ----------------------------
-- Table structure for sync_task_record_org_detail
-- ----------------------------
DROP TABLE IF EXISTS `sync_task_record_org_detail`;
CREATE TABLE `sync_task_record_org_detail` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `task_record_id` bigint NOT NULL COMMENT '同步记录ID',
  `data_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '组织ID',
  `org_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '组织名称',
  `org_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '组织编码',
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '同步结果, SUCCESS-成功, FAIL-失败',
  `fail_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '失败原因',
  `sync_data` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_task_record_id` (`task_record_id`),
  KEY `idx_data_id` (`data_id`),
  KEY `idx_org_name` (`org_name`),
  KEY `idx_org_code` (`org_code`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='组织同步详情表';

-- ----------------------------
-- Table structure for sync_task_record_user_detail
-- ----------------------------
DROP TABLE IF EXISTS `sync_task_record_user_detail`;
CREATE TABLE `sync_task_record_user_detail` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `task_record_id` bigint NOT NULL COMMENT '同步记录ID',
  `data_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '用户ID',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '手机号',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '邮箱',
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '同步结果, SUCCESS-成功, FAIL-失败',
  `fail_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '失败原因',
  `sync_data` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_task_record_id` (`task_record_id`),
  KEY `idx_data_id` (`data_id`),
  KEY `idx_username` (`username`),
  KEY `idx_phone` (`phone`),
  KEY `idx_email` (`email`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户同步详情';

-- ----------------------------
-- Table structure for sync_user
-- ----------------------------
DROP TABLE IF EXISTS `sync_user`;
CREATE TABLE `sync_user` (
  `idaas_application_id` bigint DEFAULT NULL COMMENT 'idaas新建的集成应用ID',
  `task_id` bigint DEFAULT NULL COMMENT '同步任务ID',
  `batch_id` bigint DEFAULT NULL COMMENT '同步任务批次ID',
  `scene_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '场景类型：上游，下游，回收',
  `operation_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据操作类型',
  `original_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '上游拉取原始数据',
  `id` bigint DEFAULT NULL COMMENT 'ID',
  `app_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '下游插件：三方应用用户ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `classification_id` bigint DEFAULT NULL COMMENT '分类ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '用户名',
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码',
  `email` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '邮箱',
  `phone` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '电话',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '状态 ENABLE-启用, DISABLE-禁用, LOCK-锁定, EXPIRE-过期',
  `expire_time` date DEFAULT NULL COMMENT '过期时间',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '性别 M-男, F-女',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像',
  `attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `scim_attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `password_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT '' COMMENT '密码状态',
  `lock_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '锁定状态 PERMANENT-永久锁定, TEMPORARY-临时锁定',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登陆时间',
  `last_pwd_change_time` datetime DEFAULT NULL COMMENT '上次修改密码时间',
  `is_tenant_admin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否为租户管理员',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否删除, YES-是，NO-否',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `data_source` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据来源',
  `org_ids` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'idaas用户组织ID',
  `app_org_ids` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方应用的用户组织ID',
  `supervisor_id` bigint DEFAULT NULL COMMENT 'IDaaS直属主管ID',
  `app_supervisor_id` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '第三方应用的直属主管ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Table structure for sys_i18n_error_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n_error_message`;
CREATE TABLE `sys_i18n_error_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `msg` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `lang` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `app_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `updater` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` smallint NOT NULL COMMENT '1:有效，0:无效',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_union_code_language_error` (`code`,`lang`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='DB WorkerID Assigner for UID Generator';

SET FOREIGN_KEY_CHECKS = 1;
