-- MySQL dump 10.13  Distrib 8.0.24, for Linux (x86_64)
--
-- Host: wheatley.cs.up.ac.za    Database: u17016534_VotingSystem
-- ------------------------------------------------------
-- Server version	5.5.5-10.3.27-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `iec_member`
--

DROP TABLE IF EXISTS `iec_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `iec_member` (
  `iec_member_id_number` varchar(25) NOT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `password_salt` int(4) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`iec_member_id_number`),
  KEY `iec_member_id_UNIQUE` (`iec_member_id_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `iec_member`
--

LOCK TABLES `iec_member` WRITE;
/*!40000 ALTER TABLE `iec_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `iec_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `local_municipality`
--

DROP TABLE IF EXISTS `local_municipality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `local_municipality` (
  `local_muni_id` varchar(10) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `upper_muni_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`local_muni_id`),
  KEY `local_muni_id_UNIQUE` (`local_muni_id`),
  KEY `fk_local_municipality_upper_municipality` (`upper_muni_id`),
  CONSTRAINT `local_municipality_ibfk_1` FOREIGN KEY (`upper_muni_id`) REFERENCES `upper_municipality` (`upper_muni_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `local_municipality`
--

LOCK TABLES `local_municipality` WRITE;
/*!40000 ALTER TABLE `local_municipality` DISABLE KEYS */;
/*!40000 ALTER TABLE `local_municipality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `party`
--

DROP TABLE IF EXISTS `party`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `party` (
  `party_id` int(4) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`party_id`),
  KEY `party_id_UNIQUE` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `party`
--

LOCK TABLES `party` WRITE;
/*!40000 ALTER TABLE `party` DISABLE KEYS */;
/*!40000 ALTER TABLE `party` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `upper_municipality`
--

DROP TABLE IF EXISTS `upper_municipality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `upper_municipality` (
  `upper_muni_id` varchar(10) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `type` enum('value_1','value_2','value_3') DEFAULT NULL,
  PRIMARY KEY (`upper_muni_id`),
  KEY `ward_id_UNIQUE` (`upper_muni_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `upper_municipality`
--

LOCK TABLES `upper_municipality` WRITE;
/*!40000 ALTER TABLE `upper_municipality` DISABLE KEYS */;
/*!40000 ALTER TABLE `upper_municipality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_local_municipality`
--

DROP TABLE IF EXISTS `vote_local_municipality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_local_municipality` (
  `vote_id` int(8) NOT NULL,
  `local_muni_id` varchar(10) DEFAULT NULL,
  `party_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`vote_id`),
  KEY `vote_id_UNIQUE` (`vote_id`),
  KEY `fk_vote_local_municipality_local_municipality1_idx` (`local_muni_id`),
  KEY `fk_vote_local_municipality_party1_idx` (`party_id`),
  CONSTRAINT `vote_local_municipality_ibfk_1` FOREIGN KEY (`local_muni_id`) REFERENCES `local_municipality` (`local_muni_id`),
  CONSTRAINT `vote_local_municipality_ibfk_2` FOREIGN KEY (`party_id`) REFERENCES `vote_upper_municipality` (`party_party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_local_municipality`
--

LOCK TABLES `vote_local_municipality` WRITE;
/*!40000 ALTER TABLE `vote_local_municipality` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_local_municipality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_upper_municipality`
--

DROP TABLE IF EXISTS `vote_upper_municipality`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_upper_municipality` (
  `vote_id` int(8) NOT NULL,
  `party_party_id` int(4) DEFAULT NULL,
  `upper_municipality_upper_muni_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`vote_id`),
  KEY `party_party_id` (`party_party_id`),
  KEY `upper_municipality_upper_muni_id` (`upper_municipality_upper_muni_id`),
  CONSTRAINT `vote_upper_municipality_ibfk_1` FOREIGN KEY (`party_party_id`) REFERENCES `party` (`party_id`),
  CONSTRAINT `vote_upper_municipality_ibfk_2` FOREIGN KEY (`upper_municipality_upper_muni_id`) REFERENCES `upper_municipality` (`upper_muni_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_upper_municipality`
--

LOCK TABLES `vote_upper_municipality` WRITE;
/*!40000 ALTER TABLE `vote_upper_municipality` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_upper_municipality` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vote_ward`
--

DROP TABLE IF EXISTS `vote_ward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vote_ward` (
  `vote_id` int(8) NOT NULL,
  `candidate_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`vote_id`),
  KEY `vote_id_UNIQUE` (`vote_id`),
  KEY `fk_vote_ward_ward_candidate1_idx` (`candidate_id`),
  CONSTRAINT `vote_ward_ibfk_1` FOREIGN KEY (`candidate_id`) REFERENCES `ward_candidate` (`candidate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vote_ward`
--

LOCK TABLES `vote_ward` WRITE;
/*!40000 ALTER TABLE `vote_ward` DISABLE KEYS */;
/*!40000 ALTER TABLE `vote_ward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voter`
--

DROP TABLE IF EXISTS `voter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voter` (
  `voter_id_number` varchar(13) NOT NULL,
  `first_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) DEFAULT NULL,
  `registration_code` varchar(10) DEFAULT NULL,
  `ward_id` int(4) DEFAULT NULL,
  `iec_member_registrant_id` varchar(13) DEFAULT NULL,
  `voted` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`voter_id_number`),
  KEY `voter_id_number_UNIQUE` (`voter_id_number`),
  KEY `registration_code_UNIQUE` (`registration_code`),
  KEY `fk_voter_ward1_idx` (`ward_id`),
  KEY `fk_voter_iec_member1_idx` (`iec_member_registrant_id`),
  CONSTRAINT `voter_ibfk_1` FOREIGN KEY (`ward_id`) REFERENCES `ward` (`ward_id`),
  CONSTRAINT `voter_ibfk_2` FOREIGN KEY (`iec_member_registrant_id`) REFERENCES `iec_member` (`iec_member_id_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voter`
--

LOCK TABLES `voter` WRITE;
/*!40000 ALTER TABLE `voter` DISABLE KEYS */;
/*!40000 ALTER TABLE `voter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ward`
--

DROP TABLE IF EXISTS `ward`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ward` (
  `ward_id` int(4) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `local_muni_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ward_id`),
  KEY `ward_id_UNIQUE` (`ward_id`),
  KEY `fk_ward_local_municipality1_idx` (`local_muni_id`),
  CONSTRAINT `ward_ibfk_1` FOREIGN KEY (`local_muni_id`) REFERENCES `local_municipality` (`local_muni_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ward`
--

LOCK TABLES `ward` WRITE;
/*!40000 ALTER TABLE `ward` DISABLE KEYS */;
/*!40000 ALTER TABLE `ward` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ward_candidate`
--

DROP TABLE IF EXISTS `ward_candidate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ward_candidate` (
  `candidate_id` int(4) NOT NULL,
  `name` varchar(25) DEFAULT NULL,
  `ward_id` int(4) DEFAULT NULL,
  `party_id` int(4) DEFAULT NULL,
  PRIMARY KEY (`candidate_id`),
  KEY `candidate_id_UNIQUE` (`candidate_id`),
  KEY `fk_ward_candidate_ward1_idx` (`ward_id`),
  KEY `fk_ward_candidate_party1_idx` (`party_id`),
  CONSTRAINT `ward_candidate_ibfk_1` FOREIGN KEY (`ward_id`) REFERENCES `ward` (`ward_id`),
  CONSTRAINT `ward_candidate_ibfk_2` FOREIGN KEY (`party_id`) REFERENCES `party` (`party_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ward_candidate`
--

LOCK TABLES `ward_candidate` WRITE;
/*!40000 ALTER TABLE `ward_candidate` DISABLE KEYS */;
/*!40000 ALTER TABLE `ward_candidate` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-05-03 18:42:32
