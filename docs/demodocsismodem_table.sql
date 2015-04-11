-- MySQL dump 10.11
--
-- Host: stv    Database: dhcp
-- ------------------------------------------------------
-- Server version	5.1.61-0+squeeze1

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
  `subnum` bigint(20) DEFAULT '0',
  `estado` enum('activo','anulado','cortado') DEFAULT 'activo',
  `datamudado` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP,
  `lastip` varchar(60) DEFAULT NULL,
  `tel1` varchar(14) DEFAULT NULL,
  `tel2` varchar(14) DEFAULT NULL,
  `macaddr_mta` varchar(15) DEFAULT NULL,
  `config_file_mta` varchar(254) DEFAULT NULL,
  `idmodel` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`macaddr`),
  UNIQUE KEY `ipaddr` (`ipaddr`),
  UNIQUE KEY `serialnum` (`serialnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `docsismodem`
--

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-06-22  2:15:58
