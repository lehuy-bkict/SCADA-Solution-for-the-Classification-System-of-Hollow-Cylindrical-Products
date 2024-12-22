-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: sql12.freemysqlhosting.net    Database: sql12746806
-- ------------------------------------------------------
-- Server version	5.5.62-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `NonNullMatchedAll`
--

DROP TABLE IF EXISTS `NonNullMatchedAll`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `NonNullMatchedAll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plc_description` varchar(50) DEFAULT NULL,
  `rfid_code` varchar(50) DEFAULT NULL,
  `store_info` varchar(50) DEFAULT NULL,
  `plc_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `rfid_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `store_timestamp` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NonNullMatchedAll`
--

LOCK TABLES `NonNullMatchedAll` WRITE;
/*!40000 ALTER TABLE `NonNullMatchedAll` DISABLE KEYS */;
INSERT INTO `NonNullMatchedAll` VALUES (1,'dark-low','3321597725','Kho 2','2024-12-21 01:36:56','2024-12-21 01:36:57','2024-12-21 01:36:59'),(2,'light-high','3321597981','Kho 9.1','2024-12-21 01:37:12','2024-12-21 01:37:16','2024-12-21 01:37:35');
/*!40000 ALTER TABLE `NonNullMatchedAll` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-22 12:06:26