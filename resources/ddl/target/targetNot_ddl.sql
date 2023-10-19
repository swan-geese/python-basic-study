
DROP TABLE IF EXISTS `app_flexible_form_link`;
CREATE TABLE `app_flexible_form_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_id` bigint(20) NOT NULL COMMENT '应用ID',
  `flexible_form_id` bigint(20) NOT NULL COMMENT '动态表单ID',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `app_id` (`app_id`) USING BTREE,
  KEY `flexible_form_id` (`flexible_form_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用和动态表单关联表';

DROP TABLE IF EXISTS `app_zombie_account_policy`;
CREATE TABLE `app_zombie_account_policy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_name` varchar(200) DEFAULT NULL COMMENT '策略名称',
  `num` int(11) DEFAULT NULL COMMENT '策略判断规则(天数)',
  `notice` tinyint(1) DEFAULT NULL COMMENT '通知(1:通知 ,2:不通知)',
  `notice_policy_id` bigint(20) DEFAULT NULL COMMENT '通知策略选项id',
  `operation` tinyint(2) DEFAULT NULL COMMENT '操作(1:操作,2:不操作)',
  `operation_item` int(11) DEFAULT NULL COMMENT '帐户操作(0:无操作,1:停用,2:锁定,3:删除)',
  `operation_scope` tinyint(2) DEFAULT NULL COMMENT '帐户操作范围(1:全部帐号,2:保留最新帐号,3:保留最老帐号)',
  `excut_type` tinyint(2) DEFAULT NULL COMMENT '策略执行方式(1:手动执行，2:自动执行)',
  `status` tinyint(2) DEFAULT NULL COMMENT '策略状态(0:不启用，1:启用，2:正在执行 默认：1)',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(6) DEFAULT NULL COMMENT '修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新者',
  `excuter` varchar(50) DEFAULT NULL COMMENT '执行者',
  `excut_time` datetime(6) DEFAULT NULL COMMENT '执行时间',
  `operation_type` int(11) DEFAULT NULL COMMENT '1:平台僵尸帐号,2:平台空帐号,3:应用僵尸帐号,4:应用重复帐号,5:应用孤儿帐号',
  `excuting` tinyint(2) DEFAULT '0' COMMENT '是否在执行中(0:未执行,1:在执行中) 默认:0',
  `task_id` int(11) DEFAULT NULL COMMENT '任务ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='僵尸帐号策略表';

DROP TABLE IF EXISTS `app_zombie_account_policy_item`;
CREATE TABLE `app_zombie_account_policy_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '策略id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='僵尸帐号策略账户关联表';

DROP TABLE IF EXISTS `app_zombie_account_policy_log`;
CREATE TABLE `app_zombie_account_policy_log` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '策略id',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态(0:失败，1:成功)',
  `start_time` datetime(6) DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(6) DEFAULT NULL COMMENT '结束时间',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(6) DEFAULT NULL COMMENT '修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改者',
  `operation_type` tinyint(2) DEFAULT NULL COMMENT '操作类型(1:平台,2:应用)',
  `scope_name` varchar(4000) DEFAULT NULL COMMENT '策略范围',
  `excuter` varchar(50) DEFAULT NULL COMMENT '执行者',
  `execute_result` varchar(50) DEFAULT NULL COMMENT '执行结果',
  `execute_type` tinyint(2) DEFAULT '2' COMMENT '执行方式：1-手动执行；2-自动执行',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略帐号操作记录表';

DROP TABLE IF EXISTS `app_zombie_account_result`;
CREATE TABLE `app_zombie_account_result` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `operation_log_id` bigint(20) DEFAULT NULL COMMENT '操作记录表id',
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `account_id` bigint(20) DEFAULT NULL COMMENT '帐号id',
  `num` int(11) DEFAULT NULL COMMENT '闲置天数',
  `last_excut_time` datetime(6) DEFAULT NULL COMMENT '上次执行时间',
  `create_time` datetime(6) DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(6) DEFAULT NULL COMMENT '修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新者',
  `policy_id` bigint(20) DEFAULT NULL COMMENT '策略id',
  `result` tinyint(2) DEFAULT NULL COMMENT '执行结果(1:成功，0：失败)',
  `error_msg` varchar(1000) DEFAULT NULL COMMENT '错误信息',
  `account_no` varchar(100) DEFAULT NULL COMMENT '应用帐号',
  `user_uid` varchar(64) DEFAULT NULL COMMENT '用户名',
  `user_name` varchar(480) DEFAULT NULL COMMENT '姓名',
  `org_name` varchar(50) DEFAULT NULL COMMENT '组织名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='策略操作结果表';

DROP TABLE IF EXISTS `audit_account`;
CREATE TABLE `audit_account` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `account_id` bigint(20) DEFAULT NULL,
  `account_no` varchar(255) DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `remark_en` longtext,
  `remark_zh` longtext,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `idx_a_a_time` (`time`) USING BTREE,
  KEY `idx_a_a_operator` (`operator`) USING BTREE,
  KEY `idx_a_a_name` (`name`) USING BTREE,
  KEY `idx_a_a_action` (`action`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_ad_pwd_reverse_sync`;
CREATE TABLE `audit_ad_pwd_reverse_sync` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `password` varchar(1000) DEFAULT NULL,
  `remark` longtext,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `remark_en` longtext,
  `remark_zh` longtext,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_app`;
CREATE TABLE `audit_app` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `app_id` bigint(20) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `remark_en` longtext,
  `remark_zh` longtext,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_cal_field`;
CREATE TABLE `audit_cal_field` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `field_name` varchar(64) DEFAULT NULL COMMENT '字段名',
  `field_alias` varchar(64) DEFAULT NULL COMMENT '字段别名',
  `field_type` varchar(64) DEFAULT NULL COMMENT '字段类型',
  `order_num` tinyint(4) DEFAULT NULL COMMENT '顺序',
  `format_in_str` varchar(32) DEFAULT NULL COMMENT '时间格式化',
  `format_out_str` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_f_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='计算模型生成字段表';

DROP TABLE IF EXISTS `audit_cal_task`;
CREATE TABLE `audit_cal_task` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `name` varchar(128) DEFAULT NULL COMMENT '映射名称',
  `group_name` varchar(128) DEFAULT NULL COMMENT '组',
  `connect_id` bigint(20) DEFAULT NULL COMMENT '数据源id',
  `remark` text COMMENT '备注',
  `query_sql` text COMMENT 'sql语句',
  `frequence` varchar(64) DEFAULT NULL COMMENT '运行频率\r\nONLY_ONCE       一次\r\nEVERY_YEAR     每年\r\nEVERY_MONTH  每月\r\nEVERY_WEEK     每周\r\nEVERY_DAY        每天\r\nEVERY_HOUR     每小时\r\nEVERY_MINUTE  每分钟',
  `cron_year` int(10) DEFAULT NULL COMMENT '年',
  `cron_month` int(10) DEFAULT NULL COMMENT '月',
  `cron_day` int(10) DEFAULT NULL COMMENT '日',
  `cron_hour` int(10) DEFAULT NULL COMMENT '小时',
  `cron_minute` int(10) DEFAULT NULL COMMENT '分',
  `cron_second` int(10) DEFAULT NULL COMMENT '秒',
  `cron_day_week` int(10) DEFAULT NULL COMMENT '周天',
  `cron_expr` varchar(64) DEFAULT NULL COMMENT 'quartz的cron表达式',
  `output_connect_id` bigint(20) DEFAULT NULL COMMENT '输出数据源id',
  `output_table` varchar(32) DEFAULT NULL COMMENT '输出表',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  `last_exec_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_t_connect_id` (`connect_id`) USING BTREE,
  KEY `idx_a_c_t_frequence` (`frequence`) USING BTREE,
  KEY `idx_a_c_t_output_table` (`output_table`) USING BTREE,
  KEY `idx_a_c_t_group_name` (`group_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='计算模型任务表';

DROP TABLE IF EXISTS `audit_cal_task_exe`;
CREATE TABLE `audit_cal_task_exe` (
  `id` bigint(20) NOT NULL,
  `src_type` varchar(32) DEFAULT NULL COMMENT '任务来源类型\r\ncal_module：计算模型\r\nclean_task：定时清理',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `param` varchar(1024) DEFAULT NULL COMMENT '参数',
  `exe_result` varchar(10) DEFAULT NULL COMMENT '执行结果',
  `remark` text COMMENT '失败原因',
  `stack_info` text COMMENT '堆栈信息',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_t_e_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='计算模型任务执行详情';

DROP TABLE IF EXISTS `audit_cal_time_param`;
CREATE TABLE `audit_cal_time_param` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `task_id` bigint(20) DEFAULT NULL COMMENT '任务id',
  `param` varchar(128) DEFAULT NULL COMMENT '变量名',
  `expr` varchar(128) DEFAULT NULL COMMENT '时间表达式',
  `format_str` varchar(32) DEFAULT NULL COMMENT '时间格式',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_t_p_task_id` (`task_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='计算模型时间参数配置表';

DROP TABLE IF EXISTS `audit_clean_task`;
CREATE TABLE `audit_clean_task` (
  `id` bigint(20) NOT NULL,
  `name` varchar(30) DEFAULT NULL COMMENT '名称\n            1：用户画像帐号变动\n            2：系统访问情况\n            3：所在区域分析\n            4：常用设备\n            5：登录方式',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `group_name` varchar(60) DEFAULT NULL COMMENT '分类',
  `status` smallint(6) DEFAULT NULL COMMENT '状态\n            0：未启用\n            1：启用',
  `cron_expr` varchar(64) DEFAULT NULL COMMENT '监测间隔',
  `table_type` smallint(6) DEFAULT NULL COMMENT '选择表类型\n            1：从计算模型中选择\n            2：从场景选择\n            3：自定义',
  `table_id` bigint(20) DEFAULT NULL COMMENT '计算模型id/场景id',
  `last_exec_time` datetime DEFAULT NULL COMMENT '上次执行时间',
  `last_exec_result` varchar(10) DEFAULT NULL COMMENT '上次执行结果\n            fail/success',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_t_name` (`name`) USING BTREE,
  KEY `idx_a_c_t_remark` (`remark`) USING BTREE,
  KEY `idx_a_c_t_group_name` (`group_name`) USING BTREE,
  KEY `idx_a_c_t_status` (`status`) USING BTREE,
  KEY `idx_a_c_t_table_type` (`table_type`) USING BTREE,
  KEY `idx_a_c_t_table_id` (`table_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计清理任务表';

DROP TABLE IF EXISTS `audit_clean_task_item`;
CREATE TABLE `audit_clean_task_item` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) DEFAULT NULL COMMENT '清理任务表id',
  `connect_id` bigint(20) DEFAULT NULL COMMENT '数据源\n            只有选择表为自定义时，此项才有值',
  `table_name` varchar(100) DEFAULT NULL COMMENT '表名',
  `sort` smallint(6) DEFAULT NULL COMMENT '顺序',
  `is_active` smallint(6) DEFAULT NULL COMMENT '是否启用\n            0：否\n            1：是',
  `need_clean` smallint(6) DEFAULT NULL COMMENT '是否需要执行清理检测\n            0：不需要\n            1：需要',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_t_i_task_id` (`task_id`) USING BTREE,
  KEY `idx_a_c_t_i_connect_id` (`connect_id`) USING BTREE,
  KEY `idx_a_c_t_i_table_name` (`table_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计清理任务子表';

DROP TABLE IF EXISTS `audit_clean_task_table`;
CREATE TABLE `audit_clean_task_table` (
  `id` bigint(20) NOT NULL,
  `connect_id` bigint(20) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL COMMENT '表名',
  `time_field` varchar(32) DEFAULT NULL COMMENT '时间字段',
  `format_str` varchar(32) DEFAULT NULL COMMENT '时间格式',
  `is_default_value` smallint(6) DEFAULT NULL COMMENT '是否默认清理条件\n            0：否\n            1：是',
  `time_value` int(11) DEFAULT NULL COMMENT '清理条件的值',
  `time_unit` varchar(5) DEFAULT NULL COMMENT '清理条件的单位\n            m：分钟\n            h：小时\n            d：天\n            M：月\n            y：年',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `ak_audit_clean_task_table` (`connect_id`,`table_name`) USING BTREE,
  KEY `idx_a_c_t_t_table_name` (`table_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计清理任务表字段配置';

DROP TABLE IF EXISTS `audit_connect_config`;
CREATE TABLE `audit_connect_config` (
  `id` bigint(20) NOT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '数据源名称',
  `connect_type` varchar(16) DEFAULT NULL COMMENT '连接类型（mysql，oracle，es，all）',
  `connect_url` varchar(255) DEFAULT NULL COMMENT '连接Url',
  `connect_username` varchar(32) DEFAULT NULL COMMENT '连接用户名',
  `connect_password` varchar(32) DEFAULT NULL COMMENT '连接密码（加密）',
  `template_config` varchar(255) DEFAULT NULL COMMENT '配置模板',
  `des` varchar(255) DEFAULT NULL COMMENT '描述',
  `white_table` text COMMENT '白名单表(只落白名单,逗号分隔)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `driver_class` varchar(255) DEFAULT NULL COMMENT '数据库驱动',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_c_c_connect_type` (`connect_type`) USING BTREE,
  KEY `idx_a_c_c_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计数据源表';

DROP TABLE IF EXISTS `audit_enum_config`;
CREATE TABLE `audit_enum_config` (
  `id` bigint(20) NOT NULL,
  `config_type` smallint(6) DEFAULT NULL COMMENT '1：用户画像账号变动\r\n2：系统访问情况\r\n3：所在区域分析\r\n4：常用设备\r\n5：登录方式',
  `config_name` varchar(128) DEFAULT NULL COMMENT '显示名称',
  `config_key` varchar(128) DEFAULT NULL COMMENT '子级名称',
  `list_id` bigint(20) DEFAULT NULL COMMENT '关联的审计配置id',
  `remark` text COMMENT '备注',
  `is_active` smallint(6) DEFAULT NULL COMMENT '是否启用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_e_c_config_type` (`config_type`) USING BTREE,
  KEY `idx_a_e_c_list_id` (`list_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计枚举配置表';

DROP TABLE IF EXISTS `audit_job`;
CREATE TABLE `audit_job` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `job_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `remark_en` longtext,
  `remark_zh` longtext,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_list_config`;
CREATE TABLE `audit_list_config` (
  `id` bigint(20) NOT NULL,
  `name` varchar(64) DEFAULT NULL COMMENT '审计别名',
  `des` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计配置表';

DROP TABLE IF EXISTS `audit_mapping_config`;
CREATE TABLE `audit_mapping_config` (
  `id` bigint(20) NOT NULL,
  `name` varchar(32) DEFAULT NULL COMMENT '映射名称',
  `default_value` varchar(64) DEFAULT NULL COMMENT '默认值',
  `des` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计数据源关系表';

DROP TABLE IF EXISTS `audit_mapping_config_sub`;
CREATE TABLE `audit_mapping_config_sub` (
  `id` bigint(20) NOT NULL,
  `original_value` varchar(64) DEFAULT NULL COMMENT '原始值',
  `show_value` varchar(64) DEFAULT NULL COMMENT '显示值',
  `sort` double(6,1) DEFAULT NULL COMMENT '排序',
  `mapping_id` bigint(19) DEFAULT NULL COMMENT '映射ID',
  `mapping_type` smallint(2) DEFAULT NULL COMMENT '映射类型(1:动态映射 2:固定映射)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_m_c_s_mappingid` (`mapping_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='映射配置子表';

DROP TABLE IF EXISTS `audit_mapping_datasource`;
CREATE TABLE `audit_mapping_datasource` (
  `id` bigint(20) NOT NULL,
  `default_source` smallint(2) DEFAULT NULL COMMENT '是否为默认源(1.是 0.否)',
  `query_sql` varchar(10240) DEFAULT NULL COMMENT '查询sql',
  `view_name` varchar(10240) DEFAULT NULL COMMENT '视图名称',
  `list_id` bigint(19) DEFAULT NULL COMMENT '列表ID',
  `connect_id` bigint(19) DEFAULT NULL COMMENT '连接ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_m_d_listid` (`list_id`) USING BTREE,
  KEY `idx_a_m_d_connect_id` (`connect_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计数据源关系表';

DROP TABLE IF EXISTS `audit_notify`;
CREATE TABLE `audit_notify` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `fun_code` varchar(255) DEFAULT NULL,
  `notify_method` varchar(255) DEFAULT NULL,
  `notify_mode` varchar(255) DEFAULT NULL,
  `notify_num` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark_en` longtext,
  `remark_zh` longtext,
  `user_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_online_peak`;
CREATE TABLE `audit_online_peak` (
  `log_id` varchar(36) NOT NULL COMMENT '主键',
  `app_version` varchar(50) NOT NULL COMMENT '版本',
  `c_ip` varchar(50) DEFAULT NULL COMMENT '客户端ip',
  `geo_city` varchar(255) DEFAULT NULL COMMENT '所在城市',
  `geo_country_long` varchar(255) DEFAULT NULL COMMENT '所在国家',
  `geo_latitude` float DEFAULT NULL COMMENT '所在纬度',
  `geo_longitude` float DEFAULT NULL COMMENT '所在经度',
  `geo_region` varchar(255) DEFAULT NULL COMMENT '所在地区',
  `http_req` longtext COMMENT 'request请求',
  `module` varchar(255) NOT NULL COMMENT '模块',
  `rel_obj_name` varchar(100) DEFAULT NULL COMMENT '对象名称',
  `s_ip` varchar(50) NOT NULL COMMENT '服务端ip',
  `tag` varchar(100) NOT NULL COMMENT '标签',
  `time` bigint(20) NOT NULL COMMENT '时间',
  `peak_value` bigint(20) DEFAULT NULL COMMENT '在线峰值',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_org`;
CREATE TABLE `audit_org` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `org_code` varchar(255) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `remark` longtext,
  `remark_en` longtext,
  `remark_zh` longtext,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_blob_triggers`;
CREATE TABLE `audit_qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(190) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `SCHED_NAME` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `audit_qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `audit_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_calendars`;
CREATE TABLE `audit_qrtz_calendars` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `CALENDAR_NAME` varchar(190) NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_cron_triggers`;
CREATE TABLE `audit_qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(190) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  `CRON_EXPRESSION` varchar(120) NOT NULL,
  `TIME_ZONE_ID` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `audit_qrtz_cron_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `audit_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_fired_triggers`;
CREATE TABLE `audit_qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `ENTRY_ID` varchar(95) NOT NULL,
  `TRIGGER_NAME` varchar(190) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  `INSTANCE_NAME` varchar(190) NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) NOT NULL,
  `JOB_NAME` varchar(190) DEFAULT NULL,
  `JOB_GROUP` varchar(190) DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_FT_J_G` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_FT_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_FT_T_G` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_FT_TG` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_FT_TRIG_NAME` (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_JOB_REQ_RCVRY` (`SCHED_NAME`,`INSTANCE_NAME`,`REQUESTS_RECOVERY`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_job_details`;
CREATE TABLE `audit_qrtz_job_details` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `JOB_NAME` varchar(190) NOT NULL,
  `JOB_GROUP` varchar(190) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) NOT NULL,
  `IS_DURABLE` varchar(1) NOT NULL,
  `IS_NONCONCURRENT` varchar(1) NOT NULL,
  `IS_UPDATE_DATA` varchar(1) NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_J_REQ_RECOVERY` (`SCHED_NAME`,`REQUESTS_RECOVERY`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_J_GRP` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_locks`;
CREATE TABLE `audit_qrtz_locks` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `LOCK_NAME` varchar(40) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_paused_trigger_grps`;
CREATE TABLE `audit_qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_scheduler_state`;
CREATE TABLE `audit_qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `INSTANCE_NAME` varchar(190) NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_simple_triggers`;
CREATE TABLE `audit_qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(190) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `audit_qrtz_simple_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `audit_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_simprop_triggers`;
CREATE TABLE `audit_qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(190) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  `STR_PROP_1` varchar(512) DEFAULT NULL,
  `STR_PROP_2` varchar(512) DEFAULT NULL,
  `STR_PROP_3` varchar(512) DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `audit_qrtz_simprop_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `audit_qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_qrtz_triggers`;
CREATE TABLE `audit_qrtz_triggers` (
  `SCHED_NAME` varchar(120) NOT NULL,
  `TRIGGER_NAME` varchar(190) NOT NULL,
  `TRIGGER_GROUP` varchar(190) NOT NULL,
  `JOB_NAME` varchar(190) NOT NULL,
  `JOB_GROUP` varchar(190) NOT NULL,
  `DESCRIPTION` varchar(250) DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) NOT NULL,
  `TRIGGER_TYPE` varchar(8) NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(190) DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_J` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_JG` (`SCHED_NAME`,`JOB_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_C` (`SCHED_NAME`,`CALENDAR_NAME`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_G` (`SCHED_NAME`,`TRIGGER_GROUP`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_STATE` (`SCHED_NAME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_N_STATE` (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_N_G_STATE` (`SCHED_NAME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_NFT_ST` (`SCHED_NAME`,`TRIGGER_STATE`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_AUDIT_QRTZ_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_AUDIT_T_NEXT_FIRE_TIME` (`SCHED_NAME`,`NEXT_FIRE_TIME`) USING BTREE,
  KEY `IDX_AUDIT_T_NFT_MISFIRE` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_STATE`) USING BTREE,
  KEY `IDX_AUDIT_T_NFT_MISFIRE_GRP` (`SCHED_NAME`,`MISFIRE_INSTR`,`NEXT_FIRE_TIME`,`TRIGGER_GROUP`,`TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `audit_qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `audit_qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_report_datasource`;
CREATE TABLE `audit_report_datasource` (
  `id` bigint(20) NOT NULL,
  `name` varchar(128) DEFAULT NULL COMMENT '图表名称',
  `group_name` varchar(128) DEFAULT NULL COMMENT '组',
  `connect_id` bigint(20) DEFAULT NULL COMMENT '数据源id',
  `remark` text COMMENT '备注',
  `query_sql` text COMMENT 'sql语句',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '最后更新时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_r_d_connect_id` (`connect_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='图表模型';

DROP TABLE IF EXISTS `audit_report_param`;
CREATE TABLE `audit_report_param` (
  `id` bigint(20) NOT NULL,
  `datasource_id` bigint(20) DEFAULT NULL COMMENT '图表数据源id',
  `field` varchar(64) DEFAULT NULL COMMENT '参数字段',
  `is_null` smallint(6) DEFAULT NULL COMMENT '是否可以为空',
  `default_value` varchar(64) DEFAULT NULL COMMENT '默认值',
  `field_type` varchar(64) DEFAULT NULL COMMENT '字段类型',
  `format_str` varchar(32) DEFAULT NULL COMMENT '时间格式',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_r_p_datasource_id` (`datasource_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='图表参数配置';

DROP TABLE IF EXISTS `audit_schema_config`;
CREATE TABLE `audit_schema_config` (
  `id` bigint(20) NOT NULL,
  `field` varchar(32) DEFAULT NULL COMMENT '字段',
  `field_type` varchar(64) DEFAULT NULL COMMENT '字段类型',
  `field_alias_cn` varchar(64) DEFAULT NULL COMMENT '字段别名',
  `field_alias_en` varchar(255) DEFAULT NULL COMMENT '字段描述',
  `status` smallint(2) DEFAULT NULL COMMENT '状态(是否启用：1：启用 0：禁用)',
  `sort` double(4,1) DEFAULT NULL COMMENT '字段列排序',
  `default_order` smallint(2) DEFAULT NULL COMMENT '是否拼接排序(1:是 0:否)',
  `default_index` smallint(2) DEFAULT NULL COMMENT '是否快捷索引(1:是 0否)',
  `default_collation` varchar(36) DEFAULT NULL COMMENT '排序规则(DESC,ASC)',
  `list_id` bigint(19) DEFAULT NULL COMMENT '列表ID',
  `mapping_id` bigint(19) DEFAULT NULL COMMENT '映射ID',
  `old_time_format` varchar(36) DEFAULT NULL COMMENT '原始时间格式',
  `new_time_format` varchar(36) DEFAULT NULL COMMENT '展示时间格式',
  `is_search` smallint(2) DEFAULT NULL COMMENT '是否默认搜索',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `updater` varchar(50) DEFAULT NULL COMMENT '修改人',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_a_s_c_listid` (`list_id`) USING BTREE,
  KEY `idx_a_s_c_mappingid` (`mapping_id`) USING BTREE,
  KEY `idx_a_s_c_is_search` (`is_search`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='审计字段配置';

DROP TABLE IF EXISTS `audit_self_bind_settings`;
CREATE TABLE `audit_self_bind_settings` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `retrieve_type` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `verify_result` varchar(255) DEFAULT NULL,
  `user_uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_self_pwd_mgmt`;
CREATE TABLE `audit_self_pwd_mgmt` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `remark_en` longtext,
  `remark_zh` longtext,
  `user_uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_self_pwd_retrieve_code`;
CREATE TABLE `audit_self_pwd_retrieve_code` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `receiver` varchar(255) DEFAULT NULL,
  `retrieve_type` varchar(255) DEFAULT NULL,
  `uid` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `verification_code` varchar(255) DEFAULT NULL,
  `verify_result` varchar(255) DEFAULT NULL,
  `user_uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_user`;
CREATE TABLE `audit_user` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `uid` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `remark_en` longtext,
  `remark_zh` longtext,
  `user_uid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE,
  KEY `idx_a_u_time` (`time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `audit_user_type`;
CREATE TABLE `audit_user_type` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `action` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `operator` varchar(255) DEFAULT NULL,
  `remark` longtext,
  `user_type_id` bigint(20) DEFAULT NULL,
  `remark_en` longtext,
  `remark_zh` longtext,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `data_sync_app_push_field`;
CREATE TABLE `data_sync_app_push_field` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  `mode_type` varchar(20) DEFAULT NULL COMMENT '类型: account:帐号、org:组织、job:岗位',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `method` varchar(20) DEFAULT NULL COMMENT '请求方式（GET、POST、PUT、DELETE、HEAD、OPTIONS、PATCH）',
  `path` varchar(255) DEFAULT NULL COMMENT '请求路径',
  `req_body_type` varchar(10) DEFAULT 'json' COMMENT '请求类型（form、json、file、raw)',
  `req_form` varchar(1000) DEFAULT NULL COMMENT '请求form参数',
  `req_query` varchar(1000) DEFAULT NULL COMMENT '请求query参数',
  `req_body` varchar(1000) DEFAULT NULL COMMENT '请求body',
  `req_headers` varchar(1000) DEFAULT NULL COMMENT '请求头',
  `res_body` varchar(1000) DEFAULT NULL COMMENT '请求响应',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_mode_type_name` (`mode_type`,`name`) USING BTREE,
  KEY `index_push_app_id` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='主推请求字段';

DROP TABLE IF EXISTS `flexible_form_link`;
CREATE TABLE `flexible_form_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` varchar(20) DEFAULT '1' COMMENT '表单类型，用户(idt_user)，组织(idt_org)，岗位(idt_job)，帐号(app_account)',
  `instance_id` bigint(20) DEFAULT NULL COMMENT '用户类型id，或者应用id，或者0-默认表单',
  `form_uuid` varchar(64) DEFAULT NULL COMMENT '表单的uuid',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='动态表单关联表';

DROP TABLE IF EXISTS `flexible_form_snack_component`;
CREATE TABLE `flexible_form_snack_component` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `config` longtext COMMENT '配置',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='动态表单组件信息';

DROP TABLE IF EXISTS `flexible_form_snack_design`;
CREATE TABLE `flexible_form_snack_design` (
  `id` varchar(64) NOT NULL COMMENT '标识',
  `name` varchar(255) DEFAULT NULL COMMENT '名称',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  `content` text COMMENT '内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '描述',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='动态表单设计器';

DROP TABLE IF EXISTS `flexible_snack_component_type`;
CREATE TABLE `flexible_snack_component_type` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` varchar(50) DEFAULT NULL COMMENT '类型',
  `label` varchar(100) DEFAULT NULL COMMENT '标签',
  `seq` int(3) DEFAULT NULL COMMENT '序号',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='动态表单组件类型';

DROP TABLE IF EXISTS `mfa_abnormal_polymerize_record`;
CREATE TABLE `mfa_abnormal_polymerize_record` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `risk_count` int(11) DEFAULT NULL COMMENT '风险次数',
  `second_type` varchar(64) DEFAULT NULL COMMENT '二级分类',
  `risk_date` date DEFAULT NULL COMMENT '风险日期',
  `first_type` varchar(64) DEFAULT NULL COMMENT '一级分类',
  `priority` int(2) DEFAULT NULL COMMENT '统计优先级',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='风险统计表';

DROP TABLE IF EXISTS `mfa_account_factor_cfg`;
CREATE TABLE `mfa_account_factor_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `account` varchar(1024) DEFAULT NULL COMMENT '帐号名',
  `type` int(11) DEFAULT NULL COMMENT '类型：1黑名单，0是白名单',
  `user_type` varchar(50) DEFAULT NULL COMMENT 'individual:个人,role:角色',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `org_id` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='帐号策略表';

DROP TABLE IF EXISTS `mfa_city_latlng`;
CREATE TABLE `mfa_city_latlng` (
  `government` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `N` varchar(255) DEFAULT NULL,
  `E` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`government`,`city`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='城市经纬度';

DROP TABLE IF EXISTS `mfa_date_factor_cfg`;
CREATE TABLE `mfa_date_factor_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后的更新日期',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `date_type` int(4) DEFAULT NULL COMMENT '0:每天，1:每周，2:每月，3:每年',
  `date_range` varchar(1024) DEFAULT NULL COMMENT '日期范围，比如周一至周五，或者某天',
  `holiday` int(4) DEFAULT NULL COMMENT '法定节假日，勾选：1，不选：0',
  `repeat_period` varchar(50) DEFAULT NULL COMMENT '是否重复，每日，每周，每天，每年',
  `time_range_start` varchar(50) DEFAULT NULL COMMENT '开始时间',
  `time_range_end` varchar(50) DEFAULT NULL COMMENT '结束时间',
  `legal_flag` int(4) DEFAULT NULL COMMENT '1：放行，0：限制',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `name_desc` varchar(100) DEFAULT NULL COMMENT '名称描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='日期策略表';

DROP TABLE IF EXISTS `mfa_device_factor_cfg`;
CREATE TABLE `mfa_device_factor_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `device_type` int(2) DEFAULT '1' COMMENT '是否开启设备类型，0: 关闭，1：开启',
  `login_ip` int(2) DEFAULT NULL COMMENT '是否开启登录ip，0: 关闭，1：开启',
  `browser_type` int(2) DEFAULT NULL COMMENT '是否开启浏览器类型，0: 关闭，1：开启',
  `device_printer` int(2) DEFAULT NULL COMMENT '是否开启设备指纹，0: 关闭，1：开启',
  `first_login` int(2) DEFAULT '0' COMMENT '是否是首次登录，0: 关闭，1：开启',
  `first_bio_verified` int(2) DEFAULT NULL COMMENT '是否是首次生物认证,0: 关闭，1：开启',
  `device_in_days` int(2) DEFAULT NULL COMMENT '是否开启天数使用最多的设备，0: 关闭，1：开启',
  `device_in_times` int(2) DEFAULT NULL COMMENT '是否开启次数使用最多的设备，0: 关闭，1：开启',
  `trusted_device_in_days` int(20) DEFAULT '0' COMMENT '设置最近天数大于阈值的可信设备',
  `trusted_device_in_times` int(20) DEFAULT '0' COMMENT '设置使用次数大于阈值的可信设备',
  `allow_multi_device_login` int(2) DEFAULT NULL COMMENT '是否开启多设备登录，0: 关闭，1：开启',
  `not_allow_multi_device_login` varchar(50) DEFAULT '' COMMENT 'replacefirstdevice:替换第一个设备，stopseconddevice:阻止第二个设备',
  `not_distinguish_moblie_or_pc` int(2) DEFAULT NULL COMMENT '是否开启不区分移动或PC, 0: 关闭，1：开启',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `quarantine_expire_status` int(4) DEFAULT '0' COMMENT '隔离区失效开关',
  `trust_expire_status` int(4) DEFAULT '0' COMMENT '信任区失效开关',
  `quarantine_space` int(4) DEFAULT '30' COMMENT '隔离区有效时间',
  `trust_space` int(4) DEFAULT '30' COMMENT '信任区数据有效时间',
  `required_device_printer` int(2) DEFAULT '0' COMMENT '设备号是否必需',
  `is_auto_renew` int(2) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='常用设备策略表';

DROP TABLE IF EXISTS `mfa_device_login_record_history`;
CREATE TABLE `mfa_device_login_record_history` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `device_name` varchar(64) DEFAULT NULL COMMENT '设备名称',
  `device_type` int(2) DEFAULT NULL COMMENT '设备类型：1虚拟化设备，2网络设备 3VPN 4防火墙 5堡垒机',
  `step_verrify` varchar(36) DEFAULT NULL COMMENT '首次/二次认证',
  `verify_type` int(2) DEFAULT NULL COMMENT '认证方式：1 静态密码 2 动态口令 3 密码和口令组合 5 短信验证码, 6 钉钉令牌',
  `login_status` int(2) DEFAULT '0' COMMENT '登录状态 0:失败 1:成功',
  `login_ip` varchar(36) DEFAULT NULL COMMENT '客户端登录ip(客户端IP)',
  `device_ip` varchar(1024) DEFAULT NULL COMMENT '硬件设备ip(服务端IP)',
  `login_time` datetime DEFAULT NULL COMMENT '登录时间',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `city` varchar(64) DEFAULT NULL COMMENT '来源城市',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `role_names` varchar(200) DEFAULT NULL COMMENT '用户角色名称',
  `org_ids` varchar(200) DEFAULT NULL COMMENT '用户组织id',
  `user_type_names` varchar(200) DEFAULT NULL COMMENT '用户类型',
  `job_codes` varchar(200) DEFAULT NULL COMMENT '用户岗位编码',
  `group_names` varchar(200) DEFAULT NULL COMMENT '用户分组名称',
  `verify_protocol` varchar(30) DEFAULT NULL COMMENT '认证协议',
  `fail_reason` varchar(200) DEFAULT NULL COMMENT '失败原因',
  `auth_protocol` varchar(30) DEFAULT NULL COMMENT '认证协议：PAP,MschapV2',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `mfa_device_server_ip_detail`;
CREATE TABLE `mfa_device_server_ip_detail` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `device_verify_id` varchar(64) DEFAULT NULL COMMENT '设备认证id',
  `ip_value` varchar(64) DEFAULT NULL COMMENT '服务端iP地址',
  `num_start` bigint(10) DEFAULT NULL,
  `num_end` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='设备服务端ip表';

DROP TABLE IF EXISTS `mfa_device_verified_server_ip_detail`;
CREATE TABLE `mfa_device_verified_server_ip_detail` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `device_verify_id` varchar(64) DEFAULT NULL COMMENT '设备认证id',
  `ip_value` varchar(64) DEFAULT NULL COMMENT '服务端iP地址',
  `num_start` bigint(10) DEFAULT NULL,
  `num_end` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='设备服务端ip表';

DROP TABLE IF EXISTS `mfa_device_verify`;
CREATE TABLE `mfa_device_verify` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的修改者',
  `device_name` varchar(64) DEFAULT NULL COMMENT '策略名称',
  `device_type` int(2) DEFAULT NULL COMMENT '类型：1虚拟化设备，2网络设备 3VPN 4防火墙 5堡垒机',
  `shard_key` varchar(64) DEFAULT NULL COMMENT '共享密钥',
  `server_ip` varchar(1024) DEFAULT NULL COMMENT '服务端ip地址',
  `verify_type` int(2) DEFAULT NULL COMMENT '认证方式：1 静态密码 2 动态口令 3 密码和口令组合 4 密码+动态口令',
  `second_verify_status` int(2) DEFAULT '0' COMMENT '二次认证是否开启：0 否， 1是',
  `second_verify_type` int(2) DEFAULT NULL COMMENT '二次认证方式：null 无二次认证， 5：短信验证码， 2：动态口令',
  `auto_send_sms` int(2) DEFAULT '0' COMMENT '自动发送短信 0否 1是',
  `device_status` int(2) DEFAULT NULL COMMENT '状态',
  `user_type` varchar(50) DEFAULT NULL COMMENT 'allusers:所有用户,individual:个人,role:角色,usertype:用户类型,org:组织,job:岗位',
  `device_value` varchar(1024) DEFAULT NULL COMMENT '根据用户类型存的值',
  `org_id` varchar(1024) DEFAULT NULL COMMENT '组织id',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `first_user_type` varchar(50) DEFAULT NULL COMMENT '准入策略-用户类型',
  `device_first_value` varchar(1024) DEFAULT NULL COMMENT '准入策略-根据用户类型存放的值',
  `first_org_id` varchar(1024) DEFAULT NULL COMMENT '准入策略-组织id',
  `auto_send_dd_token` int(2) DEFAULT NULL COMMENT '自动发送钉钉令牌：0 不自动发送，1 自动发送',
  `verify_protocol` varchar(30) DEFAULT NULL COMMENT '3a协议：Radius,Tacacs',
  `auth_protocol` varchar(30) DEFAULT NULL COMMENT '认证协议：PAP,MschapV2',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `namecheck` (`device_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='设备认证表';

DROP TABLE IF EXISTS `mfa_field_mapping`;
CREATE TABLE `mfa_field_mapping` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新',
  `language` varchar(20) DEFAULT NULL COMMENT '语言类型，en/cn',
  `keyword` varchar(64) DEFAULT NULL COMMENT '关键字',
  `mapping_value` varchar(255) DEFAULT NULL COMMENT '映射字段',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='国际化和字段映射表';

DROP TABLE IF EXISTS `mfa_general_strategy_schema`;
CREATE TABLE `mfa_general_strategy_schema` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `strategy_type` int(2) DEFAULT NULL COMMENT '用于标识初始化数据策略类型：0：常规策略，1：IDA策略，2：应用策略',
  `second_level_type` varchar(50) DEFAULT NULL COMMENT '二级类型：触发风险策略，增强认证方式等',
  `sort` double(10,2) DEFAULT NULL COMMENT '排序字段',
  `status` int(2) DEFAULT NULL COMMENT '表示当前行配置是否启用：1：启用，0：禁用',
  `schema_key` varchar(64) DEFAULT NULL COMMENT '属性名',
  `default_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `value` text COMMENT '实际值',
  `login_method` varchar(64) DEFAULT NULL COMMENT '常用登录:commonAuth,互联网登录:webInternetAuth,互联网验证码登录:webCodeAuth,安全登录:secureAuth,移动APP相关登录:mobileAuth',
  `priority` int(10) DEFAULT NULL COMMENT '风险评估优先级',
  `type` int(4) DEFAULT NULL COMMENT '类型：1字符串，2整型，3复选，4单选',
  `required` int(4) DEFAULT NULL COMMENT '1必填，0不必填',
  `schema_range` text COMMENT '限定范围',
  `ruleid` varchar(36) DEFAULT NULL COMMENT '关联规则策略表的uuid',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `plugin_id` bigint(20) DEFAULT NULL COMMENT '插件id',
  `icon` text COMMENT '图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通用策略schema表，用来存储和定义常规策略，IDA策略和应用策略';

DROP TABLE IF EXISTS `mfa_ip_factor_cfg`;
CREATE TABLE `mfa_ip_factor_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `ip_value` varchar(50) DEFAULT NULL COMMENT '单个ip或ip段',
  `value_type` int(4) DEFAULT NULL COMMENT '1: 单个ip， 2：ip段',
  `risk_type` int(4) DEFAULT NULL COMMENT '黑名单：1，白名单：2， 灰名单：3',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `num_start` bigint(10) DEFAULT NULL,
  `num_end` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='常用ip策略表';

DROP TABLE IF EXISTS `mfa_login_analyze`;
CREATE TABLE `mfa_login_analyze` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名称',
  `role_names` varchar(1024) DEFAULT NULL COMMENT '角色',
  `job_codes` varchar(1024) DEFAULT NULL COMMENT '岗位编码',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `org_names` varchar(1024) DEFAULT NULL COMMENT '组织名称',
  `user_type_names` varchar(1024) DEFAULT NULL COMMENT '用户类型名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `mfa_login_factor_cfg`;
CREATE TABLE `mfa_login_factor_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建日期',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新日期',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `login_account` int(2) DEFAULT '1' COMMENT '登录帐户是否启用：启动1，禁用0',
  `login_time` int(2) DEFAULT '1' COMMENT '登陆时间是否启用：启动1，禁用0',
  `login_status` int(2) DEFAULT '1' COMMENT '登录状态是否启用：启动1，禁用0',
  `auth_type` int(2) DEFAULT '1' COMMENT '登录认证方式，密码，人脸等，是否启用：启动1，禁用0',
  `mobile_number` int(2) DEFAULT NULL COMMENT '登录手机号是否启用：启动1，禁用0',
  `device_type` int(2) DEFAULT '1' COMMENT '设备类型是否启用：启动1，禁用0',
  `city` int(2) DEFAULT NULL COMMENT '登录城市是否启用：启动1，禁用0',
  `login_ip` int(2) DEFAULT '1' COMMENT '登录ip是否启用：启动1，禁用0',
  `browser_type` int(2) DEFAULT '0' COMMENT '浏览器类型是否启用：启动1，禁用0',
  `user_agent` int(2) DEFAULT '0' COMMENT '是否启用：启动1，禁用0',
  `device_printer` int(2) DEFAULT '0' COMMENT '设备指纹是否启用：启动1，禁用0',
  `location_info` int(2) DEFAULT '0' COMMENT '经纬度策略是否启用：启动1，禁用0',
  `request_application` int(2) DEFAULT '0' COMMENT '访问应用是否启用：启动1，禁用0',
  `application_account` int(2) DEFAULT '0' COMMENT '应用帐号是否启用：启动1，禁用0',
  `risk_trigger` int(2) DEFAULT '1' COMMENT '触发策略是否启用：启动1，禁用0',
  `trust_trigger` int(2) DEFAULT '0' COMMENT '触发信任是否启用：启动1，禁用0',
  `valid_date` int(6) DEFAULT '0' COMMENT '登录信息保存有效期',
  `extended_valid_date` int(6) DEFAULT '0' COMMENT '无数据用户顺延时间',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='登陆因子策略表';

DROP TABLE IF EXISTS `mfa_login_record_history`;
CREATE TABLE `mfa_login_record_history` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '登录记录创建时间',
  `username` varchar(50) DEFAULT NULL COMMENT '登录用户名',
  `login_account` varchar(50) DEFAULT NULL COMMENT '登录帐户',
  `login_time` datetime DEFAULT NULL COMMENT '此次登录时间',
  `login_status` int(2) DEFAULT NULL COMMENT '登录状态描述，1 成功，0 失败',
  `auth_type` varchar(50) DEFAULT NULL COMMENT '登录认证方式，1-密码，2-人脸 3-指纹 4-微信扫码',
  `mobile_number` varchar(20) DEFAULT NULL COMMENT '手机号信息',
  `device_abbreviate` varchar(50) DEFAULT NULL COMMENT '设备简称',
  `device_type` varchar(50) DEFAULT NULL COMMENT '登录设备类型 1-windows 2-mac 3-Android  4-ios',
  `login_ip` varchar(50) DEFAULT NULL COMMENT '登录ip地址',
  `city` varchar(50) DEFAULT NULL,
  `browser_type` varchar(50) DEFAULT NULL COMMENT '浏览器类型 1-IE 2-Firefox 3-Chrome 4-Safari',
  `user_agent` varchar(1000) DEFAULT NULL,
  `device_printer` varchar(255) DEFAULT NULL COMMENT '设备号-设备唯一标识',
  `longitude` double(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` double(10,7) DEFAULT NULL COMMENT '纬度',
  `protocol` varchar(50) DEFAULT NULL COMMENT '应用帐号跳转协议',
  `request_application` varchar(50) DEFAULT NULL COMMENT '请求应用',
  `application_account` varchar(50) DEFAULT NULL COMMENT '应用帐户',
  `valid_date` int(6) DEFAULT NULL COMMENT '此条登录记录有效期',
  `risk_trigger` varchar(255) DEFAULT NULL COMMENT '触发的风险策略描述：异常设备，ip',
  `trust_trigger` varchar(50) DEFAULT NULL COMMENT '触发信任描述：可信登录记录',
  `online_status` int(2) DEFAULT NULL COMMENT '0:失效.1:在线',
  `updated_at` datetime DEFAULT NULL,
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `password` varchar(200) DEFAULT NULL COMMENT '登陆输入密码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `login_account` (`login_account`) USING BTREE COMMENT '可以针对账户进行索引',
  KEY `idx_username` (`username`) USING BTREE COMMENT 'selfcare访问日志查询'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='登录记录历史表，用来存储各登录记录';

DROP TABLE IF EXISTS `mfa_multiple_devices_cfg`;
CREATE TABLE `mfa_multiple_devices_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `name` varchar(50) DEFAULT NULL COMMENT '多设备名称',
  `allow_multi_device_login` int(2) DEFAULT NULL COMMENT '是否开启多设备登录，0: 关闭，1：开启',
  `not_allow_multi_device_login` varchar(50) DEFAULT '' COMMENT 'replacefirstdevice:替换第一个设备，stopseconddevice:阻止第二个设备',
  `not_distinguish_moblie_or_pc` int(2) DEFAULT NULL COMMENT '是否开启不区分移动或PC, 0: 关闭，1：开启',
  `user_type` varchar(50) DEFAULT NULL COMMENT 'allusers:所有用户,individual:个人,role:角色',
  `value` varchar(1024) DEFAULT NULL COMMENT '根据用户类型存的值',
  `devices_level` int(4) DEFAULT NULL COMMENT '级别',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `org_id` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `namecheck` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='常用ip策略表';

DROP TABLE IF EXISTS `mfa_network_factor_cfg`;
CREATE TABLE `mfa_network_factor_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `name` varchar(50) DEFAULT NULL COMMENT '名称：内网1，内网2，外网1',
  `ip_value` varchar(255) DEFAULT NULL COMMENT 'ip记录，ip段或单个ip',
  `value_type` int(2) DEFAULT NULL COMMENT '1: 单个ip，2：ip段',
  `network_type` int(4) DEFAULT NULL COMMENT 'ip网段类型：0：内网，1：外网',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `num_start` bigint(10) DEFAULT NULL,
  `num_end` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `namecheck` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='内外网络ip策略表';

DROP TABLE IF EXISTS `mfa_operation_record_history`;
CREATE TABLE `mfa_operation_record_history` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `operation_name` varchar(64) DEFAULT NULL COMMENT '操作名称',
  `operation_url` varchar(1024) DEFAULT NULL COMMENT '操作路径',
  `operation_parameter` longtext COMMENT '操作参数',
  `operation_method` varchar(32) DEFAULT NULL COMMENT '操作方式',
  `ip` varchar(50) DEFAULT NULL COMMENT 'ip',
  `device_type` varchar(50) DEFAULT NULL COMMENT '操作系统类型',
  `device_number` varchar(50) DEFAULT NULL COMMENT '设备号',
  `browser_type` varchar(50) DEFAULT NULL COMMENT '浏览器类型',
  `longitude` double(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` double(10,7) DEFAULT NULL COMMENT '纬度',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户操作记录表';

DROP TABLE IF EXISTS `mfa_os_login_record`;
CREATE TABLE `mfa_os_login_record` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `device_id` varchar(200) DEFAULT NULL COMMENT '设备ID(GUID+Mac地址)',
  `client_ip` varchar(64) DEFAULT NULL COMMENT '客户端IP',
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `login_status` int(1) DEFAULT NULL COMMENT '登录状态',
  `verify_step` varchar(64) DEFAULT NULL COMMENT '首次(first)/二次(second) 认证',
  `verify_method` varchar(64) DEFAULT NULL COMMENT '认证方式',
  `user_infos` varchar(2000) DEFAULT NULL COMMENT '用户身份信息 json字符串(组织、组、用户分类)',
  `os_info` varchar(64) DEFAULT NULL COMMENT '操作系统',
  `fail_reason` varchar(64) DEFAULT NULL COMMENT '失败原因',
  `login_time` datetime DEFAULT NULL COMMENT '登陆时间',
  `online_status` int(2) DEFAULT NULL COMMENT '在线状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作系统访问记录';

DROP TABLE IF EXISTS `mfa_os_verify_detail`;
CREATE TABLE `mfa_os_verify_detail` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `second_level_type` varchar(50) DEFAULT NULL COMMENT '二级类型：触发风险策略，增强认证方式等',
  `sort` double(10,2) DEFAULT NULL COMMENT '排序字段',
  `status` int(2) DEFAULT NULL COMMENT '表示当前行配置是否启用：1：启用，0：禁用',
  `schema_key` varchar(64) DEFAULT NULL COMMENT '属性名',
  `default_value` varchar(255) DEFAULT NULL COMMENT '默认值',
  `value` text COMMENT '实际值',
  `login_method` varchar(64) DEFAULT NULL COMMENT '常用登录:commonAuth,互联网登录:webInternetAuth,互联网验证码登录:webCodeAuth,安全登录:secureAuth,移动APP相关登录:mobileAuth',
  `type` int(4) DEFAULT NULL COMMENT '类型：1字符串，2整型，3复选，4单选 ,5 单个ip ,6,ip段 ',
  `ruleid` varchar(36) DEFAULT NULL COMMENT '关联操作系统二次认证策略的uuid',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `schema_range` varchar(600) DEFAULT NULL COMMENT '取值范围',
  `required` int(2) DEFAULT NULL COMMENT '是否必填',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='os认证详细信息数据';

DROP TABLE IF EXISTS `mfa_os_verify_rules`;
CREATE TABLE `mfa_os_verify_rules` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `rule_name` varchar(400) DEFAULT NULL COMMENT '规则名称',
  `status` int(2) DEFAULT NULL COMMENT '是否启用：1：启用 0：禁用',
  `rule_level` int(2) DEFAULT NULL COMMENT '级别',
  `description` varchar(400) DEFAULT NULL COMMENT '规则描述',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `security_key` varchar(400) DEFAULT NULL COMMENT '安全密钥',
  `second_verify_status` int(2) DEFAULT NULL COMMENT '二次认证开关',
  `network_type` int(2) DEFAULT NULL COMMENT '网络类型: 1所有网络，2 自定义添加',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `namecheck` (`rule_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作系统二次认证策略';

DROP TABLE IF EXISTS `mfa_quarantine_area`;
CREATE TABLE `mfa_quarantine_area` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后修改者',
  `triggered_risk` varchar(50) DEFAULT NULL COMMENT '异地登录风险',
  `illegal_info` varchar(64) DEFAULT NULL COMMENT '异常信息：在美国登录',
  `name` varchar(512) DEFAULT NULL,
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `expire_date` date DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='隔离区名单表';

DROP TABLE IF EXISTS `mfa_risk_rule_list`;
CREATE TABLE `mfa_risk_rule_list` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `rule_name` varchar(64) DEFAULT NULL COMMENT '规则名称',
  `status` int(2) DEFAULT NULL COMMENT '是否启用：1：启用 0：禁用',
  `rule_level` int(2) DEFAULT NULL COMMENT '级别',
  `description` varchar(255) DEFAULT NULL COMMENT '规则描述',
  `type` int(2) DEFAULT NULL COMMENT '策略类型：常规：0，IDA：1，应用：2',
  `bind_status` int(4) DEFAULT '0' COMMENT '动态策略绑定状态',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `bind_screen_status` int(2) DEFAULT '0' COMMENT '是否绑定风险大屏',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `namecheck` (`rule_name`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='风险策略列表';

DROP TABLE IF EXISTS `mfa_trust_area`;
CREATE TABLE `mfa_trust_area` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `name` varchar(512) DEFAULT NULL COMMENT '用户名',
  `triggered_trust` varchar(255) DEFAULT NULL COMMENT '触发信任:常用设备，常用ip',
  `trust_info` varchar(255) DEFAULT NULL COMMENT '信任信息：两次人脸识别，两次指纹识别',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `expire_date` date DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='常用ip策略表';

DROP TABLE IF EXISTS `mfa_ueba_link_user`;
CREATE TABLE `mfa_ueba_link_user` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `user_scope` varchar(36) NOT NULL COMMENT '用户适用范围类型',
  `name` varchar(255) DEFAULT NULL COMMENT '数据',
  `data_id` varchar(255) DEFAULT NULL COMMENT '数据id',
  `rule_id` varchar(36) NOT NULL COMMENT '策略id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='UEBA策略关联用户表';

DROP TABLE IF EXISTS `mfa_ueba_risk_rule`;
CREATE TABLE `mfa_ueba_risk_rule` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `name` varchar(64) NOT NULL COMMENT '策略名称',
  `status` tinyint(1) NOT NULL COMMENT '表示当前行配置是否启用：1：启用，0：禁用',
  `embed` tinyint(1) NOT NULL COMMENT '内置',
  `level` int(11) NOT NULL COMMENT '优先级',
  `remark` varchar(256) DEFAULT NULL COMMENT '描述',
  `user_scope` varchar(255) NOT NULL COMMENT '用户适用范围类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='UEBA策略表';

DROP TABLE IF EXISTS `mfa_ueba_scence`;
CREATE TABLE `mfa_ueba_scence` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后的更新者',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `scence` varchar(255) NOT NULL COMMENT '场景',
  `type` varchar(255) NOT NULL COMMENT 'DEFAULT|CUSTOM',
  `intercept_lower` int(11) DEFAULT NULL COMMENT '拦截下限',
  `intercept_upper` int(11) DEFAULT NULL COMMENT '拦截上限',
  `intercept_status` tinyint(1) NOT NULL COMMENT '拦截状态',
  `enhance_lower` int(11) DEFAULT NULL COMMENT '二次认证下限',
  `enhance_upper` int(11) DEFAULT NULL COMMENT '二次认证上限',
  `enhance_status` tinyint(1) NOT NULL COMMENT '二次认证状态',
  `rule_id` varchar(36) NOT NULL COMMENT '策略id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='UEBA策略-场景表';

DROP TABLE IF EXISTS `mfa_verified_factor_level_cfg`;
CREATE TABLE `mfa_verified_factor_level_cfg` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updated_at` datetime DEFAULT NULL COMMENT '最后更新时间',
  `last_modifier` varchar(50) DEFAULT NULL COMMENT '最后更新者',
  `verify_name` varchar(64) DEFAULT NULL COMMENT '认证名称（key），显示名对应cfg',
  `verified_level` int(4) DEFAULT NULL COMMENT '级别',
  `login_method` varchar(64) DEFAULT NULL COMMENT '常用登录:commonAuth,互联网登录:webInternetAuth,互联网验证码登录:webCodeAuth,安全登录:secureAuth,移动APP相关登录:mobileAuth',
  `flag` int(4) DEFAULT NULL COMMENT '是否启用',
  `icon` text COMMENT '图标',
  `plugin_id` bigint(20) DEFAULT NULL COMMENT '插件ID',
  `attribute` varchar(255) DEFAULT NULL COMMENT '增加认证扩展属性',
  `detail_attribute` varchar(5001) DEFAULT NULL COMMENT '增加认证扩展属性',
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `detail_update_time` datetime DEFAULT NULL COMMENT '动态口令更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_plugin_id` (`plugin_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='认证配置表';

DROP TABLE IF EXISTS `notify_config`;
CREATE TABLE `notify_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `fun_code` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '功能类型编码',
  `targets` text CHARACTER SET utf8mb4 COMMENT '通知人',
  `time_start` varchar(25) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '通知时机-开始',
  `time_end` varchar(25) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '通知时机-结束',
  `send_type` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '发送类型（1 即时发送2 定时发送）',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态',
  `creator` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_fun_code` (`fun_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知配置表';

DROP TABLE IF EXISTS `notify_dynamic_leader`;
CREATE TABLE `notify_dynamic_leader` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `dynamic_leader_category_id` varchar(36) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '函数分类id',
  `name` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  `bean_name` varchar(100) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '计算程序的bean',
  `bean_parameter` varchar(1000) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '计算程序的参数',
  `is_multiple` tinyint(2) DEFAULT NULL COMMENT '是否返回多值 1返回 0不返回',
  `order_num` varchar(20) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '排序号',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `eid` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知接收人动态查找配置表';

DROP TABLE IF EXISTS `notify_dynamic_leader_category`;
CREATE TABLE `notify_dynamic_leader_category` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '分类名称',
  `code` varchar(50) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '分类编码',
  `order_num` mediumint(20) DEFAULT NULL COMMENT '排序号',
  `remark` varchar(200) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知接收人动态查找配置表';

DROP TABLE IF EXISTS `notify_function`;
CREATE TABLE `notify_function` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` tinyint(2) DEFAULT NULL COMMENT '通知类型 1:idm 2:外部的',
  `fun_code` varchar(100) DEFAULT NULL COMMENT '功能编码',
  `fun_name` varchar(50) DEFAULT NULL COMMENT '功能名称',
  `template_tip` varchar(3000) DEFAULT NULL COMMENT '通知模板内容提示',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1启用，0停用',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知埋点功能配置表';

DROP TABLE IF EXISTS `notify_function_provider_link`;
CREATE TABLE `notify_function_provider_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `fun_code` varchar(255) NOT NULL COMMENT '通知策略编码',
  `provider_id` bigint(20) NOT NULL COMMENT '通知接口ID',
  `creator` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `provider_id_idx` (`provider_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知策略-通知接口关联表';

DROP TABLE IF EXISTS `notify_provider`;
CREATE TABLE `notify_provider` (
  `id` bigint(20) unsigned NOT NULL COMMENT '主键',
  `notify_mode` varchar(16) DEFAULT NULL COMMENT '通知方式。邮件：email，短信：sms，微信：wechat，企业微信：workwechat，钉钉：dingding，其他：other',
  `notify_mode_type` varchar(255) DEFAULT NULL COMMENT '通知接口类型',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `plugin_mgmt_id` bigint(20) DEFAULT NULL COMMENT '通知插件ID',
  `provider_bean_name` varchar(255) DEFAULT NULL COMMENT '通知接口实现类的BeanName',
  `config_json` varchar(3000) DEFAULT NULL COMMENT '配置json串',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1启用，0停用',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知供应商配置表';

DROP TABLE IF EXISTS `notify_template`;
CREATE TABLE `notify_template` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `fun_code` varchar(50) DEFAULT NULL COMMENT '功能编码',
  `provider_id` bigint(20) DEFAULT NULL COMMENT '通知接口实例ID',
  `template_locale` varchar(50) DEFAULT NULL COMMENT '国际化语言',
  `template_content` text COMMENT '模板内容',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='通知模版表';

DROP TABLE IF EXISTS `notify_timer_send`;
CREATE TABLE `notify_timer_send` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `fun_code` varchar(50) DEFAULT NULL COMMENT '功能类型编码',
  `provider_id` bigint(20) DEFAULT NULL COMMENT '消息提供商id',
  `notify_mode` varchar(100) DEFAULT NULL COMMENT '通知方式(email,sms,dingding等)',
  `notify_number` varchar(200) DEFAULT NULL COMMENT '通知对象（邮箱，手机号，钉钉号）',
  `content` longtext COMMENT '短信内容',
  `status` smallint(2) DEFAULT NULL COMMENT '发送状态（1：未发送 | 2：发送完成 | 3：发送失败）',
  `message` varchar(1024) DEFAULT NULL COMMENT '消息内容',
  `send_fail_times` smallint(11) DEFAULT NULL COMMENT '已发送失败次数',
  `remark` varchar(512) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_fun_code_fail_times` (`fun_code`,`status`,`send_fail_times`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC COMMENT='通知发送任务表';

DROP TABLE IF EXISTS `pap_sync_data_field`;
CREATE TABLE `pap_sync_data_field` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `column_name` varchar(255) DEFAULT NULL COMMENT '列名',
  `alias_name` varchar(255) DEFAULT NULL COMMENT '下推字段别名 默认为字段的驼峰标识',
  `data_type` varchar(255) DEFAULT NULL COMMENT '数据类型 text number select dateTime date tree treelink searchlink',
  `max_length` varchar(20) DEFAULT NULL COMMENT '最大长度',
  `i18n_code` varchar(255) DEFAULT NULL COMMENT '枚举类code',
  `select_id_type` varchar(255) DEFAULT NULL COMMENT 'data_type为select时 select下拉值类型',
  `mult_flag` smallint(2) DEFAULT NULL COMMENT '是否多选 1多选 0单选',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据下推同步字段配置表';

DROP TABLE IF EXISTS `permission_recommend_link`;
CREATE TABLE `permission_recommend_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `strategy_id` bigint(20) NOT NULL COMMENT '策略id',
  `limit_job_org_id` bigint(20) DEFAULT NULL COMMENT '推荐目标-限制岗位所在组织id',
  `limit_org_id` bigint(20) DEFAULT NULL COMMENT '关联组织id',
  `limit_job_id` bigint(20) DEFAULT NULL COMMENT '关联岗位id',
  `limit_group_id` bigint(20) DEFAULT NULL COMMENT '关联用户分组id',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_strategy_id` (`strategy_id`) USING BTREE,
  KEY `index_limit_job_org_id` (`limit_job_org_id`) USING BTREE,
  KEY `index_limit_org_id` (`limit_org_id`) USING BTREE,
  KEY `index_limit_job_id` (`limit_job_id`) USING BTREE,
  KEY `index_limit_group_id` (`limit_group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限推荐目标关联表';

DROP TABLE IF EXISTS `permission_recommend_strategy`;
CREATE TABLE `permission_recommend_strategy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '策略名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态: 0停用，1启用',
  `remark` varchar(600) DEFAULT NULL COMMENT '备注',
  `target_type` tinyint(2) NOT NULL COMMENT '推荐目标选择方式:1不限制,2按所在组织选择,3按人员岗位选择,4按人员分组选择',
  `rule` tinyint(2) NOT NULL COMMENT '权限推荐规则:1按权限分布占比推荐,2按人员相似度推荐,3按权限关联性推荐',
  `same_org` tinyint(2) DEFAULT NULL COMMENT '是否同组织: 0否，1是',
  `org_child` tinyint(2) DEFAULT NULL COMMENT '是否包含子: 0否，1是',
  `trace_org` tinyint(2) DEFAULT NULL COMMENT '是否追溯上级组织: 0否，1是',
  `trace_org_level` tinyint(4) DEFAULT NULL COMMENT '追溯级别',
  `same_job` tinyint(2) DEFAULT NULL COMMENT '是否同岗位: 0否，1是',
  `same_group` tinyint(2) DEFAULT NULL COMMENT '是否同用户分组: 0否，1是',
  `scope_person_rule` tinyint(2) DEFAULT NULL COMMENT '人员范围满足条件:1必须同时满足以上条件,2满足任意一条即可',
  `matching_rate` tinyint(3) NOT NULL COMMENT '推荐匹配度值100以内',
  `policy_analysis` varchar(600) NOT NULL COMMENT '策略解析描述',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限推荐策略表';

DROP TABLE IF EXISTS `pi_app_defsso_template`;
CREATE TABLE `pi_app_defsso_template` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(25) DEFAULT NULL COMMENT '应用名称',
  `res_type` varchar(64) DEFAULT NULL COMMENT '内置应用的resType值',
  `inner_service` text COMMENT 'json模版',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态：1有效 0无效',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用自定义sso配置表';

DROP TABLE IF EXISTS `pi_device`;
CREATE TABLE `pi_device` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `deviceid` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `type` varchar(64) DEFAULT NULL,
  `isdefault` int(11) DEFAULT NULL,
  `eid` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='设备表';

DROP TABLE IF EXISTS `pi_domain`;
CREATE TABLE `pi_domain` (
  `id` varchar(255) NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='租户表';

DROP TABLE IF EXISTS `pi_profile`;
CREATE TABLE `pi_profile` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `appType` varchar(255) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `createUser` varchar(255) DEFAULT NULL,
  `groupname` varchar(255) DEFAULT NULL,
  `items` text,
  `model` int(11) DEFAULT NULL,
  `modifyTime` datetime DEFAULT NULL,
  `modifyUser` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `vars` text,
  `version` varchar(255) DEFAULT NULL,
  `application` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `application` (`application`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='ESSO上传profile配置表';

DROP TABLE IF EXISTS `pi_resourcelabel`;
CREATE TABLE `pi_resourcelabel` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `display` varchar(255) NOT NULL,
  `locale` varchar(255) NOT NULL,
  `RESOURCE_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `U_P_RSLBL_RESOURCE_ID` (`RESOURCE_ID`,`locale`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pi_selfcare`;
CREATE TABLE `pi_selfcare` (
  `pi_idmuserId` varchar(255) NOT NULL,
  `content` text,
  `createTime` datetime DEFAULT NULL,
  `createUser` varchar(255) DEFAULT NULL,
  `modifyTime` datetime DEFAULT NULL,
  `modifyUser` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pi_idmuserId`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SELFCARE图标分组配置表';

DROP TABLE IF EXISTS `pi_sp_saml_metadata`;
CREATE TABLE `pi_sp_saml_metadata` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `content` blob COMMENT 'metadata文件',
  `sp_id` varchar(255) DEFAULT NULL COMMENT ' 三方sp主键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='第三方认证源sp metadata文件存储表';

DROP TABLE IF EXISTS `pi_sso_apikey`;
CREATE TABLE `pi_sso_apikey` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `attributes` varchar(255) DEFAULT NULL COMMENT '属性',
  `creationDate` datetime DEFAULT NULL COMMENT '创建日期',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `effectiveDuration` bigint(20) DEFAULT NULL COMMENT '有效期',
  `expireDate` bigint(20) DEFAULT NULL COMMENT '过期时间',
  `inSystem` smallint(4) DEFAULT NULL COMMENT '是否系统内置',
  `lastChangeDate` datetime DEFAULT NULL COMMENT '最后修改时间',
  `lastModifier` varchar(255) DEFAULT NULL COMMENT '最后修改人',
  `secret` varchar(255) DEFAULT NULL COMMENT '密钥',
  `status` smallint(4) DEFAULT NULL COMMENT '状态',
  `type` varchar(255) DEFAULT NULL COMMENT '类型',
  `uid` varchar(255) DEFAULT NULL COMMENT '用户ID',
  `urls` longtext COMMENT '接口地址集合',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `whitelist` varchar(255) DEFAULT NULL COMMENT '白名单列表',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Api权限控制表';

DROP TABLE IF EXISTS `pi_sso_application_record`;
CREATE TABLE `pi_sso_application_record` (
  `id` varchar(36) NOT NULL DEFAULT '' COMMENT 'uuid',
  `created_at` datetime DEFAULT NULL COMMENT '登录记录创建时间',
  `username` varchar(50) DEFAULT NULL COMMENT '登录用户名',
  `login_account` varchar(50) DEFAULT NULL COMMENT '登录帐户',
  `login_time` datetime DEFAULT NULL COMMENT '此次登录时间',
  `login_status` int(2) DEFAULT NULL COMMENT '登录状态描述，1 成功，0 失败',
  `auth_type` varchar(50) DEFAULT NULL COMMENT '登录认证方式，1-密码，2-人脸 3-指纹 4-微信扫码',
  `mobile_number` varchar(20) DEFAULT NULL COMMENT '手机号信息',
  `device_abbreviate` varchar(50) DEFAULT NULL COMMENT '设备简称',
  `device_type` varchar(50) DEFAULT NULL COMMENT '登录设备类型 1-windows 2-mac 3-Android  4-ios',
  `login_ip` varchar(50) DEFAULT NULL COMMENT '登录ip地址',
  `city` varchar(50) DEFAULT NULL,
  `browser_type` varchar(50) DEFAULT NULL COMMENT '浏览器类型 1-IE 2-Firefox 3-Chrome 4-Safari',
  `user_agent` varchar(255) DEFAULT NULL COMMENT 'user agent',
  `device_printer` varchar(255) DEFAULT NULL COMMENT '设备号-设备唯一标识',
  `longitude` double(10,7) DEFAULT NULL COMMENT '经度',
  `latitude` double(10,7) DEFAULT NULL COMMENT '纬度',
  `protocol` varchar(50) DEFAULT NULL COMMENT '应用帐号跳转协议',
  `request_application` varchar(50) DEFAULT NULL COMMENT '请求应用',
  `application_account` varchar(50) DEFAULT NULL COMMENT '应用帐户',
  `valid_date` int(6) DEFAULT NULL COMMENT '此条登录记录有效期',
  `fail_result` varchar(255) DEFAULT NULL COMMENT '失败原因',
  `trust_trigger` varchar(50) DEFAULT NULL COMMENT '触发信任描述：可信登录记录',
  `online_status` int(2) DEFAULT NULL COMMENT '0:失效.1:在线',
  `updated_at` datetime DEFAULT NULL,
  `domain_id` varchar(36) DEFAULT NULL COMMENT '多租户Id',
  `replay_file_name` varchar(500) DEFAULT NULL COMMENT '录屏文件后缀名',
  `video_audit` varchar(255) DEFAULT NULL COMMENT '是否开启视频审计，1：开启，0：不开启',
  `create_time` datetime DEFAULT NULL,
  `application_id` varchar(255) DEFAULT NULL COMMENT '应用主键',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `log_id` varchar(36) NOT NULL COMMENT '审计ID',
  `app_version` varchar(50) NOT NULL COMMENT '应用版本',
  `c_ip` varchar(50) DEFAULT NULL COMMENT '客户端IP',
  `geo_city` varchar(255) DEFAULT NULL COMMENT '城市',
  `geo_country_long` varchar(255) DEFAULT NULL COMMENT '国家',
  `geo_latitude` float DEFAULT NULL COMMENT '纬度',
  `geo_longitude` float DEFAULT NULL COMMENT '经度',
  `geo_region` varchar(255) DEFAULT NULL COMMENT '区域',
  `http_req` longtext COMMENT 'http请求',
  `module` varchar(255) NOT NULL COMMENT '模块',
  `rel_obj_name` varchar(100) DEFAULT NULL COMMENT '审计对象名称',
  `s_ip` varchar(50) NOT NULL COMMENT '服务端IP',
  `tag` varchar(100) NOT NULL COMMENT '标签',
  `time` bigint(20) NOT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `login_account` (`login_account`) USING BTREE COMMENT '可以针对账户进行索引',
  KEY `index_application` (`application_account`,`application_id`) USING BTREE,
  KEY `idx_p_s_a_r_username` (`username`) USING BTREE,
  KEY `idx_p_s_a_r_login_time` (`login_time`) USING BTREE,
  KEY `idx_p_s_a_r_application_id` (`application_id`) USING BTREE,
  KEY `idx_p_s_a_r_request_application` (`request_application`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='登录记录历史表，用来存储各登录记录';

DROP TABLE IF EXISTS `pi_sso_attachment`;
CREATE TABLE `pi_sso_attachment` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `attachment_file` longblob COMMENT '附件内容',
  `type` varchar(256) DEFAULT NULL COMMENT '附件类型：qrcode',
  `file_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='存储文件表';

DROP TABLE IF EXISTS `pi_sso_audit_first_protocol`;
CREATE TABLE `pi_sso_audit_first_protocol` (
  `id` bigint(20) NOT NULL,
  `client_ip` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `protocol` varchar(255) DEFAULT NULL,
  `request` varchar(3000) DEFAULT NULL,
  `response` varchar(3000) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `service_id` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pi_sso_audit_second_protocol`;
CREATE TABLE `pi_sso_audit_second_protocol` (
  `id` bigint(20) NOT NULL,
  `client_ip` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `protocol` varchar(255) DEFAULT NULL,
  `request` varchar(3000) DEFAULT NULL,
  `response` varchar(3000) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pi_sso_audit_third_protocol`;
CREATE TABLE `pi_sso_audit_third_protocol` (
  `id` bigint(20) NOT NULL,
  `client_ip` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `protocol` varchar(255) DEFAULT NULL,
  `request` varchar(3000) DEFAULT NULL,
  `response` varchar(3000) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pi_sso_auth_level`;
CREATE TABLE `pi_sso_auth_level` (
  `auth_type` varchar(256) DEFAULT NULL COMMENT '协议',
  `auth_level` int(10) DEFAULT NULL COMMENT '认证等级',
  `id` bigint(20) NOT NULL COMMENT '主键',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='认证登记表';

DROP TABLE IF EXISTS `pi_sso_context`;
CREATE TABLE `pi_sso_context` (
  `id` bigint(20) NOT NULL COMMENT '主键，雪花id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `context_key` varchar(255) DEFAULT NULL COMMENT '存入的字段键名',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `context_value` varchar(8555) DEFAULT NULL COMMENT '存入的字段键值',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_context_key` (`context_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='上下文表';

DROP TABLE IF EXISTS `pi_sso_device`;
CREATE TABLE `pi_sso_device` (
  `id` bigint(20) NOT NULL,
  `deviceId` varchar(255) DEFAULT NULL,
  `eid` varchar(255) DEFAULT NULL,
  `isDefault` int(11) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `is_default` int(11) DEFAULT NULL,
  `user_name` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SSO设备表';

DROP TABLE IF EXISTS `pi_sso_global_config`;
CREATE TABLE `pi_sso_global_config` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `code` varchar(15) DEFAULT NULL COMMENT '配置Code',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `status` varchar(2) DEFAULT NULL COMMENT '状态',
  `value` varchar(255) DEFAULT NULL COMMENT '配置项值',
  `type` varchar(50) DEFAULT NULL COMMENT '配置类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='基础配置表';

DROP TABLE IF EXISTS `pi_sso_group_auth`;
CREATE TABLE `pi_sso_group_auth` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `groupId` varchar(255) DEFAULT NULL COMMENT '组ID',
  `auth_type` varchar(255) DEFAULT NULL COMMENT '认证类型',
  `groupName` varchar(255) DEFAULT NULL COMMENT '组名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='认证组表';

DROP TABLE IF EXISTS `pi_sso_ip_whitelist`;
CREATE TABLE `pi_sso_ip_whitelist` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `ip` varchar(255) DEFAULT NULL COMMENT 'IP地址',
  `status` smallint(4) DEFAULT NULL COMMENT '状态',
  `user_uid` varchar(36) DEFAULT NULL COMMENT '用户名',
  `type` smallint(2) DEFAULT NULL COMMENT '类型',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='白名单配置表';

DROP TABLE IF EXISTS `pi_sso_lock`;
CREATE TABLE `pi_sso_lock` (
  `id` varchar(64) NOT NULL COMMENT '应用id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expiration_date` datetime DEFAULT NULL COMMENT '过期时间',
  `unique_id` varchar(255) DEFAULT NULL COMMENT '锁唯一id',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `lockVer` int(11) NOT NULL DEFAULT '0' COMMENT '锁版本',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='锁定表';

DROP TABLE IF EXISTS `pi_sso_login_record`;
CREATE TABLE `pi_sso_login_record` (
  `id` varchar(36) NOT NULL COMMENT 'uuid',
  `auth_type` varchar(255) DEFAULT NULL COMMENT '登录认证方式，1-密码，2-人脸 3-指纹 4-微信扫码',
  `city` varchar(50) DEFAULT NULL COMMENT '城市',
  `device_type` varchar(50) DEFAULT NULL COMMENT '登录设备类型 1-windows 2-mac 3-Android  4-ios',
  `login_ip` varchar(50) DEFAULT NULL COMMENT '登录ip地址',
  `login_status` int(2) DEFAULT NULL COMMENT '登录状态描述，1 成功，0 失败',
  `login_time` datetime DEFAULT NULL COMMENT '此次登录时间',
  `risk_trigger` varchar(255) DEFAULT NULL COMMENT '登录失败的原因',
  `user_agent` varchar(2048) DEFAULT NULL COMMENT 'user agent',
  `username` varchar(50) DEFAULT NULL COMMENT '登录用户名',
  `device_id` varchar(255) DEFAULT NULL COMMENT '登录设备id（暂时未用到，作为扩展）',
  `extension` varchar(255) DEFAULT NULL COMMENT '扩展字段',
  `location` varchar(255) DEFAULT NULL COMMENT '登录时的地理信息',
  `browser_type` varchar(255) DEFAULT NULL COMMENT '登录浏览器类型',
  `account_no` varchar(255) DEFAULT NULL COMMENT '应用子帐号',
  `app_name` varchar(255) DEFAULT NULL COMMENT '应用名称',
  `app_protocol` varchar(255) DEFAULT NULL COMMENT '应用协议',
  `second_auth` varchar(255) DEFAULT NULL COMMENT '是否为二次认证， 1 是， 0 否',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `log_id` varchar(36) NOT NULL COMMENT '审计ID',
  `app_version` varchar(50) NOT NULL COMMENT '应用版本',
  `c_ip` varchar(50) DEFAULT NULL COMMENT '客户端IP',
  `geo_city` varchar(255) DEFAULT NULL COMMENT '城市',
  `geo_country_long` varchar(255) DEFAULT NULL COMMENT '国家',
  `geo_latitude` float DEFAULT NULL COMMENT '纬度',
  `geo_longitude` float DEFAULT NULL COMMENT '经度',
  `geo_region` varchar(255) DEFAULT NULL COMMENT '区域',
  `http_req` longtext COMMENT 'http请求',
  `module` varchar(255) NOT NULL COMMENT '模块',
  `rel_obj_name` varchar(100) DEFAULT NULL COMMENT '审计对象名称',
  `s_ip` varchar(50) NOT NULL COMMENT '服务端IP',
  `tag` varchar(100) NOT NULL COMMENT '标签',
  `time` bigint(20) NOT NULL COMMENT '时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_sso_login_recored_username` (`username`) USING BTREE COMMENT 'portal访问日志索引',
  KEY `idx_sso_login_record_status` (`login_status`) USING BTREE,
  KEY `idx_p_s_l_r_username` (`username`) USING BTREE,
  KEY `idx_p_s_l_r_login_time` (`login_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='sso登录记录表，用来存储各登录记录';

DROP TABLE IF EXISTS `pi_sso_login_template_policy_festival`;
CREATE TABLE `pi_sso_login_template_policy_festival` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '节日名称',
  `start_time` varchar(64) NOT NULL COMMENT '开始时间',
  `end_time` varchar(64) NOT NULL COMMENT '结束时间',
  `login_policy_id` varchar(64) NOT NULL COMMENT '登录页策略id',
  `login_page_id` varchar(64) NOT NULL COMMENT '登录页面id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pi_sso_login_template_policy_user`;
CREATE TABLE `pi_sso_login_template_policy_user` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `name` varchar(64) DEFAULT NULL COMMENT '数据名称',
  `data_id` varchar(64) DEFAULT NULL COMMENT '数据id',
  `user_scope` varchar(64) NOT NULL COMMENT '用户适用范围类型',
  `login_policy_id` varchar(64) NOT NULL COMMENT '登录页策略id',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pi_sso_ltpa_app`;
CREATE TABLE `pi_sso_ltpa_app` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `ltpa_token_id` bigint(20) NOT NULL COMMENT 'token ID',
  `provider` varchar(64) DEFAULT NULL COMMENT 'LTPA供应商：IBM，landray，kingdee',
  `version` varchar(32) DEFAULT NULL COMMENT '版本：V1,V2',
  `cookie_name` varchar(64) DEFAULT NULL COMMENT 'Cookie名称',
  `same_domain` tinyint(2) DEFAULT NULL COMMENT '是否跟sso同域：1同域，0非同域',
  `cookie_gen_url` varchar(255) DEFAULT NULL COMMENT 'cookie生成的URL地址，NONE代表同域',
  `cookie_format` varchar(1024) DEFAULT NULL COMMENT 'cookie的内容格式',
  `cookie_expired` int(11) DEFAULT NULL COMMENT 'cookie的有效期（秒）',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_ltpa_token_id` (`ltpa_token_id`) USING BTREE,
  UNIQUE KEY `uq_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='LTPA应用配置表';

DROP TABLE IF EXISTS `pi_sso_ltpa_token`;
CREATE TABLE `pi_sso_ltpa_token` (
  `id` bigint(20) NOT NULL COMMENT '主键ID',
  `file_name` varchar(50) DEFAULT NULL COMMENT '文件名称',
  `key_file` blob COMMENT '密钥文件',
  `key_password` varchar(255) DEFAULT NULL COMMENT '密钥的密码',
  `provider` varchar(255) DEFAULT NULL COMMENT 'LTPA提供商',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='LTPA token表';

DROP TABLE IF EXISTS `pi_sso_message_properties`;
CREATE TABLE `pi_sso_message_properties` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `code` varchar(255) DEFAULT NULL COMMENT '错误code',
  `operability` tinyint(2) DEFAULT NULL COMMENT '是否可操作(1:可以被接口操作，0:不可以被接口操作)',
  `zh` varchar(255) DEFAULT NULL COMMENT '简体中文',
  `en` varchar(255) DEFAULT NULL COMMENT '英语',
  `es` varchar(255) DEFAULT NULL COMMENT '西班牙语',
  `de` varchar(255) DEFAULT NULL COMMENT '德语',
  `fr` varchar(255) DEFAULT NULL COMMENT '法语',
  `ja` varchar(255) DEFAULT NULL COMMENT '日语',
  `pt` varchar(255) DEFAULT NULL COMMENT '葡萄牙语',
  `ru` varchar(255) DEFAULT NULL COMMENT '俄语',
  `zhHk` varchar(255) DEFAULT NULL COMMENT '繁体中文',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SSO国际化配置表';

DROP TABLE IF EXISTS `pi_sso_mobile_device`;
CREATE TABLE `pi_sso_mobile_device` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `pr_deviceid` varchar(64) NOT NULL,
  `pr_secretkey` varchar(300) NOT NULL,
  `pr_uid` varchar(64) DEFAULT NULL,
  `pr_status` int(2) DEFAULT NULL,
  `pr_createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pr_offsetTime` varchar(40) DEFAULT NULL,
  `pr_serialNo` varchar(255) DEFAULT NULL,
  `pr_type` varchar(30) DEFAULT NULL,
  `pr_salt` varchar(255) DEFAULT NULL,
  `eid` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='手机设备表';

DROP TABLE IF EXISTS `pi_sso_oauth_token`;
CREATE TABLE `pi_sso_oauth_token` (
  `type` varchar(16) NOT NULL COMMENT 'token类型',
  `id` varchar(255) NOT NULL COMMENT 'token id',
  `number_of_times_used` int(11) DEFAULT NULL COMMENT '使用次数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expiration_policy` longblob NOT NULL COMMENT '过期策略',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `previous_last_time_used` datetime DEFAULT NULL COMMENT '最近使用时间',
  `authentication` longblob NOT NULL COMMENT '认证主体',
  `service` longblob NOT NULL COMMENT '服务主体',
  `ticketGrantingTicket_id` varchar(255) DEFAULT NULL COMMENT 'tgt id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `IDX_OAUTH_TOKEN_TGT_ID` (`ticketGrantingTicket_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='Oauth token存储表';

DROP TABLE IF EXISTS `pi_sso_pkicert_table`;
CREATE TABLE `pi_sso_pkicert_table` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `appcert` text,
  `appname` varchar(255) DEFAULT NULL,
  `rootcert` text,
  `rootname` varchar(255) DEFAULT NULL,
  `user_uid` varchar(255) DEFAULT NULL,
  `eid` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='PKI证书表';

DROP TABLE IF EXISTS `pi_sso_registered_service`;
CREATE TABLE `pi_sso_registered_service` (
  `id` bigint(20) NOT NULL,
  `app_id` varchar(255) DEFAULT NULL COMMENT '应用id',
  `expression_type` varchar(15) NOT NULL DEFAULT 'ant' COMMENT 'service类型',
  `description` varchar(255) DEFAULT NULL COMMENT 'service描述',
  `logout_url` varchar(255) DEFAULT NULL COMMENT '登出地址',
  `name` varchar(255) NOT NULL COMMENT '应用名',
  `return_user_id` text COMMENT '协议的profile接口的帐号信息返回字段，多字段逗号分隔',
  `service_id` varchar(1024) DEFAULT NULL,
  `at_exp_policy` longblob,
  `bypass_approval_prompt` bit(1) DEFAULT NULL COMMENT '允许提示',
  `client_id` varchar(255) DEFAULT NULL COMMENT '客户端id',
  `client_secret` varchar(255) DEFAULT NULL COMMENT '客户端密钥',
  `generate_refresh_token` bit(1) DEFAULT NULL COMMENT '是否生成rt',
  `json_format` bit(1) DEFAULT NULL COMMENT 'json格式',
  `rt_exp_policy` longblob,
  `supported_grants` longblob COMMENT '支持授权',
  `supported_responses` longblob,
  `dynamic_registration_date_time` datetime DEFAULT NULL COMMENT '动态注册时间',
  `dynamically_registered` bit(1) DEFAULT NULL COMMENT '动态注册',
  `encrypt_id_token` bit(1) DEFAULT NULL COMMENT '加密idtoken',
  `id_token_encryption_alg` varchar(255) DEFAULT NULL COMMENT 'idToken加密算法',
  `id_token_encryption_encoding` varchar(255) DEFAULT NULL COMMENT 'idToken加密编码',
  `implicit` bit(1) DEFAULT NULL COMMENT '隐式',
  `jwks` varchar(255) DEFAULT NULL COMMENT '公钥',
  `scopes` longblob COMMENT '作用域',
  `sign_id_token` bit(1) DEFAULT NULL COMMENT 'idToken签名',
  `encrypt_assertions` bit(1) DEFAULT NULL COMMENT '加密断言',
  `metadata_criteria_direction` varchar(255) DEFAULT NULL COMMENT '元数据标准目录',
  `metadata_criteria_pattern` varchar(255) DEFAULT NULL COMMENT '元数据标准模式',
  `empty_entity_descriptors` bit(1) DEFAULT NULL,
  `role_less_entity_descriptors` bit(1) DEFAULT NULL,
  `metadata_criteria_roles` varchar(255) DEFAULT NULL COMMENT '元数据标准角色',
  `metadata_location` varchar(255) DEFAULT NULL COMMENT '元数据位置',
  `metadata_max_validity` bigint(20) DEFAULT NULL COMMENT '元数据最长有效期',
  `metadata_signature_location` varchar(255) DEFAULT NULL COMMENT '元数据证书位置',
  `name_id_qualifier` varchar(255) DEFAULT NULL COMMENT '名称id修饰',
  `authentication_class` varchar(255) DEFAULT NULL,
  `required_name_id_format` varchar(255) DEFAULT NULL COMMENT '必须名称id格式',
  `sp_name_id_qualifier` varchar(255) DEFAULT NULL COMMENT '服务提供者名称id修饰符',
  `sign_assertions` bit(1) DEFAULT NULL COMMENT '签名断言',
  `sign_responses` bit(1) DEFAULT NULL COMMENT '签名响应',
  `auth_level` varchar(255) DEFAULT NULL COMMENT '认证级别',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `refresh_tgt` bit(1) DEFAULT NULL COMMENT '是否开启tgt刷新',
  `allow_proxy` bit(1) DEFAULT NULL,
  `default_auth_type` varchar(255) DEFAULT NULL COMMENT '应用默认的认证类型',
  `logout_enable` bit(1) DEFAULT NULL COMMENT '是否开启单点登出',
  `logout_name_id` varchar(255) DEFAULT NULL COMMENT 'CAS协议单点登出nameId配置',
  `logout_level` varchar(255) DEFAULT NULL COMMENT 'OIDC协议单点登出级别',
  `metadata` text COMMENT '应用元数据内容',
  `skew_allowance` bigint(20) DEFAULT NULL COMMENT 'Saml Response校验时间偏移量',
  `customize_auth_status` bit(1) DEFAULT NULL COMMENT '是否开启自定义授权参数',
  `customize_auth_param` longblob COMMENT '自定义授权参数转化配置',
  `privileged` bit(1) DEFAULT NULL COMMENT '是否是特权应用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SSO应用表';

DROP TABLE IF EXISTS `pi_sso_saml_idp_metadata`;
CREATE TABLE `pi_sso_saml_idp_metadata` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `content` blob COMMENT '证书或私钥文件',
  `eid` varchar(255) DEFAULT NULL,
  `fileType` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='IDP metadata表';

DROP TABLE IF EXISTS `pi_sso_saml_metadata`;
CREATE TABLE `pi_sso_saml_metadata` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `appId` varchar(255) DEFAULT NULL COMMENT '名称',
  `metadata` longtext COMMENT '文件base64数据',
  `eid` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='应用metadata表';

DROP TABLE IF EXISTS `pi_sso_service_ticket`;
CREATE TABLE `pi_sso_service_ticket` (
  `type` varchar(16) NOT NULL COMMENT 'ticket类型',
  `id` varchar(255) NOT NULL COMMENT 'ticket id',
  `number_of_times_used` int(11) DEFAULT NULL COMMENT '使用次数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expiration_policy` longblob NOT NULL COMMENT '过期策略',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `previous_last_time_used` datetime DEFAULT NULL COMMENT '最近使用时间',
  `from_new_login` bit(1) NOT NULL COMMENT '是否新登录所创建',
  `ticket_already_granted` bit(1) NOT NULL COMMENT 'ticket是否已经授权',
  `service` longblob NOT NULL COMMENT '服务主体',
  `ticketGrantingTicket_id` varchar(255) DEFAULT NULL COMMENT 'tgt id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='CAS协议ticket表';

DROP TABLE IF EXISTS `pi_sso_settings_table`;
CREATE TABLE `pi_sso_settings_table` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) NOT NULL,
  `value` varchar(5000) DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `attachment` blob,
  `eid` varchar(32) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '数据创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '数据修改时间',
  `plugin_id` varchar(255) DEFAULT NULL COMMENT '插件ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SSO配置表';

DROP TABLE IF EXISTS `pi_sso_sp_saml_metadata`;
CREATE TABLE `pi_sso_sp_saml_metadata` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `content` blob COMMENT 'metadata文件',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='第三方认证源sp metadata文件存储表';

DROP TABLE IF EXISTS `pi_sso_sp_service`;
CREATE TABLE `pi_sso_sp_service` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT 'SP名称',
  `status` varchar(255) DEFAULT NULL COMMENT '状态',
  `ssoData` text COMMENT '协议数据',
  `creator` varchar(255) DEFAULT NULL COMMENT '创建人',
  `creationDate` datetime DEFAULT NULL COMMENT '创建日期',
  `lastChangeDate` datetime DEFAULT NULL COMMENT '最后修改日期',
  `protocol` varchar(255) DEFAULT NULL COMMENT 'SP协议',
  `autoCreateUser` smallint(2) DEFAULT NULL COMMENT '是否自动创建用户',
  `eid` varchar(255) DEFAULT NULL,
  `sole_id` varchar(255) NOT NULL COMMENT 'Client唯一ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_sole_id` (`sole_id`) USING BTREE,
  UNIQUE KEY `sole_id` (`sole_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='服务应用注册表';

DROP TABLE IF EXISTS `pi_sso_sp_user`;
CREATE TABLE `pi_sso_sp_user` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `sp_id` varchar(255) DEFAULT NULL COMMENT 'SP应用主键',
  `sp_uid` varchar(255) DEFAULT NULL COMMENT 'SP用户名',
  `user_id` varchar(255) DEFAULT NULL COMMENT 'SSO用户主键',
  `protocol` varchar(255) DEFAULT NULL COMMENT 'SP协议',
  `eid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='服务应用用户绑定表';

DROP TABLE IF EXISTS `pi_sso_ticket_granting_ticket`;
CREATE TABLE `pi_sso_ticket_granting_ticket` (
  `type` varchar(16) NOT NULL COMMENT 'ticket类型',
  `id` varchar(255) NOT NULL COMMENT 'ticket id',
  `number_of_times_used` int(11) DEFAULT NULL COMMENT '使用次数',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `expiration_policy` longblob NOT NULL COMMENT '过期策略',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `previous_last_time_used` datetime DEFAULT NULL COMMENT '最近使用时间',
  `authentication` longblob NOT NULL COMMENT '认证主体',
  `descendant_tickets` longblob NOT NULL COMMENT '子ticket',
  `expired` bit(1) NOT NULL COMMENT '是否过期',
  `proxied_by` longblob COMMENT '代理主体',
  `services_granted_access_to` longblob NOT NULL COMMENT '授权对象',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='TGT登录会话表';

DROP TABLE IF EXISTS `pi_user_browser`;
CREATE TABLE `pi_user_browser` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(36) DEFAULT NULL,
  `browserid` varchar(128) CHARACTER SET latin1 DEFAULT NULL,
  `eid` varchar(32) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_browserid` (`browserid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户和浏览器关联表';

DROP TABLE IF EXISTS `pi_user_face`;
CREATE TABLE `pi_user_face` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) DEFAULT NULL,
  `face_id` varchar(36) CHARACTER SET latin1 NOT NULL COMMENT '人脸id',
  `group_id` bigint(20) DEFAULT NULL COMMENT '组id',
  `is_registered` varchar(36) CHARACTER SET latin1 DEFAULT NULL COMMENT '是否登记',
  `creator` varchar(64) DEFAULT NULL COMMENT '帐号创建者',
  `create_time` datetime DEFAULT NULL COMMENT '记录创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '帐号最后修改者',
  `update_time` datetime DEFAULT NULL COMMENT '记录编辑时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_username` (`user_id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='人脸表';

DROP TABLE IF EXISTS `pi_user_face_group`;
CREATE TABLE `pi_user_face_group` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `group_name` varchar(64) NOT NULL COMMENT '组名',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='人脸组表';

DROP TABLE IF EXISTS `pi_user_finger`;
CREATE TABLE `pi_user_finger` (
  `id` varchar(36) NOT NULL COMMENT '主键',
  `username` varchar(36) DEFAULT NULL COMMENT '用户名',
  `deviceid` varchar(256) CHARACTER SET latin1 DEFAULT NULL COMMENT '设备ID',
  `fingerid` varchar(64) CHARACTER SET latin1 DEFAULT NULL COMMENT '指纹ID',
  `fingerdata` varchar(4096) CHARACTER SET latin1 DEFAULT NULL COMMENT '指纹数据',
  `fingernum` int(11) DEFAULT NULL COMMENT '指纹序号',
  `type` int(11) DEFAULT NULL COMMENT '类型',
  `eid` varchar(255) DEFAULT NULL COMMENT '租户ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE,
  KEY `idx_deviceid` (`deviceid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='指纹表';

DROP TABLE IF EXISTS `pi_user_systemuser`;
CREATE TABLE `pi_user_systemuser` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(128) DEFAULT NULL COMMENT '用户名',
  `system_user` varchar(512) DEFAULT NULL COMMENT '系统用户名',
  `device_id` varchar(128) DEFAULT NULL COMMENT '设备ID',
  `bind_type` varchar(64) DEFAULT NULL COMMENT '绑定类型',
  `system_pwd` varchar(512) DEFAULT NULL COMMENT '系统密码',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='操作系统用户表';

DROP TABLE IF EXISTS `pi_user_voice`;
CREATE TABLE `pi_user_voice` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `username` varchar(36) DEFAULT NULL COMMENT '用户名',
  `voiceid` varchar(36) CHARACTER SET latin1 DEFAULT NULL COMMENT '声纹ID',
  `isregistered` varchar(36) CHARACTER SET latin1 DEFAULT NULL COMMENT '声纹是否注册',
  `creationDate` datetime DEFAULT NULL COMMENT '创建时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `lastChangeDate` datetime DEFAULT NULL COMMENT '最后修改时间',
  `lastModifier` varchar(255) DEFAULT NULL COMMENT '最后修改人',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_username` (`username`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='声纹表';

DROP TABLE IF EXISTS `policy_attribute_unique`;
CREATE TABLE `policy_attribute_unique` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) DEFAULT NULL COMMENT '用户分组id',
  `name` varchar(100) DEFAULT NULL COMMENT '策略名称',
  `priority` smallint(4) DEFAULT '1' COMMENT '优先级，数字越大优先级越高，默认策略优先级为0',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-有效，0-无效',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='属性唯一策略表';

DROP TABLE IF EXISTS `policy_attribute_unique_item`;
CREATE TABLE `policy_attribute_unique_item` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `attribute_unique_id` bigint(20) DEFAULT NULL COMMENT '属性唯一策略id',
  `attributes` varchar(255) DEFAULT NULL COMMENT '属性名，多个字段，逗号分隔',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='属性唯一策略详情表';

DROP TABLE IF EXISTS `policy_collection_target_link`;
CREATE TABLE `policy_collection_target_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `collection_id` bigint(20) DEFAULT NULL COMMENT '采集策略主键',
  `org_id` bigint(20) DEFAULT NULL COMMENT '采集目标组织ID',
  `job_id` bigint(20) DEFAULT NULL COMMENT '采集目标岗位ID',
  `group_id` bigint(20) DEFAULT NULL COMMENT '采集目标用户组ID',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_collection_id` (`collection_id`) USING BTREE,
  KEY `idx_org_id` (`org_id`) USING BTREE,
  KEY `idx_job_id` (`job_id`) USING BTREE,
  KEY `idx_group_id` (`group_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限采集策略-采集目标关联表';

DROP TABLE IF EXISTS `policy_group_user_forward`;
CREATE TABLE `policy_group_user_forward` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `group_id` bigint(20) NOT NULL COMMENT '分组id',
  `name` varchar(255) DEFAULT NULL COMMENT '策略名称',
  `priority` int(11) DEFAULT NULL COMMENT '优先级',
  `default_forward_url` varchar(255) DEFAULT NULL COMMENT '用户跳转地址',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-启用；0-停用',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户组-默认跳转地址设置';

DROP TABLE IF EXISTS `policy_permission_collection`;
CREATE TABLE `policy_permission_collection` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '采集策略名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `target_type` varchar(255) NOT NULL COMMENT '采集目标类型:all-不限制,org-按所在组织选择,job-岗位，group-用户用户',
  `target_content` varchar(255) DEFAULT NULL COMMENT '采集目标摘要',
  `target_tips` varchar(255) DEFAULT NULL COMMENT '采集目标解析提示',
  `permission_percent` smallint(3) DEFAULT NULL COMMENT '权限占比',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE,
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='权限采集策略表';

DROP TABLE IF EXISTS `policy_recycle`;
CREATE TABLE `policy_recycle` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '策略名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1启用 0禁用',
  `is_create_user` tinyint(2) DEFAULT NULL COMMENT '是否创建应用帐号 1 是 0 否',
  `is_disable_account` tinyint(2) DEFAULT NULL COMMENT '是否禁用帐号 1是 0否',
  `prev_exe_time` datetime DEFAULT NULL COMMENT '开始执行时间',
  `end_exe_time` datetime DEFAULT NULL COMMENT '开始结束时间',
  `recycle_status` tinyint(2) DEFAULT NULL COMMENT '回收状态 1 失败 2成功 3回收中',
  `recycle_result` blob COMMENT '回收结果',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `search_filter` varchar(255) DEFAULT NULL COMMENT '回收一个人的信息',
  `recycle_data_types` varchar(255) DEFAULT NULL COMMENT '回收数据类型：资源、帐号、角色',
  `recycle_resource_types` varchar(255) DEFAULT NULL COMMENT '回收资源类型：菜单、api、等',
  `task_id` int(11) DEFAULT NULL COMMENT '任务ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='回收策略表';

DROP TABLE IF EXISTS `policy_recycle_app_link`;
CREATE TABLE `policy_recycle_app_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_recycle_id` bigint(20) DEFAULT NULL COMMENT '回收策略id',
  `app_id` bigint(20) DEFAULT NULL COMMENT '应用id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='回策略应用关联表';

DROP TABLE IF EXISTS `policy_recycle_mapping`;
CREATE TABLE `policy_recycle_mapping` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `policy_recycle_id` bigint(20) DEFAULT NULL COMMENT '回收策略主键',
  `user_field` varchar(255) DEFAULT NULL COMMENT '用户属性',
  `account_field` varchar(255) DEFAULT NULL COMMENT '帐号属性',
  `qlexpress_text` varchar(2000) DEFAULT NULL COMMENT 'ql表达式',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='回收策略字段映射表';

DROP TABLE IF EXISTS `pr_audit_sso_login_out`;
CREATE TABLE `pr_audit_sso_login_out` (
  `log_id` varchar(36) NOT NULL COMMENT '日志主键',
  `app_version` varchar(50) NOT NULL COMMENT '服务版本',
  `c_ip` varchar(50) DEFAULT NULL COMMENT '客户端IP',
  `geo_city` varchar(255) DEFAULT NULL COMMENT '城市',
  `geo_country_long` varchar(255) DEFAULT NULL COMMENT '国家',
  `geo_latitude` float DEFAULT NULL COMMENT '纬度',
  `geo_longitude` float DEFAULT NULL COMMENT '经度',
  `geo_region` varchar(255) DEFAULT NULL COMMENT '区域',
  `http_req` longtext COMMENT 'Http请求',
  `module` varchar(255) NOT NULL COMMENT '模块',
  `rel_obj_name` varchar(100) DEFAULT NULL COMMENT '审计对象名称',
  `s_ip` varchar(50) NOT NULL COMMENT '服务端IP',
  `tag` varchar(100) NOT NULL COMMENT '标签',
  `time` bigint(20) NOT NULL COMMENT '时间',
  `pr_device_id` varchar(255) DEFAULT NULL COMMENT '设备ID',
  `pr_employee_create_time` datetime DEFAULT NULL COMMENT '用户创建时间',
  `pr_login_auth_type` varchar(255) DEFAULT NULL COMMENT '登录方式',
  `pr_login_device` varchar(255) DEFAULT NULL COMMENT '登录设备',
  `pr_login_out` varchar(1) DEFAULT NULL COMMENT '登录是否成功',
  `pr_operate_success` varchar(255) DEFAULT NULL COMMENT '操作成功日志',
  `pr_org_id` varchar(36) DEFAULT NULL COMMENT '组织ID',
  `pr_org_name` varchar(36) DEFAULT NULL COMMENT '组织名',
  `pr_result_desc` longtext COMMENT '登录结果',
  `pr_status` int(11) DEFAULT NULL COMMENT '日志状态',
  `pr_user_id` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `pr_user_type_id` varchar(32) DEFAULT NULL COMMENT '用户类型ID',
  `pr_user_type_name` varchar(50) DEFAULT NULL COMMENT '用户类型名称',
  `pr_username` varchar(300) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pr_audit_sso_res_login`;
CREATE TABLE `pr_audit_sso_res_login` (
  `log_id` varchar(36) NOT NULL COMMENT '日志主键',
  `app_version` varchar(50) NOT NULL COMMENT '服务版本',
  `c_ip` varchar(50) DEFAULT NULL COMMENT '客户端IP',
  `geo_city` varchar(255) DEFAULT NULL COMMENT '城市',
  `geo_country_long` varchar(255) DEFAULT NULL COMMENT '国家',
  `geo_latitude` float DEFAULT NULL COMMENT '纬度',
  `geo_longitude` float DEFAULT NULL COMMENT '经度',
  `geo_region` varchar(255) DEFAULT NULL COMMENT '区域',
  `http_req` longtext COMMENT 'Http请求',
  `module` varchar(255) NOT NULL COMMENT '模块',
  `rel_obj_name` varchar(100) DEFAULT NULL COMMENT '审计对象名称',
  `s_ip` varchar(50) NOT NULL COMMENT '服务端IP',
  `tag` varchar(100) NOT NULL COMMENT '标签',
  `time` bigint(20) NOT NULL COMMENT '时间',
  `pr_operate_success` varchar(255) DEFAULT NULL COMMENT '操作成功日志',
  `pr_org_id` varchar(36) DEFAULT NULL COMMENT '组织ID',
  `pr_org_name` varchar(50) DEFAULT NULL COMMENT '组织名称',
  `pr_res_account_create_time` datetime DEFAULT NULL COMMENT '应用账号创建时间',
  `pr_res_account_id` varchar(32) DEFAULT NULL COMMENT '应用账号ID',
  `pr_res_account_name` varchar(100) DEFAULT NULL COMMENT '应用账号名',
  `pr_res_account_status` int(11) DEFAULT NULL COMMENT '应用账号状态',
  `pr_res_code` varchar(32) DEFAULT NULL COMMENT '应用code',
  `pr_res_id` varchar(32) DEFAULT NULL COMMENT '应用ID',
  `pr_res_name` varchar(200) DEFAULT NULL COMMENT '应用名',
  `pr_result_desc` longtext COMMENT '应用跳转结果',
  `pr_status` int(11) DEFAULT NULL COMMENT '日志状态',
  `pr_user_id` varchar(36) DEFAULT NULL COMMENT '用户ID',
  `pr_user_type_id` varchar(32) DEFAULT NULL COMMENT '用户类型ID',
  `pr_user_type_name` varchar(50) DEFAULT NULL COMMENT '用户类型名称',
  `pr_username` varchar(300) DEFAULT NULL COMMENT '用户名',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pr_audit_timinglog`;
CREATE TABLE `pr_audit_timinglog` (
  `log_id` varchar(36) NOT NULL,
  `app_version` varchar(50) NOT NULL,
  `c_ip` varchar(50) DEFAULT NULL,
  `geo_city` varchar(255) DEFAULT NULL,
  `geo_country_long` varchar(255) DEFAULT NULL,
  `geo_latitude` float DEFAULT NULL,
  `geo_longitude` float DEFAULT NULL,
  `geo_region` varchar(255) DEFAULT NULL,
  `http_req` longtext,
  `module` varchar(255) NOT NULL,
  `rel_obj_name` varchar(100) DEFAULT NULL,
  `s_ip` varchar(50) NOT NULL,
  `tag` varchar(100) NOT NULL,
  `time` bigint(20) NOT NULL,
  `id` bigint(20) DEFAULT NULL,
  `implementTime` longtext,
  `name` varchar(255) DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `timeField` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pt_announce_module_link`;
CREATE TABLE `pt_announce_module_link` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `announcement_module_id` bigint(20) NOT NULL COMMENT '公告模块id',
  `announcement_type_id` bigint(20) NOT NULL COMMENT '公告类型id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pt_announce_user_group_link`;
CREATE TABLE `pt_announce_user_group_link` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `announcement_id` bigint(20) NOT NULL COMMENT '公告id',
  `user_group_id` bigint(20) NOT NULL COMMENT '用户组id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告用户组关联表';

DROP TABLE IF EXISTS `pt_announcement`;
CREATE TABLE `pt_announcement` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `title` varchar(1024) NOT NULL COMMENT '公告标题',
  `keywords` varchar(1024) DEFAULT NULL COMMENT '关键字',
  `announcement_status` tinyint(1) DEFAULT NULL COMMENT '公告状态（1当前展示，2草稿，3归档）',
  `content` longtext NOT NULL COMMENT '公告内容',
  `readings` int(255) DEFAULT '0' COMMENT '阅读数',
  `view_scope` tinyint(1) DEFAULT NULL COMMENT '公告可见状态(0未登陆可见1登陆可见)',
  `fixed_time` tinyint(2) DEFAULT NULL COMMENT '定时公告',
  `effective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expired_time` datetime DEFAULT NULL COMMENT '失效时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '更新日期',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `top_order` int(11) DEFAULT '0' COMMENT '置顶',
  `top_time` datetime DEFAULT NULL COMMENT '置顶时间',
  `enable_pop` tinyint(2) DEFAULT NULL COMMENT '是否弹窗',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告表';

DROP TABLE IF EXISTS `pt_announcement_annex`;
CREATE TABLE `pt_announcement_annex` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `announcement_id` bigint(20) NOT NULL COMMENT '公告id',
  `annex_name` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `annex_url` varchar(1024) DEFAULT NULL COMMENT '附件地址',
  `annex_size` bigint(20) DEFAULT NULL COMMENT '附件大小',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告附件表';

DROP TABLE IF EXISTS `pt_announcement_carousel`;
CREATE TABLE `pt_announcement_carousel` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `announcement_id` bigint(20) NOT NULL COMMENT '公告id',
  `enable_carousel` int(11) DEFAULT NULL COMMENT '是否参与轮播0不参加，1参加',
  `carousel_url` varchar(1024) DEFAULT NULL COMMENT '轮播图url',
  `carousel_file_upload_time` datetime DEFAULT NULL COMMENT '轮播图上传时间',
  `carousel_order_num` int(11) DEFAULT '0' COMMENT '轮播图序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='轮播图设置';

DROP TABLE IF EXISTS `pt_announcement_module`;
CREATE TABLE `pt_announcement_module` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(255) DEFAULT NULL COMMENT '模块code',
  `show_carousel` tinyint(1) DEFAULT NULL COMMENT '是否展示轮播',
  `carousel_interval` int(11) DEFAULT NULL COMMENT '轮播时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告模块表';

DROP TABLE IF EXISTS `pt_announcement_type`;
CREATE TABLE `pt_announcement_type` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `order_num` int(11) DEFAULT '0' COMMENT '公告类型序号',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pt_announcement_type_link`;
CREATE TABLE `pt_announcement_type_link` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `announcement_id` bigint(20) NOT NULL COMMENT '公告id',
  `announcement_type_id` bigint(20) NOT NULL COMMENT '公告类型id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='公告类型关联表';

DROP TABLE IF EXISTS `pt_common_link_url`;
CREATE TABLE `pt_common_link_url` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `link` text NOT NULL COMMENT 'url',
  `link_name` varchar(255) NOT NULL COMMENT '常用链接名称',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='常用链接';

DROP TABLE IF EXISTS `pt_plug`;
CREATE TABLE `pt_plug` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `plug_type_id` bigint(20) DEFAULT NULL COMMENT '插件类型id',
  `plug_name` varchar(200) DEFAULT NULL COMMENT '插件名称',
  `plug_url` varchar(500) DEFAULT NULL COMMENT '插件地址',
  `icon_name` varchar(200) DEFAULT NULL COMMENT '图片名称',
  `icon_url` varchar(500) DEFAULT NULL COMMENT '图片地址',
  `adaptation_sys_id` varchar(300) DEFAULT NULL COMMENT '适配系统(如果是多个值,以逗号隔开)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  `creator` varchar(50) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(50) DEFAULT NULL COMMENT '更新者',
  `status` tinyint(1) DEFAULT NULL COMMENT '是否显示(1:显示，0:不显示，默认显示)',
  `remark` varchar(300) DEFAULT NULL COMMENT '备注',
  `sort` int(11) DEFAULT NULL COMMENT '序号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `pt_todo_app_code_priority`;
CREATE TABLE `pt_todo_app_code_priority` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `app_code` varchar(32) DEFAULT NULL COMMENT '来源系统编码',
  `app_name` varchar(64) DEFAULT NULL COMMENT '来源系统名称',
  `user_id` varchar(64) DEFAULT NULL COMMENT '用户标识',
  `order_num` int(11) DEFAULT NULL COMMENT '排序序号',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_p_t_a_c_p_app_code` (`app_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='代办来源系统排序优先级';

DROP TABLE IF EXISTS `pt_todo_column`;
CREATE TABLE `pt_todo_column` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `list_id` bigint(20) DEFAULT NULL COMMENT '待办表id',
  `column_code` varchar(50) DEFAULT NULL COMMENT '列编码',
  `column_name` varchar(100) DEFAULT NULL COMMENT '列名',
  `column_value` varchar(1024) DEFAULT NULL COMMENT '列值',
  `is_search` smallint(1) DEFAULT NULL COMMENT '是否搜索，默认否，预留',
  `is_order` smallint(1) DEFAULT NULL COMMENT '是否排序，默认否，预留',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '最后修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_p_t_c_list_id` (`list_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='待办表头';

DROP TABLE IF EXISTS `pt_todo_list`;
CREATE TABLE `pt_todo_list` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `title` varchar(1024) DEFAULT NULL COMMENT '标题',
  `emergency` varchar(30) DEFAULT NULL COMMENT '紧急程度',
  `flow_status` varchar(50) DEFAULT NULL COMMENT '流程状态',
  `todo_type` varchar(50) DEFAULT NULL COMMENT '分类',
  `send_user_name` varchar(200) DEFAULT NULL COMMENT '发起人',
  `send_date_time` datetime(3) DEFAULT NULL COMMENT '发起时间',
  `receive_date_time` datetime(3) DEFAULT NULL COMMENT '接收时间',
  `app_code` varchar(32) DEFAULT NULL COMMENT '来源系统编码',
  `app_name` varchar(64) DEFAULT NULL COMMENT '来源系统名称',
  `forward_url` varchar(128) DEFAULT NULL COMMENT '跳转地址',
  `is_read` smallint(1) DEFAULT NULL COMMENT '是否已读1表示是；0表示否',
  `is_top` smallint(1) DEFAULT NULL COMMENT '是否置顶1表示是；0表示否',
  `top_time` datetime DEFAULT NULL COMMENT '置顶时间',
  `way` smallint(1) DEFAULT NULL COMMENT '获取方式：1：定时任务 2：被动接收',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编号',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_p_t_l_emergency` (`emergency`) USING BTREE,
  KEY `idx_p_t_l_flow_status` (`flow_status`) USING BTREE,
  KEY `idx_p_t_l_todo_type` (`todo_type`) USING BTREE,
  KEY `idx_p_t_l_send_user_name` (`send_user_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='待办表';

DROP TABLE IF EXISTS `sso_login_template`;
CREATE TABLE `sso_login_template` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `platform` varchar(255) NOT NULL COMMENT '平台',
  `template` mediumtext NOT NULL COMMENT '模版',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `embed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内置',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `sso_login_template_page`;
CREATE TABLE `sso_login_template_page` (
  `id` varchar(255) NOT NULL COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `platform` varchar(255) NOT NULL COMMENT '平台',
  `template` mediumtext NOT NULL COMMENT '模版',
  `page` mediumtext NOT NULL COMMENT '登录页',
  `remark` varchar(64) DEFAULT NULL COMMENT '备注',
  `save_template` tinyint(1) NOT NULL COMMENT '是否保存模版',
  `embed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内置',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `sso_login_template_policy`;
CREATE TABLE `sso_login_template_policy` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `level` int(4) NOT NULL DEFAULT '0' COMMENT '优先级',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '状态',
  `login_page_id` varchar(64) NOT NULL COMMENT '登录页主键',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `embed` tinyint(1) NOT NULL DEFAULT '0' COMMENT '内置',
  `festival_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '节日状态',
  `user_scope` varchar(64) NOT NULL COMMENT '用户适用范围类型',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `sso_user_fido_info`;
CREATE TABLE `sso_user_fido_info` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `credential` json NOT NULL COMMENT 'FIDO设备信息',
  `operation_system` varchar(255) NOT NULL COMMENT '操作系统',
  `device` varchar(255) DEFAULT NULL COMMENT '操作系统详细信息',
  `user_id` varchar(64) NOT NULL COMMENT '用户主键',
  `type` varchar(25) DEFAULT NULL COMMENT 'FIDO设备类型(usb和internal)',
  `auth_time` datetime DEFAULT NULL COMMENT '认证日期',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `update_time` datetime DEFAULT NULL COMMENT '修改日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='FIDO设备绑定详情表';

DROP TABLE IF EXISTS `sys_configuration`;
CREATE TABLE `sys_configuration` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(50) DEFAULT NULL COMMENT 'code键值',
  `value` varchar(255) DEFAULT NULL COMMENT '值',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编号',
  `conf_type` tinyint(2) DEFAULT '0' COMMENT '配置类型 0实施团队 1系统内部 2其他',
  `display` smallint(6) DEFAULT '1' COMMENT '是否显示',
  `is_encrypt` tinyint(2) DEFAULT '0' COMMENT '是否加密',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='IDM系统配置表';

DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(128) DEFAULT NULL COMMENT '数据字典编码（唯一新建之后不可以编辑）',
  `name` varchar(200) DEFAULT NULL COMMENT '字典名称',
  `type` varchar(255) DEFAULT NULL COMMENT '字典类型',
  `order_num` int(11) DEFAULT '0' COMMENT '排序号',
  `is_sys` tinyint(2) DEFAULT NULL COMMENT '是否内置 1内置 0未内置',
  `status` tinyint(2) DEFAULT '1' COMMENT '是否有效 1有效 0无效',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_dict_code` (`code`) USING BTREE COMMENT '数据字典编码唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='字典类型表';

DROP TABLE IF EXISTS `sys_dict_item`;
CREATE TABLE `sys_dict_item` (
  `id` bigint(20) NOT NULL COMMENT '主键Id',
  `dict_id` bigint(20) DEFAULT NULL COMMENT '字典类型id',
  `dict_code` varchar(128) DEFAULT NULL COMMENT '数据字典编码',
  `label` varchar(255) DEFAULT NULL COMMENT '字典标签',
  `value` varchar(500) DEFAULT NULL COMMENT '默认语言值',
  `code_value` varchar(255) DEFAULT NULL COMMENT 'code与value字段值的拼接',
  `order_num` int(11) DEFAULT '0' COMMENT '排序号',
  `is_sys` tinyint(2) DEFAULT NULL COMMENT '是否是系统内置 1内置 0 未内置',
  `parent_ids` varchar(2000) DEFAULT NULL COMMENT '层级编码',
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父级节点id',
  `status` tinyint(2) DEFAULT '1' COMMENT '是否有效 1有效 0无效',
  `remark` varchar(200) DEFAULT NULL COMMENT '备注',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_code_label` (`dict_code`,`label`) USING BTREE COMMENT 'code与label做唯一约束'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据字典表';

DROP TABLE IF EXISTS `sys_enum_i18n`;
CREATE TABLE `sys_enum_i18n` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(100) NOT NULL COMMENT '枚举值编码',
  `simple_name` varchar(255) DEFAULT NULL COMMENT '枚举类名称',
  `key_name` varchar(255) DEFAULT NULL COMMENT '枚举类的key名称 如:SUCCESS、REDIS_PRE_METADATA',
  `value` varchar(255) NOT NULL COMMENT '枚举类的值(value)',
  `zh` varchar(500) DEFAULT NULL COMMENT '中文(简体)',
  `zh_hk` varchar(500) DEFAULT NULL COMMENT '中文(繁体)',
  `en` varchar(500) DEFAULT NULL COMMENT '英语',
  `ja` varchar(500) DEFAULT NULL COMMENT '日本',
  `ru` varchar(500) DEFAULT NULL COMMENT '俄语',
  `fr` varchar(500) DEFAULT NULL COMMENT '法语',
  `de` varchar(500) DEFAULT NULL COMMENT '德语',
  `pt` varchar(500) DEFAULT NULL COMMENT '葡萄牙语',
  `es` varchar(500) DEFAULT NULL COMMENT '西班牙语',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `uq_code_value` (`code`,`value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='返回码国际化表';

DROP TABLE IF EXISTS `sys_i18n`;
CREATE TABLE `sys_i18n` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(500) NOT NULL COMMENT '编码',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `language_code` varchar(50) NOT NULL COMMENT '语种编码',
  `language_value` varchar(500) DEFAULT NULL COMMENT '语言值',
  `type` tinyint(2) NOT NULL COMMENT '国际化分类：0：错误码，1：元数据，2：数据字典，3：属性值，4：前端展示文本',
  `sub_type` tinyint(2) DEFAULT NULL COMMENT '子分类',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_code_language_code` (`code`,`language_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='系统国际化表(存储系统的国际化)';

DROP TABLE IF EXISTS `sys_images`;
CREATE TABLE `sys_images` (
  `id` bigint(20) NOT NULL,
  `type` tinyint(2) DEFAULT NULL COMMENT '0：背景图1：LOGO 2：Favicon',
  `name` varchar(255) DEFAULT NULL COMMENT '图片名称',
  `path` varchar(1024) DEFAULT NULL COMMENT '图片路径',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1启用 0停用',
  `creator` varchar(64) DEFAULT NULL,
  `eid` varchar(64) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `updater` varchar(64) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `sys_language`;
CREATE TABLE `sys_language` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `code` varchar(50) NOT NULL COMMENT '语言编码',
  `display_name` varchar(50) DEFAULT NULL COMMENT '展示名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：0：停用，1：启用',
  `sort_num` int(10) NOT NULL COMMENT '序号',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='语种维护表';

DROP TABLE IF EXISTS `sys_license`;
CREATE TABLE `sys_license` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `creator` varchar(64) DEFAULT NULL COMMENT '第一次上传license用户id',
  `updater` varchar(64) DEFAULT NULL COMMENT '最新更行license用户id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `license_info` varchar(2048) NOT NULL COMMENT 'license密文',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='license信息';

DROP TABLE IF EXISTS `sys_metadata`;
CREATE TABLE `sys_metadata` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `metadata_type_id` bigint(11) DEFAULT NULL COMMENT '业务分类id',
  `schema_name` varchar(255) DEFAULT NULL COMMENT '数据库名',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名',
  `table_comment` varchar(255) DEFAULT NULL COMMENT '表的功能说明',
  `parent_id` varchar(255) DEFAULT NULL COMMENT '父id',
  `class_name` varchar(255) DEFAULT NULL COMMENT 'java实体类(包含路径名称)',
  `i18n_code` varchar(500) DEFAULT NULL COMMENT 'i18n的key',
  `data_url` varchar(500) DEFAULT NULL COMMENT '查看数据url',
  `show_column` varchar(255) DEFAULT NULL COMMENT '显示字段',
  `status` smallint(1) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_schema_name_table_name` (`schema_name`,`table_name`) USING BTREE COMMENT '属性schema table唯一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='元数据主表';

DROP TABLE IF EXISTS `sys_metadata_item`;
CREATE TABLE `sys_metadata_item` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `metadata_id` bigint(20) DEFAULT NULL COMMENT '所属表id',
  `table_name` varchar(255) DEFAULT NULL COMMENT '表名称 冗余 方便查询',
  `column_name` varchar(255) DEFAULT NULL COMMENT '字段名称',
  `column_comment` varchar(255) DEFAULT NULL COMMENT '字段描述',
  `column_type` varchar(255) DEFAULT NULL COMMENT '字段类型',
  `column_length` varchar(255) DEFAULT NULL COMMENT '字段长度',
  `column_digit` varchar(255) DEFAULT NULL COMMENT '字段小数位',
  `column_nullable` tinyint(2) DEFAULT NULL COMMENT '字段是否为空',
  `column_default` varchar(255) DEFAULT NULL COMMENT '字段默认值',
  `is_primary` smallint(1) DEFAULT NULL COMMENT '是否主键',
  `is_foreign` smallint(1) DEFAULT NULL COMMENT '是否外键',
  `foreign_table` varchar(255) DEFAULT NULL COMMENT '外键参考表',
  `foreign_table_column` varchar(255) DEFAULT NULL COMMENT '外键表参考字段',
  `class_field` varchar(255) DEFAULT NULL COMMENT '字段属性',
  `class_field_type` varchar(255) DEFAULT NULL COMMENT '字段类型',
  `i18n_code` varchar(255) DEFAULT NULL COMMENT 'i18n国际化key',
  `show_format` varchar(255) DEFAULT NULL COMMENT '显示格式化',
  `is_only` tinyint(11) DEFAULT NULL COMMENT '是否唯一 1唯一 0 不唯一',
  `allow_show` tinyint(11) DEFAULT NULL COMMENT '允许显示 1允许 0不允许',
  `allow_edit` tinyint(11) DEFAULT NULL COMMENT '允许编辑 1允许 0不允许',
  `mask` tinyint(11) DEFAULT NULL COMMENT '脱敏 1 脱敏 0 不脱敏',
  `allow_full_search` tinyint(11) DEFAULT NULL COMMENT '允许全文检索 1允许 0 不允许',
  `allow_js` varchar(255) DEFAULT NULL COMMENT '显示时弹出框js',
  `is_check` varchar(255) DEFAULT NULL COMMENT '是否校验',
  `dict_id` bigint(20) unsigned DEFAULT NULL COMMENT '业务字典',
  `order_num` smallint(11) DEFAULT NULL COMMENT '显示排序号',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1有效 0 无效',
  `is_sys` tinyint(2) DEFAULT '1' COMMENT '是否是内置，1是 0 否',
  `init_no` varchar(36) DEFAULT NULL COMMENT '初始化编号',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_metadata_id_table_column` (`metadata_id`,`table_name`,`column_name`) USING BTREE COMMENT '使用唯一性约束',
  KEY `table_name` (`table_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='元数据明细表';

DROP TABLE IF EXISTS `sys_metadata_type`;
CREATE TABLE `sys_metadata_type` (
  `id` bigint(20) NOT NULL COMMENT '主键id',
  `name` varchar(255) DEFAULT NULL COMMENT '业务分类名称',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(2) DEFAULT NULL COMMENT '状态 1有效 0无效',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='元数据类型表';

DROP TABLE IF EXISTS `sys_plugin_adapter_node`;
CREATE TABLE `sys_plugin_adapter_node` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `server_name` varchar(50) DEFAULT NULL COMMENT '服务名称，用于判断插件适配器属于哪个模块',
  `adapter_type` varchar(100) DEFAULT NULL COMMENT '节点类型，如SSO、IDM',
  `server_ip` varchar(100) DEFAULT NULL COMMENT 'ip地址',
  `server_port` varchar(100) DEFAULT NULL COMMENT '服务端口号',
  `host_name` varchar(255) DEFAULT NULL COMMENT '主机名',
  `application_name` varchar(100) DEFAULT NULL COMMENT '应用名称',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `last_checkin_time` bigint(20) DEFAULT NULL COMMENT '最后一次签到时间戳，单位MS',
  `checkin_interval` bigint(20) DEFAULT NULL COMMENT '签到时间间隔，单位MS',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `node_uuid` varchar(100) DEFAULT NULL COMMENT '节点uuid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='插件适配器节点表';

DROP TABLE IF EXISTS `sys_plugin_instance`;
CREATE TABLE `sys_plugin_instance` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `ip` varchar(100) DEFAULT NULL COMMENT 'ip地址',
  `err_msg` varchar(2000) DEFAULT NULL COMMENT '错误信息',
  `plugin_id` bigint(20) DEFAULT NULL COMMENT '插件管理表主键',
  `host_name` varchar(255) DEFAULT NULL COMMENT '主机名',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-成功，0-失败',
  `batch_id` varchar(32) DEFAULT NULL COMMENT '批次号，与插件表的批次号对应',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  `node_uuid` varchar(100) DEFAULT NULL COMMENT '节点uuid',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='插件实例清单表';

DROP TABLE IF EXISTS `sys_plugin_mgmt`;
CREATE TABLE `sys_plugin_mgmt` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(100) DEFAULT NULL COMMENT '插件名称',
  `code` varchar(255) DEFAULT NULL COMMENT '插件编码',
  `version` varchar(100) DEFAULT NULL COMMENT '插件版本',
  `type` varchar(100) DEFAULT NULL COMMENT '插件类型',
  `sub_type` varchar(100) DEFAULT NULL COMMENT '子类型',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `author` varchar(64) DEFAULT NULL COMMENT '插件作者',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态：1-启用，0-停用',
  `file_name` varchar(100) DEFAULT NULL COMMENT '上传的文件名',
  `file_path` varchar(255) DEFAULT NULL COMMENT '插件上传后的文件路径',
  `form_config` text COMMENT '表单配置',
  `reserve_form_json` text COMMENT '预留拓展动态表单',
  `sync_config` text COMMENT '同步配置',
  `field_mapping` text COMMENT '字段映射配置',
  `class_name` varchar(200) DEFAULT NULL COMMENT '上游/下游的实现类类名',
  `md5` varchar(32) DEFAULT NULL COMMENT '文件的md5值',
  `detail` text COMMENT '插件详细参数',
  `page_define` tinyint(2) DEFAULT NULL COMMENT '页面定义：1-有；0-无',
  `integrate_method` tinyint(2) DEFAULT '1' COMMENT '集成方式：1-主推；2-被推',
  `batch_id` varchar(32) DEFAULT NULL COMMENT '批次号，每次上传插件都会生成一个新的批次号',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_type` (`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='插件管理表';

DROP TABLE IF EXISTS `sys_process_configuration`;
CREATE TABLE `sys_process_configuration` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `code` varchar(255) DEFAULT NULL COMMENT '配置的code',
  `value` varchar(255) DEFAULT NULL COMMENT '配置的值value',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_index_code` (`code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='流程引擎配置表';

DROP TABLE IF EXISTS `sys_productkey`;
CREATE TABLE `sys_productkey` (
  `id` varchar(32) NOT NULL DEFAULT '' COMMENT '主键',
  `algorithm` varchar(32) NOT NULL DEFAULT '' COMMENT '加密算法（DES，RSA，SM2）',
  `key1` varchar(1000) NOT NULL DEFAULT '' COMMENT '算法密钥1',
  `key2` varchar(1000) NOT NULL DEFAULT '' COMMENT '算法密钥2',
  `key3` varchar(1000) DEFAULT NULL COMMENT '算法密钥3',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_algorithm` (`algorithm`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='数据加密配置表';

DROP TABLE IF EXISTS `sys_watermark`;
CREATE TABLE `sys_watermark` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `classify_type` tinyint(2) DEFAULT NULL COMMENT '水印类型 1预设值 2自定义',
  `name` varchar(255) DEFAULT NULL COMMENT '名称唯一',
  `content` varchar(1024) DEFAULT NULL COMMENT '内容',
  `style_type` varchar(255) DEFAULT NULL COMMENT '样式类型 1 预设值 2 自定义',
  `font_name` varchar(255) DEFAULT NULL COMMENT '字体',
  `font_size` int(11) DEFAULT NULL COMMENT '字体大小',
  `angular` smallint(4) DEFAULT NULL COMMENT '角度',
  `horizontal_density` int(4) DEFAULT NULL COMMENT '横向密度',
  `longitudinal_density` int(4) DEFAULT NULL COMMENT '纵向密度',
  `transparency` varchar(6) DEFAULT NULL COMMENT '透明度',
  `display_range` varchar(255) DEFAULT NULL COMMENT '显示范围 1 selfcare 2 console',
  `group_ids` varchar(255) DEFAULT NULL COMMENT '分组id 多个以逗号分隔',
  `priority` int(11) DEFAULT '1' COMMENT '优先级',
  `color` varchar(20) DEFAULT NULL COMMENT '颜色',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态 1启用 0停用',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新人',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '租户编码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uq_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='水印';

DROP TABLE IF EXISTS `user_login_lock_strategy`;
CREATE TABLE `user_login_lock_strategy` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(64) NOT NULL COMMENT '策略名称',
  `status` tinyint(2) DEFAULT '1' COMMENT '状态: 0停用，1启用',
  `priority` int(10) NOT NULL COMMENT '优先级',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `use_scope` tinyint(2) NOT NULL DEFAULT '0' COMMENT '适用范围: 0全部用户，1用户，2用户类型，3组织，4岗位，5角色',
  `login_failure_verify_switch` tinyint(2) NOT NULL DEFAULT '1' COMMENT '登录失败验证: 0否，1是',
  `login_failure_verify_count` int(4) DEFAULT NULL COMMENT '登录失败验证,限制次数',
  `login_failure_verify_type` tinyint(2) DEFAULT NULL COMMENT '登录失败验证方式: 0图形验证码，1滑块验证码',
  `login_failure_lock_switch` tinyint(2) NOT NULL DEFAULT '1' COMMENT '登录失败锁定: 0否，1是',
  `login_failure_lock_count` int(4) DEFAULT NULL COMMENT '登录失败锁定,限制次数',
  `out_of_time_unlock_switch` tinyint(2) NOT NULL DEFAULT '1' COMMENT '锁定后解锁（超出时间后自动解锁）: 0否，1是',
  `out_of_time_unlock_time` int(4) DEFAULT NULL COMMENT '锁定时间（分钟）',
  `increment_lock_switch` tinyint(2) NOT NULL DEFAULT '1' COMMENT '增量锁定(解锁后再次登录失败，增量锁定): 0否，1是',
  `increment_lock_time` int(4) DEFAULT NULL COMMENT '增量锁定时间（分钟）',
  `lock_notify_user` tinyint(2) NOT NULL DEFAULT '1' COMMENT '锁定后通知用户: 0否，1是',
  `lock_notify_admin` tinyint(2) NOT NULL DEFAULT '1' COMMENT '锁定后通知管理员: 0否，1是',
  `permanent_lock_switch` tinyint(2) NOT NULL DEFAULT '1' COMMENT '永久锁定（超出连续锁定次数后将永久锁定）: 0否，1是',
  `continue_lock_count` int(4) DEFAULT NULL COMMENT '连续锁定次数',
  `is_sys` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否内置，0：否，1：是',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户登录锁定策略表';

DROP TABLE IF EXISTS `user_login_lock_strategy_link`;
CREATE TABLE `user_login_lock_strategy_link` (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `strategy_id` bigint(20) NOT NULL COMMENT '锁定策略id',
  `use_scope` tinyint(2) NOT NULL COMMENT '适用范围: 0全部用户，1用户，2用户类型，3组织，4岗位，5角色',
  `data_id` bigint(20) NOT NULL COMMENT '主键',
  `creator` varchar(64) DEFAULT NULL COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `updater` varchar(64) DEFAULT NULL COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `eid` varchar(32) DEFAULT NULL COMMENT '企业编码',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `index_strategy_id` (`strategy_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='用户登录锁定策略表适用范围关联表';

DROP TABLE IF EXISTS `version`;
CREATE TABLE `version` (
  `component` varchar(32) DEFAULT NULL COMMENT '组件',
  `version_timestamp` int(11) DEFAULT '0' COMMENT '版本时间戳'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='版本控制表';

DROP TABLE IF EXISTS `worker_node`;
CREATE TABLE `worker_node` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increment id',
  `host_name` varchar(64) NOT NULL COMMENT 'host name',
  `port` varchar(64) NOT NULL COMMENT 'port',
  `type` int(11) NOT NULL COMMENT 'node type: CONTAINER(1), ACTUAL(2), FAKE(3)',
  `launch_date` date NOT NULL COMMENT 'launch date',
  `modified` datetime NOT NULL COMMENT 'modified time',
  `created` datetime NOT NULL COMMENT 'created time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='DB WorkerID Assigner for UID Generator';

DROP TABLE IF EXISTS `xxl_job_group`;
CREATE TABLE `xxl_job_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(64) NOT NULL COMMENT '执行器AppName',
  `title` varchar(12) NOT NULL COMMENT '执行器名称',
  `address_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '执行器地址类型：0=自动注册、1=手动录入',
  `address_list` text COMMENT '执行器地址列表，多地址逗号分隔',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `xxl_job_info`;
CREATE TABLE `xxl_job_info` (
  `id` int(11) NOT NULL,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_desc` varchar(255) NOT NULL,
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `author` varchar(64) DEFAULT NULL COMMENT '作者',
  `alarm_email` varchar(255) DEFAULT NULL COMMENT '报警邮件',
  `schedule_type` varchar(50) NOT NULL DEFAULT 'NONE' COMMENT '调度类型',
  `schedule_conf` varchar(128) DEFAULT NULL COMMENT '调度配置，值含义取决于调度类型',
  `misfire_strategy` varchar(50) NOT NULL DEFAULT 'DO_NOTHING' COMMENT '调度过期策略',
  `executor_route_strategy` varchar(50) DEFAULT NULL COMMENT '执行器路由策略',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_block_strategy` varchar(50) DEFAULT NULL COMMENT '阻塞处理策略',
  `executor_timeout` int(11) NOT NULL DEFAULT '0' COMMENT '任务执行超时时间，单位秒',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
  `glue_type` varchar(50) NOT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) DEFAULT NULL COMMENT 'GLUE备注',
  `glue_updatetime` datetime DEFAULT NULL COMMENT 'GLUE更新时间',
  `child_jobid` varchar(255) DEFAULT NULL COMMENT '子任务ID，多个逗号分隔',
  `trigger_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '调度状态：0-停止，1-运行',
  `trigger_last_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '上次调度时间',
  `trigger_next_time` bigint(13) NOT NULL DEFAULT '0' COMMENT '下次调度时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `xxl_job_lock`;
CREATE TABLE `xxl_job_lock` (
  `lock_name` varchar(50) NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`lock_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `xxl_job_log`;
CREATE TABLE `xxl_job_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `job_group` int(11) NOT NULL COMMENT '执行器主键ID',
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `executor_address` varchar(255) DEFAULT NULL COMMENT '执行器地址，本次执行的地址',
  `executor_handler` varchar(255) DEFAULT NULL COMMENT '执行器任务handler',
  `executor_param` varchar(512) DEFAULT NULL COMMENT '执行器任务参数',
  `executor_sharding_param` varchar(20) DEFAULT NULL COMMENT '执行器任务分片参数，格式如 1/2',
  `executor_fail_retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '失败重试次数',
  `trigger_time` datetime DEFAULT NULL COMMENT '调度-时间',
  `trigger_code` int(11) NOT NULL COMMENT '调度-结果',
  `trigger_msg` text COMMENT '调度-日志',
  `handle_time` datetime DEFAULT NULL COMMENT '执行-时间',
  `handle_code` int(11) NOT NULL COMMENT '执行-状态',
  `handle_msg` text COMMENT '执行-日志',
  `alarm_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `I_trigger_time` (`trigger_time`) USING BTREE,
  KEY `I_handle_code` (`handle_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `xxl_job_log_report`;
CREATE TABLE `xxl_job_log_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trigger_day` datetime DEFAULT NULL COMMENT '调度-时间',
  `running_count` int(11) NOT NULL DEFAULT '0' COMMENT '运行中-日志数量',
  `suc_count` int(11) NOT NULL DEFAULT '0' COMMENT '执行成功-日志数量',
  `fail_count` int(11) NOT NULL DEFAULT '0' COMMENT '执行失败-日志数量',
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `i_trigger_day` (`trigger_day`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `xxl_job_logglue`;
CREATE TABLE `xxl_job_logglue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_id` int(11) NOT NULL COMMENT '任务，主键ID',
  `glue_type` varchar(50) DEFAULT NULL COMMENT 'GLUE类型',
  `glue_source` mediumtext COMMENT 'GLUE源代码',
  `glue_remark` varchar(128) NOT NULL COMMENT 'GLUE备注',
  `add_time` datetime DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

DROP TABLE IF EXISTS `xxl_job_registry`;
CREATE TABLE `xxl_job_registry` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `registry_group` varchar(50) NOT NULL,
  `registry_key` varchar(255) NOT NULL,
  `registry_value` varchar(255) NOT NULL,
  `update_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `i_g_k_v` (`registry_group`,`registry_key`,`registry_value`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

