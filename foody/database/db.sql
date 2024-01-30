-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2024 at 05:07 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foody_db`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `isValidEmail` (`email` VARCHAR(255)) RETURNS TINYINT(1)  BEGIN
    DECLARE isValid BOOLEAN;
    SET isValid = FALSE;

    -- Regular Expression สำหรับตรวจสอบรูปแบบของอีเมล
    SET @emailPattern = '^[^\s@]+@[^\s@]+\.[^\s@]+$';

    -- ตรวจสอบว่ารูปแบบถูกต้องหรือไม่
    IF email REGEXP @emailPattern THEN
        SET isValid = TRUE;
    END IF;

    RETURN isValid;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `contact_messages`
--

CREATE TABLE `contact_messages` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_messages`
--

INSERT INTO `contact_messages` (`id`, `name`, `email`, `subject`, `message`) VALUES
(1, 'van', 'van@gmail.com', 'd', 'fgtrt'),
(2, 'somsy', 'som@gmail.com', 'manggo', 'good');

-- --------------------------------------------------------

--
-- Table structure for table `login_sigup`
--

CREATE TABLE `login_sigup` (
  `id_us` int(11) NOT NULL,
  `CountryCode` varchar(40) NOT NULL,
  `Phonenumber` text NOT NULL,
  `username` varchar(30) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `password` text NOT NULL
) ;

--
-- Dumping data for table `login_sigup`
--

INSERT INTO `login_sigup` (`id_us`, `CountryCode`, `Phonenumber`, `username`, `email`, `password`) VALUES
(16, '', 'e', 'eee', 'som@gmail.com', 'sssssss'),
(17, '+856', '2078154297', 'preter SAK', 'preter@gmail.com', '1234567');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact_messages`
--
ALTER TABLE `contact_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `login_sigup`
--
ALTER TABLE `login_sigup`
  ADD PRIMARY KEY (`id_us`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact_messages`
--
ALTER TABLE `contact_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `login_sigup`
--
ALTER TABLE `login_sigup`
  MODIFY `id_us` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
