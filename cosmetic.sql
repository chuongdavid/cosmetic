-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 20, 2021 lúc 02:31 PM
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

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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
-- Chỉ mục cho bảng `product_pakage`
--
ALTER TABLE `product_pakage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `product_pakage`
--
ALTER TABLE `product_pakage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
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
