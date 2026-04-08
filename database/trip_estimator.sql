-- phpMyAdmin SQL Dump
-- version 2.11.6
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 22, 2026 at 06:40 AM
-- Server version: 5.0.51
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `trip_estimator`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `username` varchar(50) default NULL,
  `password` varchar(50) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`username`, `password`) VALUES
('admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `cost_predictions`
--

CREATE TABLE `cost_predictions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `distance_km` int(11) default NULL,
  `days` int(11) default NULL,
  `travel_mode` varchar(50) default NULL,
  `hotel_type` varchar(50) default NULL,
  `entry_fee` int(11) default NULL,
  `season_index` int(11) default NULL,
  `predicted_cost` decimal(10,2) default NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Dumping data for table `cost_predictions`
--

INSERT INTO `cost_predictions` (`id`, `user_id`, `distance_km`, `days`, `travel_mode`, `hotel_type`, `entry_fee`, `season_index`, `predicted_cost`, `created_at`) VALUES
(3, 4, 400, 3, 'Flight', 'Luxury', 1000, 3, '22868.52', '2026-03-08 16:03:33'),
(7, 4, 500, 2, 'Train', 'Low Budget', 500, 1, '8003.18', '2026-03-08 16:31:20'),
(8, 4, 500, 2, 'Bus', 'Low Budget', 500, 1, '7836.50', '2026-03-08 16:43:14'),
(9, 4, 200, 2, 'Car', 'Medium', 1000, 1, '8962.38', '2026-03-19 12:42:52'),
(10, 4, 500, 3, 'Flight', 'Luxury', 5000, 1, '13322.84', '2026-03-22 09:42:24');

-- --------------------------------------------------------

--
-- Table structure for table `destination_reports`
--

CREATE TABLE `destination_reports` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `category` varchar(50) default NULL,
  `budget_type` varchar(50) default NULL,
  `season` varchar(50) default NULL,
  `spot_name` varchar(100) default NULL,
  `state` varchar(100) default NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Dumping data for table `destination_reports`
--

INSERT INTO `destination_reports` (`id`, `user_id`, `category`, `budget_type`, `season`, `spot_name`, `state`, `created_at`) VALUES
(25, 4, 'adventure', 'high budget', 'monsoon', 'Mysore Palace', 'Himachal Pradesh', '2026-03-08 16:07:55'),
(26, 4, 'adventure', 'high budget', 'monsoon', 'Goa Baga Beach', 'Himachal Pradesh', '2026-03-08 16:07:55'),
(27, 4, 'adventure', 'high budget', 'monsoon', 'Mysore Palace', 'Goa', '2026-03-08 16:07:55'),
(28, 4, 'adventure', 'high budget', 'monsoon', 'Rose Garden', 'Himachal Pradesh', '2026-03-08 16:07:55'),
(29, 4, 'adventure', 'high budget', 'monsoon', 'Kerala Munnar Hills', 'Kerala', '2026-03-08 16:07:55'),
(30, 4, 'adventure', 'high budget', 'monsoon', 'Goa Baga Beach', 'Himachal Pradesh', '2026-03-08 16:07:55'),
(31, 4, 'adventure', 'high budget', 'summer', 'Ooty Lake', 'Karnataka', '2026-03-08 16:44:29'),
(32, 4, 'adventure', 'high budget', 'summer', 'Goa Baga Beach', 'Tamil Nadu', '2026-03-08 16:44:29'),
(33, 4, 'adventure', 'high budget', 'summer', 'Goa Baga Beach', 'Goa', '2026-03-08 16:44:29'),
(34, 4, 'adventure', 'high budget', 'summer', 'Tea Factory', 'Tamil Nadu', '2026-03-08 16:44:29'),
(35, 4, 'adventure', 'high budget', 'summer', 'Mysore Palace', 'Kerala', '2026-03-08 16:44:29'),
(36, 4, 'adventure', 'high budget', 'summer', 'Tea Factory', 'Himachal Pradesh', '2026-03-08 16:44:29'),
(37, 4, 'adventure', 'medium budget', 'winter', 'Coorg Abbey Falls', 'Himachal Pradesh', '2026-03-19 12:43:01'),
(38, 4, 'adventure', 'medium budget', 'winter', 'Ooty Botanical Garden', 'Himachal Pradesh', '2026-03-19 12:43:01'),
(39, 4, 'adventure', 'medium budget', 'winter', 'Goa Baga Beach', 'Tamil Nadu', '2026-03-19 12:43:01'),
(40, 4, 'adventure', 'medium budget', 'winter', 'Manali Solang Valley', 'Himachal Pradesh', '2026-03-19 12:43:01'),
(41, 4, 'adventure', 'medium budget', 'winter', 'Doddabetta Peak', 'Goa', '2026-03-19 12:43:01'),
(42, 4, 'adventure', 'medium budget', 'winter', 'Coorg Abbey Falls', 'Goa', '2026-03-19 12:43:01'),
(43, 4, 'adventure', 'high budget', 'summer', 'Coorg Abbey Falls', 'Himachal Pradesh', '2026-03-22 10:39:49'),
(44, 4, 'adventure', 'high budget', 'summer', 'Ooty Lake', 'Himachal Pradesh', '2026-03-22 10:39:49'),
(45, 4, 'adventure', 'high budget', 'summer', 'Rose Garden', 'Himachal Pradesh', '2026-03-22 10:39:49'),
(46, 4, 'adventure', 'high budget', 'summer', 'Coorg Abbey Falls', 'Himachal Pradesh', '2026-03-22 10:39:49'),
(47, 4, 'adventure', 'high budget', 'summer', 'Kerala Munnar Hills', 'Kerala', '2026-03-22 10:39:49'),
(48, 4, 'adventure', 'high budget', 'summer', 'Goa Baga Beach', 'Himachal Pradesh', '2026-03-22 10:39:49');

-- --------------------------------------------------------

--
-- Table structure for table `distance_map`
--

CREATE TABLE `distance_map` (
  `id` int(11) NOT NULL auto_increment,
  `from_place` varchar(100) default NULL,
  `to_place` varchar(100) default NULL,
  `distance_km` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=110 ;

--
-- Dumping data for table `distance_map`
--

INSERT INTO `distance_map` (`id`, `from_place`, `to_place`, `distance_km`) VALUES
(1, 'Chennai', 'Coimbatore', 510),
(2, 'Chennai', 'Madurai', 460),
(3, 'Chennai', 'Trichy', 330),
(4, 'Chennai', 'Salem', 340),
(5, 'Chennai', 'Tirunelveli', 620),
(6, 'Chennai', 'Erode', 400),
(7, 'Chennai', 'Vellore', 140),
(8, 'Chennai', 'Thanjavur', 350),
(9, 'Chennai', 'Kanyakumari', 700),
(10, 'Chennai', 'Rameswaram', 560),
(11, 'Chennai', 'Ooty', 550),
(12, 'Chennai', 'Kodaikanal', 525),
(13, 'Chennai', 'Yercaud', 360),
(14, 'Chennai', 'Pondicherry', 160),
(15, 'Chennai', 'Bangalore', 350),
(16, 'Chennai', 'Hyderabad', 630),
(17, 'Chennai', 'Goa', 900),
(18, 'Chennai', 'Mumbai', 1330),
(19, 'Chennai', 'Delhi', 2200),
(20, 'Chennai', 'Kolkata', 1670),
(21, 'Chennai', 'Jaipur', 2100),
(22, 'Chennai', 'Agra', 2100),
(23, 'Chennai', 'Mysore', 480),
(24, 'Chennai', 'Kochi', 690),
(25, 'Chennai', 'Munnar', 600),
(26, 'Chennai', 'Shimla', 2500),
(27, 'Chennai', 'Manali', 2600),
(28, 'Coimbatore', 'Ooty', 90),
(29, 'Coimbatore', 'Kodaikanal', 175),
(30, 'Coimbatore', 'Madurai', 215),
(31, 'Coimbatore', 'Salem', 160),
(32, 'Coimbatore', 'Erode', 100),
(33, 'Coimbatore', 'Trichy', 220),
(34, 'Coimbatore', 'Tirunelveli', 350),
(35, 'Coimbatore', 'Kanyakumari', 420),
(36, 'Coimbatore', 'Bangalore', 365),
(37, 'Coimbatore', 'Mysore', 200),
(38, 'Coimbatore', 'Kochi', 190),
(39, 'Coimbatore', 'Munnar', 160),
(40, 'Coimbatore', 'Goa', 700),
(41, 'Coimbatore', 'Hyderabad', 900),
(42, 'Coimbatore', 'Mumbai', 1200),
(43, 'Madurai', 'Rameswaram', 170),
(44, 'Madurai', 'Kanyakumari', 245),
(45, 'Madurai', 'Tirunelveli', 150),
(46, 'Madurai', 'Kodaikanal', 120),
(47, 'Madurai', 'Trichy', 140),
(48, 'Madurai', 'Salem', 240),
(49, 'Madurai', 'Bangalore', 435),
(50, 'Madurai', 'Hyderabad', 820),
(51, 'Madurai', 'Mumbai', 1300),
(52, 'Madurai', 'Delhi', 2300),
(53, 'Madurai', 'Kochi', 300),
(54, 'Trichy', 'Chennai', 330),
(55, 'Trichy', 'Coimbatore', 220),
(56, 'Trichy', 'Salem', 140),
(57, 'Trichy', 'Madurai', 140),
(58, 'Trichy', 'Thanjavur', 60),
(59, 'Trichy', 'Rameswaram', 230),
(60, 'Trichy', 'Kanyakumari', 350),
(61, 'Trichy', 'Bangalore', 340),
(62, 'Trichy', 'Hyderabad', 780),
(63, 'Trichy', 'Mumbai', 1200),
(64, 'Trichy', 'Delhi', 2200),
(65, 'Salem', 'Yercaud', 30),
(66, 'Salem', 'Erode', 70),
(67, 'Salem', 'Coimbatore', 160),
(68, 'Salem', 'Chennai', 340),
(69, 'Salem', 'Bangalore', 200),
(70, 'Salem', 'Hyderabad', 600),
(71, 'Salem', 'Mumbai', 1000),
(72, 'Erode', 'Coimbatore', 100),
(73, 'Erode', 'Salem', 70),
(74, 'Erode', 'Madurai', 200),
(75, 'Erode', 'Trichy', 140),
(76, 'Erode', 'Bangalore', 300),
(77, 'Erode', 'Hyderabad', 700),
(78, 'Tirunelveli', 'Kanyakumari', 90),
(79, 'Tirunelveli', 'Madurai', 150),
(80, 'Tirunelveli', 'Rameswaram', 240),
(81, 'Tirunelveli', 'Chennai', 620),
(82, 'Tirunelveli', 'Bangalore', 650),
(83, 'Tirunelveli', 'Hyderabad', 950),
(84, 'Kanyakumari', 'Madurai', 245),
(85, 'Kanyakumari', 'Chennai', 700),
(86, 'Kanyakumari', 'Rameswaram', 310),
(87, 'Kanyakumari', 'Trivandrum', 90),
(88, 'Kanyakumari', 'Kochi', 300),
(89, 'Kanyakumari', 'Bangalore', 730),
(90, 'Bangalore', 'Mysore', 150),
(91, 'Bangalore', 'Ooty', 270),
(92, 'Bangalore', 'Goa', 560),
(93, 'Bangalore', 'Hyderabad', 570),
(94, 'Bangalore', 'Mumbai', 980),
(95, 'Hyderabad', 'Mumbai', 710),
(96, 'Hyderabad', 'Delhi', 1550),
(97, 'Hyderabad', 'Goa', 660),
(98, 'Mumbai', 'Goa', 590),
(99, 'Mumbai', 'Delhi', 1400),
(100, 'Mumbai', 'Jaipur', 1150),
(101, 'Delhi', 'Agra', 230),
(102, 'Delhi', 'Jaipur', 280),
(103, 'Delhi', 'Manali', 540),
(104, 'Delhi', 'Shimla', 350),
(105, 'Kochi', 'Munnar', 130),
(106, 'Kochi', 'Trivandrum', 200),
(107, 'Kochi', 'Goa', 700),
(108, 'Jaipur', 'Agra', 240),
(109, 'Agra', 'Delhi', 230);

-- --------------------------------------------------------

--
-- Table structure for table `tourist_data`
--

CREATE TABLE `tourist_data` (
  `id` int(11) NOT NULL auto_increment,
  `spot_name` varchar(150) default NULL,
  `state` varchar(100) default NULL,
  `budget_type` varchar(50) default NULL,
  `entry_fee` float default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=151 ;

--
-- Dumping data for table `tourist_data`
--

INSERT INTO `tourist_data` (`id`, `spot_name`, `state`, `budget_type`, `entry_fee`) VALUES
(1, 'Baga Beach', 'Goa', 'low', 50),
(2, 'Chapora Fort', 'Goa', 'low', 50),
(3, 'Anjuna Beach', 'Goa', 'low', 40),
(4, 'Miramar Beach', 'Goa', 'low', 20),
(5, 'Dona Paula View Point', 'Goa', 'low', 50),
(6, 'Fort Aguada', 'Goa', 'moderate', 150),
(7, 'Basilica of Bom Jesus', 'Goa', 'moderate', 100),
(8, 'Dudhsagar Waterfalls', 'Goa', 'moderate', 300),
(9, 'Reis Magos Fort', 'Goa', 'moderate', 200),
(10, 'Salim Ali Bird Sanctuary', 'Goa', 'moderate', 200),
(11, 'Goa Cruise Ride', 'Goa', 'high', 2000),
(12, 'Scuba Diving Goa', 'Goa', 'high', 3500),
(13, 'Casino Cruise Goa', 'Goa', 'high', 4000),
(14, 'Luxury Dinner Cruise', 'Goa', 'high', 3500),
(15, 'Parasailing Goa', 'Goa', 'high', 2500),
(16, 'Ooty Lake', 'Ooty', 'low', 50),
(17, 'Botanical Garden', 'Ooty', 'low', 50),
(18, 'Rose Garden', 'Ooty', 'low', 30),
(19, 'Doddabetta Peak', 'Ooty', 'low', 30),
(20, 'Tea Museum', 'Ooty', 'low', 40),
(21, 'Pykara Lake', 'Ooty', 'moderate', 150),
(22, 'Avalanche Lake', 'Ooty', 'moderate', 200),
(23, 'Mudumalai Wildlife Sanctuary', 'Ooty', 'moderate', 300),
(24, 'Emerald Lake', 'Ooty', 'moderate', 100),
(25, 'Ooty Toy Train', 'Ooty', 'moderate', 250),
(26, 'Private Jeep Safari', 'Ooty', 'high', 1500),
(27, 'Luxury Resort Stay', 'Ooty', 'high', 4000),
(28, 'Adventure Camp Ooty', 'Ooty', 'high', 2000),
(29, 'Horse Riding Ooty', 'Ooty', 'high', 1200),
(30, 'Premium Hill Resort', 'Ooty', 'high', 3500),
(31, 'Kodaikanal Lake', 'Kodaikanal', 'low', 50),
(32, 'Bryant Park', 'Kodaikanal', 'low', 30),
(33, 'Coaker Walk', 'Kodaikanal', 'low', 20),
(34, 'Pillar Rocks', 'Kodaikanal', 'low', 30),
(35, 'Silver Cascade Falls', 'Kodaikanal', 'low', 20),
(36, 'Berijam Lake', 'Kodaikanal', 'moderate', 150),
(37, 'Green Valley View', 'Kodaikanal', 'moderate', 100),
(38, 'Pine Forest', 'Kodaikanal', 'moderate', 120),
(39, 'Devil’s Kitchen', 'Kodaikanal', 'moderate', 150),
(40, 'Boat Ride Kodai', 'Kodaikanal', 'moderate', 200),
(41, 'Kodai Jeep Safari', 'Kodaikanal', 'high', 1500),
(42, 'Luxury Hill Resort Kodai', 'Kodaikanal', 'high', 4000),
(43, 'Adventure Camp Kodai', 'Kodaikanal', 'high', 2000),
(44, 'Horse Riding Kodai', 'Kodaikanal', 'high', 1200),
(45, 'Private Trek Guide', 'Kodaikanal', 'high', 2500),
(46, 'Yercaud Lake', 'Yercaud', 'low', 30),
(47, 'Anna Park', 'Yercaud', 'low', 20),
(48, 'Lady’s Seat', 'Yercaud', 'low', 30),
(49, 'Pagoda Point', 'Yercaud', 'low', 20),
(50, 'Shevaroy Temple', 'Yercaud', 'low', 20),
(51, 'Kiliyur Falls', 'Yercaud', 'moderate', 100),
(52, 'Botanical Garden Yercaud', 'Yercaud', 'moderate', 120),
(53, 'Bear’s Cave', 'Yercaud', 'moderate', 150),
(54, 'Coffee Plantation Tour', 'Yercaud', 'moderate', 200),
(55, 'Silk Farm', 'Yercaud', 'moderate', 150),
(56, 'Yercaud Adventure Camp', 'Yercaud', 'high', 1500),
(57, 'Luxury Resort Yercaud', 'Yercaud', 'high', 3500),
(58, 'Private Hill Safari', 'Yercaud', 'high', 2000),
(59, 'Zipline Yercaud', 'Yercaud', 'high', 1800),
(60, 'Premium View Resort', 'Yercaud', 'high', 3000),
(61, 'Promenade Beach', 'Pondicherry', 'low', 20),
(62, 'Rock Beach', 'Pondicherry', 'low', 20),
(63, 'French Colony Walk', 'Pondicherry', 'low', 30),
(64, 'Sri Aurobindo Ashram', 'Pondicherry', 'low', 50),
(65, 'Botanical Garden', 'Pondicherry', 'low', 30),
(66, 'Auroville', 'Pondicherry', 'moderate', 150),
(67, 'Paradise Beach', 'Pondicherry', 'moderate', 200),
(68, 'Chunnambar Boat House', 'Pondicherry', 'moderate', 250),
(69, 'Museum Pondicherry', 'Pondicherry', 'moderate', 150),
(70, 'Light House Visit', 'Pondicherry', 'moderate', 100),
(71, 'Scuba Diving Pondy', 'Pondicherry', 'high', 3000),
(72, 'Luxury Beach Resort', 'Pondicherry', 'high', 5000),
(73, 'Private Yacht Ride', 'Pondicherry', 'high', 4000),
(74, 'Water Sports Combo', 'Pondicherry', 'high', 2500),
(75, 'Premium Cruise Dinner', 'Pondicherry', 'high', 3500),
(76, 'Fort Kochi Beach', 'Kochi', 'low', 20),
(77, 'Chinese Fishing Nets', 'Kochi', 'low', 30),
(78, 'Marine Drive', 'Kochi', 'low', 20),
(79, 'St. Francis Church', 'Kochi', 'low', 30),
(80, 'Jew Town Walk', 'Kochi', 'low', 20),
(81, 'Mattancherry Palace', 'Kochi', 'moderate', 150),
(82, 'Kerala Folklore Museum', 'Kochi', 'moderate', 200),
(83, 'Hill Palace Museum', 'Kochi', 'moderate', 150),
(84, 'Backwater Ride Kochi', 'Kochi', 'moderate', 300),
(85, 'Bolgatty Palace Visit', 'Kochi', 'moderate', 200),
(86, 'Luxury Houseboat Kochi', 'Kochi', 'high', 4000),
(87, 'Private Backwater Cruise', 'Kochi', 'high', 5000),
(88, 'Kathakali Premium Show', 'Kochi', 'high', 1500),
(89, 'Helicopter Ride Kochi', 'Kochi', 'high', 6000),
(90, 'Luxury Resort Kochi', 'Kochi', 'high', 4500),
(91, 'Tea Gardens Munnar', 'Munnar', 'low', 20),
(92, 'Echo Point', 'Munnar', 'low', 30),
(93, 'Top Station', 'Munnar', 'low', 20),
(94, 'Photo Point', 'Munnar', 'low', 20),
(95, 'Blossom Park', 'Munnar', 'low', 30),
(96, 'Eravikulam National Park', 'Munnar', 'moderate', 200),
(97, 'Mattupetty Dam', 'Munnar', 'moderate', 150),
(98, 'Kundala Lake', 'Munnar', 'moderate', 100),
(99, 'Tea Museum', 'Munnar', 'moderate', 150),
(100, 'Attukal Waterfalls', 'Munnar', 'moderate', 100),
(101, 'Munnar Jeep Safari', 'Munnar', 'high', 1500),
(102, 'Luxury Hill Resort', 'Munnar', 'high', 4000),
(103, 'Adventure Camp Munnar', 'Munnar', 'high', 2000),
(104, 'Private Trekking Guide', 'Munnar', 'high', 2500),
(105, 'Hot Air Balloon Ride', 'Munnar', 'high', 5000),
(106, 'Marudamalai Temple', 'Coimbatore', 'low', 20),
(107, 'VOC Park', 'Coimbatore', 'low', 20),
(108, 'Perur Temple', 'Coimbatore', 'low', 30),
(109, 'Singanallur Lake', 'Coimbatore', 'low', 20),
(110, 'Brookefields Walk', 'Coimbatore', 'low', 30),
(111, 'Isha Yoga Center', 'Coimbatore', 'moderate', 150),
(112, 'Siruvani Waterfalls', 'Coimbatore', 'moderate', 100),
(113, 'Black Thunder', 'Coimbatore', 'moderate', 800),
(114, 'Gedee Car Museum', 'Coimbatore', 'moderate', 150),
(115, 'Monkey Falls', 'Coimbatore', 'moderate', 100),
(116, 'Luxury Resort Coimbatore', 'Coimbatore', 'high', 4000),
(117, 'Private Safari Coimbatore', 'Coimbatore', 'high', 2000),
(118, 'Adventure Park Combo', 'Coimbatore', 'high', 2500),
(119, 'Premium Spa Resort', 'Coimbatore', 'high', 3500),
(120, 'Helicopter Ride Coimbatore', 'Coimbatore', 'high', 6000),
(121, 'Cubbon Park', 'Bangalore', 'low', 20),
(122, 'Lalbagh Garden', 'Bangalore', 'low', 30),
(123, 'ISKCON Temple', 'Bangalore', 'low', 50),
(124, 'Ulsoor Lake', 'Bangalore', 'low', 30),
(125, 'Street Shopping Brigade', 'Bangalore', 'low', 20),
(126, 'Bangalore Palace', 'Bangalore', 'moderate', 250),
(127, 'Bannerghatta Zoo', 'Bangalore', 'moderate', 200),
(128, 'Nandi Hills', 'Bangalore', 'moderate', 150),
(129, 'Wonderla Park', 'Bangalore', 'moderate', 800),
(130, 'Planetarium', 'Bangalore', 'moderate', 150),
(131, 'Helicopter Ride Bangalore', 'Bangalore', 'high', 5000),
(132, 'Luxury Resort Bangalore', 'Bangalore', 'high', 4000),
(133, 'Wine Tour Bangalore', 'Bangalore', 'high', 3500),
(134, 'Private City Tour', 'Bangalore', 'high', 3000),
(135, 'Golf Club Experience', 'Bangalore', 'high', 6000),
(136, 'Marina Beach', 'Chennai', 'low', 20),
(137, 'Besant Nagar Beach', 'Chennai', 'low', 20),
(138, 'Kapaleeshwarar Temple', 'Chennai', 'low', 30),
(139, 'Guindy Park', 'Chennai', 'low', 20),
(140, 'Santhome Church', 'Chennai', 'low', 20),
(141, 'VGP Marine Kingdom', 'Chennai', 'moderate', 300),
(142, 'DakshinaChitra', 'Chennai', 'moderate', 150),
(143, 'Birla Planetarium', 'Chennai', 'moderate', 100),
(144, 'Crocodile Bank', 'Chennai', 'moderate', 150),
(145, 'MGM Dizzee World', 'Chennai', 'moderate', 800),
(146, 'Luxury Beach Resort Chennai', 'Chennai', 'high', 5000),
(147, 'Private Yacht Chennai', 'Chennai', 'high', 4000),
(148, 'Helicopter Ride Chennai', 'Chennai', 'high', 6000),
(149, 'Premium Dinner Cruise', 'Chennai', 'high', 3500),
(150, 'Spa Resort Chennai', 'Chennai', 'high', 3000);

-- --------------------------------------------------------

--
-- Table structure for table `trip_plans`
--

CREATE TABLE `trip_plans` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `from_place` varchar(100) NOT NULL,
  `to_place` varchar(100) NOT NULL,
  `days` int(11) NOT NULL,
  `persons` int(11) NOT NULL,
  `budget` varchar(50) NOT NULL,
  `transport_mode` varchar(50) NOT NULL,
  `total_cost` float NOT NULL,
  `created_at` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `trip_plans`
--

INSERT INTO `trip_plans` (`id`, `user_id`, `from_place`, `to_place`, `days`, `persons`, `budget`, `transport_mode`, `total_cost`, `created_at`) VALUES
(1, 4, 'chennai', 'ooty', 4, 4, 'moderate', 'car', 22200, '2026-03-22 10:27:50'),
(2, 4, 'chennai', 'ooty', 4, 4, 'high', 'flight', 42200, '2026-03-22 10:31:11'),
(3, 4, 'chennai', 'ooty', 4, 4, 'high', 'flight', 42200, '2026-03-22 10:33:31'),
(4, 4, 'chennai', 'goa', 4, 4, 'moderate', 'flight', 34550, '2026-03-22 11:55:22'),
(5, 4, 'chennai', 'kodikannal', 4, 4, 'high', 'car', 37200, '2026-03-22 12:01:19'),
(6, 4, 'chennai', 'goa', 4, 4, 'moderate', 'car', 27350, '2026-03-22 12:01:39'),
(7, 4, 'chennai', 'kodikanal', 4, 4, 'moderate', 'car', 21600, '2026-03-22 12:03:01'),
(8, 4, 'chennai', 'kodikanal', 4, 4, 'moderate', 'flight', 25600, '2026-03-22 12:05:20'),
(9, 4, 'chennai', 'bangalore', 4, 4, 'high', 'bus', 54800, '2026-03-22 12:06:06'),
(10, 4, 'chennai', 'ooty', 4, 4, 'low', 'bus', 11500, '2026-03-22 12:06:24'),
(11, 4, 'coimbatore', 'ooty', 4, 4, 'low', 'bus', 8740, '2026-03-22 12:06:45'),
(12, 4, 'coimbatore', 'chennai', 4, 4, 'low', 'bus', 11170, '2026-03-22 12:08:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) default NULL,
  `email` varchar(100) default NULL,
  `phone` bigint(20) default NULL,
  `city` varchar(100) default NULL,
  `username` varchar(100) default NULL,
  `password` varchar(200) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `phone`, `city`, `username`, `password`) VALUES
(4, 'vicky', 'vicky@gmail.com', 6578976890, 'Chennai', 'vicky', '1234');
