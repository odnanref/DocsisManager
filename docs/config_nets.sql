-- MySQL dump 10.11
--
-- Host: localhost    Database: dhcp
-- ------------------------------------------------------
-- Server version	5.0.51a-24+lenny5

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
  `nettype` enum('CM','CPE','MTA') NOT NULL default 'CPE',
  `netid` int(11) NOT NULL default '0',
  `cmts_ip` varchar(16) NOT NULL default '',
  `cmts_vlan` mediumint(9) NOT NULL default '0',
  `network` varchar(20) NOT NULL default '',
  `gateway` varchar(16) NOT NULL default '',
  `grant_flag` tinyint(1) NOT NULL default '1',
  `full_flag` tinyint(4) NOT NULL default '0',
  `range_min` varchar(16) NOT NULL default '',
  `range_max` varchar(16) NOT NULL default '',
  `config_opt1` tinyint(4) NOT NULL default '0',
  `config_opt2` tinyint(4) NOT NULL default '0',
  `config_opt3` tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (`netid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

-- Dump completed on 2011-08-25 11:49:18
