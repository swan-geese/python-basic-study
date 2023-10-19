DROP TABLE IF EXISTS `account_plugin_check`;
CREATE TABLE `account_plugin_check` (
  `id` bigint(20) NOT NULL COMMENT '主键id,对应帐号，组织，岗位id',
  `approval_type` varchar(32) NOT NULL DEFAULT '0' COMMENT '枚举：org,job,account',
  `encrypt_data` varchar(32) DEFAULT NULL COMMENT '参数加密值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='记录最新下推更新记录表';

DROP TABLE IF EXISTS `acl_api`;
CREATE TABLE `acl_api` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `api_uri` varchar(25) DEFAULT NULL COMMENT 'api编码',
  `primary_table` varchar(32) DEFAULT NULL COMMENT '主表',
  `join_table` varchar(255) DEFAULT NULL COMMENT 'Join表的清单，逗号分隔',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1有效 0无效',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_api_uri` (`api_uri`) USING BTREE,
  KEY `index_api_uri` (`api_uri`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='api接口权限表';

DROP TABLE IF EXISTS `acl_api_item`;
CREATE TABLE `acl_api_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `api_id` bigint(20) DEFAULT NULL COMMENT 'api id',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名称',
  `column_name` varchar(255) DEFAULT NULL COMMENT '列名称',
  `is_selected_column` tinyint(2) DEFAULT NULL COMMENT '是否默认显示 1是，0否',
  `is_search_column` tinyint(2) DEFAULT NULL COMMENT '是否是搜索字段 1是，0否',
  `order_num` mediumint(11) DEFAULT NULL COMMENT '列的排序号，从小到大',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_api_id` (`api_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='api接口明细表';

DROP TABLE IF EXISTS `acl_app_grade_link`;
CREATE TABLE `acl_app_grade_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用配置id',
  `grade_mgmt_id` bigint(20) DEFAULT NULL COMMENT '应用分级id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用分级关联表';

DROP TABLE IF EXISTS `acl_grade_mgmt`;
CREATE TABLE `acl_grade_mgmt` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '分级名称',
  `type` tinyint(2) DEFAULT NULL COMMENT '类型：1用户分级，2组织分级，3帐号分级',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `role_id` bigint(11) DEFAULT NULL COMMENT '角色id',
  `scope_id` bigint(11) DEFAULT NULL COMMENT 'scope id',
  `include_self_org` tinyint(2) DEFAULT NULL COMMENT '包含的本组织',
  `include_sub_org` tinyint(2) DEFAULT NULL COMMENT '包含了下级组织',
  `include_extra` tinyint(2) DEFAULT NULL COMMENT '包含了自定义的组织/应用清单，详细的在item表',
  `include_extra_sub_org` tinyint(2) DEFAULT NULL COMMENT '自定义组织，包含了下级组织',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `code` varchar(20) DEFAULT '' COMMENT '角色编码',
  `include_app` tinyint(2) DEFAULT NULL COMMENT '管理应用数据范围：0-不管理，1-管理',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分级管理配置表';

DROP TABLE IF EXISTS `acl_grade_mgmt_item`;
CREATE TABLE `acl_grade_mgmt_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `grade_id` bigint(20) DEFAULT NULL COMMENT '分级管理的id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_grade_id` (`grade_id`) USING BTREE COMMENT '分级管理id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分级管理明细表';

DROP TABLE IF EXISTS `acl_grade_org_app_user_link`;
CREATE TABLE `acl_grade_org_app_user_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `grade_id` bigint(20) DEFAULT NULL COMMENT '分级管理的id',
  `data_type` tinyint(2) DEFAULT NULL COMMENT '数据类型，1-组织；2-应用；3-菜单；4-用户；',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id，包括：组织、应用、菜单、用户',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1-绑定；0-解绑',
  `action_type` tinyint(2) DEFAULT NULL COMMENT '操作类型：1-新增；2-修改',
  `action_timestamp` bigint(20) DEFAULT NULL COMMENT '时间戳，每次新建、修改产生一个时间戳作为数据隔离的唯一标识',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_timestamp_type` (`action_timestamp`,`data_type`) USING BTREE COMMENT '分级角色中间数据索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='分级管理组织、应用、用户关联临时表';

DROP TABLE IF EXISTS `acl_jwt_api`;
CREATE TABLE `acl_jwt_api` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `api` varchar(255) DEFAULT NULL COMMENT 'api',
  `module` varchar(255) DEFAULT NULL COMMENT '模块使用',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_api` (`api`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='jwt_api表';

DROP TABLE IF EXISTS `acl_jwt_secret`;
CREATE TABLE `acl_jwt_secret` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `api_key` varchar(128) DEFAULT NULL COMMENT 'apiKey',
  `api_secret` varchar(128) DEFAULT NULL COMMENT 'api秘钥secret',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1有效 0无效',
  `ip_white` varchar(1000) DEFAULT NULL COMMENT 'ip白名单',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `auth_type` tinyint(2) DEFAULT NULL COMMENT '认证方式 1 basic 2 jwt',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_name` (`name`) USING BTREE,
  UNIQUE KEY `uq_api_key` (`api_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='jwt认证的秘钥';

DROP TABLE IF EXISTS `acl_jwt_secret_api_link`;
CREATE TABLE `acl_jwt_secret_api_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `jwt_secret_id` bigint(20) NOT NULL COMMENT 'acl_jwt_secret主键',
  `jwt_api_id` bigint(20) NOT NULL COMMENT 'acl_jwt_api主键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='jwt协议对应的秘钥和api表';

DROP TABLE IF EXISTS `acl_menu`;
CREATE TABLE `acl_menu` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
  `code` varchar(128) DEFAULT NULL COMMENT '菜单编码',
  `type` tinyint(2) DEFAULT NULL COMMENT '菜单类型 1菜单 2功能 3 api',
  `path` varchar(1024) DEFAULT NULL COMMENT '菜单地址,用code组合而成的路径',
  `url` varchar(300) DEFAULT NULL COMMENT '菜单url',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` smallint(1) DEFAULT NULL COMMENT '状态 1 有效 0 无效',
  `order_num` mediumint(11) DEFAULT NULL COMMENT '排序',
  `method` varchar(10) DEFAULT NULL COMMENT 'http请求的方式 post/get/put/delete',
  `photo` varchar(50) DEFAULT NULL COMMENT '图片地址',
  `iframe_or_route` smallint(1) DEFAULT NULL COMMENT '页面加载方式：0 iframe，1 route',
  `display_scope` smallint(1) DEFAULT NULL COMMENT '显示范围：1 后台 2自助服务 3都显示',
  `is_sys` smallint(1) DEFAULT '0' COMMENT '是否系统内置，0-非内置，1-内置，默认为0',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `display_scope_index` (`display_scope`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单管理';

DROP TABLE IF EXISTS `acl_menu_api`;
CREATE TABLE `acl_menu_api` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `module` varchar(200) DEFAULT NULL COMMENT 'api所属模块',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `code` varchar(200) DEFAULT NULL COMMENT '菜单编码',
  `auth_type` smallint(1) DEFAULT '1' COMMENT '认证类型：0-不认证，1-认证',
  `url` varchar(300) DEFAULT NULL COMMENT '菜单url',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` smallint(1) DEFAULT NULL COMMENT '状态 1 有效 0 无效',
  `method` varchar(10) DEFAULT NULL COMMENT 'http请求的方式 post/get/put/delete',
  `iframe_or_route` smallint(1) DEFAULT NULL COMMENT '页面加载方式：0 iframe，1 route',
  `display_scope` smallint(1) DEFAULT NULL COMMENT '显示范围：1 后台 2自助服务 3都显示',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_acl_menu_api_url` (`url`) USING BTREE COMMENT 'API url唯一约束',
  KEY `display_scope_index` (`display_scope`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='API管理';

DROP TABLE IF EXISTS `acl_menu_api_link`;
CREATE TABLE `acl_menu_api_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  `api_id` bigint(20) DEFAULT NULL COMMENT 'API ID',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_acl_api_id` (`api_id`) USING BTREE COMMENT 'api id索引',
  KEY `idx_acl_menu_id` (`menu_id`) USING BTREE COMMENT '菜单id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='菜单与API关联表';

DROP TABLE IF EXISTS `acl_role`;
CREATE TABLE `acl_role` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '角色名称',
  `code` varchar(30) NOT NULL COMMENT '角色编码',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1有效 0无效',
  `order_num` mediumint(11) DEFAULT NULL COMMENT '排序',
  `role_initial` smallint(2) DEFAULT NULL COMMENT '是否是系统初始化导入的角色,1是,2否',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `type` varchar(20) DEFAULT NULL COMMENT '类型：normal-普通角色，grade_mgmt-分级角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='角色管理';

DROP TABLE IF EXISTS `acl_scope`;
CREATE TABLE `acl_scope` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单分组',
  `code` varchar(20) DEFAULT NULL COMMENT 'Scope',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `version` varchar(50) DEFAULT NULL COMMENT '版本',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `type` tinyint(2) DEFAULT NULL COMMENT 'scope类型 1web前端 2mobile端 3开发人员',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `sys_scope` tinyint(2) DEFAULT '0' COMMENT '系统菜单分组：0-否，1-是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='scope管理';

DROP TABLE IF EXISTS `acl_scope_menu_link`;
CREATE TABLE `acl_scope_menu_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `scope_id` bigint(20) DEFAULT NULL COMMENT 'scope id',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单id',
  `auth_time` datetime DEFAULT NULL COMMENT '菜单授权时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_scope_id` (`scope_id`) USING BTREE,
  KEY `index_menu_id` (`menu_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='scope和菜单表的关联表';

DROP TABLE IF EXISTS `acl_scope_role_link`;
CREATE TABLE `acl_scope_role_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `scope_id` bigint(20) DEFAULT NULL COMMENT 'scope id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `auth_time` datetime DEFAULT NULL COMMENT '授权时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_scope_id` (`scope_id`) USING BTREE,
  KEY `index_role_id` (`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='scope和角色的关联表';

DROP TABLE IF EXISTS `acl_table`;
CREATE TABLE `acl_table` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名称',
  `cond_sql` varchar(1000) DEFAULT NULL COMMENT '查询条件',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_table_name` (`table_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='api接口表';

DROP TABLE IF EXISTS `acl_table_item`;
CREATE TABLE `acl_table_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `table_id` bigint(20) DEFAULT NULL COMMENT '表id',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名称',
  `column_name` varchar(255) DEFAULT NULL COMMENT '列名称',
  `is_read` tinyint(2) DEFAULT NULL COMMENT '是否可读 1可读 0不读',
  `is_update` tinyint(2) DEFAULT NULL COMMENT '是否可编辑 1编辑 0不可编辑',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_table_id` (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='api接口明细表';

DROP TABLE IF EXISTS `acl_table_role_link`;
CREATE TABLE `acl_table_role_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `table_id` bigint(20) DEFAULT NULL COMMENT 'table id',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='api和角色关联表';

DROP TABLE IF EXISTS `acl_user_role_link`;
CREATE TABLE `acl_user_role_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `auth_time` datetime DEFAULT NULL COMMENT '授权时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `idx_role_id` (`role_id`) USING BTREE COMMENT '角色id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户与角色的关联表';

DROP TABLE IF EXISTS `app_account`;
CREATE TABLE `app_account` (
  `id` bigint(20) NOT NULL COMMENT '帐号ID',
  `account_uuid` varchar(64) NOT NULL DEFAULT '' COMMENT '与下游同步数据的uuid',
  `app_id` bigint(20) NOT NULL COMMENT '应用id',
  `account_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '帐号',
  `account_pwd` varchar(400) DEFAULT NULL COMMENT '帐号密码',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：-1删除，0停用，1启用，2锁定，3申请中，4审批不同意，5等待中，7关闭',
  `account_type` varchar(3) DEFAULT '009' COMMENT '009:内部，007:临时，004:公共',
  `account_name` varchar(100) DEFAULT NULL COMMENT '帐号名称',
  `begin_time` datetime DEFAULT NULL COMMENT '帐号启用时间',
  `end_time` datetime DEFAULT NULL COMMENT '帐号关闭时间',
  `pwd_modify_time` bigint(20) DEFAULT NULL COMMENT '密码修改时间',
  `mailbox_database` varchar(100) DEFAULT NULL COMMENT 'exchange邮箱',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `privilege_account` tinyint(4) DEFAULT '0' COMMENT '视频审计',
  `pwd_salt` varchar(128) DEFAULT NULL COMMENT '盐',
  `account_app_user_id` varchar(255) DEFAULT NULL COMMENT '对应下游用户的id',
  `distinguished_name` varchar(255) DEFAULT NULL COMMENT 'AD DN',
  `user_principal_name` varchar(255) DEFAULT NULL COMMENT 'AD用户登录名',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_account_no_app_id` (`app_id`,`account_no`) USING BTREE,
  KEY `account_uuid` (`account_uuid`) USING BTREE,
  KEY `account_no` (`account_no`) USING BTREE,
  KEY `app_id` (`app_id`) USING BTREE,
  KEY `idx_a_a_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用帐号表';

DROP TABLE IF EXISTS `app_account_deputy`;
CREATE TABLE `app_account_deputy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_user_id` bigint(20) DEFAULT NULL COMMENT '委托人id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '帐号最后修改者',
  `update_time` datetime DEFAULT NULL COMMENT '记录编辑时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托单';

DROP TABLE IF EXISTS `app_account_deputy_assignee`;
CREATE TABLE `app_account_deputy_assignee` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_user_id` bigint(20) DEFAULT NULL COMMENT '委托人id',
  `assignee_user_id` bigint(20) DEFAULT NULL COMMENT '受托人id',
  `creator` varchar(64) DEFAULT NULL COMMENT '帐号创建者',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '帐号最后修改者',
  `update_time` datetime DEFAULT NULL COMMENT '记录编辑时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托常用联系人';

DROP TABLE IF EXISTS `app_account_deputy_item`;
CREATE TABLE `app_account_deputy_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_id` bigint(20) DEFAULT NULL COMMENT '委托单id',
  `order_num` mediumint(3) DEFAULT '0' COMMENT '显示排序',
  `reminder` tinyint(1) DEFAULT NULL COMMENT '收回提醒：1-提醒；0-不提醒；',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托单明细';

DROP TABLE IF EXISTS `app_account_deputy_item_app`;
CREATE TABLE `app_account_deputy_item_app` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_item_id` bigint(20) DEFAULT NULL COMMENT '委托单明细id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `begin_time` datetime DEFAULT NULL COMMENT '委托起始时间',
  `end_time` datetime DEFAULT NULL COMMENT '委托结束时间',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-委托；2-手动收回；3-自动收回',
  `revoke_time` datetime DEFAULT NULL COMMENT '回收时间',
  `account_user_link_id` bigint(20) DEFAULT NULL COMMENT '用户帐号关联表id',
  `deputy_id` bigint(20) DEFAULT NULL COMMENT '委托单id',
  `notify_status` tinyint(2) DEFAULT '0' COMMENT '通知状态 0-无需通知 1-需通知未发送 2-已发送通知',
  `notify_result` varchar(1000) DEFAULT NULL COMMENT '通知结果',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托单委托的应用';

DROP TABLE IF EXISTS `app_account_deputy_link`;
CREATE TABLE `app_account_deputy_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_item_app_id` bigint(20) DEFAULT NULL COMMENT '委托单包含应用id',
  `account_no` varchar(100) DEFAULT NULL COMMENT '委托帐号',
  `deputy_id` bigint(20) DEFAULT NULL COMMENT '委托单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托单委托的帐号app_account_deputy_item_app_account';

DROP TABLE IF EXISTS `app_account_permission_link`;
CREATE TABLE `app_account_permission_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `account_id` bigint(20) DEFAULT NULL COMMENT '应用帐号Id',
  `data_type` varchar(10) DEFAULT NULL COMMENT '权限类型：role-角色，group-组，menu-菜单',
  `data_id` bigint(20) DEFAULT NULL COMMENT '应用角色、组、菜单数据id',
  `source_type` tinyint(2) DEFAULT NULL COMMENT '来源类型：0-管理员；1-自动；2-自助申请',
  `source_id` bigint(20) DEFAULT NULL COMMENT '来源id',
  `begin_date` datetime DEFAULT NULL COMMENT '权限生效时间',
  `end_date` datetime DEFAULT NULL COMMENT '权限过期时间',
  `risky` tinyint(2) DEFAULT '0' COMMENT '风险权限:1 是 0 否',
  `risky_type` tinyint(2) DEFAULT NULL COMMENT '风险类型：1：违反互斥权限规则；2：违反合规最大权限规则',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_account_id` (`account_id`) USING BTREE COMMENT '应用帐号id索引',
  KEY `idx_data_type_data_id` (`data_type`,`data_id`,`account_id`) USING BTREE COMMENT '应用权限类型和id',
  KEY `idx_data_id` (`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帐号权限';

DROP TABLE IF EXISTS `app_account_permission_link_expired`;
CREATE TABLE `app_account_permission_link_expired` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `account_id` bigint(20) DEFAULT NULL COMMENT '应用帐号Id',
  `data_type` varchar(10) DEFAULT NULL COMMENT '权限类型：role-角色，group-组，resource-菜单',
  `data_id` bigint(20) DEFAULT NULL COMMENT '应用角色、组、菜单数据id',
  `source_type` tinyint(2) DEFAULT NULL COMMENT '来源类型：0-初始化授权；1-手动赋权；2-手动申请；3-自动分配',
  `source_id` bigint(20) DEFAULT NULL COMMENT '来源id',
  `begin_date` datetime DEFAULT NULL COMMENT '权限生效时间',
  `end_date` datetime DEFAULT NULL COMMENT '权限过期时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_account_data_id` (`account_id`,`data_id`) USING BTREE,
  KEY `idx_account_id` (`account_id`) USING BTREE COMMENT '应用帐号id索引',
  KEY `idx_data_type_data_id` (`data_type`,`data_id`) USING BTREE COMMENT '应用权限类型和id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='账号过期权限关联表';

DROP TABLE IF EXISTS `app_account_user_field_mapping`;
CREATE TABLE `app_account_user_field_mapping` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '应用id',
  `account_field` varchar(255) DEFAULT NULL COMMENT '帐号属性',
  `user_field` varchar(255) DEFAULT NULL COMMENT '用户属性',
  `qlexpress_text` varchar(2000) DEFAULT NULL COMMENT 'ql表达式',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户帐号属性映射表 ';

DROP TABLE IF EXISTS `app_account_user_link`;
CREATE TABLE `app_account_user_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `account_id` bigint(20) NOT NULL COMMENT '应用帐号id',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `primary_user_flag` tinyint(2) NOT NULL DEFAULT '0' COMMENT '1-表示这条记录是主帐号绑定的记录，0-表示否 ',
  `selected` tinyint(2) DEFAULT NULL COMMENT '1:选中，非1:未选中',
  `begin_time` datetime DEFAULT NULL COMMENT '帐号启用时间',
  `end_time` datetime DEFAULT NULL COMMENT '帐号关闭时间',
  `confirm` varchar(2) DEFAULT NULL COMMENT '审核确认状态,1:已确认,其他:未确认',
  `request_time` datetime DEFAULT NULL COMMENT '申请时间',
  `link_type` tinyint(4) DEFAULT NULL COMMENT '关联类型：1-委托',
  `source_type` tinyint(2) DEFAULT NULL COMMENT '数据来源 1 自动 0 手动',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `account_id` (`account_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用帐号-用户关系表';

DROP TABLE IF EXISTS `app_ad_group`;
CREATE TABLE `app_ad_group` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `cn` varchar(255) DEFAULT NULL COMMENT 'group名称',
  `object_guid` varchar(255) DEFAULT NULL COMMENT 'group组id',
  `display_name` varchar(255) DEFAULT NULL COMMENT '显示名称',
  `description` varchar(255) DEFAULT NULL COMMENT '组描述信息',
  `group_type` varchar(255) DEFAULT NULL COMMENT '组类型',
  `mail` varchar(255) DEFAULT NULL COMMENT '邮件',
  `info` varchar(255) DEFAULT NULL,
  `distinguished_name` varchar(255) DEFAULT NULL COMMENT 'dn',
  `member` varchar(255) DEFAULT NULL COMMENT '成员列表',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='AD的Group对象';

DROP TABLE IF EXISTS `app_ad_ou`;
CREATE TABLE `app_ad_ou` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `base_dn` varchar(255) DEFAULT NULL COMMENT 'baseDn',
  `ad_ou` varchar(255) DEFAULT NULL COMMENT 'ou名称',
  `distinguished_name` varchar(255) DEFAULT NULL COMMENT 'dn',
  `object_guid` varchar(255) DEFAULT NULL COMMENT 'guid',
  `country` varchar(255) DEFAULT NULL COMMENT '国家代码',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '城市',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='AD的OU对象';

DROP TABLE IF EXISTS `app_dependency_rule`;
CREATE TABLE `app_dependency_rule` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` tinyint(2) NOT NULL COMMENT '操作类型:0-开通帐号,1-删除帐号,2-停用帐号,3-启用帐号',
  `rule_id` bigint(20) NOT NULL COMMENT '规则id',
  `app_id` bigint(20) NOT NULL COMMENT '应用id',
  `delay_time` int(11) DEFAULT NULL COMMENT '延迟时间，分钟',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `rule_id_index` (`rule_id`) USING BTREE,
  KEY `app_id_index` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用依赖规则';

DROP TABLE IF EXISTS `app_deputy_item_assignee`;
CREATE TABLE `app_deputy_item_assignee` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_item_id` bigint(20) DEFAULT NULL COMMENT '委托明细id',
  `assignee_user_id` bigint(20) DEFAULT NULL COMMENT '受托人id',
  `deputy_id` bigint(20) DEFAULT NULL COMMENT '委托单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托单受托人';

DROP TABLE IF EXISTS `app_deputy_item_assignee_link`;
CREATE TABLE `app_deputy_item_assignee_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deputy_item_app_id` bigint(20) DEFAULT NULL COMMENT '委托单明细id',
  `assignee_user_id` bigint(20) DEFAULT NULL COMMENT '受托人id',
  `account_no` varchar(100) DEFAULT '1' COMMENT '帐号',
  `account_user_link_id` bigint(20) DEFAULT NULL COMMENT '用户帐号关联表id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `deputy_user_id` bigint(20) DEFAULT NULL COMMENT '委托人id',
  `deputy_id` bigint(20) DEFAULT NULL COMMENT '委托单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='委托单委托的应用';

DROP TABLE IF EXISTS `app_group`;
CREATE TABLE `app_group` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `custom_unique` varchar(64) DEFAULT NULL COMMENT '数据唯一标识',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级组id',
  `name` varchar(255) DEFAULT NULL COMMENT '组名称',
  `code` varchar(50) DEFAULT NULL COMMENT '组编码',
  `status` smallint(2) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_g_app_id` (`app_id`) USING BTREE,
  KEY `idx_a_g_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用组';

DROP TABLE IF EXISTS `app_group_group_link`;
CREATE TABLE `app_group_group_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_group_id` bigint(20) DEFAULT NULL COMMENT '应用组id',
  `link_app_group_id` bigint(20) DEFAULT NULL COMMENT '应用组id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用组-应用组关联表';

DROP TABLE IF EXISTS `app_group_resource_link`;
CREATE TABLE `app_group_resource_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_group_id` bigint(20) DEFAULT NULL COMMENT '应用组id',
  `app_resource_id` bigint(20) DEFAULT NULL COMMENT '应用菜单id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_g_r_l` (`app_group_id`,`app_resource_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用组-菜单关联表';

DROP TABLE IF EXISTS `app_group_role_link`;
CREATE TABLE `app_group_role_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_group_id` bigint(20) DEFAULT NULL COMMENT '应用组id',
  `app_role_id` bigint(20) DEFAULT NULL COMMENT '应用角色id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_g_r_l` (`app_group_id`,`app_role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用组-角色关联表';

DROP TABLE IF EXISTS `app_job_link`;
CREATE TABLE `app_job_link` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `app_job_id` varchar(255) DEFAULT NULL COMMENT '对应下游岗位的id',
  `job_id` bigint(20) DEFAULT NULL COMMENT '岗位id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下游岗位对应信息';

DROP TABLE IF EXISTS `app_org_link`;
CREATE TABLE `app_org_link` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `app_org_id` varchar(255) DEFAULT NULL COMMENT '对应下游组织的id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织与下游组织信息关联表';

DROP TABLE IF EXISTS `app_permission_dynamics`;
CREATE TABLE `app_permission_dynamics` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '应用ID',
  `app_name` varchar(255) NOT NULL COMMENT '应用名称',
  `permission_id` bigint(20) NOT NULL COMMENT '权限ID',
  `permission_name` varchar(255) NOT NULL COMMENT '权限名称',
  `permission_type` varchar(32) NOT NULL COMMENT '权限分类 role角色 group组 resource资源',
  `resource_id` bigint(20) DEFAULT NULL COMMENT '资源ID',
  `resource_name` varchar(255) DEFAULT NULL COMMENT '资源名称',
  `resource_type` smallint(2) DEFAULT NULL COMMENT '资源类型',
  `resource_type_name` varchar(100) DEFAULT NULL COMMENT '资源名称',
  `action_code` varchar(100) NOT NULL COMMENT '操作分类',
  `operator_work_no` varchar(32) DEFAULT NULL COMMENT '操作人工号',
  `operator_id` bigint(20) DEFAULT NULL COMMENT '操作人ID',
  `operator_name` varchar(255) NOT NULL COMMENT '操作人名称',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `permission_id` (`permission_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用权限动态记录表';

DROP TABLE IF EXISTS `app_permission_model`;
CREATE TABLE `app_permission_model` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用配置id 可以为空 如果为空配置全局模型',
  `permission_module` varchar(255) DEFAULT NULL COMMENT '权限模型路径',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1 有效 0 无效',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限树表';

DROP TABLE IF EXISTS `app_permission_policy`;
CREATE TABLE `app_permission_policy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '策略名称',
  `policy_type` tinyint(2) DEFAULT NULL COMMENT '策略类型 1 授权策略 2 检查策略',
  `manual_operation` tinyint(2) DEFAULT NULL COMMENT '手动赋权：0-未勾选；1-提醒；2-阻止',
  `range_type` varchar(20) DEFAULT NULL COMMENT '执行范围 job org group user',
  `priority` int(11) DEFAULT '1' COMMENT '优先级',
  `type` tinyint(4) DEFAULT NULL COMMENT '规则类型：1互斥，2合规，3-超级权限',
  `execute_type` tinyint(4) DEFAULT NULL COMMENT '合规类型：1-锁定；2-标记；3-无操作；',
  `notify_status` tinyint(4) DEFAULT '1' COMMENT '状态：1-通知，0-不通知',
  `notify_funcode` varchar(255) DEFAULT NULL COMMENT '通知模板code',
  `last_exe_result` tinyint(4) DEFAULT NULL COMMENT '上一次执行结果：1-成功，0-失败，2-执行中',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1-启用，0-停用',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `auto_exe` tinyint(4) DEFAULT NULL COMMENT '是否自定执行 1-自动  0-非自动',
  `task_id` int(11) DEFAULT NULL COMMENT '任务ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限策略';

DROP TABLE IF EXISTS `app_permission_policy_exe`;
CREATE TABLE `app_permission_policy_exe` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '策略名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '规则类型：1互斥，2合规',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '权限策略id',
  `execute_type` tinyint(4) DEFAULT NULL COMMENT '执行操作：1-停用；3-无操作；',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `run_time` datetime DEFAULT NULL COMMENT '计划开始时间',
  `exe_status` tinyint(2) DEFAULT NULL COMMENT '执行状态：0-失败，1-成功，2-执行中',
  `exe_result` varchar(255) DEFAULT NULL COMMENT '执行结果',
  `notify_status` tinyint(4) DEFAULT '1' COMMENT '状态：1-通知，0-不通知',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限策略执行历史';

DROP TABLE IF EXISTS `app_permission_policy_exe_item`;
CREATE TABLE `app_permission_policy_exe_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `his_id` bigint(20) DEFAULT NULL COMMENT '权限策略执行历史id',
  `user_uid` varchar(255) DEFAULT NULL COMMENT '用户uid',
  `account_no` varchar(255) DEFAULT NULL COMMENT '帐号',
  `exe_status` tinyint(2) DEFAULT NULL COMMENT '执行状态：0-失败，1-成功',
  `execute_type` tinyint(4) DEFAULT NULL COMMENT '执行操作：1-停用；3-无操作；',
  `start_time` datetime DEFAULT NULL COMMENT '执行开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '执行结束时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `user_id` varchar(255) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限策略执行历史详情表';

DROP TABLE IF EXISTS `app_permission_policy_item`;
CREATE TABLE `app_permission_policy_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '权限策略id',
  `range_type` varchar(255) DEFAULT NULL COMMENT '范围类型：group-分组，job-岗位；org-组织；user-用户',
  `data_id` bigint(20) DEFAULT NULL COMMENT '分组、岗位、组织、用户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限策略范围';

DROP TABLE IF EXISTS `app_permission_policy_rule`;
CREATE TABLE `app_permission_policy_rule` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '权限策略id',
  `rule_id` bigint(20) DEFAULT NULL COMMENT '权限规则id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限策略选择的权限规则';

DROP TABLE IF EXISTS `app_permission_relation`;
CREATE TABLE `app_permission_relation` (
  `id` bigint(20) NOT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  `current_id` bigint(20) DEFAULT NULL COMMENT '当前节点id',
  `current_data_type` varchar(20) DEFAULT NULL COMMENT '当前节点类型',
  `children_id` bigint(20) DEFAULT NULL COMMENT '子节点id',
  `children_data_type` varchar(20) DEFAULT NULL COMMENT '当前节点类型',
  `auth_time` datetime DEFAULT NULL COMMENT '授权时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_app_id_rel` (`app_id`) USING BTREE COMMENT '应用id索引',
  KEY `index_app_rel_data_type` (`app_id`,`current_data_type`,`children_data_type`) USING BTREE COMMENT '应用id和节点类型',
  KEY `idx_a_p_r_children_id` (`children_id`,`children_data_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限节点关系';

DROP TABLE IF EXISTS `app_permission_rule`;
CREATE TABLE `app_permission_rule` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '规则名称',
  `type` tinyint(4) DEFAULT NULL COMMENT '规则类型：1互斥，2合规，3-超级权限',
  `compliance_type` tinyint(4) DEFAULT NULL COMMENT '合规类型：1-最小规则；2-最大规则；',
  `manual_empowerment` tinyint(4) DEFAULT NULL COMMENT '手动赋权：0-未勾选；1-提醒；2-阻止',
  `batch_account` tinyint(4) DEFAULT '0' COMMENT '批量开通帐号 1 勾选',
  `account_type` tinyint(4) DEFAULT NULL COMMENT '帐号供应下拉框：1-无操作；2-记录；3-提醒；4-阻止',
  `priority` smallint(4) DEFAULT '1' COMMENT '优先级，数字越大优先级越高',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1-启用，0-停用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限规则';

DROP TABLE IF EXISTS `app_permission_rule_item`;
CREATE TABLE `app_permission_rule_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `rule_id` bigint(20) DEFAULT NULL COMMENT '权限规则id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用',
  `data_type` varchar(64) DEFAULT NULL COMMENT '权限数据类型：role-应用角色；group-应用组；resource-资源',
  `rule_mode` tinyint(4) DEFAULT '1' COMMENT '模式 1-简单模式 2-专家模式',
  `data_id` bigint(20) DEFAULT NULL COMMENT '权限数据id',
  `qlexpress_text` text COMMENT '表达式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限规则内容';

DROP TABLE IF EXISTS `app_permission_sensitive_mgmt`;
CREATE TABLE `app_permission_sensitive_mgmt` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '应用id',
  `data_type` tinyint(2) NOT NULL COMMENT '资源权限类型：0角色 1帐号 2资源 3应用组',
  `data_id` bigint(20) NOT NULL COMMENT '对应权限资源id',
  `marker` varchar(64) DEFAULT NULL COMMENT '标记者',
  `mark_desc` varchar(255) DEFAULT NULL COMMENT '描述',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `data_id` (`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用敏感资源管理表';

DROP TABLE IF EXISTS `app_resource`;
CREATE TABLE `app_resource` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `custom_unique` varchar(64) DEFAULT NULL COMMENT '数据唯一标识',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级资源ID',
  `name` varchar(255) DEFAULT NULL COMMENT '资源名称',
  `code` varchar(50) DEFAULT NULL COMMENT '资源编码',
  `url` varchar(255) DEFAULT NULL COMMENT 'url请求',
  `path` varchar(1000) DEFAULT NULL COMMENT 'id路径',
  `status` smallint(2) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `permission_level` int(11) DEFAULT NULL COMMENT '权限等级',
  `order_num` int(11) DEFAULT '0' COMMENT '排序',
  `type` int(11) DEFAULT NULL COMMENT '资源类型',
  `data_columns` varchar(1024) DEFAULT NULL COMMENT '数据字段',
  `data_operation` varchar(255) DEFAULT NULL COMMENT '数据操作信息',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_r_app_id` (`app_id`) USING BTREE,
  KEY `idx_a_r_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用菜单';

DROP TABLE IF EXISTS `app_role`;
CREATE TABLE `app_role` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `custom_unique` varchar(64) DEFAULT NULL COMMENT '数据唯一标识',
  `name` varchar(255) DEFAULT NULL COMMENT '角色名称',
  `code` varchar(50) DEFAULT NULL COMMENT '角色编码',
  `status` smallint(2) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_r_app_id` (`app_id`) USING BTREE,
  KEY `idx_a_r_status` (`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用角色';

DROP TABLE IF EXISTS `app_role_resource_link`;
CREATE TABLE `app_role_resource_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_role_id` bigint(20) DEFAULT NULL COMMENT '应用角色id',
  `app_resource_id` bigint(20) DEFAULT NULL COMMENT '应用菜单id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_r_r_l` (`app_role_id`,`app_resource_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用角色-菜单关联表';

DROP TABLE IF EXISTS `app_sync_config`;
CREATE TABLE `app_sync_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '关联pi_app表的id字段',
  `customized_class_name` varchar(255) DEFAULT NULL COMMENT '二次开发接口类（包括帐号生成、下推数据以及回收代码）',
  `sync_mode` tinyint(2) DEFAULT NULL COMMENT '推送方式，1主推（push），2被推（pull）',
  `pull_callback` tinyint(2) DEFAULT '0' COMMENT '被推时，下游系统是否会回调结果 1 会 0 不会',
  `pull_secret_id` varchar(64) DEFAULT NULL COMMENT '被推接口认证ID（JWT）',
  `pull_secret_key` varchar(64) DEFAULT NULL COMMENT '被推接口认证密钥（JWT）',
  `push_sync_type` tinyint(2) DEFAULT NULL COMMENT '同步方式，1-api/2-ldap/3-ad/4-db',
  `push_class_name` varchar(255) DEFAULT NULL COMMENT '主推接口类',
  `push_encryption` tinyint(2) DEFAULT NULL COMMENT '数据加密算法 0-NONE/1-RSA/2-SM2',
  `push_encryption_private` varchar(2048) DEFAULT '' COMMENT '非对称加密算法私钥',
  `push_encryption_public` varchar(2048) DEFAULT '' COMMENT '非对称加密算法公钥',
  `push_extra_info` text COMMENT '主推接口额外参数，比如认证的密钥等',
  `push_api_url` varchar(512) DEFAULT NULL COMMENT '主推的API调用地址',
  `push_ldap_ip` varchar(255) DEFAULT NULL COMMENT 'LDAP/AD的IP',
  `push_ldap_port` int(11) DEFAULT NULL COMMENT 'LDAP/AD的端口',
  `push_ldap_ssl` tinyint(2) DEFAULT NULL COMMENT '是否启用ldapSsl：0-不启用，1-启用',
  `push_ldap_cert_path` varchar(1024) DEFAULT NULL COMMENT 'keyStore路径',
  `push_ldap_cert_password` varchar(1024) DEFAULT NULL COMMENT 'keyStore的密钥',
  `push_ldap_base_dn` varchar(255) DEFAULT NULL COMMENT 'LDAP/AD的baseDN',
  `push_ldap_user_name` varchar(255) DEFAULT NULL COMMENT 'LDAP/AD的用户名',
  `push_ldap_password` varchar(1024) DEFAULT NULL COMMENT 'LDAP/AD的密码（加密）',
  `push_ldap_ad_domain_name` varchar(255) DEFAULT NULL,
  `push_db_type` varchar(20) DEFAULT NULL COMMENT '数据库类型，1-Oracle/2-MySQL/3-SQLServer',
  `push_db_jdbc_url` varchar(255) DEFAULT NULL COMMENT '数据库JDBC URL',
  `push_db_user_name` varchar(255) DEFAULT NULL COMMENT '数据库的帐号',
  `push_db_password` varchar(1024) DEFAULT NULL COMMENT '数据库的密码（加密）',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `auth_type` tinyint(2) DEFAULT NULL COMMENT '认证方式 1 basic 2 jwt认证',
  `plugin_data_json` varchar(2000) DEFAULT NULL COMMENT '插件数据信息',
  `plugin_mgmt_id` bigint(20) DEFAULT NULL COMMENT '插件id',
  `is_comparison_filed` tinyint(2) DEFAULT '1' COMMENT '是否开启比对',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id_app_sync_config` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用同步配置表';

DROP TABLE IF EXISTS `app_type`;
CREATE TABLE `app_type` (
  `id` bigint(20) NOT NULL COMMENT '应用类型ID',
  `name` varchar(20) NOT NULL COMMENT '应用类型',
  `code` varchar(20) NOT NULL COMMENT '应用类型编码',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用类型';

DROP TABLE IF EXISTS `app_type_link`;
CREATE TABLE `app_type_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '应用id',
  `app_type_id` bigint(20) NOT NULL COMMENT '应用类型id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id` (`app_id`) USING BTREE,
  KEY `idx_app_type_id` (`app_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用-应用类型关系表';

DROP TABLE IF EXISTS `app_user_leader_link`;
CREATE TABLE `app_user_leader_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用名称',
  `user_id` bigint(20) DEFAULT NULL COMMENT '应用负责人user_id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `app_id` (`app_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用负责人';

DROP TABLE IF EXISTS `batch_operate_record`;
CREATE TABLE `batch_operate_record` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `operate_type` varchar(50) NOT NULL COMMENT '操作类型',
  `target_type` varchar(50) NOT NULL COMMENT '目标类型',
  `serial_number` int(11) DEFAULT NULL COMMENT '顺序号',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态：1:进行中，2：成功，3：失败',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '失败原因',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `file_Name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `file_size` varchar(50) DEFAULT NULL COMMENT '文件大小',
  `file_key` varchar(255) DEFAULT NULL COMMENT '文件标识',
  `total_count` int(11) DEFAULT NULL COMMENT '总数量',
  `success_count` int(11) DEFAULT NULL COMMENT '成功数量',
  `fail_count` int(11) DEFAULT NULL COMMENT '失败数量',
  `param_json` longtext COMMENT '参数json',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户批量操作记录表';

DROP TABLE IF EXISTS `batch_operate_record_link`;
CREATE TABLE `batch_operate_record_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `record_id` bigint(20) NOT NULL COMMENT '用户批量操作记录ID',
  `data_type` varchar(50) NOT NULL COMMENT '数据类型',
  `data_id` bigint(20) NOT NULL COMMENT '数据ID',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_record_id` (`record_id`) USING BTREE,
  KEY `idx_data_id` (`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户批量操作资源关联表';

DROP TABLE IF EXISTS `cer_certificate_user_link`;
CREATE TABLE `cer_certificate_user_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `cer_serial_number` varchar(256) DEFAULT NULL COMMENT '证书序列号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户证书关联表';

DROP TABLE IF EXISTS `check_job`;
CREATE TABLE `check_job` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键ID',
  `data_sync_history_id` bigint(20) DEFAULT NULL COMMENT '历史记录表的ID',
  `insert_time` datetime DEFAULT NULL COMMENT '数据插入时间',
  `exec_time` datetime DEFAULT NULL COMMENT '数据被处理时间',
  `exec_result` smallint(2) DEFAULT NULL COMMENT '执行结果：1成功，0失败',
  `exec_result_info` varchar(2000) DEFAULT NULL COMMENT '执行结果描述',
  `exec_action` smallint(2) DEFAULT NULL COMMENT '执行动作：1新增，2修改，3删除，4启用，5停用',
  `failed_confirm` smallint(2) DEFAULT NULL COMMENT '失败的记录确认标记位：1已确认，0未确认',
  `failed_confirm_user_id` bigint(20) DEFAULT NULL COMMENT '确认人ID',
  `failed_confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `source_from` varchar(300) DEFAULT NULL COMMENT '来源',
  `custom_unique` varchar(64) DEFAULT NULL COMMENT '岗位唯一标识',
  `org_custom_unique` varchar(64) DEFAULT NULL COMMENT '关联组织唯一标识',
  `name` varchar(50) DEFAULT NULL COMMENT '岗位名称',
  `code` varchar(255) DEFAULT NULL COMMENT '岗位编码',
  `job_status` tinyint(2) DEFAULT NULL COMMENT '岗位状态：0停用，1启用，-1删除',
  `job_update_time` datetime DEFAULT NULL COMMENT '上游job数据修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_data_sync_history_id` (`data_sync_history_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据同步岗位中间表';

DROP TABLE IF EXISTS `check_org`;
CREATE TABLE `check_org` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键ID',
  `data_sync_history_id` bigint(20) DEFAULT NULL COMMENT '历史记录表的ID',
  `insert_time` datetime DEFAULT NULL COMMENT '数据插入时间',
  `exec_time` datetime DEFAULT NULL COMMENT '数据被处理时间',
  `exec_result` tinyint(2) DEFAULT NULL COMMENT '执行结果：1成功，0失败',
  `exec_result_info` varchar(2000) DEFAULT NULL COMMENT '执行结果描述',
  `exec_action` tinyint(2) DEFAULT NULL COMMENT '执行动作：1新增，2修改，3删除，4启用，5停用',
  `failed_confirm` tinyint(2) DEFAULT NULL COMMENT '失败的记录确认标记位：1已确认，0未确认',
  `failed_confirm_user_id` bigint(20) DEFAULT NULL COMMENT '确认人ID',
  `failed_confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `source_from` varchar(300) DEFAULT NULL COMMENT '来源',
  `custom_unique` varchar(64) DEFAULT NULL COMMENT '组织唯一标识',
  `parent_custom_unique` varchar(64) DEFAULT NULL COMMENT '父组织唯一标识',
  `org_code` varchar(64) DEFAULT NULL COMMENT '组织编码',
  `org_name` varchar(64) DEFAULT NULL COMMENT '组织名称',
  `org_name_en` varchar(64) DEFAULT NULL COMMENT '组织英文名称',
  `org_parent_code` varchar(64) DEFAULT NULL COMMENT '上级组织编码',
  `org_status` tinyint(2) DEFAULT NULL COMMENT '组织状态：0停用，1启用，-1删除',
  `org_update_time` datetime DEFAULT NULL COMMENT '上游org数据修改时间',
  `org_level` smallint(2) DEFAULT '0' COMMENT '组织级别',
  `order_num` mediumint(3) DEFAULT '0' COMMENT '显示排序',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_data_sync_history_id` (`data_sync_history_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据同步组织中间表';

DROP TABLE IF EXISTS `check_user`;
CREATE TABLE `check_user` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键ID',
  `data_sync_history_id` bigint(20) DEFAULT NULL COMMENT '历史记录表的ID',
  `insert_time` datetime DEFAULT NULL COMMENT '数据插入时间',
  `exec_time` datetime DEFAULT NULL COMMENT '数据被处理时间',
  `exec_result` tinyint(2) DEFAULT NULL COMMENT '执行结果：1成功，0失败',
  `exec_result_info` varchar(2000) DEFAULT NULL COMMENT '执行结果描述',
  `exec_action` tinyint(2) DEFAULT NULL COMMENT '执行动作：1新增，2修改，3删除，4启用，5停用，6返聘',
  `failed_confirm` tinyint(2) DEFAULT NULL COMMENT '失败的记录确认标记位：1已确认，0未确认',
  `failed_confirm_user_id` bigint(20) DEFAULT NULL COMMENT '确认人ID',
  `failed_confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  `source_from` varchar(300) DEFAULT NULL COMMENT '来源',
  `custom_unique` varchar(64) DEFAULT NULL COMMENT '用户唯一标识',
  `user_uid` varchar(64) DEFAULT NULL COMMENT '用户名',
  `user_name` varchar(480) DEFAULT NULL COMMENT '姓名',
  `user_status` tinyint(2) DEFAULT NULL COMMENT '用户状态：0停用，1启用，-1删除',
  `org_custom_unique` varchar(64) DEFAULT NULL COMMENT '组织唯一标识',
  `job_custom_unique` varchar(64) DEFAULT NULL COMMENT '岗位唯一标识',
  `job_type` varchar(16) DEFAULT NULL COMMENT '岗位类型：1-主岗，0-兼岗',
  `email` varchar(1024) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(380) DEFAULT NULL COMMENT '手机号码',
  `native_place` varchar(691) DEFAULT NULL COMMENT '工作地方',
  `ding_id` varchar(255) DEFAULT NULL COMMENT '钉钉号',
  `work_no` varchar(380) DEFAULT NULL COMMENT '工号',
  `hire_date` date DEFAULT NULL COMMENT '入职日期',
  `user_email` varchar(1024) DEFAULT NULL COMMENT '个人邮箱',
  `ad_account` varchar(380) DEFAULT '' COMMENT 'ad域帐号',
  `ad_ou_path` varchar(380) DEFAULT NULL COMMENT 'ad OU全路径',
  `identity_type` varchar(691) DEFAULT NULL COMMENT '证件类型',
  `identity_code` varchar(691) DEFAULT NULL COMMENT '证件编码',
  `user_update_time` datetime DEFAULT NULL COMMENT '上游user数据修改时间',
  `order_num` mediumint(3) DEFAULT '0' COMMENT '显示顺序',
  `tech_title` varchar(691) DEFAULT NULL COMMENT '技术职称',
  `gender` smallint(2) DEFAULT NULL COMMENT '性别',
  `contact_phone` varchar(691) DEFAULT NULL COMMENT '联系电话',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_data_sync_history_id` (`data_sync_history_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据同步用户中间表';

DROP TABLE IF EXISTS `data_sync_field`;
CREATE TABLE `data_sync_field` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `mode_type` varchar(255) DEFAULT NULL COMMENT '模块名：account(帐号)、org(组织)、job(岗位)',
  `app_id` bigint(20) NOT NULL COMMENT '应用ID',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `column_name` varchar(255) DEFAULT NULL COMMENT '列名',
  `alias_name` varchar(255) DEFAULT NULL COMMENT '下推字段别名 默认为字段的驼峰标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据下推同步字段配置表';

DROP TABLE IF EXISTS `data_sync_mapping_dict`;
CREATE TABLE `data_sync_mapping_dict` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(128) DEFAULT NULL COMMENT '映射名称',
  `is_default` smallint(2) DEFAULT NULL COMMENT '是否有默认值 1有 0没有',
  `default_value` varchar(128) DEFAULT NULL COMMENT '默认值',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典映射主表';

DROP TABLE IF EXISTS `data_sync_mapping_dict_item`;
CREATE TABLE `data_sync_mapping_dict_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `from_value` varchar(128) DEFAULT NULL COMMENT '原数据',
  `to_value` varchar(128) DEFAULT NULL COMMENT '映射值',
  `data_sync_mapping_dict_id` bigint(20) DEFAULT NULL COMMENT 'data_sync_mapping_dict主键',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_dict_id_value` (`from_value`,`to_value`,`data_sync_mapping_dict_id`) USING BTREE,
  KEY `index_mapping_dict_id` (`data_sync_mapping_dict_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典映射明细表';

DROP TABLE IF EXISTS `global_supply_policy`;
CREATE TABLE `global_supply_policy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` tinyint(2) NOT NULL COMMENT '操作类型:0-删除用户时,1-停用用户时',
  `actual_operation` tinyint(2) DEFAULT NULL COMMENT '实际操作： 0 删除帐号 1 停用帐号 2 不做处理',
  `operation_type` tinyint(2) DEFAULT NULL COMMENT '执行方式： 0 立即执行 1 延迟执行',
  `delay_time` int(11) DEFAULT NULL COMMENT '延迟时间',
  `time_unit` tinyint(2) DEFAULT NULL COMMENT '延迟时间单位： 0 分钟 1 小时 2天',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='全局供应策略';

DROP TABLE IF EXISTS `idt_job`;
CREATE TABLE `idt_job` (
  `id` bigint(20) NOT NULL COMMENT '岗位ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '岗位名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态: 0停用，1启用，-1删除',
  `code` varchar(255) DEFAULT '' COMMENT '岗位编码',
  `job_level` varchar(20) DEFAULT NULL COMMENT '岗级',
  `duty_level` varchar(20) DEFAULT NULL COMMENT '职级',
  `duty` varchar(50) DEFAULT NULL COMMENT '职务',
  `order_num` int(11) DEFAULT '0' COMMENT '显示排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `source_from` varchar(300) DEFAULT NULL COMMENT '数据来源',
  `custom_unique` varchar(100) DEFAULT NULL COMMENT '岗位唯一标识',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_code` (`code`) USING BTREE COMMENT '岗位code唯一性',
  UNIQUE KEY `uq_custom_unique_idt_job` (`custom_unique`) USING BTREE COMMENT '唯一标识'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='岗位表';

DROP TABLE IF EXISTS `idt_org`;
CREATE TABLE `idt_org` (
  `id` bigint(20) NOT NULL COMMENT '组织ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '组织名称',
  `name_en` varchar(50) DEFAULT NULL COMMENT '组织英文名称',
  `parent_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '上级组织ID',
  `org_path` varchar(512) DEFAULT NULL COMMENT '组织ID路径',
  `name_path` varchar(512) DEFAULT NULL COMMENT '组织路径',
  `name_en_path` varchar(512) DEFAULT NULL COMMENT '组织英文路径',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 0停用，1正常，-1删除',
  `order_num` int(11) DEFAULT '0' COMMENT '显示排序',
  `org_code` varchar(100) DEFAULT '' COMMENT '组织编码',
  `sup_org_code` varchar(100) DEFAULT '' COMMENT '上级组织编码',
  `org_level` smallint(2) DEFAULT NULL COMMENT '组织级别',
  `grading_leader` varchar(20) DEFAULT NULL COMMENT '分管领导（存的用户的id）',
  `expired_time` datetime DEFAULT NULL COMMENT '组织的到期时间',
  `work_weixin_id` int(11) DEFAULT NULL COMMENT '企业微信组织ID',
  `dingding_department_id` int(11) DEFAULT NULL COMMENT '钉钉部门ID',
  `source_from` varchar(300) DEFAULT NULL COMMENT '数据来源',
  `custom_unique` varchar(100) DEFAULT NULL COMMENT '组织唯一标识',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_custom_unique_idt_org` (`custom_unique`) USING BTREE COMMENT '唯一标识',
  KEY `idx_parent_id` (`parent_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织表';

DROP TABLE IF EXISTS `idt_org_director_link`;
CREATE TABLE `idt_org_director_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `org_id` bigint(20) NOT NULL COMMENT '组织ID',
  `user_id` bigint(20) NOT NULL COMMENT '组织主管',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_org_user_id` (`org_id`,`user_id`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织主管表';

DROP TABLE IF EXISTS `idt_org_job_link`;
CREATE TABLE `idt_org_job_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `org_id` bigint(20) NOT NULL COMMENT '组织id',
  `job_id` bigint(20) NOT NULL COMMENT '岗位id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  KEY `job_id` (`job_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织-岗位关系表';

DROP TABLE IF EXISTS `idt_org_job_link_tmp`;
CREATE TABLE `idt_org_job_link_tmp` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `batch_id` bigint(20) DEFAULT NULL COMMENT '批次号',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `job_id` bigint(20) DEFAULT NULL COMMENT '岗位id',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1-绑定；0-解绑',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织-岗位关系临时表';

DROP TABLE IF EXISTS `idt_org_leader_link`;
CREATE TABLE `idt_org_leader_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `org_id` bigint(20) NOT NULL COMMENT '组织id',
  `user_id` bigint(20) NOT NULL COMMENT '负责人Id',
  `leader_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '主/副：1-主，0-副',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织-负责人关系表';

DROP TABLE IF EXISTS `idt_org_range`;
CREATE TABLE `idt_org_range` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `data_id` bigint(20) DEFAULT NULL COMMENT '外部id',
  `data_type` varchar(255) DEFAULT NULL COMMENT '外部模块类型',
  `sync_parent` tinyint(2) DEFAULT '0' COMMENT '是否同步父组织 1同步 0不同步',
  `select_all` tinyint(2) DEFAULT '0' COMMENT '全部选择 1全选 0不全选',
  `include_status` tinyint(2) DEFAULT '0' COMMENT '可选组织包含子组织 1包含 0不包含',
  `exclude_status` tinyint(2) DEFAULT '0' COMMENT '排除组织包含子组织 1包含 0不包含',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(31) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_data_id_type` (`data_id`,`data_type`) USING BTREE COMMENT '数据id和数据类型唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织范围';

DROP TABLE IF EXISTS `idt_org_range_item`;
CREATE TABLE `idt_org_range_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `org_range_id` bigint(20) DEFAULT NULL COMMENT '组织范围id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `include_type` tinyint(2) DEFAULT NULL COMMENT '组织选择类型 1包含 2排除',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_org_range_id` (`org_range_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织范围详情';

DROP TABLE IF EXISTS `idt_org_type`;
CREATE TABLE `idt_org_type` (
  `id` bigint(20) NOT NULL COMMENT '组织类型ID',
  `name` varchar(20) NOT NULL COMMENT '组织类型',
  `code` varchar(20) NOT NULL COMMENT '组织类型编码',
  `remark` varchar(50) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织类型表';

DROP TABLE IF EXISTS `idt_org_type_link`;
CREATE TABLE `idt_org_type_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `org_id` bigint(20) NOT NULL COMMENT '组织ID',
  `org_type_id` bigint(20) NOT NULL COMMENT '组织类型ID',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_org_type_id` (`org_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织与组织类型关联表';

DROP TABLE IF EXISTS `idt_user`;
CREATE TABLE `idt_user` (
  `id` bigint(20) NOT NULL COMMENT '用户ID',
  `user_uid` varchar(64) NOT NULL DEFAULT '' COMMENT '用户名',
  `pwd` varchar(400) DEFAULT NULL COMMENT '密码',
  `user_name` varchar(480) DEFAULT '' COMMENT '姓名',
  `gender` tinyint(2) DEFAULT NULL COMMENT '性别 0男1女',
  `email` varchar(1024) DEFAULT NULL COMMENT '邮箱',
  `user_email` varchar(1024) DEFAULT NULL COMMENT '个人邮箱',
  `mobile` varchar(380) DEFAULT '' COMMENT '手机号码',
  `ad_account` varchar(380) DEFAULT '' COMMENT 'ad域帐号',
  `ad_ou_path` varchar(380) DEFAULT NULL COMMENT 'ad OU全路径',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '用户状态 0 停用 1 正常 2 密码错误而锁定 3 管理员强制锁定',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `login_fail_count` smallint(4) DEFAULT '0' COMMENT '登录失败次数',
  `begin_time` datetime DEFAULT NULL COMMENT '用户启用时间',
  `end_time` datetime DEFAULT NULL COMMENT '用户关闭时间',
  `pwd_modify_time` datetime DEFAULT NULL COMMENT '密码修改时间',
  `must_change_password` tinyint(11) DEFAULT '0' COMMENT '是否强制修改密码,1->要修改',
  `pinyin` varchar(380) DEFAULT NULL COMMENT '姓名拼音',
  `work_no` varchar(380) DEFAULT '' COMMENT '工号',
  `hire_date` date DEFAULT NULL COMMENT '入职日期',
  `last_work_date` date DEFAULT NULL COMMENT '最后工作日',
  `leave_date` date DEFAULT NULL COMMENT '离职日期(弃用,统一维护end_time)',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登录时间',
  `last_lock_time` datetime DEFAULT NULL COMMENT '最近锁定时间',
  `lock_num` smallint(11) DEFAULT '0' COMMENT '锁定次数',
  `prefer_locale` varchar(50) DEFAULT NULL COMMENT '用户偏爱的语言环境',
  `custom_unique` varchar(100) DEFAULT NULL COMMENT '用户唯一标识',
  `source_from` varchar(300) DEFAULT NULL COMMENT '数据来源',
  `user_photo` varchar(255) DEFAULT NULL COMMENT '用户图片',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `voip` varchar(32) DEFAULT NULL COMMENT 'VOIP',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `native_place` varchar(691) DEFAULT NULL COMMENT '民族所在地',
  `census_register` varchar(691) DEFAULT NULL COMMENT '户籍',
  `census_type` varchar(380) DEFAULT NULL COMMENT '户口性质',
  `nation` varchar(380) DEFAULT NULL COMMENT '民族',
  `political_status` varchar(380) DEFAULT NULL COMMENT '政治面貌',
  `education` varchar(380) DEFAULT NULL COMMENT '学历',
  `census_place` varchar(691) DEFAULT NULL COMMENT '户籍所在地',
  `home_place` varchar(691) DEFAULT NULL COMMENT '家庭地址',
  `home_phone` varchar(380) DEFAULT NULL COMMENT '家庭电话',
  `marital_status` varchar(380) DEFAULT NULL COMMENT '婚姻状态',
  `identity_type` varchar(691) DEFAULT NULL COMMENT '证件类型',
  `identity_code` varchar(691) DEFAULT NULL COMMENT '证件编码',
  `university` varchar(691) DEFAULT NULL COMMENT '毕业院校',
  `graduation_time` date DEFAULT NULL COMMENT '毕业时间',
  `contact_phone` varchar(691) DEFAULT NULL COMMENT '联系电话',
  `office_phone` varchar(691) DEFAULT NULL COMMENT '办公电话',
  `fax` varchar(380) DEFAULT NULL COMMENT '传真',
  `post_code` varchar(691) DEFAULT NULL COMMENT '邮编',
  `work_age` int(2) DEFAULT NULL COMMENT '工龄',
  `formation` varchar(691) DEFAULT NULL COMMENT '编制',
  `tech_title` varchar(691) DEFAULT NULL COMMENT '技术职称',
  `recruit_res` varchar(16) DEFAULT NULL COMMENT '招聘来源',
  `recruit_way` varchar(16) DEFAULT NULL COMMENT '招聘渠道',
  `policy_user_password_id` bigint(20) DEFAULT NULL COMMENT '密码策略ID',
  `pwd_expire_alert_count` varchar(64) DEFAULT NULL COMMENT '密码过期今日提醒次数',
  `pwd_salt` varchar(128) DEFAULT NULL COMMENT '盐',
  `default_forward_url` varchar(255) DEFAULT NULL COMMENT '默认跳转地址',
  `ding_id` varchar(255) DEFAULT NULL COMMENT '钉钉号',
  `sort_num` int(11) DEFAULT NULL COMMENT '编号',
  `pwd_expire_notify_time` datetime DEFAULT NULL COMMENT '密码过期邮件通知时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_uid` (`user_uid`) USING BTREE,
  UNIQUE KEY `uq_custom_unique_idt_user` (`custom_unique`) USING BTREE COMMENT '唯一标识',
  KEY `index_user_name` (`user_name`) USING BTREE,
  KEY `index_email` (`email`) USING BTREE,
  KEY `index_mobile` (`mobile`) USING BTREE,
  KEY `index_ad_account` (`ad_account`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户表';

DROP TABLE IF EXISTS `idt_user_account_supply`;
CREATE TABLE `idt_user_account_supply` (
  `id` bigint(20) NOT NULL COMMENT '用户id主键',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：0-待处理 1-成功 2-失败',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `error_message` varchar(2000) DEFAULT NULL COMMENT '错误日志',
  `batch_num` bigint(20) DEFAULT NULL COMMENT '批次号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_account_supply_status` (`status`) USING BTREE COMMENT '状态索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户帐号供应任务';

DROP TABLE IF EXISTS `idt_user_job_link`;
CREATE TABLE `idt_user_job_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `job_id` bigint(20) NOT NULL COMMENT '岗位id',
  `job_type` tinyint(2) NOT NULL DEFAULT '0' COMMENT '主岗/兼岗：1-主岗，0-兼岗',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_user_org_job_id` (`user_id`,`org_id`,`job_id`) USING BTREE COMMENT '用户 组织 岗位 id唯一',
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户-岗位关系表';

DROP TABLE IF EXISTS `idt_user_org_link`;
CREATE TABLE `idt_user_org_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `org_id` bigint(20) NOT NULL COMMENT '组织id',
  `sort_num` int(11) DEFAULT NULL COMMENT '组织编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_org_user_id` (`user_id`,`org_id`) USING BTREE COMMENT '用户组织唯一',
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户-组织关系表';

DROP TABLE IF EXISTS `idt_user_photo`;
CREATE TABLE `idt_user_photo` (
  `id` bigint(20) NOT NULL COMMENT 'userId主键',
  `photo` mediumtext COMMENT '用户照片',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户照片表';

DROP TABLE IF EXISTS `idt_user_type`;
CREATE TABLE `idt_user_type` (
  `id` bigint(20) NOT NULL COMMENT '用户类型ID',
  `name` varchar(50) NOT NULL DEFAULT '' COMMENT '用户类型名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 0停用，1正常',
  `code` varchar(20) DEFAULT '' COMMENT '用户类型编码',
  `source_from` varchar(20) DEFAULT NULL COMMENT '数据来源',
  `custom_unique` varchar(100) DEFAULT NULL COMMENT '数据来源标识（HR系统的标记）',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `valid_days` int(10) DEFAULT NULL COMMENT '用户有效期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户类型';

DROP TABLE IF EXISTS `idt_user_type_link`;
CREATE TABLE `idt_user_type_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `user_type_id` bigint(20) NOT NULL COMMENT '用户类型id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE,
  KEY `idx_user_type_id` (`user_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户-用户类型关系表';

DROP TABLE IF EXISTS `orphan_account_user_link`;
CREATE TABLE `orphan_account_user_link` (
  `ID` bigint(20) NOT NULL COMMENT '主键',
  `ACCOUNT_ID` bigint(20) NOT NULL COMMENT '应用帐号id',
  `USER_ID` bigint(20) NOT NULL COMMENT '用户id',
  `CREATE_TIME` datetime DEFAULT NULL COMMENT '创建时间',
  `CREATOR` varchar(64) DEFAULT NULL COMMENT '创建者',
  `UPDATE_TIME` datetime DEFAULT NULL COMMENT '更新时间',
  `UPDATER` varchar(64) DEFAULT NULL COMMENT '更新者',
  `EID` varchar(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `USER_ID` (`USER_ID`) USING BTREE,
  KEY `ACCOUNT_ID` (`ACCOUNT_ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='孤儿帐号-用户关系表';

DROP TABLE IF EXISTS `pi_app`;
CREATE TABLE `pi_app` (
  `id` bigint(20) NOT NULL COMMENT '应用ID',
  `name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `app_code` varchar(32) DEFAULT '' COMMENT '应用编码',
  `protocal` varchar(32) DEFAULT NULL COMMENT '单点协议(saml,regex,oidc,oauth,esso,ltpa,noAuthentication,DefSSO)	',
  `serviceId` varchar(1024) DEFAULT NULL COMMENT '应用的serviceID（OAuth等协议的callback地址）',
  `defType` varchar(32) DEFAULT NULL COMMENT '自定义单点协议的协议类型，参考表pi_app_defsso_template.res_type',
  `defSSOJson` varchar(1024) DEFAULT NULL COMMENT '自定义单点协议的JSON配置文件',
  `resType` varchar(8) DEFAULT NULL COMMENT '应用架构',
  `resUrl` varchar(1024) DEFAULT NULL COMMENT '应用地址',
  `status` varchar(1) NOT NULL DEFAULT '1' COMMENT '状态，1启用，2停用',
  `accIntegrate` varchar(1) DEFAULT NULL COMMENT '是否集成应用同步 ，1启用，0停用',
  `clientId` varchar(255) DEFAULT NULL COMMENT 'clientID',
  `clientSecret` varchar(255) DEFAULT NULL COMMENT 'clientSecret',
  `nsso` varchar(1) DEFAULT NULL COMMENT '是否启用网关代填，1启用，0停用',
  `browser` varchar(32) DEFAULT NULL COMMENT 'esso的默认浏览器',
  `default_auth_type` varchar(32) DEFAULT NULL COMMENT '默认认证方式',
  `auth_level` int(11) DEFAULT NULL COMMENT '认证等级',
  `returnUserId` text COMMENT '协议的profile接口的帐号信息返回字段，多字段逗号分隔',
  `generateRefreshToken` smallint(2) DEFAULT NULL COMMENT 'oAuth，OIDC，CAS协议里是否启用RefreshToken 1启用，0停用',
  `jsonFormat` smallint(2) DEFAULT NULL COMMENT 'oAuth，OIDC，CAS协议里是否启用json格式的Token，1启用，0停用',
  `signIdToken` smallint(2) DEFAULT NULL COMMENT 'OIDC里签名Token标记位 1签名，0不签名',
  `encryptIdToken` smallint(2) DEFAULT NULL COMMENT 'OIDC里加密Token标记位 1加密，0不加密',
  `metadataLocation` varchar(255) DEFAULT NULL COMMENT 'saml协议metadata文件的URL地址',
  `resIcon` longtext COMMENT '应用的icon，base64加密',
  `recyclingState` varchar(8) DEFAULT '0' COMMENT '回收状态，0未回收，1回收完成，2回收失败 3 回收中',
  `sso_ltpa_app_id` bigint(20) DEFAULT NULL COMMENT 'pi_sso_ltpa_app中的主键',
  `ssodata` text COMMENT '用于SSO做应用配置发现的集合字段',
  `is_sys` smallint(2) DEFAULT '0' COMMENT '是否是内置应用（内置应用前台不显示）',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `sso` varchar(255) DEFAULT NULL COMMENT '1',
  `org` varchar(36) DEFAULT NULL COMMENT '1',
  `resPort` varchar(255) DEFAULT NULL COMMENT '1',
  `resAuthTypes` varchar(255) DEFAULT NULL COMMENT '1',
  `REALM_ID` varchar(36) DEFAULT NULL COMMENT '1',
  `ACCOUNTPOLICY_ID` varchar(255) DEFAULT NULL COMMENT '1',
  `CONNECTOR_ID` varchar(255) DEFAULT NULL COMMENT '1',
  `createTraceLevel` varchar(255) DEFAULT NULL COMMENT '1',
  `deleteTraceLevel` varchar(255) DEFAULT NULL COMMENT '1',
  `enforceMandatoryCondition` bigint(20) DEFAULT NULL COMMENT '1',
  `jsonConf` longtext COMMENT '1',
  `overrideCapabilities` bigint(20) DEFAULT NULL COMMENT '1',
  `PASSWORDPOLICY_ID` varchar(255) DEFAULT NULL COMMENT '1',
  `propagationPriority` bigint(20) DEFAULT NULL COMMENT '1',
  `provisioningTraceLevel` varchar(255) DEFAULT NULL COMMENT '1',
  `PULLPOLICY_ID` varchar(255) DEFAULT NULL COMMENT '1',
  `randomPwdIfNotProvided` bigint(20) DEFAULT NULL COMMENT '1',
  `resAuthType` varchar(255) DEFAULT NULL COMMENT '1',
  `suspended` bigint(20) DEFAULT NULL COMMENT '1',
  `updateTraceLevel` varchar(255) DEFAULT NULL COMMENT '1',
  `userSynFlag` bigint(20) DEFAULT NULL COMMENT '1',
  `wfStatus` varchar(255) DEFAULT NULL COMMENT '1',
  `workflowId` varchar(255) DEFAULT NULL COMMENT '1',
  `businessId` varchar(255) DEFAULT NULL COMMENT '1',
  `singleAccountLogin` int(11) DEFAULT NULL COMMENT '1',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `creationDate` datetime DEFAULT NULL COMMENT '1',
  `lastChangeDate` datetime DEFAULT NULL COMMENT '1',
  `lastModifier` varchar(255) DEFAULT NULL COMMENT '1',
  `requireAccount` tinyint(4) DEFAULT '1' COMMENT '单点是否需要从帐号',
  `pwd_algorithm` varchar(20) DEFAULT NULL COMMENT '应用密码加密方式',
  `pwd_salt` varchar(132) DEFAULT NULL,
  `network_type` varchar(50) DEFAULT NULL COMMENT '网络分类 内网（inner_net）、外网(out_net)、内外网(inner_out_net)',
  `custom_tag` varchar(1024) DEFAULT NULL COMMENT '应用标记',
  `sso_integrate` tinyint(2) DEFAULT '1' COMMENT '是否集成sso(集成selfcare列表显示 1:不集成 0:不显示)',
  `access_token_max_time_to_live` varchar(20) DEFAULT NULL COMMENT 'accessToken最长有效期(秒)',
  `access_token_time_to_kill` varchar(20) DEFAULT NULL COMMENT 'accessToken有效期(秒)',
  `refresh_time_to_kill` varchar(20) DEFAULT NULL COMMENT 'refreshToken有效期(秒)',
  `protocol_plugin_id` bigint(20) DEFAULT NULL COMMENT '协议插件id',
  `notify_apply` tinyint(2) DEFAULT NULL COMMENT '应用申请-通知申请人：1-通知，0-不通知',
  `notify_approve` tinyint(2) DEFAULT NULL COMMENT '应用申请-通知审批人：1-通知，0-不通知',
  `bpm_id` varchar(100) DEFAULT NULL COMMENT '流程id(指定版本号)',
  `bpm_name` varchar(200) DEFAULT NULL COMMENT '流程名称',
  `bpm_key` varchar(100) DEFAULT NULL COMMENT '流程标识',
  `permission_scope` varchar(100) NOT NULL COMMENT '用户可赋权范围',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_app_code` (`app_code`) USING BTREE COMMENT '应用code唯一性',
  KEY `idx_p_a_status` (`status`) USING BTREE,
  KEY `idx_p_a_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用表';

DROP TABLE IF EXISTS `pi_sso_internet_user`;
CREATE TABLE `pi_sso_internet_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `authType` varchar(255) DEFAULT NULL COMMENT '认证方式：wechat, workwechat, dingding, weibo',
  `openid` varchar(255) DEFAULT NULL COMMENT 'OpenID',
  `user_id` varchar(255) DEFAULT NULL COMMENT 'idt_user表的id字段',
  `relopenid` varchar(255) DEFAULT NULL COMMENT '冗余字段',
  `eid` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='互联网用户关联表';

DROP TABLE IF EXISTS `policy_apply`;
CREATE TABLE `policy_apply` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '策略名称',
  `policy_type` varchar(20) DEFAULT NULL COMMENT '策略类型：account-帐号，permission-权限',
  `bpm_id` varchar(100) DEFAULT NULL COMMENT '流程id(指定版本号)',
  `bpm_name` varchar(100) DEFAULT NULL COMMENT '流程名称',
  `bpm_key` varchar(100) DEFAULT NULL COMMENT '流程key',
  `notify_code` varchar(100) DEFAULT NULL COMMENT '通知策略编码',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-启用，0-停用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帐号申请流程策略表';

DROP TABLE IF EXISTS `policy_apply_app`;
CREATE TABLE `policy_apply_app` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `apply_id` bigint(20) DEFAULT NULL COMMENT '帐号申请流程策略表id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帐号申请流程策略关联应用表';

DROP TABLE IF EXISTS `policy_apply_app_permission`;
CREATE TABLE `policy_apply_app_permission` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `data_type` varchar(20) DEFAULT NULL COMMENT '权限类型：role-角色，group-组，res-资源',
  `data_id` bigint(20) DEFAULT NULL COMMENT '权限id',
  `apply_id` bigint(20) DEFAULT NULL COMMENT '帐号申请流程策略表id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `apply_app_id` bigint(20) DEFAULT NULL COMMENT '帐号申请流程策略关联应用表id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帐号申请流程策略关联应用权限表';

DROP TABLE IF EXISTS `policy_apply_group`;
CREATE TABLE `policy_apply_group` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `apply_id` bigint(20) DEFAULT NULL COMMENT '帐号申请流程策略表id',
  `group_id` bigint(20) DEFAULT NULL COMMENT '用户组id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帐号申请流程策略关联用户组表';

DROP TABLE IF EXISTS `policy_data_sync`;
CREATE TABLE `policy_data_sync` (
  `id` bigint(32) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '身份源名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态，0-无效，1-有效',
  `last_run_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `exe_status` tinyint(2) DEFAULT NULL COMMENT '执行状态：0-失败，1-成功，2-执行中',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `check_change` tinyint(2) DEFAULT '1' COMMENT '是否校验数据变化',
  `task_id` int(11) DEFAULT NULL COMMENT '任务ID',
  `enable_notice` int(11) DEFAULT NULL COMMENT '是否开启同步任务失败通知，1-开启，0-不开启',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='身份源管理';

DROP TABLE IF EXISTS `policy_data_sync_config`;
CREATE TABLE `policy_data_sync_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `data_sync_id` bigint(20) DEFAULT NULL COMMENT '数据同步策略id',
  `sync_way` tinyint(2) DEFAULT NULL COMMENT '同步方式：1-IDM从上游抽取;2-上游推送到IDM',
  `sync_type` tinyint(2) DEFAULT NULL COMMENT '同步方式：1-api/2-ldap/3-ad/4-db',
  `db_type` tinyint(2) DEFAULT NULL COMMENT '数据库类型：1-Oracle/2-MySQL/3-SQLServer/4-PostgreSQL',
  `base_dn` varchar(255) DEFAULT NULL COMMENT 'LDAP的basedn',
  `ad_domain_name` varchar(200) DEFAULT NULL COMMENT 'AD的域名',
  `ip` varchar(64) DEFAULT NULL COMMENT 'ip地址',
  `port` varchar(8) DEFAULT NULL COMMENT '端口',
  `user_name` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(2048) DEFAULT NULL COMMENT '密码',
  `url` varchar(255) DEFAULT NULL COMMENT 'jdbcurl，api/webservice的url',
  `extra_info` text COMMENT '接口的附加参数',
  `interface_class_name` varchar(255) DEFAULT NULL COMMENT '同步调用的接口类Bean名称',
  `sync_class_type` tinyint(2) DEFAULT NULL COMMENT '处理类类型：1-自定义处理类，2-内置处理类',
  `enable_ldap_ssl` tinyint(2) DEFAULT NULL COMMENT '是否启用ldapSsl：0-不启用，1-启用',
  `key_store_path` varchar(1024) DEFAULT NULL COMMENT 'keyStore路径',
  `key_store_secret` varchar(2048) DEFAULT NULL COMMENT 'keyStore的密钥',
  `filter` varchar(2048) DEFAULT NULL COMMENT '过滤条件',
  `plugin_config` text COMMENT '插件配置信息',
  `plugin_id` bigint(20) DEFAULT NULL COMMENT '插件id',
  `rel_app_code` varchar(255) DEFAULT NULL COMMENT '上游数据源对应下游应用编码',
  `rel_app_id` bigint(20) DEFAULT NULL COMMENT '上游数据源对应下游应用ID',
  `last_pull_time` datetime DEFAULT NULL COMMENT '最后一次拉取数据的时间，用于同步增量数据',
  `exec_supply` tinyint(2) DEFAULT '1' COMMENT '同步后是否执行供应策略下推: 1-是；0-否',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据同步策略配置表';

DROP TABLE IF EXISTS `policy_data_sync_field_mapping`;
CREATE TABLE `policy_data_sync_field_mapping` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `data_sync_id` bigint(20) DEFAULT NULL COMMENT '数据同步策略id',
  `data_type` tinyint(2) DEFAULT NULL COMMENT '类型：1-组织，2-岗位，3-用户',
  `config_type` tinyint(2) DEFAULT NULL COMMENT '配置类型：1-中间表同步配置，2-主表同步配置',
  `action_type` tinyint(2) DEFAULT NULL COMMENT '同步动作，0-新增，1-修改(同REQUEST_FLAG)',
  `target_field` varchar(255) DEFAULT NULL COMMENT '目标字段',
  `source_field` varchar(255) DEFAULT NULL COMMENT '源字段',
  `qlexpress_text` varchar(2000) DEFAULT NULL COMMENT 'qle表达式',
  `mapping_dict_id` bigint(20) DEFAULT NULL COMMENT '映射字典id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='同步字段映射表';

DROP TABLE IF EXISTS `policy_data_sync_history`;
CREATE TABLE `policy_data_sync_history` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `data_sync_id` bigint(20) DEFAULT NULL COMMENT '数据同步策略id',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `run_time` datetime DEFAULT NULL COMMENT '计划开始时间',
  `exe_status` tinyint(2) DEFAULT NULL COMMENT '执行状态：0-失败，1-成功，2-执行中',
  `exe_result` varchar(2048) DEFAULT NULL COMMENT '执行结果',
  `sync_result` tinyint(2) DEFAULT NULL COMMENT '同步结果，0-失败，1-成功',
  `sync_total` varchar(255) DEFAULT NULL COMMENT '总数',
  `sync_success_num` varchar(255) DEFAULT NULL COMMENT '成功数',
  `sync_fail_num` varchar(255) DEFAULT NULL COMMENT '失败数',
  `sync_unconfirm_num` varchar(255) DEFAULT NULL COMMENT '未确认数',
  `exception_level` varchar(255) DEFAULT NULL COMMENT '异常等级',
  `exception_type` varchar(255) DEFAULT NULL COMMENT '异常类型',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_data_sync_id` (`data_sync_id`) USING BTREE,
  KEY `idx_exe_status` (`exe_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据同步策略执行历史表';

DROP TABLE IF EXISTS `policy_desensitize`;
CREATE TABLE `policy_desensitize` (
  `id` bigint(20) NOT NULL,
  `field_type` varchar(20) NOT NULL COMMENT '脱敏字段类型',
  `field_code` varchar(20) DEFAULT NULL COMMENT '脱敏字段编码',
  `field_name` varchar(32) DEFAULT NULL COMMENT '脱敏字段',
  `desensitize_flag` int(1) DEFAULT NULL COMMENT '是否前端脱敏',
  `encrypt_flag` int(1) DEFAULT NULL COMMENT '是否存储加密',
  `style` varchar(16) DEFAULT NULL COMMENT '前端脱敏方式',
  `stuff` varchar(20) DEFAULT NULL COMMENT '脱敏固定值',
  `start` varchar(4) DEFAULT NULL COMMENT '脱敏范围-起点方式',
  `start_step` int(2) DEFAULT NULL COMMENT '脱敏范围-起点大小',
  `start_char_style` varchar(16) DEFAULT NULL COMMENT '脱敏范围-起点字符类型',
  `start_char` char(1) DEFAULT NULL COMMENT '脱敏范围-起点字符',
  `end_style` varchar(4) DEFAULT NULL,
  `end_step` int(2) DEFAULT NULL COMMENT '脱敏范围-终点大小',
  `end_char_style` varchar(16) DEFAULT NULL COMMENT '脱敏范围-终点字符类型',
  `end_char` char(1) DEFAULT NULL COMMENT '脱敏范围-终点字符',
  `analysis` varchar(255) DEFAULT NULL COMMENT '策略解析',
  `example` varchar(255) DEFAULT NULL COMMENT '策略解析示例值',
  `algorithm_type` varchar(16) DEFAULT NULL COMMENT '加密算法类型',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '修改者',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `file_id` varchar(256) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL COMMENT '文件名称',
  `view_flag` tinyint(2) DEFAULT '0' COMMENT '是否允许用户查看明文，0：不允许，1：允许',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_code_type` (`field_code`,`field_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `policy_desensitize_random`;
CREATE TABLE `policy_desensitize_random` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `desensitize_id` bigint(20) DEFAULT NULL COMMENT '脱敏配置id',
  `code` varchar(16) NOT NULL COMMENT '脱敏配置字段编码',
  `original_char` char(1) NOT NULL COMMENT '原始值',
  `replace_char` char(1) NOT NULL COMMENT '替换值',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `policy_desensitize_role_link`;
CREATE TABLE `policy_desensitize_role_link` (
  `id` bigint(20) NOT NULL COMMENT '表主键',
  `role_id` bigint(20) NOT NULL COMMENT '角色id',
  `desensitize_id` bigint(20) NOT NULL COMMENT '脱敏策略id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_type_code` (`role_id`,`desensitize_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `policy_group`;
CREATE TABLE `policy_group` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '分组名称',
  `type` tinyint(2) DEFAULT '1' COMMENT '类型：1-用户，2-组织，3-岗位',
  `policy_mode` tinyint(2) DEFAULT '0' COMMENT '模式：1-动态分组，0-静态分组',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-启用，0-停用',
  `sql_code` text COMMENT '动态分组sql',
  `java_code` text COMMENT '动态分组java代码',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `data_type` varchar(20) DEFAULT 'group' COMMENT '类型：group-用户分组，property-属性',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户、组织、岗位分组表';

DROP TABLE IF EXISTS `policy_group_item`;
CREATE TABLE `policy_group_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) DEFAULT NULL COMMENT '用户分组id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `job_id` bigint(20) DEFAULT NULL COMMENT '岗位id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  KEY `job_id` (`job_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='静态分组包含的用户、组织、岗位清单表';

DROP TABLE IF EXISTS `policy_group_link`;
CREATE TABLE `policy_group_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) DEFAULT NULL COMMENT '用户分组id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `job_id` bigint(20) DEFAULT NULL COMMENT '岗位id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '策略id',
  `type` varchar(50) DEFAULT NULL COMMENT '数据类型，entity实体名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `group_id` (`group_id`) USING BTREE,
  KEY `org_id` (`org_id`) USING BTREE,
  KEY `job_id` (`job_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略与分组的关联表';

DROP TABLE IF EXISTS `policy_initial_password`;
CREATE TABLE `policy_initial_password` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) DEFAULT NULL COMMENT '用户分组id',
  `name` varchar(100) DEFAULT NULL COMMENT '策略名称',
  `default_policy_flag` tinyint(2) DEFAULT '0' COMMENT '默认策略标记1：是，0：否',
  `priority` smallint(4) DEFAULT '1' COMMENT '优先级，数字越大优先级越高，默认策略优先级为0',
  `type` tinyint(2) DEFAULT '1' COMMENT '类型：1-固定密码，2-身份证后六位，3-自定义的参数，4-随机密码',
  `express_info` text COMMENT '存放前端需要的数据，可以直接存值可以存json结构',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-有效，0-无效',
  `java_code` text COMMENT 'java代码生成密码',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `type_by_id` tinyint(2) DEFAULT NULL COMMENT '身份证编码为空的时候策略状态：0-随机，1-固定',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='初始密码表';

DROP TABLE IF EXISTS `policy_model`;
CREATE TABLE `policy_model` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '模型名称',
  `range_type` varchar(100) DEFAULT NULL COMMENT '人员适用范围：group、org、job、property、all',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `include_sub` tinyint(2) DEFAULT '1' COMMENT '是否包含子组织：1-包含；0-不包含',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` bigint(2) DEFAULT NULL COMMENT '状态：1-启用，0-停用',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `notify_apply` tinyint(1) DEFAULT NULL COMMENT '流程权限-通知申请人：1-通知，0-不通知',
  `notify_approve` tinyint(1) DEFAULT NULL COMMENT '流程权限-通知审批人：1-通知，0-不通知',
  `supply_permission` tinyint(1) DEFAULT NULL COMMENT '是否配置供应权限：1-是，0-否',
  `process_permission` tinyint(1) DEFAULT NULL COMMENT '是否配置流程权限：1-是，0-否',
  `process_permission_begin_time` datetime DEFAULT NULL COMMENT '流程权限有效期：生效时间',
  `process_permission_end_time` datetime DEFAULT NULL COMMENT '流程权限有效期：失效时间',
  `bpm_key` varchar(100) DEFAULT NULL COMMENT '流程key',
  `bpm_name` varchar(200) DEFAULT NULL COMMENT '流程名称',
  `bpm_id` varchar(100) DEFAULT NULL COMMENT '流程id(指定版本号)',
  `policy_model_type_id` bigint(20) DEFAULT NULL COMMENT '权限模型类型id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `policy_model_type_id_idx` (`policy_model_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略模型表';

DROP TABLE IF EXISTS `policy_model_app_link`;
CREATE TABLE `policy_model_app_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `model_id` bigint(20) DEFAULT NULL COMMENT '模型id',
  `model_type` varchar(32) DEFAULT NULL COMMENT '模块类型（同一个model下，供应权限和流程权限模块类型不同）',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略模型应用关联表';

DROP TABLE IF EXISTS `policy_model_leader_link`;
CREATE TABLE `policy_model_leader_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_model_id` bigint(20) DEFAULT NULL COMMENT '权限模型id',
  `leader_id` bigint(20) DEFAULT NULL COMMENT '负责人id',
  `leader_type` varchar(20) DEFAULT NULL COMMENT '负责人类型：business-业务负责人；it-IT负责人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限模型负责人关联表';

DROP TABLE IF EXISTS `policy_model_permission_link`;
CREATE TABLE `policy_model_permission_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `model_id` bigint(20) DEFAULT NULL COMMENT '模型id',
  `model_type` varchar(32) DEFAULT NULL COMMENT '模块类型（同一个model下，供应权限和流程权限模块类型不同）',
  `model_app_link_id` bigint(20) DEFAULT NULL COMMENT '策略模型应用关联id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `data_type` varchar(64) DEFAULT NULL COMMENT '数据类型',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id',
  `include_sub` tinyint(2) DEFAULT '1' COMMENT '是否包含子数据：1-包含；0-不包含',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略模型权限关联表';

DROP TABLE IF EXISTS `policy_model_permission_tmp`;
CREATE TABLE `policy_model_permission_tmp` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `model_id` bigint(20) DEFAULT NULL COMMENT '模型id',
  `model_type` varchar(32) DEFAULT NULL COMMENT '模块类型（同一个model下，供应权限和流程权限模块类型不同）',
  `link_id` bigint(20) DEFAULT NULL COMMENT '策略模型应用关联id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `data_type` varchar(64) DEFAULT NULL COMMENT '数据类型: role-角色；group-应用组',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id',
  `batch_id` bigint(20) DEFAULT NULL COMMENT '批次号',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1-绑定；0-解绑',
  `include_sub` tinyint(2) DEFAULT '1' COMMENT '是否包含子数据：1-包含；0-不包含',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_batch_id_type` (`batch_id`,`model_type`,`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略模型权限临时表';

DROP TABLE IF EXISTS `policy_model_range_link`;
CREATE TABLE `policy_model_range_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `model_id` bigint(20) DEFAULT NULL COMMENT '模型id',
  `model_type` varchar(32) DEFAULT NULL COMMENT '模块类型',
  `data_type` varchar(32) DEFAULT NULL COMMENT '模型类型',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略模型范围关联表';

DROP TABLE IF EXISTS `policy_model_range_link_tmp`;
CREATE TABLE `policy_model_range_link_tmp` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `batch_id` bigint(20) DEFAULT NULL COMMENT '批次号',
  `model_id` bigint(20) DEFAULT NULL COMMENT '模型id',
  `model_type` varchar(32) DEFAULT NULL COMMENT '模块类型',
  `data_type` varchar(64) DEFAULT NULL COMMENT '数据类型：group、org、job、property',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1-绑定；0-解绑',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略模型范围临时表';

DROP TABLE IF EXISTS `policy_model_type`;
CREATE TABLE `policy_model_type` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) NOT NULL COMMENT '分类名称',
  `range_type` varchar(50) NOT NULL COMMENT '适用人员选择：group,job,org,property,all',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `policy_model_type_name_uindex` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限模型类型表';

DROP TABLE IF EXISTS `policy_security_matter`;
CREATE TABLE `policy_security_matter` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) NOT NULL COMMENT '名称',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态，0-停用，1-启用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `reserved1` varchar(255) DEFAULT NULL COMMENT '预留字段',
  `reserved2` varchar(255) DEFAULT NULL COMMENT '预留字段',
  `reserved3` varchar(255) DEFAULT NULL COMMENT '预留字段',
  `template_id` bigint(20) DEFAULT NULL COMMENT '模板id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  UNIQUE KEY `uq_name` (`name`) USING BTREE COMMENT '确保安保问题唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='密保问题';

DROP TABLE IF EXISTS `policy_supply`;
CREATE TABLE `policy_supply` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '策略名称',
  `type` varchar(20) DEFAULT NULL COMMENT '策略分类：account-帐号，org-组织，job-岗位',
  `range_type` varchar(20) DEFAULT NULL COMMENT '数据范围类型：group-分组，sql-SQL语句',
  `range_value` varchar(1000) DEFAULT NULL COMMENT '数据范围配置',
  `policy_model_type` varchar(50) DEFAULT NULL COMMENT '授权模型类型',
  `policy_model_id` bigint(20) DEFAULT NULL COMMENT '授权模型id',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1-启用，0-停用',
  `priority` smallint(4) DEFAULT '1' COMMENT '优先级，数字越大优先级越高',
  `config_supply` tinyint(4) DEFAULT NULL COMMENT '是否配置供应,1-配置，0-未配置',
  `config_scope` tinyint(4) DEFAULT NULL COMMENT '是否配置授权,1-配置，0-未配置',
  `content` text COMMENT 'json格式配置内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `policy_model_type_id` bigint(20) DEFAULT NULL COMMENT '权限模型类型id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `policy_model_type_id_idx` (`policy_model_type_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应策略';

DROP TABLE IF EXISTS `policy_supply_app_link`;
CREATE TABLE `policy_supply_app_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应策略应用关联表';

DROP TABLE IF EXISTS `policy_supply_app_res_link`;
CREATE TABLE `policy_supply_app_res_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `supply_app_link_id` bigint(20) DEFAULT NULL COMMENT '供应策略-应用关联id',
  `data_type` varchar(20) DEFAULT NULL COMMENT '权限类型：role-角色，group-组，menu-菜单',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id，包括：组织、应用、菜单、用户',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1-绑定；0-解绑',
  `action_type` tinyint(2) DEFAULT NULL COMMENT '操作类型：1-新增；2-修改',
  `action_timestamp` bigint(20) DEFAULT NULL COMMENT '时间戳，每次新建、修改产生一个时间戳作为数据隔离的唯一标识',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应策略应用权限关联临时表';

DROP TABLE IF EXISTS `policy_supply_app_scope`;
CREATE TABLE `policy_supply_app_scope` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_app_link_id` bigint(20) DEFAULT NULL COMMENT '供应策略-应用关联id',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `data_type` varchar(20) DEFAULT NULL COMMENT '权限类型：role-角色，group-组，menu-菜单',
  `data_id` bigint(20) DEFAULT NULL COMMENT '应用角色、组、菜单数据id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用授权';

DROP TABLE IF EXISTS `policy_supply_class_method`;
CREATE TABLE `policy_supply_class_method` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` varchar(255) DEFAULT NULL COMMENT '分类：org-组织，job-岗位，account-帐号',
  `name` varchar(255) DEFAULT NULL COMMENT '服务名称',
  `request_flag` tinyint(4) DEFAULT NULL COMMENT '申请标识',
  `method_name` varchar(255) DEFAULT NULL COMMENT 'requestFlag对应的方法',
  `callback_method` varchar(255) DEFAULT NULL COMMENT '下推数据后的回调方法',
  `content_template` text COMMENT '数据配置模板（json格式）',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态：1-启用；0-停用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `is_sys` tinyint(4) DEFAULT NULL COMMENT '状态：1-系统内置，0-其他方法',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应策略类方法配置';

DROP TABLE IF EXISTS `policy_supply_config`;
CREATE TABLE `policy_supply_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `request_flag` tinyint(4) DEFAULT NULL COMMENT '请求标志（如新增、修改、停用、启用、删除等）',
  `config` text COMMENT '生命周期配置（json数据）',
  `priority` smallint(4) DEFAULT '1' COMMENT '优先级，数字越大优先级越高',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应策略生命周期配置';

DROP TABLE IF EXISTS `policy_supply_config_app_link`;
CREATE TABLE `policy_supply_config_app_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_config_id` bigint(20) DEFAULT NULL COMMENT '供应策略配置id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `request_flag` tinyint(4) DEFAULT NULL COMMENT '请求标志（如新增、修改、停用、启用、删除等）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用生命周期配置-应用关联表';

DROP TABLE IF EXISTS `policy_supply_model_app`;
CREATE TABLE `policy_supply_model_app` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `policy_model_id` bigint(20) DEFAULT NULL COMMENT '授权模型id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_policy_supply_id` (`supply_id`) USING BTREE COMMENT '供应策略id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='供应策略对应权限模型应用的快照';

DROP TABLE IF EXISTS `policy_supply_org_range`;
CREATE TABLE `policy_supply_org_range` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `supply_id` bigint(20) DEFAULT NULL COMMENT '供应策略id',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `include_child` tinyint(1) DEFAULT NULL COMMENT '包含子组织：1-包含，0-不包含',
  `exclude_org` tinyint(1) DEFAULT NULL COMMENT '排除组织：1-排除，0-不排除',
  `include_range_id` bigint(20) DEFAULT NULL COMMENT '包含记录id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='组织供应策略数据范围';

DROP TABLE IF EXISTS `policy_user_password`;
CREATE TABLE `policy_user_password` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) DEFAULT NULL COMMENT '用户组id',
  `name` varchar(100) DEFAULT NULL COMMENT '策略名称',
  `default_policy_flag` tinyint(2) DEFAULT '0' COMMENT '默认策略标记1：是，0：否',
  `priority` smallint(4) DEFAULT '1' COMMENT '优先级，数字越大优先级越高，默认策略优先级为0',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态，0-无效，1-有效',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `max_char` tinyint(2) DEFAULT NULL COMMENT '大写字母至少几位',
  `min_char` tinyint(2) DEFAULT NULL COMMENT '小写字母至少几位',
  `number_char` tinyint(2) DEFAULT NULL COMMENT '数字至少几位',
  `special_char` tinyint(2) DEFAULT NULL COMMENT '特殊字符个数',
  `is_first_number` tinyint(2) DEFAULT NULL COMMENT '首个字符是否为数字，0-不允许，1-允许',
  `history` tinyint(2) DEFAULT '3' COMMENT '强制密码历史',
  `min_length` tinyint(2) DEFAULT NULL COMMENT '最小长度',
  `max_length` tinyint(2) DEFAULT NULL COMMENT '最大长度',
  `min_cycle` smallint(4) unsigned DEFAULT NULL COMMENT '密码有效期（天）',
  `expire_prompt` smallint(4) DEFAULT NULL COMMENT '预提醒时间(天)',
  `reminders_num` tinyint(2) DEFAULT NULL COMMENT '提醒次数（每天）',
  `ad_display_name` varchar(255) DEFAULT NULL COMMENT 'AD的displayname的组成',
  `required_chars` varchar(50) DEFAULT NULL COMMENT '必须使用的字符',
  `allowed_special_chars` varchar(255) DEFAULT NULL COMMENT '允许使用的特殊字符',
  `not_allowed_chars` varchar(50) DEFAULT NULL COMMENT '不允许使用的字符',
  `required_rule_num` tinyint(2) DEFAULT '4' COMMENT '特殊字符，数字，大写字符，小写字符，4选N的策略',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `password_strength` tinyint(2) DEFAULT NULL COMMENT '密码强度 1低 2中 3高 4自定义',
  `no_space` tinyint(2) DEFAULT NULL COMMENT '是否包含空格，0-不允许 1-允许',
  `no_user_uid` tinyint(2) DEFAULT NULL COMMENT '是否包含帐号名，0-不允许，1-允许',
  `no_ad_name` tinyint(2) DEFAULT NULL COMMENT '是否包含ad帐号名，0-不允许，1-允许',
  `first_log_in_reset` tinyint(2) DEFAULT NULL COMMENT '首次登录是否需要更改密码，1-需要，0-不需要',
  `check_weak_pwd` tinyint(2) DEFAULT NULL COMMENT '是否允许弱密码，0-不允许 1-允许',
  `repeat_limit` tinyint(2) DEFAULT NULL COMMENT '连续相同字符的重复校验',
  `keyboard_seq_limit` tinyint(2) DEFAULT NULL COMMENT '键盘连续字符的重复校验',
  `str_concat_type` tinyint(2) DEFAULT NULL COMMENT '字符串组合类型，0：默认组合，1，自定义组合',
  `char_type_count` tinyint(2) DEFAULT NULL COMMENT '字符字符类型的数量（特殊字符，数字，大写字符，小写字符）',
  `login_check_pwd` tinyint(2) DEFAULT NULL COMMENT '登录时是否校验密码，0：不校验，1：校验',
  `corp_abbr` varchar(255) DEFAULT NULL COMMENT '企业简称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_status` (`group_id`,`status`) USING BTREE COMMENT '密码重新执行索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户密码策略表';

DROP TABLE IF EXISTS `policy_user_password_challenge`;
CREATE TABLE `policy_user_password_challenge` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `type` tinyint(2) NOT NULL COMMENT '类型，1-手机，2-邮箱，3-密保',
  `email` varchar(1024) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(380) DEFAULT NULL COMMENT '手机',
  `question_id` bigint(20) DEFAULT NULL COMMENT '密保问题',
  `answer` varchar(100) DEFAULT NULL COMMENT '密保答案',
  `custommatter` varchar(300) DEFAULT NULL COMMENT '自定义问题',
  `reserved1` varchar(300) DEFAULT NULL COMMENT '预留字段',
  `reserved2` varchar(300) DEFAULT NULL COMMENT '预留字段',
  `reserved3` varchar(300) DEFAULT NULL COMMENT '预留字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户密码找回方式';

DROP TABLE IF EXISTS `policy_user_password_get_back`;
CREATE TABLE `policy_user_password_get_back` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `user_password_id` bigint(20) DEFAULT NULL COMMENT '密码策略id',
  `verify_name` varchar(255) DEFAULT NULL COMMENT '标签',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='密码策略找回方式';

DROP TABLE IF EXISTS `policy_user_password_history`;
CREATE TABLE `policy_user_password_history` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_password` varchar(400) DEFAULT NULL COMMENT '用户密码，密文',
  `modify_password_time` datetime DEFAULT NULL COMMENT '修改密码的时间',
  `pwd_salt` varchar(128) DEFAULT NULL COMMENT '盐',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户密码历史表';

DROP TABLE IF EXISTS `policy_user_password_regex`;
CREATE TABLE `policy_user_password_regex` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_user_password_id` bigint(20) NOT NULL COMMENT '密码策略ID',
  `regex` varchar(255) DEFAULT NULL COMMENT '正则',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(255) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `policy_user_password_id_idx` (`policy_user_password_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pt_account_apply`;
CREATE TABLE `pt_account_apply` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `code` varchar(64) DEFAULT '' COMMENT '申请编码',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_uid` varchar(64) DEFAULT '' COMMENT '用户帐号',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `apply_policy_type` varchar(20) DEFAULT NULL COMMENT '供应类型：account-帐号，permission-权限',
  `policy_model_id` bigint(20) DEFAULT NULL COMMENT '流程权限id',
  `app_content` varchar(500) DEFAULT NULL COMMENT '申请应用摘要信息',
  `permission_content` varchar(500) DEFAULT NULL COMMENT '申请权限摘要信息',
  `account_content` varchar(500) DEFAULT NULL COMMENT '申请帐号的摘要信息',
  `policy_model_name` varchar(255) DEFAULT NULL COMMENT '流程权限名称',
  `status` tinyint(2) DEFAULT '0' COMMENT '状态：0-草稿，1-申请中，2-已完成',
  `long_term` tinyint(2) DEFAULT '1' COMMENT '长期有效：1-长期，0-非长期',
  `process_inst_id` varchar(60) DEFAULT NULL COMMENT '流程实例id',
  `process_inst_status` tinyint(4) DEFAULT NULL COMMENT '流程实例状态：0-审批驳回，1-审批通过',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `commit_time` datetime DEFAULT NULL COMMENT '提交时间',
  `last_approval_time` datetime DEFAULT NULL COMMENT '最近审批时间',
  `approval_user` varchar(255) DEFAULT '' COMMENT '当前审批人',
  `begin_time` datetime DEFAULT NULL COMMENT '启用时间',
  `end_time` datetime DEFAULT NULL COMMENT '关闭时间',
  `approval_result` tinyint(4) DEFAULT NULL COMMENT '审批结果：0-申请驳回，1-申请通过',
  `account_no` varchar(100) DEFAULT NULL COMMENT '帐号',
  `activity_name` varchar(255) DEFAULT '' COMMENT '活动节点名称',
  `error_msg` varchar(2000) DEFAULT NULL COMMENT '错误信息',
  `error_detail` varchar(2000) DEFAULT NULL COMMENT '错误详情',
  `apply_data_type` varchar(255) DEFAULT NULL COMMENT '申请单的类型',
  `apply_title` varchar(255) DEFAULT NULL COMMENT '申请单标题',
  `source_user_id` bigint(20) DEFAULT NULL COMMENT '权限复制人员ID',
  `default_process` tinyint(2) DEFAULT '0' COMMENT '是否默认流程：1-是；0-否',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_code` (`code`) USING BTREE COMMENT '申请单编号索引',
  KEY `idx_user_id_status` (`user_id`,`status`,`approval_result`) USING BTREE COMMENT '我的申请列表查询索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用帐号自助申请表';

DROP TABLE IF EXISTS `pt_account_apply_app`;
CREATE TABLE `pt_account_apply_app` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `account_apply_id` bigint(20) DEFAULT NULL COMMENT '应用帐号自助申请表id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `app_name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `skip` tinyint(1) DEFAULT NULL COMMENT '申请跳过该应用：1-跳过；0-不跳过',
  `skip_reason` varchar(255) DEFAULT NULL COMMENT '申请跳过原因',
  `skip_type` tinyint(2) DEFAULT NULL COMMENT '跳过类型：1-应用；2-帐号',
  `account_id` bigint(20) DEFAULT NULL COMMENT '应用帐号id',
  `account_no` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `account_name` varchar(255) DEFAULT NULL COMMENT '申请的帐号名称',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_account_apply_id_app` (`account_apply_id`) USING BTREE COMMENT '自助申请id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用帐号自助申请表应用清单';

DROP TABLE IF EXISTS `pt_account_apply_permission`;
CREATE TABLE `pt_account_apply_permission` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `account_apply_id` bigint(20) DEFAULT NULL COMMENT '应用帐号自助申请表id',
  `data_type` varchar(20) DEFAULT NULL COMMENT '权限类型：role-角色，group-组，resource-资源',
  `data_id` bigint(20) DEFAULT NULL COMMENT '数据id，包括：角色、组、菜单',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  `code` varchar(255) DEFAULT NULL COMMENT '权限编码',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父节点id',
  `end_date` datetime DEFAULT NULL COMMENT '权限过期时间',
  `skip` tinyint(2) DEFAULT NULL COMMENT '跳过改权限',
  `skip_reason` varchar(255) DEFAULT NULL COMMENT '跳过原因',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idt_account_apply_id_permission` (`account_apply_id`) USING BTREE COMMENT '自助申请id索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用帐号自助申请表权限清单';

DROP TABLE IF EXISTS `request_log`;
CREATE TABLE `request_log` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `approval_type` varchar(32) NOT NULL DEFAULT '0' COMMENT '枚举：org,job,account',
  `sync_factor` smallint(2) DEFAULT NULL COMMENT '同步动作来源:1-用户自助释放;2-用户申请;3-供应策略;4-修改用户后重新供应;5-用户权限异动;6-全局供应策略;7-应用帐号策略;8-权限合规检查;9-权限到期;10-手动操作',
  `request_flag` smallint(2) NOT NULL COMMENT '请求标志，如：新增，删除、停用、启用，离职、转岗',
  `action_flag` smallint(2) DEFAULT NULL COMMENT '请求引起的操作，如：新增，删除、停用、启用，离职、转岗',
  `action_desc` varchar(255) DEFAULT NULL COMMENT '操作的概要说明',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `app_name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `supply_policy_id` bigint(20) DEFAULT NULL COMMENT '应用同步策略id',
  `supply_policy_name` varchar(100) DEFAULT NULL COMMENT '应用同步策略名称',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户的id',
  `user_uid` varchar(64) DEFAULT NULL COMMENT '用户的uid',
  `account_id` bigint(20) DEFAULT NULL COMMENT '帐号的id',
  `account_uuid` varchar(64) DEFAULT NULL COMMENT '帐号的uuid',
  `account_no` varchar(100) DEFAULT NULL COMMENT '帐号的名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `org_name` varchar(50) DEFAULT NULL COMMENT '组织名称',
  `org_name_en` varchar(50) DEFAULT NULL COMMENT '组织英文名称',
  `job_id` bigint(20) DEFAULT NULL COMMENT '岗位id',
  `job_name` varchar(50) DEFAULT NULL COMMENT '岗位名称',
  `request_time` datetime(3) DEFAULT NULL COMMENT '任务生成时间',
  `finish_time` datetime DEFAULT NULL COMMENT '任务完成时间',
  `require_exec_time` datetime DEFAULT NULL COMMENT '非空，代表任务的执行时间，为空，代表任务立即执行',
  `status` smallint(2) DEFAULT NULL COMMENT '状态，0失败，1成功，2执行中，3失败重试请求中，4等待被调用，5等待中，6请求中',
  `submit_user_id` bigint(20) DEFAULT NULL COMMENT '创建者的user id',
  `submit_uid` varchar(64) DEFAULT '0' COMMENT '创建者uid',
  `latest_operator_user_id` bigint(11) DEFAULT NULL COMMENT '最后操作人user id',
  `latest_operator_uid` varchar(64) DEFAULT NULL COMMENT '最后操作人uid',
  `retry_count` int(11) DEFAULT '0' COMMENT '重试次数',
  `confirm` smallint(2) DEFAULT '0' COMMENT '信息是否已确认,1:已确认,0:未确认',
  `priority` int(11) DEFAULT '1' COMMENT '任务的优先级',
  `extend_impl` varchar(200) DEFAULT NULL COMMENT '扩展实现类和方法，#号隔开。如com.para.Test#testMethod',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `account_pwd` varchar(400) DEFAULT NULL COMMENT '帐号密码',
  `account_pwd_salt` varchar(128) DEFAULT NULL COMMENT '帐号密码盐',
  `sync_data_id` bigint(20) DEFAULT NULL COMMENT '同步的数据id',
  `sync_data_name` varchar(255) DEFAULT NULL COMMENT '同步的数据名称',
  `batch_num` bigint(20) DEFAULT '0' COMMENT '供应策略执行批次号',
  `last_interval` int(11) DEFAULT NULL COMMENT '上次间隔时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_app_id_account_no` (`app_id`,`account_no`) USING BTREE COMMENT '主账号修改时查询下推记录',
  KEY `idx_status_require_exec_time` (`status`,`confirm`,`require_exec_time`) USING BTREE,
  KEY `idx_org_approval_app` (`approval_type`,`app_id`,`org_id`) USING BTREE COMMENT '组织供应时查询是否已推送父组织',
  KEY `idx_request_time` (`request_time`) USING BTREE COMMENT '默认分页数据索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下推任务调度表';

DROP TABLE IF EXISTS `request_log_history`;
CREATE TABLE `request_log_history` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `approval_type` varchar(32) NOT NULL DEFAULT '0' COMMENT '枚举：org,job,account',
  `request_flag` smallint(2) NOT NULL COMMENT '请求标志，如：新增，删除、停用、启用，离职、转岗',
  `action_flag` smallint(2) DEFAULT NULL COMMENT '请求引起的操作，如：新增，删除、停用、启用，离职、转岗',
  `action_desc` varchar(255) DEFAULT NULL COMMENT '操作的概要说明',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `app_name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `supply_policy_id` bigint(20) DEFAULT NULL COMMENT '应用同步策略id',
  `supply_policy_name` varchar(100) DEFAULT NULL COMMENT '应用同步策略名称',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户的id',
  `user_uid` varchar(64) DEFAULT NULL COMMENT '用户的uid',
  `account_id` bigint(20) DEFAULT NULL COMMENT '帐号的id',
  `account_uuid` varchar(64) DEFAULT NULL COMMENT '帐号的uuid',
  `account_no` varchar(100) DEFAULT NULL COMMENT '帐号的名称',
  `org_id` bigint(20) DEFAULT NULL COMMENT '组织id',
  `org_name` varchar(50) DEFAULT NULL COMMENT '组织名称',
  `org_name_en` varchar(50) DEFAULT NULL COMMENT '组织英文名称',
  `job_id` bigint(20) DEFAULT NULL COMMENT '岗位id',
  `job_name` varchar(50) DEFAULT NULL COMMENT '岗位名称',
  `request_time` datetime(3) DEFAULT NULL COMMENT '任务生成时间',
  `finish_time` datetime DEFAULT NULL COMMENT '任务完成时间',
  `require_exec_time` datetime DEFAULT NULL COMMENT '非空，代表任务的执行时间，为空，代表任务立即执行',
  `status` smallint(2) DEFAULT NULL COMMENT '状态，0失败，1成功，2执行中，3失败重试请求中，4等待被调用，5等待中，6请求中',
  `submit_user_id` bigint(20) DEFAULT NULL COMMENT '创建者的user id',
  `submit_uid` varchar(64) DEFAULT '0' COMMENT '创建者uid',
  `latest_operator_user_id` bigint(11) DEFAULT NULL COMMENT '最后操作人user id',
  `latest_operator_uid` varchar(64) DEFAULT NULL COMMENT '最后操作人uid',
  `retry_count` int(11) DEFAULT '0' COMMENT '重试次数',
  `confirm` smallint(2) DEFAULT '0' COMMENT '信息是否已确认,1:已确认,0:未确认',
  `priority` int(11) DEFAULT '1' COMMENT '任务的优先级',
  `extend_impl` varchar(200) DEFAULT NULL COMMENT '扩展实现类和方法，#号隔开。如com.para.Test#testMethod',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `account_pwd` varchar(400) DEFAULT NULL COMMENT '帐号密码',
  `account_pwd_salt` varchar(128) DEFAULT NULL COMMENT '帐号密码盐',
  `sync_data_id` bigint(20) DEFAULT NULL COMMENT '同步的数据id',
  `sync_data_name` varchar(255) DEFAULT NULL COMMENT '同步的数据名称',
  `batch_num` bigint(20) DEFAULT '0' COMMENT '供应策略执行批次号',
  `permission_id` bigint(20) DEFAULT NULL COMMENT '权限id',
  `permission_name` varchar(255) DEFAULT NULL COMMENT '权限名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下推任务调度表';

DROP TABLE IF EXISTS `request_log_item`;
CREATE TABLE `request_log_item` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键id',
  `request_log_id` bigint(11) DEFAULT NULL COMMENT 'request_log id',
  `exec_serial` int(11) DEFAULT NULL COMMENT '执行的序号（可能有重试）',
  `exec_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '执行时间',
  `status` smallint(11) DEFAULT NULL COMMENT '状态，1成功，0失败，2执行中',
  `entity` text COMMENT '收到的实体',
  `message` text COMMENT '下推的数据',
  `error_message` text COMMENT '错误日志',
  `response_message` text COMMENT '响应报文',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_request_log_id` (`request_log_id`) USING BTREE COMMENT '申请查询'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下推任务调度表详情表';

DROP TABLE IF EXISTS `request_log_item_history`;
CREATE TABLE `request_log_item_history` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键id',
  `request_log_id` bigint(11) DEFAULT NULL COMMENT 'request_log id',
  `exec_serial` int(11) DEFAULT NULL COMMENT '执行的序号（可能有重试）',
  `exec_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '执行时间',
  `status` smallint(11) DEFAULT NULL COMMENT '状态，1成功，0失败，2执行中',
  `entity` text COMMENT '收到的实体',
  `message` text COMMENT '下推的数据',
  `error_message` text COMMENT '错误日志',
  `response_message` text COMMENT '响应报文',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下推任务调度表详情表';

DROP TABLE IF EXISTS `request_log_permission_link`;
CREATE TABLE `request_log_permission_link` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `request_log_id` bigint(20) DEFAULT NULL COMMENT '申请查询id',
  `action_type` tinyint(2) DEFAULT NULL COMMENT '修改动作：0-解绑；1-绑定',
  `data_type` varchar(10) DEFAULT NULL COMMENT '修改对象：role-应用角色，group-应用组，resource-应用资源',
  `data_id` bigint(20) DEFAULT NULL COMMENT '权限id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_request_log_id` (`request_log_id`) USING BTREE,
  KEY `idx_data_id` (`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下推任务调度表权限变更关联表';

DROP TABLE IF EXISTS `request_log_permission_link_history`;
CREATE TABLE `request_log_permission_link_history` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `request_log_id` bigint(20) DEFAULT NULL COMMENT '申请查询id',
  `action_type` tinyint(2) DEFAULT NULL COMMENT '修改动作：0-解绑；1-绑定',
  `data_type` varchar(10) DEFAULT NULL COMMENT '修改对象：role-应用角色，group-应用组，resource-应用资源',
  `data_id` bigint(20) DEFAULT NULL COMMENT '权限id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_request_log_id` (`request_log_id`) USING BTREE,
  KEY `idx_data_id` (`data_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='下推任务调度表权限变更关联表备份表';

DROP TABLE IF EXISTS `sensitive_response_user`;
CREATE TABLE `sensitive_response_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `sensitive_id` bigint(20) DEFAULT NULL COMMENT '敏感标记ID',
  `user_id` bigint(20) DEFAULT NULL COMMENT '负责人用户ID',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `sensitive_id` (`sensitive_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='敏感信息负责人关联关系表';

DROP TABLE IF EXISTS `sys_holiday`;
CREATE TABLE `sys_holiday` (
  `id` bigint(20) NOT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '节日名称',
  `scope` varchar(64) DEFAULT NULL COMMENT '范围',
  `type` varchar(64) DEFAULT NULL COMMENT '类型',
  `start_time` datetime DEFAULT NULL COMMENT '节日开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '节日结束时间',
  `bak` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1启用 0停用',
  `eid` varchar(64) DEFAULT NULL COMMENT '范围',
  `creator` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `updater` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `sys_secret`;
CREATE TABLE `sys_secret` (
  `id` bigint(20) NOT NULL COMMENT '表主键',
  `secret_name` varchar(20) DEFAULT NULL COMMENT '名称',
  `algorithm_type` varchar(16) NOT NULL COMMENT '加密算法类型',
  `private_key` varchar(1024) DEFAULT NULL COMMENT '私钥',
  `public_key` varchar(1024) DEFAULT NULL COMMENT '公钥',
  `salt` varchar(128) DEFAULT NULL COMMENT '加密盐值',
  `version` int(11) NOT NULL COMMENT '版本号',
  `state` int(1) DEFAULT NULL COMMENT '停启用，1为启用，0为停用',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_type_version` (`algorithm_type`,`version`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `t_base_encrypt_field_config`;
CREATE TABLE `t_base_encrypt_field_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `encrypt_type` varchar(20) NOT NULL COMMENT '加密方式',
  `field_name` varchar(50) NOT NULL COMMENT '字段编码',
  `aliases_name` varchar(50) NOT NULL COMMENT '字段名称',
  `field_type` varchar(50) NOT NULL COMMENT '字段类型',
  `status` varchar(1) DEFAULT '1' COMMENT '状态<1:可用，0:不可用>',
  `prefix` varchar(60) DEFAULT '1' COMMENT '前缀',
  `create_time` datetime NOT NULL COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `t_base_secret_key_config`;
CREATE TABLE `t_base_secret_key_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `encrypt_type` varchar(50) NOT NULL COMMENT '加密方式',
  `pri_key` text NOT NULL COMMENT '私钥',
  `pub_key` text NOT NULL COMMENT '公钥',
  `version` bigint(20) NOT NULL COMMENT '版本号',
  `status` varchar(1) DEFAULT '1' COMMENT '状态<1:可用，0:不可用>',
  `create_time` datetime NOT NULL COMMENT '记录创建时间',
  `update_time` datetime NOT NULL COMMENT '记录更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uniq_encrypt_status` (`encrypt_type`,`status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `task_app_count`;
CREATE TABLE `task_app_count` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '应用ID',
  `name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `app_code` varchar(32) DEFAULT '' COMMENT '应用编码',
  `status` varchar(1) NOT NULL DEFAULT '1' COMMENT '状态，1启用，2停用',
  `recycling_state` varchar(8) DEFAULT '0' COMMENT '回收状态，0未回收，1回收完成，2回收失败 3 回收中',
  `account_count` int(20) DEFAULT NULL COMMENT '应用帐号总数',
  `orphan_account_count` int(20) DEFAULT NULL COMMENT '孤儿帐号总数',
  `zombie_account_count` int(20) DEFAULT NULL COMMENT '僵尸帐号总数',
  `resource_count` int(20) DEFAULT NULL COMMENT '资源总数',
  `role_count` int(20) DEFAULT NULL COMMENT '角色总数',
  `group_count` int(20) DEFAULT NULL COMMENT '应用组总数',
  `count_date` date DEFAULT NULL COMMENT '记录创建时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '记录创建者',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '记录最后修改者',
  `update_time` datetime DEFAULT NULL COMMENT '记录编辑时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `batch_number` bigint(20) DEFAULT NULL COMMENT '批次号',
  `zombie_policy_log_id` bigint(20) DEFAULT NULL COMMENT '僵尸帐号策略执行日志ID',
  `zombie_policy_id` bigint(20) DEFAULT NULL COMMENT '僵尸帐号策略ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='统计应用表';

DROP TABLE IF EXISTS `task_failed_job_statistics`;
CREATE TABLE `task_failed_job_statistics` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `success_count` int(11) DEFAULT NULL COMMENT '任务成功记录数',
  `failed_count` int(11) DEFAULT NULL COMMENT '任务失败记录数',
  `total_count` int(11) DEFAULT NULL COMMENT '任务总数',
  `start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '任务结束时间',
  `send_status` smallint(2) DEFAULT '1' COMMENT '发送通知状态 1成功 0失败',
  `run_start_time` datetime DEFAULT NULL COMMENT '任务开始时间',
  `run_end_time` datetime DEFAULT NULL COMMENT '任务结束时间创建时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='失败任务统计表';

DROP TABLE IF EXISTS `task_policy_execute`;
CREATE TABLE `task_policy_execute` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` tinyint(2) DEFAULT '1' COMMENT '任务类型：1-用户密码，2-仅预览，3-帐号重新执行，4-组织重新执行，5-岗位重新执行',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `in_param` text COMMENT '入参json',
  `exe_status` tinyint(2) DEFAULT '3' COMMENT '执行状态：0-失败，1-成功，2-执行中，3-等待中',
  `exe_result` varchar(2048) DEFAULT NULL COMMENT '执行结果',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `total` int(11) DEFAULT NULL COMMENT '执行记录总数',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_exe_status` (`exe_status`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略的运行任务';

DROP TABLE IF EXISTS `task_policy_execute_item`;
CREATE TABLE `task_policy_execute_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `task_id` bigint(20) DEFAULT '1' COMMENT '任务',
  `type` tinyint(2) DEFAULT NULL COMMENT '类型：1-开通，2-不符合开通策略',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `user_uid` varchar(64) DEFAULT '' COMMENT '用户名',
  `account_no` varchar(100) DEFAULT '' COMMENT '帐号',
  `account_name` varchar(100) DEFAULT NULL COMMENT '帐号名称',
  `account_user_link_id` bigint(20) DEFAULT NULL COMMENT '用户帐号关联id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `old_policy_pwd_id` bigint(20) DEFAULT NULL COMMENT '旧密码策略id',
  `old_policy_pwd_name` varchar(100) DEFAULT NULL COMMENT '旧策略',
  `new_policy_pwd_id` bigint(20) DEFAULT NULL COMMENT '新密码策略id',
  `new_policy_pwd_name` varchar(100) DEFAULT NULL COMMENT '新策略',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '策略id',
  `policy_name` varchar(100) DEFAULT '' COMMENT '策略名称',
  `error_msg` varchar(2048) DEFAULT '' COMMENT '错误信息',
  `org_name` varchar(100) DEFAULT NULL COMMENT '组织名称',
  `org_code` varchar(100) DEFAULT NULL COMMENT '组织编码',
  `job_name` varchar(100) DEFAULT NULL COMMENT '岗位名称',
  `job_code` varchar(100) DEFAULT NULL COMMENT '岗位编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略的运行任务-变更明细';

