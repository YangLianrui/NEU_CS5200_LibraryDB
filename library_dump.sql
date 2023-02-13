-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: library
-- ------------------------------------------------------
-- Server version	8.0.27
drop schema if EXISTS library;
create schema library;
use library;
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
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `book_id` varchar(30) NOT NULL,
  `book_name` varchar(200) DEFAULT NULL,
  `ISBN` varchar(30) DEFAULT NULL,
  `publisher_id` varchar(30) DEFAULT NULL,
  `author` varchar(100) DEFAULT NULL,
  `availability` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`book_id`),
  KEY `publisher_id` (`publisher_id`),
  CONSTRAINT `book_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES ('10000001','Data and Computer Communications','9780137561704','1000001','William Stallings','Available'),('10000002','Starting out with Python, 5th edition','9780136912330','1000001','Tony Gaddis','Available'),('10000003','Computer Networks, 5th edition','9780137523214','1000001','Andrew S. Tanenbaum,  David J. Wetheral','Not Available'),('10000004','The Atlas Six','9781250854513','1000002','Olivie Blake','Available'),('10000005','The Sentimental Life of International Law','9780192849793','1000003','Gerry Simpson','Available'),('10000006','The Fight for Climate after COVID-19','9780197549704','1000003','Alice C. Hill','Available'),('10000007','The Giver','9780544336261','1000004','Lois Lowry','Available'),('10000008','Beren and Luthien','9780008214197','1000004','TOLKIEN J. R. R.','Available'),('10000009','The Complete History of Middle-earth','0008259844','1000004','Christopher Tolkien','Available'),('10000010','Nursing: A Concept-Based Approach to Learning, Volume II 3rd Edition','0134616812','1000001','Pearson Education','Available');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `borrow_record`
--

DROP TABLE IF EXISTS `borrow_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrow_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `book_id` varchar(30) DEFAULT NULL,
  `user_id` varchar(30) DEFAULT NULL,
  `borrow_time_start` date DEFAULT NULL,
  `borrow_time_Estimated_end` date DEFAULT NULL,
  `borrow_time_real_end` date DEFAULT NULL,
  `penalty` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `book_id` (`book_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `borrow_record_ibfk_1` FOREIGN KEY (`book_id`) REFERENCES `book` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrow_record_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `borrow_record`
--

LOCK TABLES `borrow_record` WRITE;
/*!40000 ALTER TABLE `borrow_record` DISABLE KEYS */;
INSERT INTO `borrow_record` VALUES (1,'10000001','20220101','2022-04-23','2022-04-27','2022-04-26',0),(2,'10000001','20220102','2022-04-23','2022-04-27','2022-04-28',1),(4,'10000008','20220101','2022-04-29','2022-04-30','2022-05-01',1);
/*!40000 ALTER TABLE `borrow_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `document` (
  `user_id` varchar(30) DEFAULT NULL,
  `Document_id` int NOT NULL AUTO_INCREMENT,
  `Document_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Document_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `document_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `document`
--

LOCK TABLES `document` WRITE;
/*!40000 ALTER TABLE `document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` varchar(30) NOT NULL,
  `publisher_name` varchar(30) DEFAULT NULL,
  `phone_No` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES ('1000001','Pearson','123-235-3456'),('1000002','Macmillan','576-567-8578'),('1000003','Oxford','830-826-0987'),('1000004','HarperCollins','153-387-2054'),('1000005','Cambridge','739-392-5820');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `screen`
--

DROP TABLE IF EXISTS `screen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `screen` (
  `Screen_id` varchar(30) NOT NULL,
  `room_id` varchar(30) DEFAULT NULL,
  `manufacturer` varchar(30) DEFAULT NULL,
  `serial_number` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`Screen_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `screen_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `study_room` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `screen`
--

LOCK TABLES `screen` WRITE;
/*!40000 ALTER TABLE `screen` DISABLE KEYS */;
INSERT INTO `screen` VALUES ('Screen-001','1111111101','Sony','SK019HNL9302'),('Screen-002','1111111103','Sony','HB982NKBLS35'),('Screen-003','1111111104','Sony','UIEB82738BI9'),('Screen-004','1111111104','LG','KJHN778JHHJ0');
/*!40000 ALTER TABLE `screen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `seat_id` varchar(30) NOT NULL,
  `room_id` varchar(30) DEFAULT NULL,
  `current_condition` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`seat_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `study_room` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES ('Seat-0001','1111111101','Perfect'),('Seat-0002','1111111101','Perfect'),('Seat-0003','1111111101','Perfect'),('Seat-0004','1111111101','Good'),('Seat-0005','1111111102','Good'),('Seat-0006','1111111102','Perfect'),('Seat-0007','1111111102','Good'),('Seat-0008','1111111103','Good'),('Seat-0009','1111111103','Perfect'),('Seat-0010','1111111104','Good'),('Seat-0011','1111111104','Perfect'),('Seat-0012','1111111104','Perfect'),('Seat-0013','1111111105','Good');
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_room`
--

DROP TABLE IF EXISTS `study_room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_room` (
  `room_id` varchar(30) NOT NULL,
  PRIMARY KEY (`room_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_room`
--

LOCK TABLES `study_room` WRITE;
/*!40000 ALTER TABLE `study_room` DISABLE KEYS */;
INSERT INTO `study_room` VALUES ('1111111101'),('1111111102'),('1111111103'),('1111111104'),('1111111105');
/*!40000 ALTER TABLE `study_room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `study_table`
--

DROP TABLE IF EXISTS `study_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `study_table` (
  `table_id` varchar(30) NOT NULL,
  `room_id` varchar(30) DEFAULT NULL,
  `current_condition` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`table_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `study_table_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `study_room` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `study_table`
--

LOCK TABLES `study_table` WRITE;
/*!40000 ALTER TABLE `study_table` DISABLE KEYS */;
INSERT INTO `study_table` VALUES ('Table-001','1111111101','Perfect'),('Table-002','1111111101','Perfect'),('Table-003','1111111101','Perfect'),('Table-004','1111111102','Perfect'),('Table-005','1111111102','Perfect'),('Table-006','1111111103','Perfect'),('Table-007','1111111104','Perfect'),('Table-008','1111111105','Good');
/*!40000 ALTER TABLE `study_table` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_room_record`
--

DROP TABLE IF EXISTS `user_room_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_room_record` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) DEFAULT NULL,
  `room_id` varchar(30) DEFAULT NULL,
  `start_time` int DEFAULT NULL,
  `end_time` int DEFAULT NULL,
  `date_current` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `room_id` (`room_id`),
  CONSTRAINT `user_room_record_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_room_record_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `study_room` (`room_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_room_record`
--

LOCK TABLES `user_room_record` WRITE;
/*!40000 ALTER TABLE `user_room_record` DISABLE KEYS */;
INSERT INTO `user_room_record` VALUES (1,'20220102','1111111101',13,16,'2022-04-29'),(2,'20220102','1111111101',9,11,'2022-04-29'),(3,'20220101','1111111101',7,8,'2022-04-29');
/*!40000 ALTER TABLE `user_room_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` varchar(30) NOT NULL,
  `user_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('00000001','Library'),('20220101','Lianrui Yang'),('20220102','Xinyu Wan'),('20220103','Xiangyu Zeng');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'library'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_document` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_document`(IN user_id_input varchar(30), IN Document_name_input varchar(30), OUT state int)
begin
declare user_count int;
select count(*) into user_count from users where user_id = user_id_input;
IF user_count = 1 THEN
 insert into Document(user_id,Document_name) values (user_id_input, Document_name_input);


ELSE
 SET state = 1; -- does not have this user
    END IF;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_publisher` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_publisher`(IN publisher_id_input varchar(30), IN publisher_name_input varchar(30), IN phone_No_input varchar(30), OUT state int)
BEGIN
DECLARE publisher_count int;
select count(*) into publisher_count from publisher where publisher_id = publisher_id_input;

IF publisher_count = 0 THEN
 insert into publisher(publisher_id,publisher_name,phone_No) values(publisher_id_input, publisher_name_input, phone_No_input);


ELSE
 SET state = 1; -- Already has this publisher
 END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Borrow_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Borrow_book`(IN user_id_input varchar(30), IN book_id_input varchar(30), IN borrow_start_time_input date, IN borrow_estimated_end_time_input date, OUT state int)
BEGIN
-- 1. Check whether the user exists.
-- 2. Check whether the user borrows more than 5 books
-- 3. Check if the book exists and is available
-- 4. Generate record and fill in userID Bookid, start time, expected end time
-- 5. Alter availability under Bookid to 'Not Available'
DECLARE user_count int default 0; 
DECLARE book_count int default 0;
DECLARE user_book_count int default 0;
DECLARE book_ava varchar(30);

select count(*) into user_count from users where user_id = user_id_input; -- Verify if user exists
select count(*) into book_count from book where book_id = book_id_input; -- Verify if book exists
select count(*) into user_book_count from Borrow_record where user_id=user_id_input and borrow_time_real_end is NULL; -- Verify the number of book that user has borrowed

IF user_count>0 THEN
	IF book_count>0 THEN
		IF user_book_count<5 THEN
			select availability into book_ava from book where book_id = book_id_input; -- Verify availability of this book
			IF book_ava = 'Available' THEN
				insert into Borrow_record(user_id,book_id,borrow_time_start,borrow_time_Estimated_end)
				values(user_id_input,book_id_input,borrow_start_time_input,borrow_estimated_end_time_input);
                UPDATE Book SET availability = 'Not Available' where book_id = book_id_input;
                SET state = 5; -- Success
			ELSE
				SET state = 4; 
                END IF;-- Book not available
		ELSE
			SET state = 3;
            END IF;-- Beyond max book for this user
	ELSE
		SET state = 2;
        END IF;-- Book not exists
ELSE
     SET state=1;    -- User not exists
	 END IF;  

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `check_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `check_room`(IN room_input varchar(30),OUT state int)
BEGIN
DECLARE room_count int default 0; 
select count(*) into room_count from study_room where room_id = room_input;
if room_count>0 then
	set state=1; -- have room
else
	set state=0; -- room not exist
end if;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_book`(IN book_id_input varchar(30), OUT state int)
BEGIN
DECLARE book_count int;
DECLARE book_record_count int;
select count(*) into book_count from Book where book_id = book_id_input;
select count(*) into book_record_count from Borrow_record where book_id = book_id_input and borrow_time_real_end is NULL; 
-- Verify if not closed record of this book exists
IF book_count>0 THEN
	IF book_record_count <= 0 THEN
		DELETE from Borrow_record where book_id = book_id_input; -- Remove borrowing book records of this book
		DELETE from book where book_id = book_id_input; -- Remove this book from book table
       
		set state = 3; -- successfully remove this user
        
	ELSE
		set state = 2; -- Please return borrowed book(s) before delete this book
        END IF;
ELSE
	set state = 1; -- does not have this book
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_user`(IN user_id_input varchar(30), OUT state int)
BEGIN
DECLARE user_count int;
DECLARE book_record_count int;
select count(*) into user_count from users where user_id = user_id_input;
select count(*) into book_record_count from Borrow_record where user_id = user_id_input and borrow_time_real_end is NULL; 
-- Verify if not closed record of this user exists
IF user_count>0 THEN
	IF book_record_count <= 0 THEN
		DELETE from Borrow_record where user_id = user_id_input; -- Remove borrowing book records of this user
		DELETE from Borrow_record where user_id = user_id_input; -- Remove study room use record of this user.
        DELETE from users where user_id = user_id_input; -- Remove this user from user table
   
		set state = 3; -- successfully remove this user
        
	ELSE
		set state = 2; -- Please return borrowed book(s) before delete this user
        END IF;
ELSE
	set state = 1; -- does not have this user
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_room_record` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_room_record`(IN user_id_input varchar(30), IN room_id_input varchar(30), IN date_current_input date, IN start_time_input int, IN end_time_input int, OUT state int)
BEGIN
DECLARE user_count int;
DECLARE room_count int;
select count(*) into user_count from users where user_id = user_id_input;
select count(*) into room_count from Study_room where room_id = room_id_input;

IF user_count>0 THEN
	IF room_count>0 THEN
		IF start_time_input< end_time_input THEN
			insert into user_room_record(user_id,room_id,start_time,end_time, date_current)
						values(user_id_input,room_id_input,start_time_input,end_time_input,date_current_input);
    
		ELSE
			SET state = 3; -- Invalid time input. Start time after end time;
            END IF;
	ELSE
		SET state = 2; -- Room detect error. Does not have this room
        END IF;
ELSE
	SET state =1; -- User detect error. Does not have this user.
	END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `print_document` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `print_document`(IN document_id_input int, OUT state int)
begin
declare doc_count int;
select count(*) into doc_count from Document where Document_id = document_id_input;

IF doc_count >0 THEN
 DELETE from Document where Document_id = document_id_input;
    
ELSE
 SET state = 1; -- Does not have this document
    END IF;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Return_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Return_book`(IN user_id_input varchar(30), IN book_id_input varchar(30), IN borrow_time_real_end_input date, OUT state int, OUT state_penality int)
BEGIN
-- 1. Check whether the user exists
-- 2. Check userID and BooKID in all records that have no borrow_time_real_end in the borrow record
-- 3. Update the real end time into the record
-- 4. Determine whether there is a penalty and update into the record
-- 5. Change Bookid Availability to 'Avaibalbe'
DECLARE user_count int default 0; 
DECLARE book_count int default 0;
DECLARE user_record_count int default 0;
DECLARE estimated_date date;
select count(*) into user_count from users where user_id = user_id_input; -- Verify if user exists
select count(*) into book_count from book where book_id = book_id_input; -- Verify if book exists
select count(*) into user_record_count from Borrow_record where user_id = user_id_input and book_id = book_id_input and borrow_time_real_end is NULL; 
-- Verify if not closed record of this user and this book exists
select borrow_time_Estimated_end into estimated_date from Borrow_record where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end is NULL;
SET state_penality = 3; -- Initialize penality state, if state_penality =3, return not success

IF user_count>0 THEN
	IF book_count>0 THEN
		IF user_record_count>0 THEN 
            UPDATE Borrow_record SET borrow_time_real_end = borrow_time_real_end_input where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end is NULL;
			-- Update real end time to the record (existed, belong to the user, not returned, related to the book)
            UPDATE Book SET availability = 'Available' where book_id = book_id_input;
            -- Verify penality
            IF borrow_time_real_end_input>estimated_date THEN
				UPDATE Borrow_record SET penalty = TRUE where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end = borrow_time_real_end_input;
                SET state_penality = 1; -- Has penality
            ELSE
				UPDATE Borrow_record SET penalty = FALSE where book_id = book_id_input and user_id = user_id_input and borrow_time_real_end = borrow_time_real_end_input;
				SET state_penality = 0; -- Does not have penality
                END IF;
            SET state = 4; -- Success
        ELSE 
			SET state = 3; -- Record of this book not exists
			END IF;
	ELSE
		SET state = 2; -- Book not exists
        END IF;
ELSE 
	SET state = 1; -- User not exists
	END IF;


end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_book_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_book_by_id`(IN bookid_input int)
BEGIN
select * from Book where book_id = bookid_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_book_by_ISBN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_book_by_ISBN`(IN ISBN_input varchar(30))
BEGIN
select * from Book where ISBN = ISBN_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_book_by_name` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_book_by_name`(IN book_name_input varchar(200))
BEGIN
select * from Book where book_name like concat('%',book_name_input,'%');
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_screen_by_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_screen_by_room`(IN room_input varchar(30))
BEGIN
select * from screen where room_id=room_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_seat_by_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_seat_by_room`(IN room_input varchar(30))
BEGIN
select * from seat where room_id=room_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_study_room_by_screen` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_study_room_by_screen`(IN num_of_screen_input int)
BEGIN

select room_id from 
(select count(screen_id) as number_of_screen, room_id from 
(select Study_room.room_id, Screen_id, manufacturer, serial_number from Study_room 
left join screen
on screen.room_id = study_room.room_id) as aaa group by room_id) as bbb where number_of_screen = num_of_screen_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_study_room_by_seat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_study_room_by_seat`(IN num_of_seat_input int)
BEGIN

select room_id from 
(select count(seat_id) as number_of_seat, room_id from 
(select Study_room.room_id, seat_id from Study_room 
left join seat
on seat.room_id = study_room.room_id) as aaa group by room_id) as bbb where number_of_seat = num_of_seat_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_study_room_by_table` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_study_room_by_table`(IN num_of_table_input int)
BEGIN

select room_id from 
(select count(table_id) as number_of_table, room_id from 
(select Study_room.room_id, table_id from Study_room 
left join Study_Table
on Study_Table.room_id = study_room.room_id) as aaa group by room_id) as bbb where number_of_table = num_of_table_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `track_table_by_room` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `track_table_by_room`(IN room_input varchar(30))
BEGIN
select * from study_table where room_id=room_input;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-04-29 23:46:54
