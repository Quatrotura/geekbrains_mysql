-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: localhost    Database: procurement_db
-- ------------------------------------------------------
-- Server version	8.0.26

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
-- Table structure for table `alias_buyers`
--

DROP TABLE IF EXISTS `alias_buyers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alias_buyers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `alias_buyer_name` varchar(255) NOT NULL,
  `alias_buyer_country_city_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias_buyer_name` (`alias_buyer_name`),
  KEY `index_of_alias_suppl_name` (`alias_buyer_name`),
  KEY `index_of_alias_suppl_country_city_id` (`alias_buyer_country_city_id`),
  CONSTRAINT `fk_alias_buyers_country_city_id` FOREIGN KEY (`alias_buyer_country_city_id`) REFERENCES `country_cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alias_buyers`
--

LOCK TABLES `alias_buyers` WRITE;
/*!40000 ALTER TABLE `alias_buyers` DISABLE KEYS */;
INSERT INTO `alias_buyers` VALUES (1,'Inditex',6),(2,'Inditex Logistics',6);
/*!40000 ALTER TABLE `alias_buyers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alias_suppliers`
--

DROP TABLE IF EXISTS `alias_suppliers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `alias_suppliers` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `alias_suppl_name` varchar(255) NOT NULL COMMENT 'Псевдоним поставщика внутри закупочной компании необходим, т.к. у одного поставщика может быть несколько юр лиц.',
  `alias_suppl_country_city_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alias_suppl_name` (`alias_suppl_name`),
  KEY `index_of_alias_suppl_name` (`alias_suppl_name`),
  KEY `index_of_alias_suppl_country_city_id` (`alias_suppl_country_city_id`),
  CONSTRAINT `fk_alias_suppl_country_city_id` FOREIGN KEY (`alias_suppl_country_city_id`) REFERENCES `country_cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alias_suppliers`
--

