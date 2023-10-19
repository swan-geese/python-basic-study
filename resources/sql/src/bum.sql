-- ----------------------------
-- Table structure for app_account
-- ----------------------------
DROP TABLE IF EXISTS `app_account`;
CREATE TABLE `app_account` (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户主键',
  `app_id` bigint NOT NULL COMMENT '应用id',
  `crop_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业id',
  `username` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '账号名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `creator` bigint DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户三方账号表';

-- ----------------------------
-- Table structure for app_auth
-- ----------------------------
DROP TABLE IF EXISTS `app_auth`;
CREATE TABLE `app_auth` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `app_status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用状态：UNAVAILABILITY--不可用，APPLY--已申请，APPROVED--已授权',
  `app_auth` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'NO' COMMENT '用户是否授权该应用：YES/NO',
  `auth_field` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `auth_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '授权时间',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'NO' COMMENT '是否删除, YES-是，NO-否',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_userid_appid` (`app_id`,`user_id`) USING BTREE COMMENT '应用id与用户id唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_info
-- ----------------------------
DROP TABLE IF EXISTS `app_info`;
CREATE TABLE `app_info` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint DEFAULT '0' COMMENT '集成应用id，自建应用为0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '应用名称',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用图标',
  `app_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限code',
  `app_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用地址',
  `web_security_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'web认证类型： custom ：自己设置账号密码 idaas：使用idass账号  property：账号属性方式自己设置密码',
  `crop_id_modifiable` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'YES' COMMENT '是否可修改企业id  YES：是 NO：否',
  `account_property` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '账号属性 username email phone',
  `crop_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '企业id',
  `corp_id_visible` tinyint DEFAULT '0' COMMENT '是否展示企业id',
  `app_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'sso360应用链接地址',
  `app_Proxy` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '代理地址',
  `secondary_certification` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'false' COMMENT '登录应用二次认证, YES-是，NO-否',
  `protocal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单点协议(saml,regex,oidc,oauth,esso,ltpa,noAuthentication,DefSSO)',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '描述',
  `plugin_data_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '集成应用json值',
  `sort` bigint DEFAULT NULL COMMENT '排序',
  `type` tinyint NOT NULL DEFAULT '1' COMMENT '应用类型：1--集成，2--自建',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '状态 ENABLE-启用, DISABLE-禁用, LOCK-锁定, EXPIRE-过期',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'NO' COMMENT '是否删除, YES-是，NO-否',
  `is_internally` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'false' COMMENT '是否内置应用的属性',
  `is_portal_hide` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'NO' COMMENT '是否在自服务中隐藏 YES-是, NO-否',
  `sync_connect_json` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '数据同步配置信息',
  `sync_connect_status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'FAIL' COMMENT '测试连接状态：成功-SUCCESS，失败-FAIL',
  `creator` bigint NOT NULL COMMENT '创建人id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_gateway` tinyint DEFAULT '1' COMMENT '是否为内置网关应用：0--是，1--否',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '应用版本号',
  `app_template_id` bigint DEFAULT NULL COMMENT '集成应用ID',
  `is_enable_sync` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否数据同步：YES，NO',
  `template_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '应用分类',
  `dynamic_form_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '动态表单key',
  `connect_form_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '测试联通动态表单key',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_integration_config
-- ----------------------------
DROP TABLE IF EXISTS `app_integration_config`;
CREATE TABLE `app_integration_config` (
  `id` bigint NOT NULL COMMENT 'ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '应用ID',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用图标',
  `protocal` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单点协议(saml,regex,oidc,oauth,esso,ltpa,noAuthentication,DefSSO)',
  `app_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用地址',
  `app_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用code',
  `dynamic_form_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '动态表单key',
  `connect_form_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '测试联通动态表单key',
  `sub_protocol` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '内置应用key',
  `plugin_data_json` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '插件数据信息',
  `is_child` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'NO' COMMENT '是：YES 否：NO',
  `sync_plugin_data_json` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `script` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用描述',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `name_i18n` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `description_i18n` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '集成应用状态：启用-ENABLE，停用-DISABLE',
  `version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '集成应用版本号',
  `app_template_id` bigint DEFAULT NULL COMMENT '集成应用模板ID',
  `is_enable_sync` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否支持数据同步：YES，NO',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '应用分类',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_tenant_code_version` (`app_code`,`version`,`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_integration_properties
-- ----------------------------
DROP TABLE IF EXISTS `app_integration_properties`;
CREATE TABLE `app_integration_properties` (
  `id` bigint NOT NULL COMMENT 'ID',
  `config_id` bigint DEFAULT NULL COMMENT '对应app_integration_config表中的ID',
  `properties_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '属性名称',
  `properties_classification` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '属性分类 USER-用户属性, ORG-组织属性',
  `properties_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '属性数据类型',
  `properties_examples` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性示例值',
  `properties_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性描述',
  `is_required` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否必填：是-YES，否-NO',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_template_id` bigint DEFAULT NULL COMMENT '集成应用ID',
  `properties_template_id` bigint NOT NULL COMMENT '大平台应用属性模板ID',
  `expression` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '表达式',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_properties_name` (`properties_name`) USING BTREE,
  KEY `unique` (`config_id`,`properties_name`,`properties_classification`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_integration_sync_plugin
-- ----------------------------
DROP TABLE IF EXISTS `app_integration_sync_plugin`;
CREATE TABLE `app_integration_sync_plugin` (
  `id` bigint NOT NULL COMMENT 'ID',
  `plugin_template_id` bigint NOT NULL COMMENT '对应app_plugin_template_manager表中的ID',
  `app_template_id` bigint NOT NULL COMMENT '对应app_integration_template_manager表中的ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `plugin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '插件名称',
  `plugin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'UPSTREAM' COMMENT '插件类型，UPSTREAM，DOWNSTREAM, SSO',
  `plugin_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '插件ID',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '状态 ENABLE-启用, DISABLE-禁用',
  `user_org_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户所属组织类型 SINGLE-单组织, MULTIPLE-多组织',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '插件版本号',
  `enable_sync_user` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'YES' COMMENT '是否开启用户同步:YES，NO',
  `enable_sync_org` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'YES' COMMENT '是否开启组织同步:YES，NO',
  `enable_data_recovery` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否支持数据回收:YES，NO',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '插件文件名',
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '插件文件路径',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='租户插件';

-- ----------------------------
-- Table structure for app_org_relation
-- ----------------------------
DROP TABLE IF EXISTS `app_org_relation`;
CREATE TABLE `app_org_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `org_id` bigint NOT NULL COMMENT '组织ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `adx_tenant_org_app_id` (`tenant_id`,`org_id`,`app_id`),
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_plugin
-- ----------------------------
DROP TABLE IF EXISTS `app_plugin`;
CREATE TABLE `app_plugin` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用id',
  `plugin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '插件名称',
  `plugin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'UPSTREAM' COMMENT '插件类型',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '状态 ENABLE-启用, DISABLE-禁用',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '插件版本号',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_properties_mapping
-- ----------------------------
DROP TABLE IF EXISTS `app_properties_mapping`;
CREATE TABLE `app_properties_mapping` (
  `id` bigint NOT NULL COMMENT 'id',
  `app_id` bigint NOT NULL COMMENT '应用id',
  `is_required` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'true' COMMENT '是否必选',
  `app_properties_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用属性名称',
  `p_id` bigint DEFAULT NULL COMMENT '属性id',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `app_properties_id` bigint DEFAULT NULL COMMENT '应用属性id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_api_name` (`app_id`) USING BTREE,
  KEY `api_code` (`is_required`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='api资源表';

-- ----------------------------
-- Table structure for app_protocol
-- ----------------------------
DROP TABLE IF EXISTS `app_protocol`;
CREATE TABLE `app_protocol` (
  `id` bigint NOT NULL COMMENT 'id',
  `protocol_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '协议类型',
  `app_id` bigint DEFAULT NULL COMMENT '应用id',
  `protocol_json` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `job_info` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique_idx` (`id`,`app_id`) USING BTREE,
  KEY `idx_api_name` (`protocol_type`) USING BTREE,
  KEY `api_code` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='api资源表';

-- ----------------------------
-- Table structure for app_sync_plugin
-- ----------------------------
DROP TABLE IF EXISTS `app_sync_plugin`;
CREATE TABLE `app_sync_plugin` (
  `id` bigint NOT NULL COMMENT '插件ID',
  `config_id` bigint DEFAULT NULL COMMENT '配置表单ID',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户ID',
  `app_id` bigint DEFAULT NULL COMMENT '应用id',
  `plugin_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '插件名称',
  `plugin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'UPSTREAM' COMMENT '插件类型，UPSTREAM，DOWNSTREAM, SSO',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '状态 ENABLE-启用, DISABLE-禁用',
  `user_org_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户所属组织类型 SINGLE-单组织, MULTIPLE-多组织',
  `version` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '插件版本号',
  `enable_sync_user` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'YES' COMMENT '是否开启用户同步:YES，NO',
  `enable_sync_org` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'YES' COMMENT '是否开启组织同步:YES，NO',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `enable_data_recovery` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '是否支持数据回收:YES，NO',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_config_id` (`config_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_sync_properties
-- ----------------------------
DROP TABLE IF EXISTS `app_sync_properties`;
CREATE TABLE `app_sync_properties` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `properties_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '属性名称',
  `properties_classification` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '属性分类 USER-用户属性, ORG-组织属性',
  `properties_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '属性数据类型',
  `properties_examples` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性示例值',
  `properties_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '属性描述',
  `is_required` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否必填：是-YES，否-NO',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_properties_name` (`properties_name`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_sync_properties_mapping
-- ----------------------------
DROP TABLE IF EXISTS `app_sync_properties_mapping`;
CREATE TABLE `app_sync_properties_mapping` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `upstream_properties_id` bigint NOT NULL COMMENT '上游属性ID',
  `downstream_properties_id` bigint NOT NULL COMMENT '下游属性ID：与上游属性ID对应',
  `is_properties_sync` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否同步：是 - YES，否 - NO',
  `properties_mapping_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '字段映射类别：USER, ORG',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_sync_task_info
-- ----------------------------
DROP TABLE IF EXISTS `app_sync_task_info`;
CREATE TABLE `app_sync_task_info` (
  `id` bigint NOT NULL COMMENT '任务ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `task_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务名称',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用名称',
  `plugin_id` bigint NOT NULL COMMENT '插件ID',
  `plugin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'UPSTREAM' COMMENT '插件类型，UPSTREAM，DOWNSTREAM',
  `xxl_job_info` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '任务状态：启用-ENABLE，停用-DISABLE',
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '任务执行结果：未执行-NOT_IMPLEMENT，成功-SUCCESS，失败-FAIL，运行中 RUNNING',
  `is_task_deployed` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'NO' COMMENT '任务是否配置完成, YES-是, NO-否',
  `enable_sync_user` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否同步用户：是-YES，否-NO',
  `trigger_mode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `trigger_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `sync_org_id` bigint DEFAULT NULL,
  `user_sync_classification_id` bigint DEFAULT NULL COMMENT '上游操作：用户同步到SSO360的某个用户分类下面',
  `operate_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `enable_sync_org` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否同步组织：是-YES，否-NO',
  `org_sync_classification_id` bigint DEFAULT NULL COMMENT '上游操作：组织同步到SSO360的某个组织分类下面',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_plugin_id` (`plugin_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_sync_task_record
-- ----------------------------
DROP TABLE IF EXISTS `app_sync_task_record`;
CREATE TABLE `app_sync_task_record` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `plugin_id` bigint NOT NULL COMMENT '插件ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `batch_id` bigint NOT NULL COMMENT '批次ID',
  `result` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '任务执行结果：未执行，成功，失败，运行中',
  `operate_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '操作类型',
  `data_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据类型：USER, ORG',
  `upstream_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '上游应用',
  `downstream_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '下游应用',
  `trigger_mode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '触发方式',
  `result_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin COMMENT '执行结果返回信息',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_batch_id` (`batch_id`) USING BTREE,
  KEY `idx_plugin_id` (`plugin_id`) USING BTREE,
  KEY `idx_task_id` (`task_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_user_apply
-- ----------------------------
DROP TABLE IF EXISTS `app_user_apply`;
CREATE TABLE `app_user_apply` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `user_id` bigint DEFAULT NULL COMMENT '用户ID',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_userid_appid` (`app_id`,`user_id`) USING BTREE COMMENT '应用id与用户id唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for app_user_relation
-- ----------------------------
DROP TABLE IF EXISTS `app_user_relation`;
CREATE TABLE `app_user_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `adx_tenant_user_app_id` (`tenant_id`,`user_id`,`app_id`),
  KEY `idx_app_id` (`app_id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_auth_api_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_auth_api_relation`;
CREATE TABLE `bum_auth_api_relation` (
  `id` bigint NOT NULL COMMENT '接口id',
  `api_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '接口名称',
  `api_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '接口code',
  `api_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '接口url',
  `api_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '接口请求类型: GET,POST,PUT',
  `api_version` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1.0' COMMENT 'api版本',
  `auth_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限code',
  `app_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用名称',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_api_name` (`api_name`) USING BTREE,
  KEY `api_code` (`api_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='api资源表';

-- ----------------------------
-- Table structure for bum_authority_collection
-- ----------------------------
DROP TABLE IF EXISTS `bum_authority_collection`;
CREATE TABLE `bum_authority_collection` (
  `id` bigint NOT NULL COMMENT '主键',
  `ac_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '权限集名称',
  `ac_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限集code',
  `auth_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限编码集合',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '描述',
  `creator` bigint DEFAULT NULL COMMENT '创建者id',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `role_idx` (`ac_name`) USING BTREE,
  KEY `ac_idx` (`ac_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_authority_menu
-- ----------------------------
DROP TABLE IF EXISTS `bum_authority_menu`;
CREATE TABLE `bum_authority_menu` (
  `id` bigint NOT NULL COMMENT '接口id',
  `parent_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '0' COMMENT '父id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '名称',
  `path` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '路径',
  `url` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '菜单与组件映射关系',
  `auth_list` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限编码集合',
  `order_num` int DEFAULT '1' COMMENT '排序',
  `url_version` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '1.0' COMMENT '版本',
  `iframe_or_route` int DEFAULT NULL COMMENT '菜单对应组件类型\n0: router\n1: iframe\n2: snack\n3. snackPage\n4. redirect',
  `i18n_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '国际化key（在对接国际化后使用）',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `photo` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '菜单图标',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `tenant_id` bigint NOT NULL COMMENT '租户id',
  `snack_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '区分snack页面的标识',
  `query` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '入参参数',
  PRIMARY KEY (`id`,`tenant_id`) USING BTREE,
  KEY `idx_api_name` (`parent_id`) USING BTREE,
  KEY `api_code` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='api资源表';

-- ----------------------------
-- Table structure for bum_aws_user_id
-- ----------------------------
DROP TABLE IF EXISTS `bum_aws_user_id`;
CREATE TABLE `bum_aws_user_id` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `udx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='AWS用户ID';

-- ----------------------------
-- Table structure for bum_org
-- ----------------------------
DROP TABLE IF EXISTS `bum_org`;
CREATE TABLE `bum_org` (
  `id` bigint NOT NULL COMMENT 'ID',
  `org_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '组织名称',
  `org_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '组织编码',
  `org_level` int NOT NULL COMMENT '组织层级',
  `parent_id` bigint NOT NULL COMMENT '父id',
  `org_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '路径',
  `org_path_name` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '组织名称全路径',
  `classification_id` bigint DEFAULT NULL COMMENT '分类ID',
  `attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `scim_attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `auto_create_account` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'YES' COMMENT '是否自动创建用户',
  `address_book_display` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'YES' COMMENT '是否显示通讯录',
  `tenant_id` bigint NOT NULL DEFAULT '111' COMMENT '租户ID',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '状态',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` bigint DEFAULT NULL COMMENT '创建人id',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'NO' COMMENT '是否删除, YES-是，NO-否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_path_del` (`org_path`,`is_deleted`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_org_name` (`org_name`),
  KEY `idx_org_code` (`org_code`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_org_charge_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_org_charge_relation`;
CREATE TABLE `bum_org_charge_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `org_id` bigint NOT NULL COMMENT '组织id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `tenant_id` bigint NOT NULL DEFAULT '111' COMMENT '租户ID',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `sort` int NOT NULL DEFAULT '1' COMMENT '排序',
  `creator` bigint DEFAULT '111' COMMENT '创建人id',
  `main_charge` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否主负责人，1-是，0-否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_org_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_org_role_relation`;
CREATE TABLE `bum_org_role_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `org_id` bigint NOT NULL COMMENT '组织ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `udx_user_id_role_id` (`org_id`,`role_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='组织角色关系表';

-- ----------------------------
-- Table structure for bum_role
-- ----------------------------
DROP TABLE IF EXISTS `bum_role`;
CREATE TABLE `bum_role` (
  `id` bigint NOT NULL,
  `role_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '角色名称',
  `rid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '角色编码',
  `role_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '角色类型: General/Rank',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '状态',
  `attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '描述',
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'NO' COMMENT '是否删除',
  `creator` bigint DEFAULT NULL COMMENT '创建者id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `tenant_idx` (`tenant_id`) USING BTREE,
  KEY `statusx` (`status`) USING BTREE,
  KEY `idx_role_name` (`role_name`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_update_time` (`update_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_role_authority_collection_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_role_authority_collection_relation`;
CREATE TABLE `bum_role_authority_collection_relation` (
  `id` bigint NOT NULL,
  `role_id` bigint NOT NULL COMMENT '角色id',
  `ac_id` bigint NOT NULL COMMENT '权限集id',
  `creator` bigint DEFAULT NULL COMMENT '创建者id',
  `tenant_id` bigint DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `role_idx` (`role_id`) USING BTREE,
  KEY `ac_idx` (`ac_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_sync_data
-- ----------------------------
DROP TABLE IF EXISTS `bum_sync_data`;
CREATE TABLE `bum_sync_data` (
  `id` bigint NOT NULL,
  `tenant_id` bigint DEFAULT NULL COMMENT '租户id',
  `task_id` bigint DEFAULT NULL COMMENT '同步任务ID',
  `plugin_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '插件类型: UPSTREAM, DOWNSTREAM',
  `data_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据类型：USER, ORG',
  `data_operation` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据操作类型：USER_INSERT, USER_UPDATE, USER_DELETE, ORG_INSERT, ORG_UPDATE, ORG_DELETE',
  `data` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `trigger_mode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '触发方式',
  `trigger_config` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT 'NO' COMMENT '是否下发，YES，NO',
  `fail_number` int NOT NULL DEFAULT '0' COMMENT '失败次数',
  `batch_id` bigint DEFAULT NULL COMMENT '批次号',
  `timestamp` bigint DEFAULT NULL COMMENT '快照时间戳',
  `creator` bigint DEFAULT NULL,
  `updater` bigint DEFAULT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `data_id` bigint DEFAULT NULL COMMENT '业务主键ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_tenant_task_id` (`tenant_id`,`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_sync_org_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_sync_org_relation`;
CREATE TABLE `bum_sync_org_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `app_org_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `org_id` bigint NOT NULL COMMENT '应用组织ID对应的SSO360组织ID',
  `data_source` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据来源',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_app_org_id` (`app_org_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_sync_user_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_sync_user_relation`;
CREATE TABLE `bum_sync_user_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `app_id` bigint NOT NULL COMMENT '应用ID',
  `app_user_id` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `user_id` bigint NOT NULL COMMENT '应用用户ID对应的SSO360用户ID',
  `data_source` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '数据来源',
  `creator` bigint DEFAULT NULL COMMENT '创建人ID',
  `updater` bigint DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_app_user_id` (`app_user_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for bum_user
-- ----------------------------
DROP TABLE IF EXISTS `bum_user`;
CREATE TABLE `bum_user` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `classification_id` bigint NOT NULL COMMENT '分类ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '用户名',
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '密码',
  `email` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '邮箱',
  `phone` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '电话',
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '状态 ENABLE-启用, DISABLE-禁用, LOCK-锁定, EXPIRE-过期',
  `expire_time` date DEFAULT NULL COMMENT '过期时间',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '性别 M-男, F-女',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像',
  `avatar_url` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '头像图片url地址',
  `supervisor_id` bigint DEFAULT NULL COMMENT '直属主管id',
  `uuid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户UUID',
  `source` varchar(1000) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户来源',
  `attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `scim_attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'NO' COMMENT '是否删除, YES-是，NO-否',
  `creator` bigint NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `password_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'SYSTEM_GENERATE' COMMENT '密码状态, SYSTEM_GENERATE:系统生成, USER_INPUT:用户录入',
  `last_login_time` datetime DEFAULT NULL COMMENT '上次登陆时间',
  `last_pwd_change_time` datetime DEFAULT NULL COMMENT '上次修改密码时间',
  `is_tenant_admin` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'NO' COMMENT '是否为租户管理员',
  `lock_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '锁定状态 PERMANENT-永久锁定, TEMPORARY-临时锁定',
  `privacy_agreement_confirm_time` datetime DEFAULT NULL COMMENT '隐私协议更新时间',
  `register_id` varchar(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户注册ID',
  `register_time` bigint DEFAULT NULL COMMENT '用户注册时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_classification_id` (`classification_id`) USING BTREE,
  KEY `idx_create_time` (`create_time`),
  KEY `idx_update_time` (`update_time`),
  KEY `idx_uuid` (`uuid`),
  KEY `idx_email` (`email`),
  KEY `idx_phone` (`phone`),
  KEY `idx_username` (`username`),
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_register_id` (`register_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户表';

-- ----------------------------
-- Table structure for bum_user_ext
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_ext`;
CREATE TABLE `bum_user_ext` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `history_password` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_tenant_id` (`tenant_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户扩展信息表';

-- ----------------------------
-- Table structure for bum_user_import_item
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_import_item`;
CREATE TABLE `bum_user_import_item` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `record_id` bigint NOT NULL COMMENT '导入记录ID',
  `excel_number` int NOT NULL COMMENT 'excel行号',
  `excel_cells` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `error_msg` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '错误消息',
  `creator` bigint NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_classification_id` (`record_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户导入记录表';

-- ----------------------------
-- Table structure for bum_user_import_record
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_import_record`;
CREATE TABLE `bum_user_import_record` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `classification_id` bigint NOT NULL COMMENT '分类ID',
  `is_error` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '是否错误',
  `success_number` int NOT NULL DEFAULT '0' COMMENT '成功人数',
  `fail_number` int NOT NULL DEFAULT '0' COMMENT '失败人数',
  `import_time` datetime NOT NULL COMMENT '导入时间',
  `import_file` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'excel原始文件',
  `header` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `creator` bigint NOT NULL COMMENT '创建者',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_classification_id` (`classification_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_creator` (`creator`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户导入记录表';

-- ----------------------------
-- Table structure for bum_user_org_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_org_relation`;
CREATE TABLE `bum_user_org_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `org_id` bigint NOT NULL COMMENT '组织ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `extend_org_app_auth` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否继承组织的应用权限,1:继承，0:不继承',
  `main_org` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否主组织，1-是，0-否',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `udx_user_id_org_id` (`user_id`,`org_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户组织关系表';

-- ----------------------------
-- Table structure for bum_user_register
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_register`;
CREATE TABLE `bum_user_register` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `classification_id` bigint NOT NULL COMMENT '分类ID',
  `org_id` bigint DEFAULT NULL COMMENT '组织ID',
  `role_id` bigint DEFAULT NULL COMMENT '角色ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '密码',
  `email` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '邮箱',
  `phone` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '电话',
  `gender` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT '' COMMENT '性别 M-男, F-女',
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '用户状态',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `attributes` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `source` varchar(1000) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户来源',
  `register_type` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'B' COMMENT '注册类型, B:B端注册, C:C端注册',
  `review_type` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT 'REVIEW' COMMENT '审核类型, REVIEW:管理员审核, ACTIVE:用户激活',
  `active_status` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '激活状态, PENDING_ACTIVE-待激活, ACTIVE_SUCCESS-激活成功',
  `active_expire_time` datetime DEFAULT NULL COMMENT '激活失效时间',
  `third_account_c` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `review_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'PENDING_REVIEW' COMMENT '审核状态, PENDING_REVIEW-待审核, REVIEW_PASS-审核通过, REVIEW_REFUSE-审核拒绝',
  `register_time` datetime NOT NULL COMMENT '注册时间',
  `reviewer` bigint DEFAULT NULL COMMENT '审核人',
  `is_deleted` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'NO' COMMENT '是否删除, YES-是，NO-否',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_classification_id` (`classification_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_username` (`username`),
  KEY `idx_phone` (`phone`),
  KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户注册表';

-- ----------------------------
-- Table structure for bum_user_register_active_link
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_register_active_link`;
CREATE TABLE `bum_user_register_active_link` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `user_register_id` bigint NOT NULL COMMENT '临时账号ID',
  `expire_time` datetime NOT NULL COMMENT '激活链接失效时间',
  `status` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'ENABLE' COMMENT '激活链接状态, ENABLE-有效, DISABLE-失效',
  `url` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '前端路由地址',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_user_register_id` (`user_register_id`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户注册激活链接表';

-- ----------------------------
-- Table structure for bum_user_register_push_fail
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_register_push_fail`;
CREATE TABLE `bum_user_register_push_fail` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `uuid` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户uuid',
  `data` json NOT NULL DEFAULT (_utf8mb4'{}'),
  `fail_number` int NOT NULL COMMENT '失败次数',
  `fail_reason` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '失败原因',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `operate_type` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '类型：INSERT,UPDATE,DELETE',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_uuid` (`uuid`),
  KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户注册数据发送失败记录表';

-- ----------------------------
-- Table structure for bum_user_role_relation
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_role_relation`;
CREATE TABLE `bum_user_role_relation` (
  `id` bigint NOT NULL COMMENT 'ID',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `udx_user_id_role_id` (`user_id`,`role_id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户角色关系表';

-- ----------------------------
-- Table structure for bum_user_third_account
-- ----------------------------
DROP TABLE IF EXISTS `bum_user_third_account`;
CREATE TABLE `bum_user_third_account` (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户主键',
  `acc_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '平台类型QY_WX:企业微信、FS:飞书',
  `acc_value` varchar(500) COLLATE utf8mb4_bin NOT NULL COMMENT '平台唯一值，当微信是：使用unionid',
  `status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT 'BIND' COMMENT '绑定:BIND,解绑:UNBIND',
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_value_type` (`acc_value`,`acc_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='用户三方账号表';

-- ----------------------------
-- Table structure for sys_i18n_error_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n_error_message`;
CREATE TABLE `sys_i18n_error_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `msg` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `lang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `app_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updater` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20230327104718 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Table structure for sys_i18n_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n_message`;
CREATE TABLE `sys_i18n_message` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `msg` varchar(1500) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `lang` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `app_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `creator` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `updater` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `status` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB AUTO_INCREMENT=1693879627929378990 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC COMMENT='DB WorkerID Assigner for UID Generator';

SET FOREIGN_KEY_CHECKS = 1;
