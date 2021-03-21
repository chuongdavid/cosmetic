-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 21, 2021 lúc 05:16 AM
-- Phiên bản máy phục vụ: 10.4.14-MariaDB
-- Phiên bản PHP: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `cosmetic`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

CREATE TABLE `account` (
  `id` int(20) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `role` int(11) NOT NULL DEFAULT 0,
  `phone` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`id`, `name`, `email`, `role`, `phone`, `password`) VALUES
(6, 'Trung Tín', 'tincao241@gmail.com', 0, '0909829308', '$2b$10$4OIo28k.CJoGA0TnQ8todOTDfAmru9RlZO.aRB7tBQsWsMof3wHne'),
(8, 'IPhone 12', 'tincao241@gmail.com', 0, '0909829308', '$2b$10$.02l/wCjyAHmhectQZAR5us1wAGfkK0rednXy76n1s0PdrmKlyImy'),
(9, 'Trung Tín', 'tincao241@gmail.com', 0, '0909829308', '$2b$10$5F252HgSdfyTTo8Rv7qq2e4y7v7GTklrgFDAvM9Cgmfs/vBWNj8MO'),
(10, 'Trung Tín', 'tincao241@gmail.com', 0, '0909829308', '$2b$10$oaSNs0TH2S47Z7NV2oFR4u.2Tk8ImkGRhe4MxwsPsaV1kixW/vHWy'),
(11, 'Trung Tín', 'tincao241@gmail.com', 0, '0909829308', '$2b$10$QkFxpdBPsqddZY.fjZotKOxbsD3HzYISYmxhHuezfBWKggrtDikHu'),
(12, 'Dương Thụy Chương', 'tincao111@gmail.com', 0, '0909829308', '$2b$10$GcyF23o5A9N8YLrc83gGoetjceA1/p4KayvVGfjvq5SukG6UhxUkG');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` varchar(50) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `desc` varchar(1000) DEFAULT NULL,
  `ingredient` varchar(1000) DEFAULT NULL,
  `brand` varchar(100) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `name`, `desc`, `ingredient`, `brand`, `category`, `image`) VALUES
('2W7z9i6FXm3', 'Sữa Rửa Mặt Cetaphil Dịu Nhẹ', 'sdfa', 'sdfasf', 'asdfasdfa', 'Chăm sóc mặt', 'srm.jpg'),
('dWqiV9PZVPt', 'Dương Thụy Chương', 'asdasd', 'asdas', 'dasdas', 'asdasd', 'srm.jpg'),
('FU9gfNBfLZE', 'Dương Quang Thụy', 'asdas', 'dad', 'asdasdas', 'adsada', 'srm.jpg'),
('OsPkKiY1Kig', 'Sữa Rửa Mặt Cetaphil Dịu Nhẹ', 'Miêu tả', 'Thành phần hcun', 'Lancome', 'Chăm sóc mặt', 'srm.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_attr`
--

CREATE TABLE `product_attr` (
  `id` varchar(50) NOT NULL,
  `volume` float DEFAULT NULL,
  `price` float DEFAULT NULL,
  `volume_unit` varchar(10) DEFAULT 'ml'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product_attr`
--

INSERT INTO `product_attr` (`id`, `volume`, `price`, `volume_unit`) VALUES
('g0wjUSt2um3', 150, 500000, 'ml'),
('G7abubQMLh_', 100, 600000, 'ml'),
('oj9FvR5xra6', 200, 700000, 'ml');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_detailed`
--

CREATE TABLE `product_detailed` (
  `id` varchar(50) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `attr_id` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product_detailed`
--

INSERT INTO `product_detailed` (`id`, `product_id`, `attr_id`) VALUES
('80VJP0F-Y3T', '2W7z9i6FXm3', 'G7abubQMLh_'),
('GDWHnfnnNx1', '2W7z9i6FXm3', 'g0wjUSt2um3'),
('sLOMZQyrLKB', '2W7z9i6FXm3', 'oj9FvR5xra6');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_pakage`
--

CREATE TABLE `product_pakage` (
  `id` int(11) NOT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `date_import` date DEFAULT NULL,
  `date_exp` date DEFAULT NULL,
  `date_sanxuat` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price_import` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product_attr`
--
ALTER TABLE `product_attr`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `product_detailed`
--
ALTER TABLE `product_detailed`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `attr_id` (`attr_id`);

--
-- Chỉ mục cho bảng `product_pakage`
--
ALTER TABLE `product_pakage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `account`
--
ALTER TABLE `account`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `product_pakage`
--
ALTER TABLE `product_pakage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `product_detailed`
--
ALTER TABLE `product_detailed`
  ADD CONSTRAINT `product_detailed_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `product_detailed_ibfk_2` FOREIGN KEY (`attr_id`) REFERENCES `product_attr` (`id`),
  ADD CONSTRAINT `product_detailed_ibfk_3` FOREIGN KEY (`attr_id`) REFERENCES `product_attr` (`id`);

--
-- Các ràng buộc cho bảng `product_pakage`
--
ALTER TABLE `product_pakage`
  ADD CONSTRAINT `product_pakage_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `product_pakage_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product_detailed` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
