-- MySQL dump 10.11
--
-- Host: stv    Database: dhcp
-- ------------------------------------------------------
-- Server version	5.1.49-3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `config_nets`
--

DROP TABLE IF EXISTS `config_nets`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `config_nets` (
  `nettype` enum('CM','CPE','MTA') NOT NULL DEFAULT 'CPE',
  `netid` int(11) NOT NULL DEFAULT '0',
  `cmts_ip` varchar(16) NOT NULL DEFAULT '',
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  `network` varchar(20) NOT NULL DEFAULT '',
  `gateway` varchar(16) NOT NULL DEFAULT '',
  `grant_flag` tinyint(1) NOT NULL DEFAULT '1',
  `full_flag` tinyint(4) NOT NULL DEFAULT '0',
  `range_min` varchar(16) NOT NULL DEFAULT '',
  `range_max` varchar(16) NOT NULL DEFAULT '',
  `config_opt1` tinyint(4) NOT NULL DEFAULT '0',
  `config_opt2` tinyint(4) NOT NULL DEFAULT '0',
  `config_opt3` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`netid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `config_opts`
--

DROP TABLE IF EXISTS `config_opts`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `config_opts` (
  `opt_id` tinyint(4) NOT NULL DEFAULT '0',
  `opt_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `opt_len` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `opt_dtype` enum('IP','2IP','INT8','UINT8','INT16','UINT16','INT32','UINT32','CHAR','SUBOPT','TYPEIP','TYPECHAR') NOT NULL DEFAULT 'CHAR',
  `opt_value` varchar(250) NOT NULL,
  `sub_opt` tinyint(4) NOT NULL DEFAULT '0',
  `comment` varchar(250) NOT NULL,
  PRIMARY KEY (`opt_id`,`opt_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `counter201110`
--

DROP TABLE IF EXISTS `counter201110`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `counter201110` (
  `idcounter` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(12) NOT NULL,
  `traffic` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`idcounter`)
) ENGINE=MyISAM AUTO_INCREMENT=792 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `counter201111`
--

DROP TABLE IF EXISTS `counter201111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `counter201111` (
  `idcounter` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(12) NOT NULL,
  `traffic` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`idcounter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `counter201112`
--

DROP TABLE IF EXISTS `counter201112`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `counter201112` (
  `idcounter` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(12) NOT NULL,
  `traffic` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`idcounter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `counter201201`
--

DROP TABLE IF EXISTS `counter201201`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `counter201201` (
  `idcounter` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(12) NOT NULL,
  `traffic` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`idcounter`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `counter201202`
--

DROP TABLE IF EXISTS `counter201202`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `counter201202` (
  `idcounter` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(12) NOT NULL,
  `traffic` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`idcounter`)
) ENGINE=MyISAM AUTO_INCREMENT=936 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `counter201203`
--

DROP TABLE IF EXISTS `counter201203`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `counter201203` (
  `idcounter` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(12) NOT NULL,
  `traffic` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`idcounter`)
) ENGINE=MyISAM AUTO_INCREMENT=746 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease`
--

DROP TABLE IF EXISTS `cust_lease`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110307`
--

DROP TABLE IF EXISTS `cust_lease20110307`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110307` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110316`
--

DROP TABLE IF EXISTS `cust_lease20110316`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110316` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110325`
--

DROP TABLE IF EXISTS `cust_lease20110325`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110325` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110329`
--

DROP TABLE IF EXISTS `cust_lease20110329`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110329` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110330`
--

DROP TABLE IF EXISTS `cust_lease20110330`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110330` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110331`
--

DROP TABLE IF EXISTS `cust_lease20110331`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110331` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110401`
--

DROP TABLE IF EXISTS `cust_lease20110401`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110401` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110402`
--

DROP TABLE IF EXISTS `cust_lease20110402`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110402` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110404`
--

DROP TABLE IF EXISTS `cust_lease20110404`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110404` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110408`
--

DROP TABLE IF EXISTS `cust_lease20110408`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110408` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110410`
--

DROP TABLE IF EXISTS `cust_lease20110410`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110410` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110411`
--

DROP TABLE IF EXISTS `cust_lease20110411`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110411` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110412`
--

DROP TABLE IF EXISTS `cust_lease20110412`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110412` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110413`
--

DROP TABLE IF EXISTS `cust_lease20110413`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110413` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease20110414`
--

DROP TABLE IF EXISTS `cust_lease20110414`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease20110414` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease_Abr042011`
--

DROP TABLE IF EXISTS `cust_lease_Abr042011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease_Abr042011` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease_back`
--

DROP TABLE IF EXISTS `cust_lease_back`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease_back` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_lease_fail`
--

DROP TABLE IF EXISTS `cust_lease_fail`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_lease_fail` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `start_time` (`start_time`),
  KEY `end_time` (`end_time`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `cust_static`
--

DROP TABLE IF EXISTS `cust_static`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `cust_static` (
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '1',
  `subnum` bigint(20) NOT NULL,
  PRIMARY KEY (`ipaddr`),
  UNIQUE KEY `macaddr` (`macaddr`),
  KEY `subnum` (`subnum`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `deleted_leases`
--

DROP TABLE IF EXISTS `deleted_leases`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `deleted_leases` (
  `deletion_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `deleted_leases_temp`
--

DROP TABLE IF EXISTS `deleted_leases_temp`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `deleted_leases_temp` (
  `deletion_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ipaddr` varchar(16) NOT NULL,
  `macaddr` varchar(15) NOT NULL,
  `real_start` datetime DEFAULT NULL,
  `real_end` datetime DEFAULT NULL,
  `start_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `update_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pc_name` varchar(50) NOT NULL,
  `modem_macaddr` varchar(15) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dhcp_log_20110307`
--

DROP TABLE IF EXISTS `dhcp_log_20110307`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `dhcp_log_20110307` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `thetime` time NOT NULL DEFAULT '00:00:00',
  `sending` enum('ACK','NACK','OFFER','Q_ACK') NOT NULL DEFAULT 'ACK',
  `macaddr` varchar(16) NOT NULL,
  `ipaddr` varchar(16) NOT NULL,
  `modem_macaddr` varchar(16) NOT NULL,
  KEY `thedate` (`thedate`,`thetime`),
  KEY `macaddr` (`macaddr`),
  KEY `ipaddr` (`ipaddr`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dhcp_summary`
--

DROP TABLE IF EXISTS `dhcp_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `dhcp_summary` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `macaddr` varchar(16) NOT NULL,
  `ipaddr` varchar(16) NOT NULL,
  `sending` enum('ACK','NACK','OFFER','Q_ACK') NOT NULL DEFAULT 'ACK',
  `modem_macaddr` varchar(16) NOT NULL,
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`thedate`,`macaddr`,`ipaddr`,`sending`,`modem_macaddr`),
  KEY `macaddr` (`macaddr`),
  KEY `ipaddr` (`ipaddr`),
  KEY `modem_macaddr` (`modem_macaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `dhcpsignal`
--

DROP TABLE IF EXISTS `dhcpsignal`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `dhcpsignal` (
  `iddhcpsignal` int(11) NOT NULL AUTO_INCREMENT,
  `reboot` int(11) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`iddhcpsignal`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `docsis_update`
--

DROP TABLE IF EXISTS `docsis_update`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `docsis_update` (
  `macaddr` varchar(15) NOT NULL,
  `cmts_ip` varchar(16) NOT NULL,
  `agentid` varchar(20) NOT NULL,
  `thetime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`macaddr`),
  KEY `thetime` (`thetime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `docsismodem`
--

DROP TABLE IF EXISTS `docsismodem`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `docsismodem` (
  `macaddr` varchar(15) NOT NULL DEFAULT '',
  `first_online` datetime DEFAULT NULL,
  `last_online` datetime DEFAULT NULL,
  `reg_count` int(11) NOT NULL DEFAULT '0',
  `serialnum` varchar(30) NOT NULL DEFAULT '',
  `ipaddr` varchar(16) NOT NULL DEFAULT '',
  `config_file` varchar(50) NOT NULL DEFAULT '',
  `cmts_vlan` mediumint(9) NOT NULL DEFAULT '0',
  `id_aparelho` int(11) NOT NULL DEFAULT '0',
  `id_servico` int(11) NOT NULL DEFAULT '0',
  `subnum` bigint(20) DEFAULT '0',
  `estado` enum('activo','anulado','cortado') DEFAULT 'activo',
  `datamudado` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `lastip` varchar(60) DEFAULT NULL,
  `tel1` varchar(14) DEFAULT NULL,
  `tel2` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`macaddr`),
  UNIQUE KEY `ipaddr` (`ipaddr`),
  UNIQUE KEY `serialnum` (`serialnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease`
--

DROP TABLE IF EXISTS `historiclease`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=501 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease10102011`
--

DROP TABLE IF EXISTS `historiclease10102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease10102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=74690 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease10112011`
--

DROP TABLE IF EXISTS `historiclease10112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease10112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88770 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1012012`
--

DROP TABLE IF EXISTS `historiclease1012012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1012012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98301 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease10122011`
--

DROP TABLE IF EXISTS `historiclease10122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease10122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90425 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1022012`
--

DROP TABLE IF EXISTS `historiclease1022012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1022012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99151 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1032012`
--

DROP TABLE IF EXISTS `historiclease1032012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1032012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=104277 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease104111`
--

DROP TABLE IF EXISTS `historiclease104111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease104111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=61552 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease105111`
--

DROP TABLE IF EXISTS `historiclease105111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease105111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69429 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease106111`
--

DROP TABLE IF EXISTS `historiclease106111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease106111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68603 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1082011`
--

DROP TABLE IF EXISTS `historiclease1082011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1082011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=75717 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1092011`
--

DROP TABLE IF EXISTS `historiclease1092011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1092011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71857 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1102011`
--

DROP TABLE IF EXISTS `historiclease1102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72981 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease11102011`
--

DROP TABLE IF EXISTS `historiclease11102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease11102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72702 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease11112011`
--

DROP TABLE IF EXISTS `historiclease11112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease11112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=87679 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1112011`
--

DROP TABLE IF EXISTS `historiclease1112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=94717 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1112012`
--

DROP TABLE IF EXISTS `historiclease1112012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1112012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=97638 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease11122011`
--

DROP TABLE IF EXISTS `historiclease11122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease11122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=92609 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease112012`
--

DROP TABLE IF EXISTS `historiclease112012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease112012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=93364 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1122011`
--

DROP TABLE IF EXISTS `historiclease1122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90862 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1122012`
--

DROP TABLE IF EXISTS `historiclease1122012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1122012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100780 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1132012`
--

DROP TABLE IF EXISTS `historiclease1132012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1132012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=104421 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease114111`
--

DROP TABLE IF EXISTS `historiclease114111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease114111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63058 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease115111`
--

DROP TABLE IF EXISTS `historiclease115111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease115111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70124 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease116111`
--

DROP TABLE IF EXISTS `historiclease116111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease116111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68308 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1182011`
--

DROP TABLE IF EXISTS `historiclease1182011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1182011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68581 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1192011`
--

DROP TABLE IF EXISTS `historiclease1192011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1192011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71091 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease12102011`
--

DROP TABLE IF EXISTS `historiclease12102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease12102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73053 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease12112011`
--

DROP TABLE IF EXISTS `historiclease12112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease12112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89165 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1212012`
--

DROP TABLE IF EXISTS `historiclease1212012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1212012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98485 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease12122011`
--

DROP TABLE IF EXISTS `historiclease12122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease12122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90545 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease122012`
--

DROP TABLE IF EXISTS `historiclease122012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease122012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102904 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1222012`
--

DROP TABLE IF EXISTS `historiclease1222012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1222012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99875 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1232012`
--

DROP TABLE IF EXISTS `historiclease1232012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1232012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103437 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease124111`
--

DROP TABLE IF EXISTS `historiclease124111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease124111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63552 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease125111`
--

DROP TABLE IF EXISTS `historiclease125111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease125111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68589 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease126111`
--

DROP TABLE IF EXISTS `historiclease126111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease126111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68626 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1282011`
--

DROP TABLE IF EXISTS `historiclease1282011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1282011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68741 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1292011`
--

DROP TABLE IF EXISTS `historiclease1292011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1292011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71632 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease13102011`
--

DROP TABLE IF EXISTS `historiclease13102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease13102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73674 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease13112011`
--

DROP TABLE IF EXISTS `historiclease13112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease13112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88949 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1312012`
--

DROP TABLE IF EXISTS `historiclease1312012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1312012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98291 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease13122011`
--

DROP TABLE IF EXISTS `historiclease13122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease13122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88868 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease132012`
--

DROP TABLE IF EXISTS `historiclease132012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease132012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101044 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1322012`
--

DROP TABLE IF EXISTS `historiclease1322012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1322012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100599 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1332012`
--

DROP TABLE IF EXISTS `historiclease1332012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1332012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102271 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease134111`
--

DROP TABLE IF EXISTS `historiclease134111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease134111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63601 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease135111`
--

DROP TABLE IF EXISTS `historiclease135111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease135111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68986 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease136111`
--

DROP TABLE IF EXISTS `historiclease136111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease136111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70189 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1382011`
--

DROP TABLE IF EXISTS `historiclease1382011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1382011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=74040 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1392011`
--

DROP TABLE IF EXISTS `historiclease1392011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1392011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71165 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease14102011`
--

DROP TABLE IF EXISTS `historiclease14102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease14102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73721 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease14111`
--

DROP TABLE IF EXISTS `historiclease14111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease14111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63879 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease14112011`
--

DROP TABLE IF EXISTS `historiclease14112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease14112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=87866 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1412012`
--

DROP TABLE IF EXISTS `historiclease1412012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1412012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99383 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease14122011`
--

DROP TABLE IF EXISTS `historiclease14122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease14122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89372 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1422012`
--

DROP TABLE IF EXISTS `historiclease1422012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1422012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98777 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease143111`
--

DROP TABLE IF EXISTS `historiclease143111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease143111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=56781 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1432012`
--

DROP TABLE IF EXISTS `historiclease1432012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1432012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103326 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease144111`
--

DROP TABLE IF EXISTS `historiclease144111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease144111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64986 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease145111`
--

DROP TABLE IF EXISTS `historiclease145111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease145111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68619 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease146111`
--

DROP TABLE IF EXISTS `historiclease146111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease146111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70154 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1482011`
--

DROP TABLE IF EXISTS `historiclease1482011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1482011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=83674 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1492011`
--

DROP TABLE IF EXISTS `historiclease1492011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1492011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71287 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease15102011`
--

DROP TABLE IF EXISTS `historiclease15102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease15102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=82440 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease15111`
--

DROP TABLE IF EXISTS `historiclease15111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease15111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65211 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease15112011`
--

DROP TABLE IF EXISTS `historiclease15112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease15112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88571 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1512012`
--

DROP TABLE IF EXISTS `historiclease1512012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1512012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98940 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease15122011`
--

DROP TABLE IF EXISTS `historiclease15122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease15122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88716 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1522012`
--

DROP TABLE IF EXISTS `historiclease1522012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1522012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99265 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease153111`
--

DROP TABLE IF EXISTS `historiclease153111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease153111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69353 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1532012`
--

DROP TABLE IF EXISTS `historiclease1532012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1532012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73298 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease154111`
--

DROP TABLE IF EXISTS `historiclease154111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease154111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65363 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease155111`
--

DROP TABLE IF EXISTS `historiclease155111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease155111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69604 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease156111`
--

DROP TABLE IF EXISTS `historiclease156111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease156111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69928 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1582011`
--

DROP TABLE IF EXISTS `historiclease1582011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1582011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68121 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1592011`
--

DROP TABLE IF EXISTS `historiclease1592011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1592011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70486 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease16102011`
--

DROP TABLE IF EXISTS `historiclease16102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease16102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=79877 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease16111`
--

DROP TABLE IF EXISTS `historiclease16111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease16111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69453 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease16112011`
--

DROP TABLE IF EXISTS `historiclease16112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease16112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=87764 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1612012`
--

DROP TABLE IF EXISTS `historiclease1612012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1612012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98018 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease16122011`
--

DROP TABLE IF EXISTS `historiclease16122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease16122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90119 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1622012`
--

DROP TABLE IF EXISTS `historiclease1622012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1622012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98021 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease163111`
--

DROP TABLE IF EXISTS `historiclease163111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease163111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69463 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease164111`
--

DROP TABLE IF EXISTS `historiclease164111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease164111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65181 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease165111`
--

DROP TABLE IF EXISTS `historiclease165111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease165111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68817 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease166111`
--

DROP TABLE IF EXISTS `historiclease166111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease166111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70895 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1672011`
--

DROP TABLE IF EXISTS `historiclease1672011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1672011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=282 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1682011`
--

DROP TABLE IF EXISTS `historiclease1682011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1682011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=79925 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1692011`
--

DROP TABLE IF EXISTS `historiclease1692011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1692011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69409 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease17102011`
--

DROP TABLE IF EXISTS `historiclease17102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease17102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=79319 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease17112011`
--

DROP TABLE IF EXISTS `historiclease17112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease17112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89368 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1712012`
--

DROP TABLE IF EXISTS `historiclease1712012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1712012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98584 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease17122011`
--

DROP TABLE IF EXISTS `historiclease17122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease17122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=91418 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1722012`
--

DROP TABLE IF EXISTS `historiclease1722012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1722012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=97884 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease173111`
--

DROP TABLE IF EXISTS `historiclease173111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease173111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70319 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease174111`
--

DROP TABLE IF EXISTS `historiclease174111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease174111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64449 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease175111`
--

DROP TABLE IF EXISTS `historiclease175111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease175111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68781 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease176111`
--

DROP TABLE IF EXISTS `historiclease176111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease176111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=2553 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1772011`
--

DROP TABLE IF EXISTS `historiclease1772011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1772011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68709 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1782011`
--

DROP TABLE IF EXISTS `historiclease1782011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1782011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68982 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1792011`
--

DROP TABLE IF EXISTS `historiclease1792011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1792011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72362 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease18102011`
--

DROP TABLE IF EXISTS `historiclease18102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease18102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=80004 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease18112011`
--

DROP TABLE IF EXISTS `historiclease18112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease18112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89800 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1812012`
--

DROP TABLE IF EXISTS `historiclease1812012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1812012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100714 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease18122011`
--

DROP TABLE IF EXISTS `historiclease18122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease18122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90440 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease182011`
--

DROP TABLE IF EXISTS `historiclease182011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease182011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68469 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1822012`
--

DROP TABLE IF EXISTS `historiclease1822012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1822012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99469 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease183111`
--

DROP TABLE IF EXISTS `historiclease183111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease183111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70489 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease184111`
--

DROP TABLE IF EXISTS `historiclease184111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease184111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=66256 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease185111`
--

DROP TABLE IF EXISTS `historiclease185111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease185111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69496 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1872011`
--

DROP TABLE IF EXISTS `historiclease1872011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1872011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69754 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1882011`
--

DROP TABLE IF EXISTS `historiclease1882011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1882011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68882 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1892011`
--

DROP TABLE IF EXISTS `historiclease1892011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1892011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72088 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease19102011`
--

DROP TABLE IF EXISTS `historiclease19102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease19102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=81908 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease19112011`
--

DROP TABLE IF EXISTS `historiclease19112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease19112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89447 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1912012`
--

DROP TABLE IF EXISTS `historiclease1912012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1912012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100593 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease19122011`
--

DROP TABLE IF EXISTS `historiclease19122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease19122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90532 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease192011`
--

DROP TABLE IF EXISTS `historiclease192011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease192011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69229 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1922012`
--

DROP TABLE IF EXISTS `historiclease1922012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1922012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101811 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease193111`
--

DROP TABLE IF EXISTS `historiclease193111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease193111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70931 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease194111`
--

DROP TABLE IF EXISTS `historiclease194111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease194111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=66836 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease195111`
--

DROP TABLE IF EXISTS `historiclease195111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease195111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69397 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1972011`
--

DROP TABLE IF EXISTS `historiclease1972011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1972011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68073 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1982011`
--

DROP TABLE IF EXISTS `historiclease1982011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1982011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=74903 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease1992011`
--

DROP TABLE IF EXISTS `historiclease1992011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease1992011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72543 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease20102011`
--

DROP TABLE IF EXISTS `historiclease20102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease20102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89231 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease20112011`
--

DROP TABLE IF EXISTS `historiclease20112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease20112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88330 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2012012`
--

DROP TABLE IF EXISTS `historiclease2012012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2012012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101301 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease20122011`
--

DROP TABLE IF EXISTS `historiclease20122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease20122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90627 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2022012`
--

DROP TABLE IF EXISTS `historiclease2022012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2022012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102301 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease203111`
--

DROP TABLE IF EXISTS `historiclease203111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease203111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70501 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease204111`
--

DROP TABLE IF EXISTS `historiclease204111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease204111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63245 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease205111`
--

DROP TABLE IF EXISTS `historiclease205111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease205111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69569 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2072011`
--

DROP TABLE IF EXISTS `historiclease2072011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2072011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69237 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2082011`
--

DROP TABLE IF EXISTS `historiclease2082011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2082011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85899 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2092011`
--

DROP TABLE IF EXISTS `historiclease2092011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2092011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70872 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2102011`
--

DROP TABLE IF EXISTS `historiclease2102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=74321 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease21102011`
--

DROP TABLE IF EXISTS `historiclease21102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease21102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=93988 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease21112011`
--

DROP TABLE IF EXISTS `historiclease21112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease21112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=87823 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2112011`
--

DROP TABLE IF EXISTS `historiclease2112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85715 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2112012`
--

DROP TABLE IF EXISTS `historiclease2112012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2112012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101170 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease21122011`
--

DROP TABLE IF EXISTS `historiclease21122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease21122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=91855 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease212012`
--

DROP TABLE IF EXISTS `historiclease212012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease212012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=94345 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2122011`
--

DROP TABLE IF EXISTS `historiclease2122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89946 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2122012`
--

DROP TABLE IF EXISTS `historiclease2122012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2122012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=96781 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease213111`
--

DROP TABLE IF EXISTS `historiclease213111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease213111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `remoteid` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64753 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease214111`
--

DROP TABLE IF EXISTS `historiclease214111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease214111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65513 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease215111`
--

DROP TABLE IF EXISTS `historiclease215111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease215111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68912 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2172011`
--

DROP TABLE IF EXISTS `historiclease2172011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2172011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68733 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2182011`
--

DROP TABLE IF EXISTS `historiclease2182011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2182011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64183 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2192011`
--

DROP TABLE IF EXISTS `historiclease2192011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2192011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70503 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease22102011`
--

DROP TABLE IF EXISTS `historiclease22102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease22102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99077 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease22112011`
--

DROP TABLE IF EXISTS `historiclease22112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease22112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88027 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2212012`
--

DROP TABLE IF EXISTS `historiclease2212012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2212012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98726 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease22122011`
--

DROP TABLE IF EXISTS `historiclease22122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease22122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=92749 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease222012`
--

DROP TABLE IF EXISTS `historiclease222012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease222012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102440 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2222012`
--

DROP TABLE IF EXISTS `historiclease2222012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2222012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103101 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease223111`
--

DROP TABLE IF EXISTS `historiclease223111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease223111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65495 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease224111`
--

DROP TABLE IF EXISTS `historiclease224111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease224111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65446 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease225111`
--

DROP TABLE IF EXISTS `historiclease225111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease225111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68485 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2272011`
--

DROP TABLE IF EXISTS `historiclease2272011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2272011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68413 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2282011`
--

DROP TABLE IF EXISTS `historiclease2282011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2282011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65483 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2292011`
--

DROP TABLE IF EXISTS `historiclease2292011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2292011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71983 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease23102011`
--

DROP TABLE IF EXISTS `historiclease23102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease23102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=105118 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease23112011`
--

DROP TABLE IF EXISTS `historiclease23112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease23112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88897 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2312012`
--

DROP TABLE IF EXISTS `historiclease2312012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2312012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99690 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease23122011`
--

DROP TABLE IF EXISTS `historiclease23122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease23122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=91804 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease232012`
--

DROP TABLE IF EXISTS `historiclease232012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease232012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101047 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2322012`
--

DROP TABLE IF EXISTS `historiclease2322012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2322012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99734 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease233111`
--

DROP TABLE IF EXISTS `historiclease233111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease233111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65234 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease234111`
--

DROP TABLE IF EXISTS `historiclease234111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease234111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65184 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease235111`
--

DROP TABLE IF EXISTS `historiclease235111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease235111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70721 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2372011`
--

DROP TABLE IF EXISTS `historiclease2372011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2372011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68194 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2382011`
--

DROP TABLE IF EXISTS `historiclease2382011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2382011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68436 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2392011`
--

DROP TABLE IF EXISTS `historiclease2392011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2392011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71853 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease24102011`
--

DROP TABLE IF EXISTS `historiclease24102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease24102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=119961 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease24111`
--

DROP TABLE IF EXISTS `historiclease24111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease24111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=43438 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease24112011`
--

DROP TABLE IF EXISTS `historiclease24112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease24112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88892 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2412012`
--

DROP TABLE IF EXISTS `historiclease2412012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2412012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99755 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease24122011`
--

DROP TABLE IF EXISTS `historiclease24122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease24122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=92281 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2422012`
--

DROP TABLE IF EXISTS `historiclease2422012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2422012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100271 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease243111`
--

DROP TABLE IF EXISTS `historiclease243111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease243111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=61391 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease244111`
--

DROP TABLE IF EXISTS `historiclease244111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease244111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64541 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease245111`
--

DROP TABLE IF EXISTS `historiclease245111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease245111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71268 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2472011`
--

DROP TABLE IF EXISTS `historiclease2472011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2472011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69214 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2482011`
--

DROP TABLE IF EXISTS `historiclease2482011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2482011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68249 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2492011`
--

DROP TABLE IF EXISTS `historiclease2492011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2492011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72725 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease25102011`
--

DROP TABLE IF EXISTS `historiclease25102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease25102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=83583 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease25111`
--

DROP TABLE IF EXISTS `historiclease25111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease25111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65619 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease25112011`
--

DROP TABLE IF EXISTS `historiclease25112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease25112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88813 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2512012`
--

DROP TABLE IF EXISTS `historiclease2512012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2512012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100198 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease25122011`
--

DROP TABLE IF EXISTS `historiclease25122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease25122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=91834 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2522012`
--

DROP TABLE IF EXISTS `historiclease2522012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2522012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102823 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease253111`
--

DROP TABLE IF EXISTS `historiclease253111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease253111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64947 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease254111`
--

DROP TABLE IF EXISTS `historiclease254111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease254111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64643 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease255111`
--

DROP TABLE IF EXISTS `historiclease255111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease255111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69411 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2572011`
--

DROP TABLE IF EXISTS `historiclease2572011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2572011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68939 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2582011`
--

DROP TABLE IF EXISTS `historiclease2582011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2582011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68325 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2592011`
--

DROP TABLE IF EXISTS `historiclease2592011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2592011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72474 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease26102011`
--

DROP TABLE IF EXISTS `historiclease26102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease26102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85377 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease26111`
--

DROP TABLE IF EXISTS `historiclease26111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease26111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68937 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease26112011`
--

DROP TABLE IF EXISTS `historiclease26112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease26112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90041 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2612012`
--

DROP TABLE IF EXISTS `historiclease2612012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2612012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99692 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease26122011`
--

DROP TABLE IF EXISTS `historiclease26122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease26122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=93341 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2622012`
--

DROP TABLE IF EXISTS `historiclease2622012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2622012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103696 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease263111`
--

DROP TABLE IF EXISTS `historiclease263111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease263111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=58628 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease264111`
--

DROP TABLE IF EXISTS `historiclease264111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease264111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=64645 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease265111`
--

DROP TABLE IF EXISTS `historiclease265111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease265111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69764 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2672011`
--

DROP TABLE IF EXISTS `historiclease2672011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2672011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68721 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2682011`
--

DROP TABLE IF EXISTS `historiclease2682011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2682011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=67905 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2692011`
--

DROP TABLE IF EXISTS `historiclease2692011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2692011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73562 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease27102011`
--

DROP TABLE IF EXISTS `historiclease27102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease27102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85269 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease27112011`
--

DROP TABLE IF EXISTS `historiclease27112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease27112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90380 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2712012`
--

DROP TABLE IF EXISTS `historiclease2712012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2712012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=99630 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease27122011`
--

DROP TABLE IF EXISTS `historiclease27122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease27122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=92899 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2722012`
--

DROP TABLE IF EXISTS `historiclease2722012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2722012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101060 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease273111`
--

DROP TABLE IF EXISTS `historiclease273111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease273111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=46542 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease274111`
--

DROP TABLE IF EXISTS `historiclease274111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease274111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65564 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease275111`
--

DROP TABLE IF EXISTS `historiclease275111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease275111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68771 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2772011`
--

DROP TABLE IF EXISTS `historiclease2772011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2772011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=67644 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2782011`
--

DROP TABLE IF EXISTS `historiclease2782011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2782011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=67425 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2792011`
--

DROP TABLE IF EXISTS `historiclease2792011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2792011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71935 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease28102011`
--

DROP TABLE IF EXISTS `historiclease28102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease28102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85014 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease28112011`
--

DROP TABLE IF EXISTS `historiclease28112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease28112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89205 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2812012`
--

DROP TABLE IF EXISTS `historiclease2812012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2812012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100735 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease28122011`
--

DROP TABLE IF EXISTS `historiclease28122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease28122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=94711 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease282011`
--

DROP TABLE IF EXISTS `historiclease282011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease282011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73516 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2822012`
--

DROP TABLE IF EXISTS `historiclease2822012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2822012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101422 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease283111`
--

DROP TABLE IF EXISTS `historiclease283111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease283111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=57272 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease284111`
--

DROP TABLE IF EXISTS `historiclease284111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease284111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=66502 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease285111`
--

DROP TABLE IF EXISTS `historiclease285111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease285111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68721 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2872011`
--

DROP TABLE IF EXISTS `historiclease2872011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2872011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69148 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2882011`
--

DROP TABLE IF EXISTS `historiclease2882011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2882011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68518 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2892011`
--

DROP TABLE IF EXISTS `historiclease2892011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2892011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71643 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease29102011`
--

DROP TABLE IF EXISTS `historiclease29102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease29102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85950 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease29112011`
--

DROP TABLE IF EXISTS `historiclease29112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease29112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90317 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2912012`
--

DROP TABLE IF EXISTS `historiclease2912012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2912012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101835 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease29122011`
--

DROP TABLE IF EXISTS `historiclease29122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease29122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=95021 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease292011`
--

DROP TABLE IF EXISTS `historiclease292011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease292011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68870 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2922012`
--

DROP TABLE IF EXISTS `historiclease2922012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2922012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101329 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease293111`
--

DROP TABLE IF EXISTS `historiclease293111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease293111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=60297 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease294111`
--

DROP TABLE IF EXISTS `historiclease294111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease294111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63423 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease295111`
--

DROP TABLE IF EXISTS `historiclease295111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease295111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68223 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2972011`
--

DROP TABLE IF EXISTS `historiclease2972011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2972011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=76289 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2982011`
--

DROP TABLE IF EXISTS `historiclease2982011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2982011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69862 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease2992011`
--

DROP TABLE IF EXISTS `historiclease2992011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease2992011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71407 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease30102011`
--

DROP TABLE IF EXISTS `historiclease30102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease30102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89090 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease30112011`
--

DROP TABLE IF EXISTS `historiclease30112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease30112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89884 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3012012`
--

DROP TABLE IF EXISTS `historiclease3012012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3012012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100319 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease30122011`
--

DROP TABLE IF EXISTS `historiclease30122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease30122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=94941 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease303111`
--

DROP TABLE IF EXISTS `historiclease303111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease303111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63487 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease304111`
--

DROP TABLE IF EXISTS `historiclease304111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease304111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=63410 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease305111`
--

DROP TABLE IF EXISTS `historiclease305111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease305111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69816 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3072011`
--

DROP TABLE IF EXISTS `historiclease3072011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3072011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68646 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3082011`
--

DROP TABLE IF EXISTS `historiclease3082011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3082011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70162 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3092011`
--

DROP TABLE IF EXISTS `historiclease3092011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3092011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71960 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3102011`
--

DROP TABLE IF EXISTS `historiclease3102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73043 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease31102011`
--

DROP TABLE IF EXISTS `historiclease31102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease31102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=86155 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3112011`
--

DROP TABLE IF EXISTS `historiclease3112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=85026 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3112012`
--

DROP TABLE IF EXISTS `historiclease3112012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3112012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101418 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease31122011`
--

DROP TABLE IF EXISTS `historiclease31122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease31122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=95212 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease312012`
--

DROP TABLE IF EXISTS `historiclease312012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease312012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=93781 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3122011`
--

DROP TABLE IF EXISTS `historiclease3122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=91639 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease314111`
--

DROP TABLE IF EXISTS `historiclease314111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease314111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65355 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3172011`
--

DROP TABLE IF EXISTS `historiclease3172011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3172011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68037 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease3182011`
--

DROP TABLE IF EXISTS `historiclease3182011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease3182011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69979 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease322012`
--

DROP TABLE IF EXISTS `historiclease322012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease322012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101766 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease332012`
--

DROP TABLE IF EXISTS `historiclease332012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease332012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=104404 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease34111`
--

DROP TABLE IF EXISTS `historiclease34111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease34111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=47641 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease35111`
--

DROP TABLE IF EXISTS `historiclease35111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease35111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=66373 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease36111`
--

DROP TABLE IF EXISTS `historiclease36111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease36111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68241 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease382011`
--

DROP TABLE IF EXISTS `historiclease382011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease382011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69206 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease392011`
--

DROP TABLE IF EXISTS `historiclease392011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease392011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70140 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease4102011`
--

DROP TABLE IF EXISTS `historiclease4102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease4102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72640 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease4112011`
--

DROP TABLE IF EXISTS `historiclease4112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease4112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=86135 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease412012`
--

DROP TABLE IF EXISTS `historiclease412012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease412012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=94293 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease4122011`
--

DROP TABLE IF EXISTS `historiclease4122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease4122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=93250 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease422012`
--

DROP TABLE IF EXISTS `historiclease422012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease422012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=100955 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease432012`
--

DROP TABLE IF EXISTS `historiclease432012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease432012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=104352 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease44111`
--

DROP TABLE IF EXISTS `historiclease44111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease44111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=52662 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease45111`
--

DROP TABLE IF EXISTS `historiclease45111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease45111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=67439 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease46111`
--

DROP TABLE IF EXISTS `historiclease46111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease46111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69117 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease482011`
--

DROP TABLE IF EXISTS `historiclease482011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease482011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69356 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease492011`
--

DROP TABLE IF EXISTS `historiclease492011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease492011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70879 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease5102011`
--

DROP TABLE IF EXISTS `historiclease5102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease5102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=74554 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease5112011`
--

DROP TABLE IF EXISTS `historiclease5112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease5112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88056 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease512012`
--

DROP TABLE IF EXISTS `historiclease512012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease512012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=93958 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease5122011`
--

DROP TABLE IF EXISTS `historiclease5122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease5122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=91376 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease522012`
--

DROP TABLE IF EXISTS `historiclease522012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease522012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103245 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease532008`
--

DROP TABLE IF EXISTS `historiclease532008`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease532008` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease532012`
--

DROP TABLE IF EXISTS `historiclease532012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease532012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103314 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease54111`
--

DROP TABLE IF EXISTS `historiclease54111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease54111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=55463 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease55111`
--

DROP TABLE IF EXISTS `historiclease55111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease55111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=66631 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease56111`
--

DROP TABLE IF EXISTS `historiclease56111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease56111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69673 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease582011`
--

DROP TABLE IF EXISTS `historiclease582011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease582011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69615 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease592011`
--

DROP TABLE IF EXISTS `historiclease592011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease592011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70650 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease6102011`
--

DROP TABLE IF EXISTS `historiclease6102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease6102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=72824 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease6112011`
--

DROP TABLE IF EXISTS `historiclease6112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease6112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88135 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease612012`
--

DROP TABLE IF EXISTS `historiclease612012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease612012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=94638 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease6122011`
--

DROP TABLE IF EXISTS `historiclease6122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease6122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89991 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease622012`
--

DROP TABLE IF EXISTS `historiclease622012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease622012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=101316 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease632012`
--

DROP TABLE IF EXISTS `historiclease632012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease632012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102581 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease64111`
--

DROP TABLE IF EXISTS `historiclease64111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease64111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=57501 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease65111`
--

DROP TABLE IF EXISTS `historiclease65111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease65111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65814 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease66111`
--

DROP TABLE IF EXISTS `historiclease66111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease66111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68338 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease682011`
--

DROP TABLE IF EXISTS `historiclease682011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease682011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69946 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease692011`
--

DROP TABLE IF EXISTS `historiclease692011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease692011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70803 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease7102011`
--

DROP TABLE IF EXISTS `historiclease7102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease7102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73347 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease7112011`
--

DROP TABLE IF EXISTS `historiclease7112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease7112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=86349 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease712012`
--

DROP TABLE IF EXISTS `historiclease712012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease712012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=95891 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease7122011`
--

DROP TABLE IF EXISTS `historiclease7122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease7122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=89600 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease722012`
--

DROP TABLE IF EXISTS `historiclease722012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease722012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98443 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease732012`
--

DROP TABLE IF EXISTS `historiclease732012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease732012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102131 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease74111`
--

DROP TABLE IF EXISTS `historiclease74111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease74111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=61230 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease75111`
--

DROP TABLE IF EXISTS `historiclease75111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease75111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=65991 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease76111`
--

DROP TABLE IF EXISTS `historiclease76111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease76111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69158 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease782011`
--

DROP TABLE IF EXISTS `historiclease782011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease782011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68709 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease792011`
--

DROP TABLE IF EXISTS `historiclease792011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease792011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=71148 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease8102011`
--

DROP TABLE IF EXISTS `historiclease8102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease8102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=75886 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease8112011`
--

DROP TABLE IF EXISTS `historiclease8112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease8112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=86319 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease812012`
--

DROP TABLE IF EXISTS `historiclease812012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease812012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=95915 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease8122011`
--

DROP TABLE IF EXISTS `historiclease8122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease8122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=90672 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease822012`
--

DROP TABLE IF EXISTS `historiclease822012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease822012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=98890 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease832012`
--

DROP TABLE IF EXISTS `historiclease832012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease832012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=102018 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease84111`
--

DROP TABLE IF EXISTS `historiclease84111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease84111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=61906 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease85111`
--

DROP TABLE IF EXISTS `historiclease85111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease85111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=67334 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease86111`
--

DROP TABLE IF EXISTS `historiclease86111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease86111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=73107 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease882011`
--

DROP TABLE IF EXISTS `historiclease882011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease882011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70625 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease892011`
--

DROP TABLE IF EXISTS `historiclease892011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease892011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70478 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease9102011`
--

DROP TABLE IF EXISTS `historiclease9102011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease9102011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=75292 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease9112011`
--

DROP TABLE IF EXISTS `historiclease9112011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease9112011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=87925 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease912012`
--

DROP TABLE IF EXISTS `historiclease912012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease912012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=96439 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease9122011`
--

DROP TABLE IF EXISTS `historiclease9122011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease9122011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=88821 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease922012`
--

DROP TABLE IF EXISTS `historiclease922012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease922012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=97592 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease932012`
--

DROP TABLE IF EXISTS `historiclease932012`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease932012` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=103054 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease94111`
--

DROP TABLE IF EXISTS `historiclease94111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease94111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=61097 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease95111`
--

DROP TABLE IF EXISTS `historiclease95111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease95111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=67994 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease96111`
--

DROP TABLE IF EXISTS `historiclease96111`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease96111` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=68965 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease982011`
--

DROP TABLE IF EXISTS `historiclease982011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease982011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=69615 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `historiclease992011`
--

DROP TABLE IF EXISTS `historiclease992011`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `historiclease992011` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ordem` varchar(254) DEFAULT NULL,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  `remoteid` varchar(254) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM AUTO_INCREMENT=70967 DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `lease`
--

DROP TABLE IF EXISTS `lease`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `lease` (
  `idlease` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(254) DEFAULT NULL,
  `macaddr` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idlease`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sys_log`
--

DROP TABLE IF EXISTS `sys_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_log` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `thetime` time NOT NULL DEFAULT '00:00:00',
  `priority` int(11) NOT NULL DEFAULT '0',
  `message` varchar(200) NOT NULL,
  KEY `thedate` (`thedate`,`thetime`),
  KEY `priority` (`priority`),
  KEY `message` (`message`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sys_log_2010_dez`
--

DROP TABLE IF EXISTS `sys_log_2010_dez`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_log_2010_dez` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `thetime` time NOT NULL DEFAULT '00:00:00',
  `priority` int(11) NOT NULL DEFAULT '0',
  `message` varchar(200) NOT NULL,
  KEY `thedate` (`thedate`,`thetime`),
  KEY `priority` (`priority`),
  KEY `message` (`message`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sys_summary`
--

DROP TABLE IF EXISTS `sys_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `sys_summary` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `priority` int(11) NOT NULL DEFAULT '0',
  `message` varchar(200) NOT NULL,
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`thedate`,`priority`,`message`),
  KEY `message` (`message`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tftp_log`
--

DROP TABLE IF EXISTS `tftp_log`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tftp_log` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `thetime` time NOT NULL DEFAULT '00:00:00',
  `fname` varchar(100) NOT NULL,
  `ipaddr` varchar(16) NOT NULL,
  KEY `thedate` (`thedate`,`thetime`),
  KEY `ipaddr` (`ipaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `tftp_summary`
--

DROP TABLE IF EXISTS `tftp_summary`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tftp_summary` (
  `thedate` date NOT NULL DEFAULT '0000-00-00',
  `ipaddr` varchar(16) NOT NULL,
  `counter` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`thedate`,`ipaddr`),
  KEY `ipaddr` (`ipaddr`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-03-15 15:31:25
