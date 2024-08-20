-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2023 at 04:22 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `aadhar`
--

-- --------------------------------------------------------

--
-- Table structure for table `aadhar_info`
--

CREATE TABLE `aadhar_info` (
  `Name` varchar(50) NOT NULL,
  `Aadharno` bigint(12) NOT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Phoneno` bigint(12) NOT NULL,
  `Gender` varchar(2) NOT NULL,
  `dob` int(5) NOT NULL,
  `Is_registered` varchar(5) DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `aadhar_info`
--

INSERT INTO `aadhar_info` (`Name`, `Aadharno`, `Email`, `Phoneno`, `Gender`, `dob`, `Is_registered`) VALUES
('Vishwas', 753951456852, 'vishwas@gmail.com', 9638527413, 'm', 25, 'YES'),
('Pramitha', 773394948885, 'pramitha@gmail.com', 8762125705, 'ma', 25, 'YES');

-- --------------------------------------------------------

--
-- Table structure for table `registered_users`
--

CREATE TABLE `registered_users` (
  `Account_address` varchar(60) NOT NULL,
  `Is_registered` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registered_users`
--

INSERT INTO `registered_users` (`Account_address`, `Is_registered`) VALUES
('0x040b4b12Ba9173337bEfb9c24dF8625b4443518D', 'Yes'),
('0x272573c15cAfA4116EeAdBD65C246E9725245bfc', 'Yes');

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

CREATE TABLE `registration` (
  `id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `email_address` varchar(50) NOT NULL,
  `password` varchar(70) NOT NULL,
  `confirm_password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`id`, `first_name`, `last_name`, `gender`, `email_address`, `password`, `confirm_password`) VALUES
(1, 'admin', NULL, NULL, 'admin@admin.com', 'admin', 'admin'),
(2, 'Aman', NULL, NULL, 'themanqwerty28@gmail.com', 'aaa', 'aaa'),
(3, 'appu', NULL, 'm', 'appu@gmail.com', 'aaa', 'aaa');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `aadhar_info`
--
ALTER TABLE `aadhar_info`
  ADD PRIMARY KEY (`Aadharno`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `registered_users`
--
ALTER TABLE `registered_users`
  ADD PRIMARY KEY (`Account_address`),
  ADD UNIQUE KEY `Account_address` (`Account_address`),
  ADD UNIQUE KEY `Account_address_2` (`Account_address`);

--
-- Indexes for table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `registration`
--
ALTER TABLE `registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
