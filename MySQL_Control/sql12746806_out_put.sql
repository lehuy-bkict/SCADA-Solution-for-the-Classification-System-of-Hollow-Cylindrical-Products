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
-- Table structure for table `out_put`
--

DROP TABLE IF EXISTS `out_put`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `out_put` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rfid_code` varchar(45) DEFAULT NULL,
  `rfid_timestamp` timestamp NULL DEFAULT NULL,
  `plc_description` varchar(45) DEFAULT NULL,
  `plc_timestamp` timestamp NULL DEFAULT NULL,
  `store_info` varchar(45) DEFAULT NULL,
  `store_timestamp` timestamp NULL DEFAULT NULL,
  `output_timestamp` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `out_put`
--

LOCK TABLES `out_put` WRITE;
/*!40000 ALTER TABLE `out_put` DISABLE KEYS */;
INSERT INTO `out_put` VALUES (1,'3321599261','2024-12-19 22:22:48','dark-low','2024-12-19 22:22:50','Kho 2','2024-12-19 22:22:53','2024-12-20 01:00:00'),(2,'3321599261','2024-12-19 22:26:26','dark-low','2024-12-19 22:26:29','Kho 2','2024-12-19 22:26:32','2024-12-20 01:00:00');
/*!40000 ALTER TABLE `out_put` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-22 12:06:37
