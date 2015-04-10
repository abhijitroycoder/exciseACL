-- MySQL dump 10.13  Distrib 5.5.16, for Win32 (x86)
--
-- Host: localhost    Database: exciseacl
-- ------------------------------------------------------
-- Server version	5.1.49-community

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
-- Current Database: `exciseacl`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `exciseacl` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `exciseacl`;

--
-- Table structure for table `actions`
--

DROP TABLE IF EXISTS `actions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `actions` (
  `idactions` int(11) NOT NULL AUTO_INCREMENT,
  `action_name` varchar(45) NOT NULL,
  PRIMARY KEY (`idactions`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actions`
--

LOCK TABLES `actions` WRITE;
/*!40000 ALTER TABLE `actions` DISABLE KEYS */;
INSERT INTO `actions` VALUES (1,'login'),(2,'logout'),(3,'index'),(4,'index'),(5,'index'),(6,'detailsChallanEntry');
/*!40000 ALTER TABLE `actions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controllers`
--

DROP TABLE IF EXISTS `controllers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `controllers` (
  `idcontrollers` int(11) NOT NULL AUTO_INCREMENT,
  `controller_name` varchar(45) NOT NULL,
  PRIMARY KEY (`idcontrollers`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controllers`
--

LOCK TABLES `controllers` WRITE;
/*!40000 ALTER TABLE `controllers` DISABLE KEYS */;
INSERT INTO `controllers` VALUES (1,'authentication'),(2,'applicationDetails'),(3,'apply'),(4,'application');
/*!40000 ALTER TABLE `controllers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `modules`
--

DROP TABLE IF EXISTS `modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `modules` (
  `idmodules` int(11) NOT NULL AUTO_INCREMENT,
  `module_name` varchar(45) NOT NULL,
  PRIMARY KEY (`idmodules`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `modules`
--

LOCK TABLES `modules` WRITE;
/*!40000 ALTER TABLE `modules` DISABLE KEYS */;
INSERT INTO `modules` VALUES (1,'default'),(2,'importPermit'),(3,'challan');
/*!40000 ALTER TABLE `modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resources_privileges`
--

DROP TABLE IF EXISTS `resources_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resources_privileges` (
  `idresources_privileges` int(11) NOT NULL AUTO_INCREMENT,
  `idmodules` int(11) NOT NULL,
  `idcontrollers` int(11) NOT NULL,
  `idactions` int(11) NOT NULL,
  PRIMARY KEY (`idresources_privileges`),
  KEY `idmodules` (`idmodules`),
  KEY `idcontrollers` (`idcontrollers`),
  KEY `idactions` (`idactions`),
  CONSTRAINT `idactions` FOREIGN KEY (`idactions`) REFERENCES `actions` (`idactions`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idcontrollers` FOREIGN KEY (`idcontrollers`) REFERENCES `controllers` (`idcontrollers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `idmodules` FOREIGN KEY (`idmodules`) REFERENCES `modules` (`idmodules`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resources_privileges`
--

LOCK TABLES `resources_privileges` WRITE;
/*!40000 ALTER TABLE `resources_privileges` DISABLE KEYS */;
INSERT INTO `resources_privileges` VALUES (1,1,1,1),(2,1,1,2),(3,2,2,3),(4,2,3,4),(5,3,4,5),(6,3,4,6);
/*!40000 ALTER TABLE `resources_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `idroles` int(11) NOT NULL AUTO_INCREMENT,
  `rolename` varchar(45) NOT NULL,
  `inheritated_role` varchar(45) DEFAULT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idroles`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'guest',NULL,1),(2,'user','guest',1),(3,'officer1','user',1),(4,'officer2','officer1',1),(5,'admin','officer2',1);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles_resources_privileges`
--

DROP TABLE IF EXISTS `roles_resources_privileges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles_resources_privileges` (
  `idroles_resources_privileges` int(11) NOT NULL AUTO_INCREMENT,
  `idroles` int(11) NOT NULL,
  `idresources_privileges` int(11) NOT NULL,
  `permission` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`idroles_resources_privileges`),
  KEY `idroles_fk` (`idroles`),
  KEY `idresources_privileges` (`idresources_privileges`),
  CONSTRAINT `idresources_privileges` FOREIGN KEY (`idresources_privileges`) REFERENCES `resources_privileges` (`idresources_privileges`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `idroles_fk` FOREIGN KEY (`idroles`) REFERENCES `roles` (`idroles`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles_resources_privileges`
--

LOCK TABLES `roles_resources_privileges` WRITE;
/*!40000 ALTER TABLE `roles_resources_privileges` DISABLE KEYS */;
INSERT INTO `roles_resources_privileges` VALUES (1,1,1,1),(2,2,1,0),(3,2,2,1),(4,2,4,1),(5,3,3,1),(6,3,5,1),(7,4,6,1);
/*!40000 ALTER TABLE `roles_resources_privileges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `idusers` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `active` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idusers`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'abhijit','abhi',1),(2,'testuser','testuser',1),(3,'testuser1','testuser1',1),(4,'testuser2','testuser2',1),(5,'testuser3','testuser3',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_roles`
--

DROP TABLE IF EXISTS `users_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_roles` (
  `idusers_roles` int(11) NOT NULL AUTO_INCREMENT,
  `idusers` int(11) NOT NULL,
  `idroles` int(11) NOT NULL,
  PRIMARY KEY (`idusers_roles`),
  KEY `idusers` (`idusers`),
  KEY `idroles` (`idroles`),
  CONSTRAINT `idroles` FOREIGN KEY (`idroles`) REFERENCES `roles` (`idroles`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `idusers` FOREIGN KEY (`idusers`) REFERENCES `users` (`idusers`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_roles`
--

LOCK TABLES `users_roles` WRITE;
/*!40000 ALTER TABLE `users_roles` DISABLE KEYS */;
INSERT INTO `users_roles` VALUES (1,5,1),(2,4,2),(3,3,3),(4,2,4),(5,1,5);
/*!40000 ALTER TABLE `users_roles` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-04-10  5:05:01
