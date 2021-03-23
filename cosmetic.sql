-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 23, 2021 lúc 04:56 AM
-- Phiên bản máy phục vụ: 10.4.17-MariaDB
-- Phiên bản PHP: 7.3.27

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
(12, 'Dương Thụy Chương', 'tincao111@gmail.com', 0, '0909829308', '$2b$10$GcyF23o5A9N8YLrc83gGoetjceA1/p4KayvVGfjvq5SukG6UhxUkG'),
(0, 'Dương Thụy Chương', 'chuongddavid@gmail.com', 0, '0387845823', '$2b$10$4FcUYv0PIkDakeVgSX/y.uPdK7AVEkSX3.o.C5iKEPoxSuYgtTe96');

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
('rTgsVb1I3aT', 'Sữa Rửa Mặt Cetaphil Dịu Nhẹ', 'Sạch sâu thông thoáng lỗ chân lông', 'AHA, BHA', 'Cetaphil', 'Chăm sóc mặt', 'srm.jpg'),
('xcgn5TJ1zDf', 'Sữa Rửa Mặt Cetaphil Dịu Nhẹ 2', 'Sạch sâu thông thoáng lỗ chân lông', 'AHA, BHA', 'Cetaphil', 'Chăm sóc mặt', 'tinh-chat-some-by-mi-cho-da-mun-50ml-111_2__img_80x80_d200c5_fit_center.jpg');

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
('1A3_ByRTtNq', 123, 600000, 'ml'),
('IaG_14qioJ2', 200, 500000, 'g'),
('LUtol_sFp2E', 125, 138000, 'ml'),
('QzLMhMXJ3eN', 150, 500000, 'g');

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
('MruShp55RUO', 'rTgsVb1I3aT', 'LUtol_sFp2E'),
('NlWVCHOlK2z', 'xcgn5TJ1zDf', '1A3_ByRTtNq'),
('tLtRQbN4u0g', 'xcgn5TJ1zDf', 'QzLMhMXJ3eN'),
('Xt1Jt8IZ08u', 'rTgsVb1I3aT', 'IaG_14qioJ2');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_package`
--

CREATE TABLE `product_package` (
  `id` int(11) NOT NULL,
  `product_id` varchar(50) DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  `mfg_date` date DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price_import` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product_package`
--

INSERT INTO `product_package` (`id`, `product_id`, `exp_date`, `mfg_date`, `quantity`, `price_import`, `created_at`, `updated_at`) VALUES
(6, 'NlWVCHOlK2z', '2021-06-23', '2020-11-23', 120, 123456, '2021-03-23 02:48:36', NULL),
(7, 'tLtRQbN4u0g', '2021-10-23', '2020-12-09', 500, 123456, '2021-03-23 02:49:00', NULL),
(8, 'NlWVCHOlK2z', '2021-04-10', '2021-03-10', 70, 8000, '2021-03-23 02:49:22', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

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
-- Chỉ mục cho bảng `product_package`
--
ALTER TABLE `product_package`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `product_package`
--
ALTER TABLE `product_package`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
-- Các ràng buộc cho bảng `product_package`
--
ALTER TABLE `product_package`
  ADD CONSTRAINT `product_package_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product_detailed` (`id`),
  ADD CONSTRAINT `product_package_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `product_detailed` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
