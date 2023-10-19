-- ----------------------------
-- Table structure for bootstrap
-- ----------------------------
DROP TABLE IF EXISTS `bootstrap`;
CREATE TABLE `bootstrap` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `database_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `table_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `where_clause` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `is_complete` tinyint unsigned NOT NULL DEFAULT '0',
  `inserted_rows` bigint unsigned NOT NULL DEFAULT '0',
  `total_rows` bigint unsigned NOT NULL DEFAULT '0',
  `created_at` datetime DEFAULT NULL,
  `started_at` datetime DEFAULT NULL,
  `completed_at` datetime DEFAULT NULL,
  `binlog_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `binlog_position` int unsigned DEFAULT '0',
  `client_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'maxwell',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for columns
-- ----------------------------
DROP TABLE IF EXISTS `columns`;
CREATE TABLE `columns` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `schema_id` bigint DEFAULT NULL,
  `table_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `charset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `coltype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `is_signed` tinyint unsigned DEFAULT NULL,
  `enum_values` text CHARACTER SET utf8 COLLATE utf8_general_ci,
  `column_length` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schema_id` (`schema_id`),
  KEY `table_id` (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5785 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for databases
-- ----------------------------
DROP TABLE IF EXISTS `databases`;
CREATE TABLE `databases` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `schema_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `charset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schema_id` (`schema_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for heartbeats
-- ----------------------------
DROP TABLE IF EXISTS `heartbeats`;
CREATE TABLE `heartbeats` (
  `server_id` int unsigned NOT NULL,
  `client_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'maxwell',
  `heartbeat` bigint NOT NULL,
  PRIMARY KEY (`server_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for positions
-- ----------------------------
DROP TABLE IF EXISTS `positions`;
CREATE TABLE `positions` (
  `server_id` int unsigned NOT NULL,
  `binlog_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `binlog_position` int unsigned DEFAULT NULL,
  `gtid_set` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `client_id` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'maxwell',
  `heartbeat_at` bigint DEFAULT NULL,
  `last_heartbeat_read` bigint DEFAULT NULL,
  PRIMARY KEY (`server_id`,`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for schemas
-- ----------------------------
DROP TABLE IF EXISTS `schemas`;
CREATE TABLE `schemas` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `binlog_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `binlog_position` int unsigned DEFAULT NULL,
  `last_heartbeat_read` bigint DEFAULT '0',
  `gtid_set` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `base_schema_id` bigint DEFAULT NULL,
  `deltas` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `server_id` int unsigned DEFAULT NULL,
  `position_sha` char(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `charset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `version` smallint unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `position_sha` (`position_sha`)
) ENGINE=InnoDB AUTO_INCREMENT=260 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Table structure for tables
-- ----------------------------
DROP TABLE IF EXISTS `tables`;
CREATE TABLE `tables` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `schema_id` bigint DEFAULT NULL,
  `database_id` bigint DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `charset` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `pk` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `schema_id` (`schema_id`),
  KEY `database_id` (`database_id`)
) ENGINE=InnoDB AUTO_INCREMENT=555 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