LOCK TABLES `alias_suppliers` WRITE;
/*!40000 ALTER TABLE `alias_suppliers` DISABLE KEYS */;
INSERT INTO `alias_suppliers` VALUES (1,'Shanghai Textiles',1),(2,'Ningbo Supreme',3),(3,'Shanghai Knitwear',1),(4,'Shuangfeng Accessories',2),(5,'Minar Industry',8),(6,'Zeria Tekstil',9),(7,'Heung Apparels',10),(8,'Anhui Garments',1),(9,'H&J',4),(10,'Top Shirts',5);
/*!40000 ALTER TABLE `alias_suppliers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `balance_amount_for_payment`
--

DROP TABLE IF EXISTS `balance_amount_for_payment`;
/*!50001 DROP VIEW IF EXISTS `balance_amount_for_payment`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `balance_amount_for_payment` AS SELECT 
 1 AS `style_number`,
 1 AS `ordered_amount`,
 1 AS `paid_amount`,
 1 AS `balance_amount`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `bank_details`
--

DROP TABLE IF EXISTS `bank_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_details` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `contract_id` bigint unsigned NOT NULL,
  `beneficiary` varchar(255) NOT NULL,
  `benefic_address` varchar(255) NOT NULL,
  `benefic_country_city_id` bigint unsigned NOT NULL,
  `bank_name` varchar(255) NOT NULL,
  `bank_address` varchar(255) NOT NULL,
  `bank_country_city_id` bigint unsigned NOT NULL,
  `account_no` bigint unsigned NOT NULL,
  `corresp_account_no` bigint unsigned NOT NULL,
  `swift` char(14) DEFAULT NULL,
  `status_id` tinyint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_bank_details_benefic_country_cities_id` (`benefic_country_city_id`),
  KEY `fk_bank_details_bank_country_cities_id` (`bank_country_city_id`),
  KEY `fk_bank_details_status_id` (`status_id`),
  KEY `index_of_contract_id_wh_status` (`contract_id`,`status_id`),
  CONSTRAINT `fk_bank_details_bank_country_cities_id` FOREIGN KEY (`bank_country_city_id`) REFERENCES `country_cities` (`id`),
  CONSTRAINT `fk_bank_details_benefic_country_cities_id` FOREIGN KEY (`benefic_country_city_id`) REFERENCES `country_cities` (`id`),
  CONSTRAINT `fk_bank_details_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `contracts` (`id`),
  CONSTRAINT `fk_bank_details_status_id` FOREIGN KEY (`status_id`) REFERENCES `bank_details_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_details`
--

LOCK TABLES `bank_details` WRITE;
/*!40000 ALTER TABLE `bank_details` DISABLE KEYS */;
INSERT INTO `bank_details` VALUES (1,1,'Shanghai Textiles Supplies Co. Ltd.','Mainstreet 2, Road Town, British Virgin Islands',7,'Virgin Trust Bank BVI','Mainstreet 5, Road Town, British Virgin Islands',7,38585904,3040053,'VTBBVI',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(2,2,'Shanghai Trading I&E Co. Ltd','Xuehuadadao 23, Shanghai, China',1,'Construction Bank of China','Liujielu 34, Shanghai, China',1,90394984,309393,'CBHSWF',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(3,3,'Zeria Tekstil Sanayi ve Dİs Ticaret Ltd Sti','Esenler Sk 1, Istanbul, Turkey ',9,'International Bank of Commerce','Turkoglu 34, Istanbul, Turkey',9,24948943,849398384,'IBCTURK',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(4,4,'H&J Outerwear Apparels Co. Ltd','Xihulu 29, Xiamen, China ',4,'Bank of China Xiamen Branch','Shangxiadadao 34, Xiamen, China',4,949403033,94940402,'BOCXMN',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(5,5,'Chittagong Minar Industries Co. Ltd','Queens Street 10, Chittagong, Bangladesh',8,'Islamic Bank of Bangladesh','Fortune Road 23, Chittagong, Bangladesh',8,57389393,203948484,'ISBCTG',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(6,6,'Shuangfeng Accessories Manufacturing Co. Ltd','Xinguolu 65, Shenzhen, China',2,'Agricultural Bank of China','Zhuyaodadao 84, Shenzhen, China',2,7383943,10984742,'ABCSHZ',2,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(7,7,'Ningbo Supreme Import & Export Co. Ltd','Shijiedadao 84, Ningbo, China',3,'ICBC Ningbo branch','Louhongqiao 29, Ningbo, China',3,8694943,84949384,'ICBCNGB',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(8,8,'Shanghai Knitwear Co. Ltd.','Dongfengdadao 13, Shanghai, China',1,'Construction Bank of China','Xidonglu 48, Shanghai, China',1,95958432,50595984,'CBCSHA',2,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(9,9,'Heung Apparels Manufacturing LLC','Minhaseung 34, Busan, Korea',10,'Korean Bank of Trade and Commerce','Bunghaseyong 93, Busan, Korea',10,8478722,84733823,'KBRCBSN',1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),(10,10,'Anhui Dafeng Garments I&E Co. Ltd','Liudalu 98, Shanghai, China',1,'Shanghai Trading Bank','Xinshijielu 23, Shanghai, China',1,57348393,94587362,'STBSHA',2,'2021-10-20 18:45:20','2021-10-20 18:45:20');
/*!40000 ALTER TABLE `bank_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bank_details_status`
--

DROP TABLE IF EXISTS `bank_details_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bank_details_status` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` enum('active','deactivated') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bank_details_status`
--

LOCK TABLES `bank_details_status` WRITE;
/*!40000 ALTER TABLE `bank_details_status` DISABLE KEYS */;
INSERT INTO `bank_details_status` VALUES (1,'active'),(2,'deactivated');
/*!40000 ALTER TABLE `bank_details_status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `buyers_leg_entities`
--

DROP TABLE IF EXISTS `buyers_leg_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyers_leg_entities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_name` varchar(255) NOT NULL,
  `entity_tax_id` bigint unsigned NOT NULL COMMENT 'ИНН',
  `entity_reg_address` text NOT NULL,
  `entity_fact_address` text NOT NULL,
  `entity_fact_country_city_id` bigint unsigned NOT NULL,
  `entity_alias_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entity_tax_id` (`entity_tax_id`),
  KEY `index_of_entity_name` (`entity_name`),
  KEY `index_of_country_city_id` (`entity_fact_country_city_id`),
  KEY `index_of_entity_alias_id` (`entity_alias_id`),
  CONSTRAINT `fk_buyer_leg_entities_country_city_id` FOREIGN KEY (`entity_fact_country_city_id`) REFERENCES `country_cities` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_buyer_leg_entities_entity_alias` FOREIGN KEY (`entity_alias_id`) REFERENCES `alias_buyers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyers_leg_entities`
--

LOCK TABLES `buyers_leg_entities` WRITE;
/*!40000 ALTER TABLE `buyers_leg_entities` DISABLE KEYS */;
INSERT INTO `buyers_leg_entities` VALUES (1,'Inditex Retail Solutions Rus Co., Ltd.',481983947,'ulitsa Yakimanka 31, Moscow, Russia','Presnenskay Naberezhnaya 10, Blok C, etazh 35, Moscow, Russia',6,1),(2,'Inditex Logistcs Services Rus Co. Ltd.',481983384,'Promyshlenny Proezd 485, Moscow, Russia','Promyshlenny Proezd 485, Moscow, Russia',6,2);
/*!40000 ALTER TABLE `buyers_leg_entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collections`
--

DROP TABLE IF EXISTS `collections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collections` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` char(4) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collections`
--

LOCK TABLES `collections` WRITE;
/*!40000 ALTER TABLE `collections` DISABLE KEYS */;
INSERT INTO `collections` VALUES (2,'AW19'),(4,'AW20'),(6,'AW21'),(8,'AW22'),(10,'AW23'),(1,'SS19'),(3,'SS20'),(5,'SS21'),(7,'SS22'),(9,'SS23');
/*!40000 ALTER TABLE `collections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contracts`
--

DROP TABLE IF EXISTS `contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contracts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `buyer_leg_entity_id` bigint unsigned NOT NULL,
  `supplier_leg_entity_id` bigint unsigned NOT NULL,
  `contract_no` varchar(255) NOT NULL,
  `collection_id` bigint unsigned NOT NULL,
  `status` enum('active','deactivated','on hold') DEFAULT NULL,
  `currency_id` tinyint unsigned NOT NULL,
  `ports_of_loading_id` int unsigned NOT NULL,
  `delivery_basis_id` tinyint unsigned NOT NULL,
  `payment_mode_id` tinyint unsigned NOT NULL,
  `payment_terms_id` int unsigned NOT NULL,
  `vat` tinyint unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_of_contract_no` (`contract_no`),
  KEY `index_of_collection_id` (`collection_id`),
  KEY `index_of_ports_of_loading_id` (`ports_of_loading_id`),
  KEY `index_of_delivery_basis_id` (`delivery_basis_id`),
  KEY `index_of_suppl_leg_entity_id_payment_terms_id` (`supplier_leg_entity_id`,`payment_terms_id`,`payment_mode_id`),
  KEY `fk_contracts_buyer_leg_entity_id` (`buyer_leg_entity_id`),
  KEY `fk_contracts_currency_id` (`currency_id`),
  KEY `fk_contract_payment_mode_id` (`payment_mode_id`),
  KEY `fk_contracts_payment_terms_id` (`payment_terms_id`),
  CONSTRAINT `fk_contract_payment_mode_id` FOREIGN KEY (`payment_mode_id`) REFERENCES `payment_modes` (`id`),
  CONSTRAINT `fk_contracts_buyer_leg_entity_id` FOREIGN KEY (`buyer_leg_entity_id`) REFERENCES `buyers_leg_entities` (`id`),
  CONSTRAINT `fk_contracts_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `fk_contracts_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `fk_contracts_delivery_basis_id` FOREIGN KEY (`delivery_basis_id`) REFERENCES `delivery_basis` (`id`),
  CONSTRAINT `fk_contracts_payment_terms_id` FOREIGN KEY (`payment_terms_id`) REFERENCES `payment_terms` (`id`),
  CONSTRAINT `fk_contracts_pol_id` FOREIGN KEY (`ports_of_loading_id`) REFERENCES `ports_of_loading` (`id`),
  CONSTRAINT `fk_contracts_supplier_leg_entity_id` FOREIGN KEY (`supplier_leg_entity_id`) REFERENCES `suppliers_leg_entities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contracts`
--

LOCK TABLES `contracts` WRITE;
/*!40000 ALTER TABLE `contracts` DISABLE KEYS */;
INSERT INTO `contracts` VALUES (1,1,1,'IRR/STS/001/AW22',8,'active',1,1,1,1,2,NULL),(2,1,4,'IRR/STI/002/AW22',8,'active',4,1,8,1,1,NULL),(3,2,7,'IRL/ZTS/003/AW22',8,'active',3,7,2,1,9,NULL),(4,1,10,'IRR/HJO/005/AW22',8,'active',1,4,1,1,3,NULL),(5,1,6,'IRR/CMI/004/AW22',8,'active',1,6,1,1,10,NULL),(6,1,5,'IRR/SAM/006/AW22',8,'deactivated',4,2,1,1,4,NULL),(7,1,2,'IRR/NSI/007/AW21',6,'deactivated',1,3,2,1,9,NULL),(8,1,3,'IRR/SHC/008/AW22',8,'active',4,1,1,1,2,NULL),(9,2,8,'IRL/HEM/010/AW22',8,'active',1,8,8,1,7,15),(10,1,9,'IRR/ADG/012/SS22',7,'on hold',1,1,1,1,1,NULL);
/*!40000 ALTER TABLE `contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_cities`
--

DROP TABLE IF EXISTS `country_cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country_cities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `country` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_of_country_city` (`country`,`city`),
  KEY `index_of_city` (`city`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_cities`
--

LOCK TABLES `country_cities` WRITE;
/*!40000 ALTER TABLE `country_cities` DISABLE KEYS */;
INSERT INTO `country_cities` VALUES (8,'Bangladesh','Chittagong'),(7,'British Virgin Islands','Road Town'),(5,'China','Hong Kong'),(3,'China','Ningbo'),(1,'China','Shanghai'),(2,'China','Shenzhen'),(4,'China','Xiamen'),(10,'Korea','Busan'),(6,'Russia','Moscow'),(14,'Russia','Novosibirsk'),(11,'Russia','Saint Petersburg'),(13,'Russia','Vladivostok'),(12,'Russia','Yekaterinburg'),(9,'Turkey','Istambul');
/*!40000 ALTER TABLE `country_cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name_acronym` char(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'USD'),(2,'RUB'),(3,'EUR'),(4,'CNY'),(5,'TRY'),(6,'BYN'),(7,'BDT'),(8,'UZS'),(9,'INR'),(10,'HKD'),(11,'SGD');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currency_exchange_rates`
--

DROP TABLE IF EXISTS `currency_exchange_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currency_exchange_rates` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_currency_id` tinyint unsigned NOT NULL,
  `to_currency_id` tinyint unsigned NOT NULL,
  `rate_value` decimal(10,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_curr_exch_rates_to_currency_id` (`to_currency_id`),
  KEY `index_of_currency_pair` (`from_currency_id`,`to_currency_id`),
  KEY `index_of_created_at` (`created_at`),
  KEY `index_of_rate_value` (`rate_value`),
  CONSTRAINT `fk_curr_exch_rates_from_currency_id` FOREIGN KEY (`from_currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `fk_curr_exch_rates_to_currency_id` FOREIGN KEY (`to_currency_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currency_exchange_rates`
--

LOCK TABLES `currency_exchange_rates` WRITE;
/*!40000 ALTER TABLE `currency_exchange_rates` DISABLE KEYS */;
INSERT INTO `currency_exchange_rates` VALUES (1,4,2,11.2128,'2021-10-07 21:00:00'),(2,3,1,1.1564,'2021-10-07 21:00:00'),(3,3,2,83.1400,'2021-10-07 21:00:00'),(4,1,2,71.8800,'2021-10-07 21:00:00'),(5,1,4,6.4369,'2021-10-07 21:00:00'),(6,9,2,9.5374,'2021-10-14 21:00:00'),(7,4,2,11.1569,'2021-10-14 21:00:00'),(8,3,2,82.3900,'2021-10-14 21:00:00'),(9,3,1,1.1601,'2021-10-14 21:00:00'),(10,1,2,71.0300,'2021-10-14 21:00:00');
/*!40000 ALTER TABLE `currency_exchange_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_basis`
--

DROP TABLE IF EXISTS `delivery_basis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_basis` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` char(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_basis`
--

LOCK TABLES `delivery_basis` WRITE;
/*!40000 ALTER TABLE `delivery_basis` DISABLE KEYS */;
INSERT INTO `delivery_basis` VALUES (1,'FOB'),(2,'FCA'),(3,'FAS'),(4,'DAP'),(5,'DAT'),(6,'CIF'),(7,'CFR'),(8,'EXW'),(9,'FOR'),(10,'DPU');
/*!40000 ALTER TABLE `delivery_basis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `delivery_instores`
--

DROP TABLE IF EXISTS `delivery_instores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_instores` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `collection_id` bigint unsigned NOT NULL,
  `delivery_no` tinyint unsigned NOT NULL,
  `instore` timestamp NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_of_coll_del_instore` (`collection_id`,`delivery_no`,`instore`),
  CONSTRAINT `fk_deliv_instores_id` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_instores`
--

LOCK TABLES `delivery_instores` WRITE;
/*!40000 ALTER TABLE `delivery_instores` DISABLE KEYS */;
INSERT INTO `delivery_instores` VALUES (10,8,1,'2022-03-01 21:00:00'),(9,8,2,'2022-03-15 21:00:00'),(8,8,3,'2022-03-29 21:00:00'),(7,8,4,'2022-04-12 21:00:00'),(6,8,5,'2022-04-26 21:00:00'),(5,8,6,'2022-05-10 21:00:00'),(4,8,7,'2022-05-24 21:00:00'),(3,8,8,'2022-06-07 21:00:00'),(2,8,9,'2022-06-21 21:00:00'),(1,8,10,'2022-07-05 21:00:00');
/*!40000 ALTER TABLE `delivery_instores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `destination_points`
--

DROP TABLE IF EXISTS `destination_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `destination_points` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `country_city_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_destin_points_country_city_id` (`country_city_id`),
  CONSTRAINT `fk_destin_points_country_city_id` FOREIGN KEY (`country_city_id`) REFERENCES `country_cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `destination_points`
--

LOCK TABLES `destination_points` WRITE;
/*!40000 ALTER TABLE `destination_points` DISABLE KEYS */;
INSERT INTO `destination_points` VALUES (1,'FDC Moscow',6),(2,'RDC Saint Petersburg',11),(3,'RDC Yekaterinburg',12),(4,'RDC Vladivostok',13),(5,'RDC Novosibirsk',14),(6,'NDC Shanghai',1);
/*!40000 ALTER TABLE `destination_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `contract_no_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_of_collection_suppl_alias_contract` (`contract_no_id`),
  CONSTRAINT `fk_orders_contract_no_id` FOREIGN KEY (`contract_no_id`) REFERENCES `contracts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (1,1,'2021-10-20 18:45:20'),(2,2,'2021-10-20 18:45:20'),(3,3,'2021-10-20 18:45:20'),(4,4,'2021-10-20 18:45:20'),(5,5,'2021-10-20 18:45:20'),(6,6,'2021-10-20 18:45:20'),(7,1,'2021-10-20 18:45:20'),(8,1,'2021-10-20 18:45:20'),(9,5,'2021-10-20 18:45:20');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders_products`
--

DROP TABLE IF EXISTS `orders_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders_products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `style_no_id` varchar(255) NOT NULL,
  `qty_share_to_ship_by_route` int unsigned NOT NULL DEFAULT '100',
  `transportation_route_id` int unsigned NOT NULL,
  `order_amount` decimal(12,2) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_orders_products_order_amount` (`order_amount`),
  KEY `index_orders_products_order_id_currency_id` (`order_id`,`style_no_id`,`order_amount`),
  KEY `fk_orders_products_style_no_id` (`style_no_id`),
  KEY `fk_orders_products_trans_route` (`transportation_route_id`),
  CONSTRAINT `fk_orders_products_order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `fk_orders_products_style_no_id` FOREIGN KEY (`style_no_id`) REFERENCES `product_styles` (`style_no`),
  CONSTRAINT `fk_orders_products_trans_route` FOREIGN KEY (`transportation_route_id`) REFERENCES `transportation_routes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders_products`
--

LOCK TABLES `orders_products` WRITE;
/*!40000 ALTER TABLE `orders_products` DISABLE KEYS */;
INSERT INTO `orders_products` VALUES (1,5,'MK9F4278',70,4,188434.65),(2,5,'MK9F4278',30,5,80757.71),(3,3,'MJ9L9399',100,8,420675.20),(4,3,'MP3L9402',100,8,231714.00),(5,1,'GP2K3800',60,1,42227.22),(6,1,'GP2K3800',40,2,28151.48),(7,2,'LT4R3400',80,1,13211.92),(8,2,'LT4R3400',20,3,3302.98),(9,2,'MK5R3499',70,1,35392.64),(10,2,'MK5R3499',30,6,15168.28),(11,7,'MO3J4828',100,3,21277.08),(12,6,'LE9I8308',100,7,25447.40),(13,4,'LD3O4901',100,7,630790.44),(14,4,'LP2H6255',100,7,513021.60);
/*!40000 ALTER TABLE `orders_products` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_insert_calc_amount` BEFORE INSERT ON `orders_products` FOR EACH ROW BEGIN
    DECLARE alias_id_from_product_styles BIGINT UNSIGNED;
    DECLARE alias_id_from_order BIGINT UNSIGNED;

    SET alias_id_from_product_styles = (SELECT prod_st.supplier_alias_id
                                        FROM product_styles prod_st WHERE NEW.style_no_id = prod_st.style_no);
    SET alias_id_from_order = (SELECT alias.id
                                FROM orders
                                JOIN contracts con ON orders.contract_no_id = con.id
                                JOIN suppliers_leg_entities sle on con.supplier_leg_entity_id = sle.id
                                JOIN alias_suppliers alias on sle.entity_alias_id = alias.id
                                WHERE orders.id = NEW.order_id);
    IF alias_id_from_product_styles = alias_id_from_order
        THEN
            SET NEW.order_amount =
                (SELECT ps.price_value FROM product_styles AS ps WHERE ps.style_no = NEW.style_no_id LIMIT 1) *
                (SELECT ps.ordered_qty FROM product_styles AS ps WHERE ps.style_no = NEW.style_no_id LIMIT 1) *
                (NEW.qty_share_to_ship_by_route / 100);
        ELSE
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Alias of supplier id set in style does not match alias of supplier set in contract assigned to selected order number.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `payment_due_points`
--

DROP TABLE IF EXISTS `payment_due_points`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_due_points` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `due_points` enum('planned latest shipment','order allocation','quality approval','actual shipment date','planned delivery to final destination','actual delivery to final destination') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_due_points`
--

LOCK TABLES `payment_due_points` WRITE;
/*!40000 ALTER TABLE `payment_due_points` DISABLE KEYS */;
INSERT INTO `payment_due_points` VALUES (1,'planned latest shipment'),(2,'order allocation'),(3,'quality approval'),(4,'actual shipment date'),(5,'planned delivery to final destination'),(6,'actual delivery to final destination');
/*!40000 ALTER TABLE `payment_due_points` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_modes`
--

DROP TABLE IF EXISTS `payment_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_modes` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `name` enum('T/T','L/C','mixed') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_modes`
--

LOCK TABLES `payment_modes` WRITE;
/*!40000 ALTER TABLE `payment_modes` DISABLE KEYS */;
INSERT INTO `payment_modes` VALUES (1,'T/T'),(2,'L/C'),(3,'mixed');
/*!40000 ALTER TABLE `payment_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_terms`
--

DROP TABLE IF EXISTS `payment_terms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment_terms` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `payment_due_point_id` tinyint unsigned NOT NULL DEFAULT '1',
  `advance_payment_val` tinyint unsigned DEFAULT '0',
  `before_shpmt_payment_val` tinyint unsigned DEFAULT '0',
  `postpayment_1_val` tinyint unsigned DEFAULT '0',
  `postpayment_2_val` tinyint unsigned DEFAULT '0',
  `lc_val` tinyint unsigned DEFAULT '0',
  `advance_payment_due_point_delta` int DEFAULT '-100',
  `before_shpmt_payment_due_point_delta` int DEFAULT '-14',
  `postpayment_1_due_point_delta` int DEFAULT '120',
  `postpayment_2_due_point_delta` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payment_terms_due_point_id` (`payment_due_point_id`),
  CONSTRAINT `fk_payment_terms_due_point_id` FOREIGN KEY (`payment_due_point_id`) REFERENCES `payment_due_points` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_terms`
--

LOCK TABLES `payment_terms` WRITE;
/*!40000 ALTER TABLE `payment_terms` DISABLE KEYS */;
INSERT INTO `payment_terms` VALUES (1,1,10,60,30,0,0,-150,-14,90,0),(2,1,20,50,30,0,0,-150,-14,60,0),(3,1,0,50,50,0,0,-150,-14,120,0),(4,1,10,0,50,40,0,-150,0,30,120),(5,1,10,0,60,30,0,-150,0,21,150),(6,3,0,0,100,0,0,0,0,110,0),(7,3,10,0,90,0,0,-120,0,100,0),(8,4,0,0,100,0,0,0,0,70,0),(9,1,30,60,10,0,0,-150,-14,90,0),(10,6,0,0,80,20,0,0,0,14,30);
/*!40000 ALTER TABLE `payment_terms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `payment_type` enum('advance payment','before shipment','postpayment_1','postpayment_2','lc') DEFAULT NULL,
  `orders_products_id` bigint unsigned NOT NULL,
  `payment_amount_suggested` decimal(12,2) unsigned DEFAULT NULL,
  `payment_amount_user` decimal(12,2) unsigned DEFAULT NULL,
  `status` enum('created','approved','remitted','cancelled') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `index_of_payments` (`orders_products_id`,`status`,`payment_amount_user`),
  CONSTRAINT `fk_payments_order_id` FOREIGN KEY (`orders_products_id`) REFERENCES `orders_products` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (1,'advance payment',7,1321.19,0.00,'remitted','2021-10-20 18:45:20'),(2,'advance payment',8,330.30,0.00,'remitted','2021-10-20 18:45:20'),(3,'advance payment',9,3539.26,0.00,'remitted','2021-10-20 18:45:20'),(4,'advance payment',10,1516.83,0.00,'remitted','2021-10-20 18:45:20'),(5,'before shipment',7,7927.15,0.00,'remitted','2021-10-20 18:45:20'),(6,'before shipment',8,1981.79,0.00,'remitted','2021-10-20 18:45:20'),(7,'before shipment',9,21235.58,0.00,'remitted','2021-10-20 18:45:20'),(8,'before shipment',10,9100.97,0.00,'remitted','2021-10-20 18:45:20'),(9,'advance payment',11,4255.42,0.00,'remitted','2021-10-20 18:45:20'),(10,'before shipment',11,10638.54,0.00,'remitted','2021-10-20 18:45:20'),(11,'postpayment_1',11,6383.12,0.00,'remitted','2021-10-20 18:45:20'),(12,'advance payment',12,2544.74,0.00,'remitted','2021-10-20 18:45:20'),(13,'postpayment_1',12,12723.70,0.00,'remitted','2021-10-20 18:45:20'),(14,'advance payment',3,126202.56,0.00,'remitted','2021-10-20 18:45:20'),(15,'advance payment',5,8445.44,0.00,'remitted','2021-10-20 18:45:20');
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calc_check_payment` BEFORE INSERT ON `payments` FOR EACH ROW BEGIN
    DECLARE p_type VARCHAR(255);
    DECLARE amount_share_for_payment INT;
    DECLARE order_calc_amount DECIMAL(12,2) DEFAULT 0;
    SET p_type = NEW.payment_type;
    SET order_calc_amount = (SELECT sum(op.order_amount)
                            FROM orders_products op WHERE op.id = NEW.orders_products_id);
    CASE p_type
        WHEN 'advance payment' THEN
        SET amount_share_for_payment = (SELECT pt.advance_payment_val FROM orders_products op
                                        JOIN orders o ON op.order_id = o.id
                                        JOIN contracts con ON o.contract_no_id = con.id
                                        JOIN payment_terms pt ON con.payment_terms_id = pt.id
                                        WHERE op.id = NEW.orders_products_id);

        WHEN 'before shipment' THEN
        SET amount_share_for_payment = (SELECT pt.before_shpmt_payment_val FROM orders_products op
                                        JOIN orders o ON op.order_id = o.id
                                        JOIN contracts con ON o.contract_no_id = con.id
                                        JOIN payment_terms pt ON con.payment_terms_id = pt.id
                                        WHERE op.id = NEW.orders_products_id);
        WHEN 'postpayment_1' THEN
        SET amount_share_for_payment = (SELECT pt.postpayment_1_val FROM orders_products op
                                        JOIN orders o ON op.order_id = o.id
                                        JOIN contracts con ON o.contract_no_id = con.id
                                        JOIN payment_terms pt ON con.payment_terms_id = pt.id
                                        WHERE op.id = NEW.orders_products_id);
        WHEN 'postpayment_2' THEN
        SET amount_share_for_payment = (SELECT pt.postpayment_2_val FROM orders_products op
                                        JOIN orders o ON op.order_id = o.id
                                        JOIN contracts con ON o.contract_no_id = con.id
                                        JOIN payment_terms pt ON con.payment_terms_id = pt.id
                                        WHERE op.id = NEW.orders_products_id);
    END CASE;
    IF amount_share_for_payment != 0 OR amount_share_for_payment IS NOT NULL THEN
        SET NEW.payment_amount_suggested = order_calc_amount * (amount_share_for_payment/100);
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This type of payment is not stipulated by the contract payment terms.';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'REAL_AS_FLOAT,PIPES_AS_CONCAT,ANSI_QUOTES,IGNORE_SPACE,ONLY_FULL_GROUP_BY,ANSI' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_style_payment_account` BEFORE INSERT ON `payments` FOR EACH ROW BEGIN
        DECLARE order_amount DECIMAL(12,2) DEFAULT 0;
        DECLARE already_paid DECIMAL(12,2) DEFAULT 0;

        SET order_amount = (SELECT sum(op.order_amount)
                            FROM orders_products op WHERE op.id = NEW.orders_products_id);
        SET already_paid = (SELECT SUM(payment_amount_suggested)
                            FROM payments WHERE orders_products_id = NEW.orders_products_id);
        IF order_amount - already_paid <= 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'This style under indicated order has been fully paid to supplier.';
        END IF;
    END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ports_of_loading`
--

DROP TABLE IF EXISTS `ports_of_loading`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ports_of_loading` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `country_city_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_pol_country_city_id` (`country_city_id`),
  CONSTRAINT `fk_pol_country_city_id` FOREIGN KEY (`country_city_id`) REFERENCES `country_cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ports_of_loading`
--

LOCK TABLES `ports_of_loading` WRITE;
/*!40000 ALTER TABLE `ports_of_loading` DISABLE KEYS */;
INSERT INTO `ports_of_loading` VALUES (1,'Shanghai',1),(2,'Shenzhen',2),(3,'Ningbo',3),(4,'Xiamen',4),(5,'Hong Kong',5),(6,'Chittagong',8),(7,'Istambul',9),(8,'Busan',10);
/*!40000 ALTER TABLE `ports_of_loading` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_compositions`
--

DROP TABLE IF EXISTS `product_compositions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_compositions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `composition` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `composition` (`composition`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_compositions`
--

LOCK TABLES `product_compositions` WRITE;
/*!40000 ALTER TABLE `product_compositions` DISABLE KEYS */;
INSERT INTO `product_compositions` VALUES (4,'100% cotton'),(1,'100% polyester'),(5,'50% cotton 50% polyester'),(3,'60% cotton, 40% polyester'),(7,'65% cotton, 30% polyester, 5% spandex'),(10,'70% cotton, 30% polyamide'),(6,'70% cotton, 30% polyester'),(2,'80% cotton, 20% polyester'),(9,'SHELL: 100% polyester, PADDING: 50% goose down, 50% sintepon'),(8,'SHELL: 90% polyester, 10% acrylic, PADDING: 100% goose down');
/*!40000 ALTER TABLE `product_compositions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_descriptions`
--

DROP TABLE IF EXISTS `product_descriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_descriptions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  `production_type_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_of_descr_product_type` (`description`,`production_type_id`),
  KEY `fk_product_descr_production_type_id` (`production_type_id`),
  CONSTRAINT `fk_product_descr_production_type_id` FOREIGN KEY (`production_type_id`) REFERENCES `production_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_descriptions`
--

LOCK TABLES `product_descriptions` WRITE;
/*!40000 ALTER TABLE `product_descriptions` DISABLE KEYS */;
INSERT INTO `product_descriptions` VALUES (8,'female basic blouse',6),(3,'female oversize fancy hoodie',2),(1,'female padded jacket with hydrophobic coating',9),(7,'male basic straight jeans',5),(5,'male casual hoodie with zipper',2),(9,'male casual oxford shirt',6),(2,'male natural down padded jacket',9),(4,'male slimfit hoodie',2),(10,'male swimming shorts printed',8),(6,'male t-shirt with front print',1);
/*!40000 ALTER TABLE `product_descriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_styles`
--

DROP TABLE IF EXISTS `product_styles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_styles` (
  `style_no` varchar(255) NOT NULL,
  `collection_no_id` bigint unsigned NOT NULL,
  `supplier_alias_id` bigint unsigned NOT NULL,
  `price_value` decimal(7,2) unsigned NOT NULL,
  `price_currency_id` tinyint unsigned NOT NULL,
  `ordered_qty` int unsigned DEFAULT '0',
  `production_type_id` bigint unsigned NOT NULL,
  `product_description_id` bigint unsigned NOT NULL,
  `product_composition_id` bigint unsigned NOT NULL,
  `delivery_instore_id` bigint unsigned NOT NULL,
  `production_facility_id` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`style_no`),
  KEY `fk_product_styles_collection_no_id` (`collection_no_id`),
  KEY `fk_product_styles_supplier_alias_id` (`supplier_alias_id`),
  KEY `fk_product_styles_price_currency_id` (`price_currency_id`),
  KEY `fk_product_styles_production_type_id` (`production_type_id`),
  KEY `fk_product_styles_product_descr_id` (`product_description_id`),
  KEY `fk_product_styles_product_compo_id` (`product_composition_id`),
  KEY `fk_product_styles_delivery_instore_id` (`delivery_instore_id`),
  KEY `fk_product_styles_production_facility_id` (`production_facility_id`),
  CONSTRAINT `fk_product_styles_collection_no_id` FOREIGN KEY (`collection_no_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `fk_product_styles_delivery_instore_id` FOREIGN KEY (`delivery_instore_id`) REFERENCES `delivery_instores` (`id`),
  CONSTRAINT `fk_product_styles_price_currency_id` FOREIGN KEY (`price_currency_id`) REFERENCES `currencies` (`id`),
  CONSTRAINT `fk_product_styles_product_compo_id` FOREIGN KEY (`product_composition_id`) REFERENCES `product_compositions` (`id`),
  CONSTRAINT `fk_product_styles_product_descr_id` FOREIGN KEY (`product_description_id`) REFERENCES `product_descriptions` (`id`),
  CONSTRAINT `fk_product_styles_production_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `production_facilities` (`id`),
  CONSTRAINT `fk_product_styles_production_type_id` FOREIGN KEY (`production_type_id`) REFERENCES `production_types` (`id`),
  CONSTRAINT `fk_product_styles_supplier_alias_id` FOREIGN KEY (`supplier_alias_id`) REFERENCES `alias_suppliers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_styles`
--

LOCK TABLES `product_styles` WRITE;
/*!40000 ALTER TABLE `product_styles` DISABLE KEYS */;
INSERT INTO `product_styles` VALUES ('GP2K3800',8,1,7.42,1,9485,6,8,2,7,1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('LD3O4901',8,9,34.23,1,18428,9,2,8,6,7,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('LE9I8308',8,4,4.73,4,5380,8,8,6,2,8,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('LP2H6255',8,9,23.49,1,21840,9,1,9,10,7,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('LT4R3400',8,1,4.78,4,3455,6,8,2,2,1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('MJ9L9399',8,6,12.92,3,32560,5,7,2,6,6,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('MK5R3499',8,1,3.48,4,14529,8,10,7,1,2,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('MK9F4278',8,5,5.93,1,45395,2,3,3,1,5,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('MO3J4828',8,1,5.94,1,3582,6,9,6,4,1,'2021-10-20 18:45:20','2021-10-20 18:45:20'),('MP3L9402',8,6,9.45,3,24520,5,7,4,5,6,'2021-10-20 18:45:20','2021-10-20 18:45:20');
/*!40000 ALTER TABLE `product_styles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_facilities`
--

DROP TABLE IF EXISTS `production_facilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `production_facilities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `facility_name` varchar(255) NOT NULL,
  `fact_address` varchar(255) NOT NULL,
  `fact_country_city_id` bigint unsigned NOT NULL,
  `alias_suppl_id` bigint unsigned NOT NULL,
  `status` enum('Inspection','Approved','Rejected','To be reinspected','Reinspection') NOT NULL,
  `status_updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `port_of_loading_id` int unsigned NOT NULL,
  `comments` text,
  PRIMARY KEY (`id`),
  KEY `fk_prod_facil_port_of_loading_id` (`port_of_loading_id`),
  KEY `index_of_facility_name` (`facility_name`),
  KEY `index_of_fact_country_city_id` (`fact_country_city_id`),
  KEY `index_of_alias_suppl_id` (`alias_suppl_id`),
  KEY `index_of_status` (`status`),
  CONSTRAINT `fk_prod_facil_alias_suppl_id` FOREIGN KEY (`alias_suppl_id`) REFERENCES `alias_suppliers` (`id`),
  CONSTRAINT `fk_prod_facil_fact_country_city_id` FOREIGN KEY (`fact_country_city_id`) REFERENCES `country_cities` (`id`),
  CONSTRAINT `fk_prod_facil_port_of_loading_id` FOREIGN KEY (`port_of_loading_id`) REFERENCES `ports_of_loading` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_facilities`
--

LOCK TABLES `production_facilities` WRITE;
/*!40000 ALTER TABLE `production_facilities` DISABLE KEYS */;
INSERT INTO `production_facilities` VALUES (1,'Xinshuai Zhenfeng Textile Co. Ltd','Bingfengdadao 34, Shanghai, China',1,1,'Approved','2020-10-02 21:00:00',1,NULL),(2,'Shanghai Textiles Industries Co. Ltd','Xuehuadadao 23, Shanghai, China',1,1,'Approved','2020-12-30 21:00:00',1,NULL),(3,'Ningbo Seduno Top Sewing Co. Ltd','Shijiedadao 84, Ningbo, China',3,2,'Approved','2018-10-11 21:00:00',3,NULL),(4,'Minar Woven Manufacturing Co. Ltd','Queens Street 10, Chittagong, Bangladesh',8,5,'Inspection','2021-10-16 21:00:00',6,'Problems with quality system, 6% defection ratio in the last batch. Need to reinspect in-line quality system'),(5,'Minar Excellent Sewing Industries Co. Ltd','Dhaka-Bangalore National Highway 456 km, building 1, Dhaka, Bangladesh',8,5,'Rejected','2021-09-29 21:00:00',6,'35% of SS21 bulk orders with major defects, 25% of retail returns. Need to go through inspection.'),(6,'Zeria Tekstil Sanayi ve Dİs Ticaret Ltd Sti','Esenler Sk 1, Istanbul, Turkey',9,6,'Inspection','2021-10-08 21:00:00',7,'Good quality PPS. Inspection planned on Nov 1, 2021'),(7,'Xiamen H&J Outerwear Manufacturing Co. Ltd','Xihulu 29, Xiamen, China',4,9,'Approved','2019-12-30 21:00:00',4,NULL),(8,'Haochi Huluobo Indusrial Co. Ltd.','Xinguolu 65, Shenzhen, China',2,4,'Approved','2016-01-30 21:00:00',2,NULL),(9,'Ssang Yong Heung Textile Industries Co., Ltd','Minhaseung 34, Busan, Korea',10,7,'Approved','2021-04-19 21:00:00',8,NULL),(10,'Istanbul tekstil üretim şirketi','Sarhoş rusların sokağı 10, Instanbul, Turkey',9,6,'Approved','2020-08-18 21:00:00',7,NULL);
/*!40000 ALTER TABLE `production_facilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_facilities_types`
--

DROP TABLE IF EXISTS `production_facilities_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `production_facilities_types` (
  `production_facility_id` bigint unsigned NOT NULL,
  `production_types_id` bigint unsigned NOT NULL,
  UNIQUE KEY `index_of_facility_production_type` (`production_facility_id`,`production_types_id`),
  KEY `fk_prod_fac_type_prod_type_id` (`production_types_id`),
  CONSTRAINT `fk_prod_fac_type_prod_facility_id` FOREIGN KEY (`production_facility_id`) REFERENCES `production_facilities` (`id`),
  CONSTRAINT `fk_prod_fac_type_prod_type_id` FOREIGN KEY (`production_types_id`) REFERENCES `production_types` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_facilities_types`
--

LOCK TABLES `production_facilities_types` WRITE;
/*!40000 ALTER TABLE `production_facilities_types` DISABLE KEYS */;
INSERT INTO `production_facilities_types` VALUES (3,1),(5,2),(10,3),(9,4),(6,5),(1,6),(4,6),(1,7),(2,8),(8,8),(7,9);
/*!40000 ALTER TABLE `production_facilities_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `production_types`
--

DROP TABLE IF EXISTS `production_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `production_types` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class` varchar(255) NOT NULL,
  `subclass` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_of_product_types` (`class`,`subclass`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `production_types`
--

LOCK TABLES `production_types` WRITE;
/*!40000 ALTER TABLE `production_types` DISABLE KEYS */;
INSERT INTO `production_types` VALUES (2,'CUTKNITS','HOODIES'),(3,'CUTKNITS','SWEATSHIRTS'),(1,'CUTKNITS','T-SHIRTS'),(4,'DENIM','JACKETS'),(5,'DENIM','JEANS'),(9,'OUTERWEAR','PADDED JACKETS'),(10,'OUTERWEAR','WINDJACKETS'),(6,'WOVEN','SHIRTS'),(8,'WOVEN','SHORTS'),(7,'WOVEN','TROUSERS');
/*!40000 ALTER TABLE `production_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `suppliers_leg_entities`
--

DROP TABLE IF EXISTS `suppliers_leg_entities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `suppliers_leg_entities` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `entity_name` varchar(255) NOT NULL COMMENT 'Юридическое наименование поставщика, не уникально, т.к. юридические наименования могут повторяться',
  `entity_tax_id` bigint unsigned NOT NULL COMMENT 'ИНН',
  `entity_reg_address` text NOT NULL,
  `entity_fact_address` text NOT NULL,
  `entity_reg_country_city_id` bigint unsigned NOT NULL COMMENT 'Необходимо т.к. офис поставщика может находиться в одном городе-стране, а юридическое лицо где-нибуль на виргинских островах',
  `entity_alias_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `entity_tax_id` (`entity_tax_id`),
  KEY `index_of_entity_name` (`entity_name`),
  KEY `index_of_country_city_id` (`entity_reg_country_city_id`),
  KEY `index_of_entity_alias_id` (`entity_alias_id`),
  CONSTRAINT `fk_suppl_leg_entities_country_city_id` FOREIGN KEY (`entity_reg_country_city_id`) REFERENCES `country_cities` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_suppl_leg_entities_entity_alias` FOREIGN KEY (`entity_alias_id`) REFERENCES `alias_suppliers` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `suppliers_leg_entities`
--

LOCK TABLES `suppliers_leg_entities` WRITE;
/*!40000 ALTER TABLE `suppliers_leg_entities` DISABLE KEYS */;
INSERT INTO `suppliers_leg_entities` VALUES (1,'Shanghai Textiles Supplies Co. Ltd.',3747498593,'Mainstreet 2, Road Town, British Virgin Islands','Xuehuadadao 23, Shanghai, China',7,1),(2,'Ningbo Supreme Import & Export Co. Ltd',3747492984,'Shijiedadao 84, Ningbo, China','Shijiedadao 84, Ningbo, China',3,2),(3,'Shanghai Knitwear Co. Ltd.',3747490193,'Dongfengdadao 13, Shanghai, China','Dongfengdadao 13, Shanghai, China',1,3),(4,'Shanghai Trading I&E Co. Ltd',3747498450,'Xuehuadadao 23, Shanghai, China','Xuehuadadao 23, Shanghai, China',1,1),(5,'Shuangfeng Accessories Manufacturing Co. Ltd',3747491095,'Xinguolu 65, Shenzhen, China','Xinguolu 65, Shenzhen, China',2,4),(6,'Chittagong Minar Industries Co. Ltd',24578510,'Queens Street 10, Chittagong, Bangladesh','Queens Street 10, Chittagong, Bangladesh',8,5),(7,'Zeria Tekstil Sanayi ve Dİs Ticaret Ltd Sti',569384917,'Esenler Sk 1, Istanbul, Turkey','Esenler Sk 1, Istanbul, Turkey',9,6),(8,'Heung Apparels Manufacturing LLC',384950276,'Minhaseung 34, Busan, Korea','Minhaseung 34, Busan, Korea',10,7),(9,'Anhui Dafeng Garments I&E Co. Ltd',3747495739,'Liudalu 98, Shanghai, China','Liudalu 98, Shanghai, China',1,8),(10,'H&J Outerwear Apparels Co. Ltd',3747499384,'Xihulu 29, Xiamen, China','Xihulu 29, Xiamen, China',4,9);
/*!40000 ALTER TABLE `suppliers_leg_entities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transhipment_hubs`
--

DROP TABLE IF EXISTS `transhipment_hubs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transhipment_hubs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `country_city_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_trans_hubs_country_city_id` (`country_city_id`),
  CONSTRAINT `fk_trans_hubs_country_city_id` FOREIGN KEY (`country_city_id`) REFERENCES `country_cities` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transhipment_hubs`
--

LOCK TABLES `transhipment_hubs` WRITE;
/*!40000 ALTER TABLE `transhipment_hubs` DISABLE KEYS */;
INSERT INTO `transhipment_hubs` VALUES (1,'HUB Vladivostok',13),(2,'HUB Vostochny',13),(3,'HUB Ust Luga',11),(4,'HUB Shanghai',1),(5,'HUB Busan',10),(6,'HUB Hong Kong',5),(7,'HUB Shenzhen',2),(8,'HUB Chittagong',8),(9,'HUB Moscow',6),(10,'HUB Yekaterinburg',12);
/*!40000 ALTER TABLE `transhipment_hubs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `transit_routes_times`
--

DROP TABLE IF EXISTS `transit_routes_times`;
/*!50001 DROP VIEW IF EXISTS `transit_routes_times`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `transit_routes_times` AS SELECT 
 1 AS `id`,
 1 AS `transit_route_name`,
 1 AS `transit_time`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transportation_modes`
--

DROP TABLE IF EXISTS `transportation_modes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportation_modes` (
  `id` tinyint unsigned NOT NULL AUTO_INCREMENT,
  `trans_mode` enum('sea','air','railway','truck','river') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportation_modes`
--

LOCK TABLES `transportation_modes` WRITE;
/*!40000 ALTER TABLE `transportation_modes` DISABLE KEYS */;
INSERT INTO `transportation_modes` VALUES (1,'sea'),(2,'air'),(3,'railway'),(4,'truck'),(5,'river');
/*!40000 ALTER TABLE `transportation_modes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transportation_routes`
--

DROP TABLE IF EXISTS `transportation_routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transportation_routes` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `port_of_loading_id` int unsigned NOT NULL COMMENT 'Точка отгрузки',
  `trans_hub_id` int unsigned DEFAULT NULL,
  `from_port_to_hub_trans_mode_id` tinyint unsigned DEFAULT NULL,
  `from_hub_to_dest_point_trans_mode_id` tinyint unsigned DEFAULT NULL,
  `from_port_to_dest_point_trans_mode_id` tinyint unsigned DEFAULT NULL,
  `destination_point_id` bigint unsigned NOT NULL,
  `collection_id` bigint unsigned NOT NULL,
  `transit_time` int unsigned NOT NULL DEFAULT '60',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_of_trans_routes` (`collection_id`,`port_of_loading_id`,`trans_hub_id`,`destination_point_id`),
  KEY `index_of_transit_time` (`transit_time`),
  KEY `fk_trans_routes_pol_id` (`port_of_loading_id`),
  KEY `fk_trans_routes_trans_hub_id` (`trans_hub_id`),
  KEY `fk_trans_routes_from_port_to_hub_trans_mode_id` (`from_port_to_hub_trans_mode_id`),
  KEY `fk_trans_routes_from_hub_to_dest_point_trans_mode_id` (`from_hub_to_dest_point_trans_mode_id`),
  KEY `fk_trans_routes_from_port_to_dest_point_trans_mode_id` (`from_port_to_dest_point_trans_mode_id`),
  KEY `fk_trans_routes_destination_point_id` (`destination_point_id`),
  CONSTRAINT `fk_trans_routes_collection_id` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`),
  CONSTRAINT `fk_trans_routes_destination_point_id` FOREIGN KEY (`destination_point_id`) REFERENCES `destination_points` (`id`),
  CONSTRAINT `fk_trans_routes_from_hub_to_dest_point_trans_mode_id` FOREIGN KEY (`from_hub_to_dest_point_trans_mode_id`) REFERENCES `transportation_modes` (`id`),
  CONSTRAINT `fk_trans_routes_from_port_to_dest_point_trans_mode_id` FOREIGN KEY (`from_port_to_dest_point_trans_mode_id`) REFERENCES `transportation_modes` (`id`),
  CONSTRAINT `fk_trans_routes_from_port_to_hub_trans_mode_id` FOREIGN KEY (`from_port_to_hub_trans_mode_id`) REFERENCES `transportation_modes` (`id`),
  CONSTRAINT `fk_trans_routes_pol_id` FOREIGN KEY (`port_of_loading_id`) REFERENCES `ports_of_loading` (`id`),
  CONSTRAINT `fk_trans_routes_trans_hub_id` FOREIGN KEY (`trans_hub_id`) REFERENCES `transhipment_hubs` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transportation_routes`
--

LOCK TABLES `transportation_routes` WRITE;
/*!40000 ALTER TABLE `transportation_routes` DISABLE KEYS */;
INSERT INTO `transportation_routes` VALUES (1,1,2,1,3,NULL,1,8,35),(2,1,2,1,3,NULL,3,8,30),(3,1,3,1,4,NULL,1,8,57),(4,6,1,1,3,NULL,1,8,45),(5,6,3,1,4,NULL,1,8,52),(6,1,NULL,NULL,NULL,2,1,8,12),(7,4,NULL,NULL,NULL,2,1,8,7),(8,7,NULL,NULL,NULL,4,1,8,14),(9,3,NULL,NULL,NULL,3,5,8,17),(10,3,NULL,NULL,NULL,3,1,8,21);
/*!40000 ALTER TABLE `transportation_routes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `firstname` char(40) NOT NULL,
  `lastname` char(40) NOT NULL,
  `acc_name` varchar(45) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `status` enum('active','deactivated') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `acc_name` (`acc_name`),
  UNIQUE KEY `email` (`email`),
  KEY `index_of_lastname` (`lastname`),
  KEY `index_of_names` (`firstname`,`lastname`),
  KEY `index_of_emails` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Judy','Dickinson','dickinson.judy','9f0000106ea539eb6bda8cb2f1cd16362ada0dd7','miguel.feil@example.net','deactivated','2000-06-21 07:35:18'),(2,'Jovanny','Smith','jovanny.smith','441cbba5dffcc3e315f1ec8dce33219c0712aa3b','gleichner.nadia@example.net','deactivated','1988-01-30 01:01:26'),(3,'Haylie','Schulist','schulist.haylie','68c7fad6c099ec43912dda581ec48f7c43101ac5','kulas.trenton@example.net','deactivated','2013-01-20 22:55:39'),(4,'Mireya','Hoppe','hoppe.mireya','a606d05710aac2fdbacbf86461174655c5dcdf41','xbeatty@example.net','active','2007-07-07 14:04:29'),(5,'Zap','Rolfson','zrolfson','48477817566966d2f2d111df65d4988d9fd905c9','gthiel@example.com','deactivated','1987-09-28 11:58:26'),(6,'Timur','Murzik','tmurazik','7cac1070c6b7af8ca3f8bcbf3f62d3bafe32be7d','vonrueden.khalil@example.org','active','1978-03-05 20:25:04'),(7,'Jenifer','Weimann','weimann.jenifer','483f264ceb6c81e2d1f615e895aa429cfb3ab7d3','drolfson@example.org','deactivated','1987-07-08 11:22:45'),(8,'Sadye','Schneider','sadye.schneider','e9ff98c447c8fe6331c5ddf7ff8cfb4a991d31e2','eanderson@example.net','deactivated','1977-01-28 15:24:35'),(9,'Natalie','Swift','nswift','5503ff403ff6ca7cec306a6b9652be7d21d3104c','taurean.wisoky@example.org','deactivated','2016-04-25 11:42:33'),(10,'Amira','Schumm','amira.schumm','222c4c8ea342f86c4ce47c063226b0f72cffd7fa','bauch.raven@example.net','active','1978-10-21 17:31:47');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `balance_amount_for_payment`
--

/*!50001 DROP VIEW IF EXISTS `balance_amount_for_payment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `balance_amount_for_payment` AS select `op`.`style_no_id` AS `style_number`,sum(distinct `op`.`order_amount`) AS `ordered_amount`,sum(`p`.`payment_amount_suggested`) AS `paid_amount`,(select (sum(distinct `op`.`order_amount`) - sum(`p`.`payment_amount_suggested`))) AS `balance_amount` from (`orders_products` `op` left join `payments` `p` on((`p`.`orders_products_id` = `op`.`id`))) where ((`p`.`status` = 'remitted') or (`p`.`status` = 'approved')) group by `op`.`style_no_id` with rollup order by (select (sum(distinct `op`.`order_amount`) - sum(`p`.`payment_amount_suggested`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `transit_routes_times`
--

/*!50001 DROP VIEW IF EXISTS `transit_routes_times`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `transit_routes_times` AS select `tr`.`id` AS `id`,concat(`pol`.`name`,' - ',if((`th`.`name` is not null),concat(`th`.`name`,' '),''),if((`tm1`.`trans_mode` is not null),concat('by ',`tm1`.`trans_mode`,' - '),''),`dp`.`name`,if((`tm2`.`trans_mode` is not null),concat(' by ',`tm2`.`trans_mode`),''),if((`tm3`.`trans_mode` is not null),concat(' by ',`tm3`.`trans_mode`),'')) AS `transit_route_name`,`tr`.`transit_time` AS `transit_time` from ((((((`transportation_routes` `tr` left join `ports_of_loading` `pol` on((`tr`.`port_of_loading_id` = `pol`.`id`))) left join `transhipment_hubs` `th` on((`tr`.`trans_hub_id` = `th`.`id`))) left join `transportation_modes` `tm1` on((`tr`.`from_port_to_hub_trans_mode_id` = `tm1`.`id`))) left join `transportation_modes` `tm2` on((`tr`.`from_hub_to_dest_point_trans_mode_id` = `tm2`.`id`))) left join `transportation_modes` `tm3` on((`tr`.`from_port_to_dest_point_trans_mode_id` = `tm3`.`id`))) left join `destination_points` `dp` on((`tr`.`destination_point_id` = `dp`.`id`))) order by `tr`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-20 21:47:23
