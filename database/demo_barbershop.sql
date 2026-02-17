-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 17, 2026 at 04:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `demo_barbershop`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointment`
--

CREATE TABLE `appointment` (
  `appointment_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `barber_id` int(11) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_start` time NOT NULL,
  `appointment_finish` time NOT NULL,
  `remarks` varchar(255) NOT NULL,
  `status` enum('Pending','Confirmed','Completed','Cancelled') NOT NULL DEFAULT 'Pending'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `appointment`
--

INSERT INTO `appointment` (`appointment_id`, `customer_id`, `barber_id`, `appointment_date`, `appointment_start`, `appointment_finish`, `remarks`, `status`) VALUES
(1, 1, 630502, '2026-02-18', '19:30:00', '20:00:00', 'No', 'Completed');

-- --------------------------------------------------------

--
-- Table structure for table `appointment_service`
--

CREATE TABLE `appointment_service` (
  `appointment_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `appointment_service`
--

INSERT INTO `appointment_service` (`appointment_id`, `service_id`) VALUES
(1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `barber`
--

CREATE TABLE `barber` (
  `barber_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `status` enum('active','resign') NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `barber`
--

INSERT INTO `barber` (`barber_id`, `full_name`, `email`, `phone_num`, `address`, `status`) VALUES
(630502, 'Staff', 'staff@hotmail.com', '0192533523', 'Penang, Malaysia', 'active');

-- --------------------------------------------------------

--
-- Table structure for table `barber_service`
--

CREATE TABLE `barber_service` (
  `barber_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `skill_level` enum('Beginner','Intermediate','Professional','') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `barber_service`
--

INSERT INTO `barber_service` (`barber_id`, `service_id`, `skill_level`) VALUES
(630502, 2, 'Professional'),
(630502, 3, 'Intermediate');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `phone_num` varchar(20) NOT NULL,
  `address` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `full_name`, `email`, `password`, `phone_num`, `address`) VALUES
(1, 'Customer', 'customer@hotmail.com', 'fbc9f3ebc980d43734b788d27bf5b945ddd209719949ebba1578bb98bbbccada', '0165388253', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `receipt`
--

CREATE TABLE `receipt` (
  `receipt_id` int(11) NOT NULL,
  `appointment_id` int(11) NOT NULL,
  `payment_name` enum('Online Banking','Debit Card','Credit Card','Cash','E-wallet') NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `issued_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `receipt`
--

INSERT INTO `receipt` (`receipt_id`, `appointment_id`, `payment_name`, `total_amount`, `issued_date`) VALUES
(1, 1, 'Online Banking', 10.00, '2026-02-17 15:00:16');

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL,
  `service_name` varchar(50) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`service_id`, `service_name`, `price`) VALUES
(1, 'Facial Treatment', 18.00),
(2, 'Haircut', 10.00),
(3, 'Beard Trim', 7.00);

-- --------------------------------------------------------

--
-- Table structure for table `shift`
--

CREATE TABLE `shift` (
  `shift_id` int(11) NOT NULL,
  `barber_id` int(11) NOT NULL,
  `day_name` enum('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') NOT NULL,
  `shift_start` time NOT NULL,
  `shift_finish` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `shift`
--

INSERT INTO `shift` (`shift_id`, `barber_id`, `day_name`, `shift_start`, `shift_finish`) VALUES
(1, 630502, 'Monday', '13:00:00', '18:00:00'),
(2, 630502, 'Wednesday', '18:00:00', '23:00:00'),
(3, 630502, 'Friday', '08:00:00', '13:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointment`
--
ALTER TABLE `appointment`
  ADD PRIMARY KEY (`appointment_id`),
  ADD KEY `fk_customer_id` (`customer_id`),
  ADD KEY `fk_barber_id` (`barber_id`);

--
-- Indexes for table `appointment_service`
--
ALTER TABLE `appointment_service`
  ADD KEY `pk_fk_appointment_id` (`appointment_id`),
  ADD KEY `pk_fk_service_id` (`service_id`);

--
-- Indexes for table `barber`
--
ALTER TABLE `barber`
  ADD PRIMARY KEY (`barber_id`),
  ADD UNIQUE KEY `uk_barber_email` (`email`);

--
-- Indexes for table `barber_service`
--
ALTER TABLE `barber_service`
  ADD KEY `pk_fk_barber_id` (`barber_id`),
  ADD KEY `pk_fk_service_id` (`service_id`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `uk_customer_email` (`email`);

--
-- Indexes for table `receipt`
--
ALTER TABLE `receipt`
  ADD PRIMARY KEY (`receipt_id`),
  ADD KEY `fk_appointment_id` (`appointment_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`service_id`),
  ADD UNIQUE KEY `uk_service_name` (`service_name`);

--
-- Indexes for table `shift`
--
ALTER TABLE `shift`
  ADD PRIMARY KEY (`shift_id`),
  ADD KEY `fk_barber_id` (`barber_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointment`
--
ALTER TABLE `appointment`
  MODIFY `appointment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `receipt`
--
ALTER TABLE `receipt`
  MODIFY `receipt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `shift`
--
ALTER TABLE `shift`
  MODIFY `shift_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointment`
--
ALTER TABLE `appointment`
  ADD CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`barber_id`) REFERENCES `barber` (`barber_id`);

--
-- Constraints for table `appointment_service`
--
ALTER TABLE `appointment_service`
  ADD CONSTRAINT `appointment_service_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`),
  ADD CONSTRAINT `appointment_service_ibfk_2` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `barber_service`
--
ALTER TABLE `barber_service`
  ADD CONSTRAINT `barber_service_ibfk_1` FOREIGN KEY (`barber_id`) REFERENCES `barber` (`barber_id`),
  ADD CONSTRAINT `barber_service_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`service_id`);

--
-- Constraints for table `receipt`
--
ALTER TABLE `receipt`
  ADD CONSTRAINT `receipt_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`);

--
-- Constraints for table `shift`
--
ALTER TABLE `shift`
  ADD CONSTRAINT `shift_ibfk_1` FOREIGN KEY (`barber_id`) REFERENCES `barber` (`barber_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
