-- @author Maryam Khanahmadi 26-July-2024
-- CREATE - LOAD - EXTRACT - TRANSFER 
-- Drop the database if it exists and create a new one
DROP DATABASE IF EXISTS `sql_invoic`;
CREATE DATABASE `sql_invoic`; 
USE `sql_invoic`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

-- Create and populate the payment_method table
CREATE TABLE `payment_method` (
  `payment_method_id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payment_method` VALUES (1,'Credit Card');
INSERT INTO `payment_method` VALUES (2,'Cash');
INSERT INTO `payment_method` VALUES (3,'PayPal');
INSERT INTO `payment_method` VALUES (4,'Swish');

-- Create and populate the clients table
CREATE TABLE `clients` (
  `client_id` int(12) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `clients` VALUES (1,'Maryam','Toleredsgatan','Syracuse','054-652-7985');
INSERT INTO `clients` VALUES (2,'Roza','Gibraltargatan','Malmo','023-659-1892');
INSERT INTO `clients` VALUES (3,'Sahar','Holtermansgatan','Stockholm','086-234-6677');
INSERT INTO `clients` VALUES (4,'Eli','Westerfield Circle','Copenhagen','254-750-0784');
INSERT INTO `clients` VALUES (5,'John','Farmco Road','Linkoping','070-888-9129');
INSERT INTO `clients` VALUES (6,'Will','0863 Gibraltargatan','Goteborg','071-234-9629');


-- Create and populate the invoices table
CREATE TABLE `invoices` (
  `invoice_id` int(11) NOT NULL,
  `number` varchar(50) NOT NULL,
  `client_id` int(11) NOT NULL,
  `invoice_total` decimal(9,2) NOT NULL,
  `payment_total` decimal(9,2) NOT NULL DEFAULT '0.00',
  `invoice_date` date NOT NULL,
  `due_date` date NOT NULL,
  `payment_date` date DEFAULT NULL,
  PRIMARY KEY (`invoice_id`),
  KEY `FK_client_id` (`client_id`),
  CONSTRAINT `FK_client_id` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `invoices` VALUES (1,'41-953-3396',2,101.79,0.00,'2019-03-09','2019-03-29',NULL);
INSERT INTO `invoices` VALUES (2,'23-898-6735',5,175.32,8.18,'2019-06-11','2019-07-01','2019-02-12');
INSERT INTO `invoices` VALUES (3,'20-456-0335',5,147.99,0.00,'2019-07-31','2019-08-20',NULL);
INSERT INTO `invoices` VALUES (4,'56-934-0123',3,152.21,0.00,'2019-03-08','2019-03-28',NULL);
INSERT INTO `invoices` VALUES (5,'87-564-3121',5,169.36,0.00,'2019-07-18','2019-08-07',NULL);
INSERT INTO `invoices` VALUES (6,'75-587-6626',1,157.78,74.55,'2019-01-29','2019-02-18','2019-01-03');
INSERT INTO `invoices` VALUES (7,'68-093-9863',3,133.87,0.00,'2019-09-04','2019-09-24',NULL);
INSERT INTO `invoices` VALUES (8,'78-145-1093',1,189.12,0.00,'2019-05-20','2019-06-09',NULL);
INSERT INTO `invoices` VALUES (9,'77-593-0081',5,172.17,0.00,'2019-07-09','2019-07-29',NULL);
INSERT INTO `invoices` VALUES (10,'48-266-1517',1,159.50,0.00,'2019-06-30','2019-07-20',NULL);
INSERT INTO `invoices` VALUES (11,'20-848-0181',3,126.15,0.03,'2019-01-07','2019-01-27','2019-01-11');
INSERT INTO `invoices` VALUES (13,'41-666-1035',5,135.01,87.44,'2019-06-25','2019-07-15','2019-01-26');
INSERT INTO `invoices` VALUES (15,'55-105-9605',3,167.29,80.31,'2019-11-25','2019-12-15','2019-01-15');
INSERT INTO `invoices` VALUES (16,'10-451-8824',1,162.02,0.00,'2019-03-30','2019-04-19',NULL);
INSERT INTO `invoices` VALUES (17,'33-615-4694',3,126.38,68.10,'2019-07-30','2019-08-19','2019-01-15');
INSERT INTO `invoices` VALUES (18,'52-269-9803',5,180.17,42.77,'2019-05-23','2019-06-12','2019-01-08');
INSERT INTO `invoices` VALUES (19,'83-559-4105',1,134.47,0.00,'2019-11-23','2019-12-13',NULL);

-- Create and populate the payments table
CREATE TABLE `payments` (
  `payment_id` int(12) NOT NULL AUTO_INCREMENT,
  `client_id` int(12) NOT NULL,
  `invoice_id` int(12) NOT NULL,
  `date` date NOT NULL,
  `amount` decimal(9,2) NOT NULL,
  `payment_method` tinyint(4) NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `fk_client_id_idx` (`client_id`),
  KEY `fk_invoice_id_idx` (`invoice_id`),
  KEY `fk_payment_payment_method_idx` (`payment_method`),
  CONSTRAINT `fk_payment_client` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_invoice` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_payment_payment_method` FOREIGN KEY (`payment_method`) REFERENCES `payment_method` (`payment_method_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `payments` VALUES (1,5,2,'2019-02-12',8.18,1);
INSERT INTO `payments` VALUES (2,1,6,'2019-03-03',74.55,1);
INSERT INTO `payments` VALUES (3,3,11,'2019-05-11',0.03,1);
INSERT INTO `payments` VALUES (4,5,13,'2019-01-26',87.44,1);
INSERT INTO `payments` VALUES (5,3,15,'2020-01-15',80.31,1);
INSERT INTO `payments` VALUES (6,3,17,'2019-01-15',68.10,1);
INSERT INTO `payments` VALUES (7,5,18,'2019-01-03',32.77,1);
INSERT INTO `payments` VALUES (8,5,18,'2019-01-08',10.00,2);

-- Create a new table to load the transformed data
CREATE TABLE IF NOT EXISTS invoice_summary (
    client_id INT,
    client_name VARCHAR(50),
    client_city VARCHAR(50),
    invoice_id INT,
    invoice_total DECIMAL(9,2),
    payment_total DECIMAL(9,2),
    remaining_balance DECIMAL(9,2),
    invoice_date DATE,
    due_date DATE,
    payment_date DATE
);

-- Insert the transformed data into the new table
INSERT INTO invoice_summary (client_id, client_name, client_city, invoice_id, invoice_total, payment_total, remaining_balance, invoice_date, due_date, payment_date)
SELECT 
    c.client_id, 
    c.name AS client_name, 
    c.city AS client_city, 
    i.invoice_id, 
    i.invoice_total, 
    i.payment_total, 
    (i.invoice_total - i.payment_total) AS remaining_balance, 
    i.invoice_date, 
    i.due_date, 
    i.payment_date
FROM 
    clients c
JOIN 
    invoices i ON c.client_id = i.client_id;