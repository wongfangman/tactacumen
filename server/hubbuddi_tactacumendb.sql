-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jul 10, 2021 at 01:41 PM
-- Server version: 10.3.29-MariaDB-cll-lve
-- PHP Version: 7.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hubbuddi_tactacumendb`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_addressbook`
--

CREATE TABLE `tbl_addressbook` (
  `user_email` varchar(100) NOT NULL,
  `fullname` varchar(200) NOT NULL,
  `phoneno` varchar(12) NOT NULL,
  `detailedaddress` varchar(500) NOT NULL,
  `postalcode` int(5) NOT NULL,
  `city` varchar(100) NOT NULL,
  `state` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_carts`
--

CREATE TABLE `tbl_carts` (
  `user_email` varchar(100) NOT NULL,
  `prid` int(6) NOT NULL,
  `cartqty` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_feedbacks`
--

CREATE TABLE `tbl_feedbacks` (
  `user_email` varchar(100) NOT NULL,
  `feedback_type` varchar(50) NOT NULL,
  `feedback_message` varchar(300) NOT NULL,
  `date_created` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_order`
--

CREATE TABLE `tbl_order` (
  `orderid` varchar(10) NOT NULL,
  `user_email` varchar(200) NOT NULL,
  `prid` varchar(10) NOT NULL,
  `orderqty` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_products`
--

CREATE TABLE `tbl_products` (
  `prid` int(6) NOT NULL,
  `prname` varchar(300) NOT NULL,
  `prtype` varchar(100) NOT NULL,
  `prprice` double(10,2) NOT NULL,
  `prqty` int(6) NOT NULL,
  `prdescription` varchar(500) NOT NULL,
  `prlength` double(6,1) NOT NULL,
  `prwidth` double(6,1) NOT NULL,
  `prheight` double(6,1) NOT NULL,
  `datecreated` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tbl_products`
--

INSERT INTO `tbl_products` (`prid`, `prname`, `prtype`, `prprice`, `prqty`, `prdescription`, `prlength`, `prwidth`, `prheight`, `datecreated`) VALUES
(1, 'MAL-24 (2.5HP) Malcomair Portable Direct Driven Air Compressor', 'Malcomair', 370.00, 50, 'Model : MAL-24\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 2.5HP\r\nTank : 24L\r\nCylinder dia x No.mm : 42mm\r\nDisplacement : 135L/min\r\nSpeed : 2850rpm\r\nWeight : 18.5/20.5kg', 56.0, 28.0, 61.5, '2021-06-07'),
(2, 'MAL-50 (3HP) Malcomair Portable Direct Driven Air Compressor', 'Malcomair', 430.00, 20, 'Model : MAL-50\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 3HP\r\nTank : 50L\r\nCylinder dia x No. mm : 42mm\r\nDisplacement : 135L/min\r\nSpeed : 2850rpm\r\nWeight : 22.5/25.5kg', 70.5, 33.5, 66.0, '2021-06-07'),
(3, 'MAL-0368 (1HP) Malcomair Belt Driven Piston Air Compressor', 'Malcomair', 770.00, 10, 'Model : MAL-0368\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 1HP\r\nTank : 50L\r\nCylinder dia x No. mm : 51mm\r\nDisplacement : 36L/min\r\nSpeed : 1250rpm\r\nWeight : 35/45kg', 88.0, 43.0, 66.0, '2021-06-08'),
(4, 'MAL-1708 (2HP) Malcomair Belt Driven Piston Air Compressor', 'Malcomair', 1250.00, 10, 'Model : MAL-1708\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 2HP\r\nTank : 100L\r\nCylinder dia x No. mm : 51 x 2mm\r\nDisplacement : 170L/min\r\nSpeed : 1050rpm\r\nWeight : 57/67kg', 109.0, 44.5, 82.0, '2021-06-08'),
(5, 'MAL-3008 (3HP) Malcomair Belt Driven Piston Air Compressor', 'Malcomair', 2100.00, 8, 'Model : MAL-3008\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 2.2KW / 3HP\r\nTank : 100L\r\nCylinder dia x No. mm : 65mm x 2\r\nDisplacement : 12CFM\r\nSpeed : 1120rpm\r\nWeight : 90.6kg', 118.0, 44.5, 85.5, '2021-06-08'),
(6, 'MAL-5508 (5.5HP) Malcomair Belt Driven Piston Air Compressor', 'Malcomair', 3800.00, 8, 'Model : MAL-5508\r\nVoltage Frequency : 380V / 50HZ\r\nPower : 4KW / 5.5HP\r\nTank : 150L\r\nCylinder dia x No. mm : 80mm x 3\r\nDisplacement : 28.1CFM\r\nSpeed : 880rpm\r\nWeight : 158kg', 141.0, 56.0, 105.0, '2021-06-08'),
(7, 'MAL-600-9 (1HP) Malcomair Oil-Free Air Compressor', 'Malcomair', 480.00, 15, 'Model : MAL-600-9\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 1HP\r\nTank : 9L\r\nCylinder dia x No. mm : 63.7mm\r\nDisplacement : 103L/min\r\nSpeed : 1440rpm\r\nWeight : 15.5/16.5kg', 47.5, 21.0, 51.5, '2021-06-08'),
(8, 'MAL-600-30 (1HP) Malcomair Oil-Free Air Compressor', 'Malcomair', 540.00, 15, 'Model : MAL-600-30\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 1HP\r\nTank : 30L\r\nCylinder dia x No. mm : 63.7mm\r\nDisplacement : 103L/min\r\nSpeed : 1440rpm\r\nWeight : 22.5/24.5kg', 59.5, 26.5, 61.0, '2021-06-08'),
(9, 'MAL-1500-30 (2HP) Malcomair Oil-Free Air Compressor', 'Malcomair', 600.00, 30, 'Model : MAL-1500-30\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 1500W / 2HP\r\nTank : 30L\r\nCylinder dia x No. mm : 63.7mm\r\nDisplacement : 260L/min\r\nSpeed : 2850rpm\r\nWeight : 22kg', 56.0, 28.0, 61.5, '2021-06-08'),
(10, 'MAL-1500-50 (2HP) Malcomair Oil-Free Air Compressor', 'Malcomair', 690.00, 30, 'Model : MAL-1500-50\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 1500W / 2HP\r\nTank : 50L\r\nCylinder dia x No. mm : 63 x 2mm\r\nDisplacement : 260L/min\r\nSpeed : 2850rpm\r\nWeight : 25/27kg', 70.5, 33.0, 66.0, '2021-06-08'),
(11, 'MAL-2200-100 (3HP) Malcomair Oil-Free Air Compressor', 'Malcomair', 2400.00, 10, 'Model : MAL-2200-100\r\nVoltage Frequency : 240V / 50HZ\r\nPower : 3HP\r\nTank : 100L\r\nCylinder dia x No. mm : 63.7mm\r\nDisplacement : 404L/min\r\nSpeed : 1440rpm\r\nWeight : 71.5/81.2kg', 118.0, 44.5, 85.5, '2021-06-08'),
(12, 'TA-2524 (2.5HP) Tacumen Portable Direct Driven Air Compressor', 'Tacumen', 530.00, 30, 'Model : TA-2524\r\nPower : 2.5HP\r\nTank Capacity : 24L\r\nPressure : 8bar\r\nVoltage : 240V / 50HZ\r\nAir Delivery : 6.6cfm\r\nSpeed : 2800rpm\r\nN.W/G.W : 21.5/23.5kg', 57.0, 28.5, 61.0, '2021-06-10'),
(13, 'TA-3050 (3HP) Tacumen Portable Direct Driven Air Compressor', 'Tacumen', 600.00, 30, 'Model : TA-3050\r\nPower : 3HP\r\nTank Capacity : 50L\r\nPressure : 8bar\r\nVoltage : 240V / 50HZ\r\nAir Delivery : 7.3cfm\r\nSpeed : 2800rpm\r\nN.W/G.W : 27.3/30kg', 76.0, 32.5, 67.0, '2021-06-10'),
(14, 'TA-20LS (2HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 1600.00, 20, 'Model : TA-20LS\r\nPower : 2HP\r\nTank Capacity : 100L\r\nPressure : 8bar\r\nVoltage : 240V / 50HZ\r\nAir Delivery : 8.4cfm\r\nSpeed : 1000rpm\r\nN.W/G.W : 75.64/85.98kg', 118.5, 46.0, 87.5, '2021-06-10'),
(15, 'TA-25LS (3HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 2200.00, 20, 'Model : TA-25LS\r\nPower : 3HP\r\nTank Capacity : 100L\r\nPressure : 8bar\r\nVoltage : 240V / 50HZ\r\nAir Delivery : 12cfm\r\nSpeed : 1120rpm\r\nN.W/G.W : 79.16/89.46kg', 118.5, 46.0, 87.5, '2021-06-10'),
(16, 'TA-30LS (3HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 3400.00, 10, 'Model : TA-30LS\r\nPower : 3HP\r\nTank Capacity : 150L\r\nPressure : 8bar\r\nVoltage : 240V / 50HZ\r\nAir Delivery : 12.1cfm\r\nSpeed : 750rpm\r\nN.W/G.W : 116.3/134.46kg', 139.0, 53.0, 104.0, '2021-06-10'),
(17, 'TA-30LT (3HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 3350.00, 10, 'Model : TA-30LT\r\nPower : 3HP\r\nTank Capacity : 150L\r\nPressure : 8bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 12.1cfm\r\nSpeed : 750rpm\r\nN.W/G.W : 116.3/134.46kg', 139.0, 53.0, 104.0, '2021-06-10'),
(18, 'TA-30HT (3HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 3450.00, 10, 'Model : TA-30HT\r\nPower : 3HP\r\nTank Capacity : 150L\r\nPressure : 12.5bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 9.1cfm\r\nSpeed : 850rpm\r\nN.W/G.W : 116.3/134.46kg', 139.0, 53.0, 104.0, '2021-06-10'),
(19, 'TA-55LT (5.5HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 4300.00, 5, 'Model : TA-55LT\r\nPower : 5.5HP\r\nTank Capacity : 150L\r\nPressure : 8bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 26.1cfm\r\nSpeed : 710rpm\r\nN.W/G.W : 170.16/188.32kg', 139.0, 53.0, 104.0, '2021-06-10'),
(20, 'TA-55HT (5.5HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 4700.00, 5, 'Model : TA-55HT\r\nPower : 5.5HP\r\nTank Capacity : 150L\r\nPressure : 12.5bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 17.4cfm\r\nSpeed : 820rpm\r\nN.W/G.W : 170.16/188.32kg', 139.0, 53.0, 104.0, '2021-06-10'),
(21, 'TA-75LT (7.5HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 5900.00, 3, 'Model : TA-75LT\r\nPower : 7.5HP\r\nTank Capacity : 200L\r\nPressure : 8bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 33.8cfm\r\nSpeed : 940rpm\r\nN.W/G.W : 205/215.32kg', 172.5, 58.0, 108.0, '2021-06-10'),
(22, 'TA-75HT (7.5HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 6300.00, 3, 'Model : TA-75HT\r\nPower : 7.5HP\r\nTank Capacity : 200L\r\nPressure : 12.5bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 20.2cfm\r\nSpeed : 1040rpm\r\nN.W/G.W : 205/215.32kg', 172.5, 58.0, 108.0, '2021-06-10'),
(23, 'TA-100LT (10HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 7900.00, 2, 'Model : TA-100LT\r\nPower : 10HP\r\nTank Capacity : 300L\r\nPressure : 8bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 50.6cfm\r\nSpeed : 870rpm\r\nN.W/G.W : 293.5/313.5kg', 191.0, 61.0, 128.0, '2021-06-10'),
(24, 'TA-100HT (10HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 8300.00, 2, 'Model : TA-100HT\r\nPower : 10HP\r\nTank Capacity : 300L\r\nPressure : 12.5bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 33.8cfm\r\nSpeed : 870rpm\r\nN.W/G.W : 293.5/313.5kg', 191.0, 61.0, 128.0, '2021-06-10'),
(25, 'TA-120LT (15HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 9100.00, 1, 'Model : TA-120LT\r\nPower : 15HP\r\nTank Capacity : 300L\r\nPressure : 8bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 70.8cfm\r\nSpeed : 740rpm\r\nN.W/G.W : 381/401kg', 191.0, 74.0, 134.0, '2021-06-10'),
(26, 'TA-120HT (15HP) Tacumen Belt Driven Piston Air Compressor', 'Tacumen', 9600.00, 1, 'Model : TA-120HT\r\nPower : 15HP\r\nTank Capacity : 300L\r\nPressure : 12.5bar\r\nVoltage : 415V / 50HZ\r\nAir Delivery : 52.4cfm\r\nSpeed : 820rpm\r\nN.W/G.W : 381/401kg', 191.0, 74.0, 134.0, '2021-06-10');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_purchased`
--

CREATE TABLE `tbl_purchased` (
  `orderid` varchar(10) NOT NULL,
  `user_email` varchar(100) NOT NULL,
  `paid` varchar(10) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_user`
--

CREATE TABLE `tbl_user` (
  `user_email` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `otp` varchar(5) NOT NULL,
  `date_reg` datetime(6) NOT NULL DEFAULT current_timestamp(6),
  `fullname` varchar(200) NOT NULL,
  `phoneno` varchar(12) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `birthday` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_products`
--
ALTER TABLE `tbl_products`
  ADD PRIMARY KEY (`prid`);

--
-- Indexes for table `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`user_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_products`
--
ALTER TABLE `tbl_products`
  MODIFY `prid` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
