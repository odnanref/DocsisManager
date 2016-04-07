-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: docsismanager
-- ------------------------------------------------------
-- Server version	5.5.47-0+deb8u1

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
-- Table structure for table `acgroups`
--

DROP TABLE IF EXISTS `acgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acgroups` (
  `idacgroup` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `name` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idacgroup`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acgroups`
--

LOCK TABLES `acgroups` WRITE;
/*!40000 ALTER TABLE `acgroups` DISABLE KEYS */;
INSERT INTO `acgroups` VALUES (1,1,'Admin');
/*!40000 ALTER TABLE `acgroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acgroups_acusers`
--

DROP TABLE IF EXISTS `acgroups_acusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acgroups_acusers` (
  `idacgroup` int(11) NOT NULL,
  `idacuser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acgroups_acusers`
--

LOCK TABLES `acgroups_acusers` WRITE;
/*!40000 ALTER TABLE `acgroups_acusers` DISABLE KEYS */;
INSERT INTO `acgroups_acusers` VALUES (1,1);
/*!40000 ALTER TABLE `acgroups_acusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `acusers`
--

DROP TABLE IF EXISTS `acusers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `acusers` (
  `idacuser` int(11) NOT NULL AUTO_INCREMENT,
  `login` varchar(254) NOT NULL,
  `senha` varchar(254) NOT NULL,
  `name` varchar(254) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `state` enum('active','unactive') DEFAULT NULL,
  PRIMARY KEY (`idacuser`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acusers`
--

LOCK TABLES `acusers` WRITE;
/*!40000 ALTER TABLE `acusers` DISABLE KEYS */;
INSERT INTO `acusers` VALUES (1,'admin','f6fdffe48c908deb0f4c3bd36c032e72','Admin Man','admin@localhost.localdomain','active');
/*!40000 ALTER TABLE `acusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brand`
--

DROP TABLE IF EXISTS `brand`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brand` (
  `idbrand` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) DEFAULT NULL,
  `code` varchar(16) DEFAULT NULL,
  `default_file` varchar(254) DEFAULT NULL,
  `default_file_phone_on` varchar(254) DEFAULT NULL,
  `default_file_mta` varchar(254) DEFAULT NULL,
  `onefilemta` tinyint(1) DEFAULT NULL,
  `default_file_mta_2l` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idbrand`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brand`
--

LOCK TABLES `brand` WRITE;
/*!40000 ALTER TABLE `brand` DISABLE KEYS */;
INSERT INTO `brand` VALUES (1,'Thomson','THOMSON','DEFAULT.cfg','DEFAULT_THOMSON_MTA.cfg','1',NULL,'DEFAULT_THOMSON_MTA_2L.cfg'),(2,'Netgear','NETGEAR',NULL,NULL,NULL,NULL,NULL),(3,'MISSING_INFO',NULL,NULL,NULL,NULL,NULL,NULL),(4,'Hitron Technologies','HITRON','DEFAULT_HITRON.cfg','','0',0,NULL),(5,'Motorola Corporation','MOTOROLA',NULL,NULL,NULL,NULL,NULL),(6,'Arris Interactive, L.L.C.','ARRIS','DEFAULT_ARRIS_phone_on.cfg','DEFAULT_ARRIS_mta.cfg','0',NULL,'DEFAULT_ARRIS_mta_2L.cfg'),(7,'TERAYON',NULL,NULL,NULL,NULL,NULL,NULL),(8,'Askey',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `brand` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `idclient` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(254) NOT NULL,
  `contract` varchar(40) NOT NULL,
  `node` varchar(20) NOT NULL,
  `mobile` int(11) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `email` varchar(254) DEFAULT NULL,
  `state` enum('active','unactive','cut') DEFAULT NULL,
  `datain` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idclient`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `config_nets`
--

DROP TABLE IF EXISTS `config_nets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `config_nets`
--

LOCK TABLES `config_nets` WRITE;
/*!40000 ALTER TABLE `config_nets` DISABLE KEYS */;
/*!40000 ALTER TABLE `config_nets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dmhistory`
--

DROP TABLE IF EXISTS `dmhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dmhistory` (
  `iddmhistory` int(11) NOT NULL AUTO_INCREMENT,
  `macaddr` varchar(16) DEFAULT NULL,
  `serialnum` varchar(254) DEFAULT NULL,
  `ipaddr` varchar(254) DEFAULT NULL,
  `config_file` varchar(254) DEFAULT NULL,
  `cmts_vlan` varchar(254) DEFAULT NULL,
  `subnum` int(11) DEFAULT NULL,
  `estado` varchar(100) DEFAULT NULL,
  `datamudado` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastip` varchar(254) DEFAULT NULL,
  `tel1` varchar(40) DEFAULT NULL,
  `tel2` varchar(40) DEFAULT NULL,
  `macaddr_mta` varchar(16) DEFAULT NULL,
  `config_file_mta` varchar(254) DEFAULT NULL,
  `idmodel` int(11) DEFAULT NULL,
  `user` varchar(254) DEFAULT NULL,
  `action` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`iddmhistory`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dmhistory`
--

LOCK TABLES `dmhistory` WRITE;
/*!40000 ALTER TABLE `dmhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `dmhistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `docsismodem`
--

DROP TABLE IF EXISTS `docsismodem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
  `node` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`macaddr`),
  UNIQUE KEY `ipaddr` (`ipaddr`),
  UNIQUE KEY `serialnum` (`serialnum`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `docsismodem`
--

LOCK TABLES `docsismodem` WRITE;
/*!40000 ALTER TABLE `docsismodem` DISABLE KEYS */;
/*!40000 ALTER TABLE `docsismodem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipment`
--

DROP TABLE IF EXISTS `equipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `equipment` (
  `idequipment` int(11) NOT NULL AUTO_INCREMENT,
  `idclient` int(11) DEFAULT NULL,
  `idtypeequipment` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `datain` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `datachanged` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dataout` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `serialnum` varchar(200) DEFAULT NULL,
  `macaddr` varchar(200) DEFAULT NULL,
  `idmodel` int(11) DEFAULT NULL,
  PRIMARY KEY (`idequipment`),
  KEY `idtypeequipment` (`idtypeequipment`),
  KEY `idclient` (`idclient`),
  CONSTRAINT `equipment_ibfk_1` FOREIGN KEY (`idtypeequipment`) REFERENCES `typeequipment` (`idtypeequipment`),
  CONSTRAINT `equipment_ibfk_2` FOREIGN KEY (`idclient`) REFERENCES `client` (`idclient`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipment`
--

LOCK TABLES `equipment` WRITE;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `model`
--

DROP TABLE IF EXISTS `model`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `model` (
  `idmodel` int(11) NOT NULL AUTO_INCREMENT,
  `idbrand` int(11) DEFAULT NULL,
  `description` varchar(254) DEFAULT NULL,
  `vendormac` varchar(6) DEFAULT NULL,
  `default_file` varchar(254) DEFAULT NULL,
  `default_file_phone_on` varchar(254) DEFAULT NULL,
  `default_file_mta` varchar(254) DEFAULT NULL,
  `onefilemta` tinyint(1) DEFAULT NULL,
  `default_file_mta_2l` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idmodel`),
  KEY `idbrand` (`idbrand`),
  CONSTRAINT `model_ibfk_1` FOREIGN KEY (`idbrand`) REFERENCES `brand` (`idbrand`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `model`
--

LOCK TABLES `model` WRITE;
/*!40000 ALTER TABLE `model` DISABLE KEYS */;
INSERT INTO `model` VALUES (1,1,'THG540',NULL,NULL,NULL,NULL,NULL,NULL),(2,2,'CBVG834G',NULL,NULL,NULL,NULL,NULL,NULL),(3,2,'CVG834G',NULL,NULL,NULL,NULL,NULL,NULL),(4,3,'MISSING_INFO',NULL,NULL,NULL,NULL,NULL,NULL),(5,4,'BVW-3653',NULL,NULL,NULL,NULL,NULL,NULL),(6,5,'SB5101',NULL,NULL,NULL,NULL,NULL,NULL),(7,1,'THG520',NULL,NULL,NULL,NULL,NULL,NULL),(8,6,'TM502A',NULL,NULL,NULL,NULL,NULL,NULL),(9,5,'SB5100',NULL,NULL,NULL,NULL,NULL,NULL),(10,1,'TCM420',NULL,NULL,NULL,NULL,NULL,NULL),(11,1,'TCM425',NULL,NULL,NULL,NULL,NULL,NULL),(12,6,'TM601B',NULL,NULL,NULL,NULL,NULL,NULL),(13,1,'TCM325',NULL,NULL,NULL,NULL,NULL,NULL),(14,7,'TA-102-A-HP',NULL,NULL,NULL,NULL,NULL,NULL),(15,8,'CME075',NULL,NULL,NULL,NULL,NULL,NULL),(16,6,'TM601A',NULL,NULL,NULL,NULL,NULL,NULL),(18,6,'WTM652A',NULL,NULL,NULL,NULL,NULL,NULL),(19,6,'WTM652B',NULL,NULL,NULL,NULL,NULL,NULL),(20,6,'TM602A',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `model` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pack`
--

DROP TABLE IF EXISTS `pack`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pack` (
  `idpack` int(11) NOT NULL AUTO_INCREMENT,
  `idtypeservice` int(11) DEFAULT NULL,
  `name` varchar(254) NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `dataactive` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dataunactive` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `downloadspeed` varchar(40) DEFAULT NULL,
  `uploadspeed` varchar(40) DEFAULT NULL,
  `prebuilt_file` varchar(254) DEFAULT NULL,
  `prebuilt_file_mta` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idpack`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pack`
--

LOCK TABLES `pack` WRITE;
/*!40000 ALTER TABLE `pack` DISABLE KEYS */;
INSERT INTO `pack` VALUES (1,1,'Basico','TV base','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(2,1,'Basico','TV Top','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(3,2,'Basico NET','Velocidade baixa','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(4,2,'Medio NET','Velocidade Media','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(5,2,'Topo NET','Velocidade maxima','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(6,2,'Empresarial NET','Para empresas','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(7,3,'Telefone Base','Telefone','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL),(8,3,'Telefone Extra','Telefone Extra','2016-04-06 01:11:02','0000-00-00 00:00:00',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `pack` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `privilege_controller`
--

DROP TABLE IF EXISTS `privilege_controller`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege_controller` (
  `idprivilege` int(11) NOT NULL AUTO_INCREMENT,
  `modulename` varchar(254) DEFAULT NULL,
  `controllername` varchar(254) DEFAULT NULL,
  `controlleraction` varchar(254) DEFAULT NULL,
  `r` tinyint(1) DEFAULT NULL,
  `w` tinyint(1) DEFAULT NULL,
  `d` tinyint(1) DEFAULT NULL,
  `idacgroup` int(11) DEFAULT NULL,
  PRIMARY KEY (`idprivilege`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege_controller`
--

LOCK TABLES `privilege_controller` WRITE;
/*!40000 ALTER TABLE `privilege_controller` DISABLE KEYS */;
INSERT INTO `privilege_controller` VALUES (1,'*','*','*',1,1,1,1);
/*!40000 ALTER TABLE `privilege_controller` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `idservice` int(11) NOT NULL AUTO_INCREMENT,
  `idequipment` int(11) NOT NULL,
  `idpack` int(11) NOT NULL,
  `datain` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dataactive` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dataunactive` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `tel` bigint(20) DEFAULT NULL,
  `linenumber` int(11) DEFAULT NULL,
  `node` varchar(254) DEFAULT NULL,
  PRIMARY KEY (`idservice`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typeequipment`
--

DROP TABLE IF EXISTS `typeequipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `typeequipment` (
  `idtypeequipment` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(6) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`idtypeequipment`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typeequipment`
--

LOCK TABLES `typeequipment` WRITE;
/*!40000 ALTER TABLE `typeequipment` DISABLE KEYS */;
INSERT INTO `typeequipment` VALUES (1,'NONE','N/A'),(2,'MODEM','Modem'),(3,'TELEF','Telefone fixo');
/*!40000 ALTER TABLE `typeequipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `typeservice`
--

DROP TABLE IF EXISTS `typeservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `typeservice` (
  `idtypeservice` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `description` varchar(254) DEFAULT NULL,
  `type` enum('tv','net','tel') DEFAULT NULL,
  PRIMARY KEY (`idtypeservice`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `typeservice`
--

LOCK TABLES `typeservice` WRITE;
/*!40000 ALTER TABLE `typeservice` DISABLE KEYS */;
INSERT INTO `typeservice` VALUES (1,'televisao','Servico de TV','tv'),(2,'Internet','Internet','net'),(3,'Telefone','Telefone','tel');
/*!40000 ALTER TABLE `typeservice` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-05 22:11:56
