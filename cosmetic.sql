-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 27, 2021 lúc 05:56 AM
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
(12, 'Dương Thụy Chương', 'tincao111@gmail.com', 0, '0909829308', '$2b$10$GcyF23o5A9N8YLrc83gGoetjceA1/p4KayvVGfjvq5SukG6UhxUkG'),
(0, 'Dương Thụy Chương', 'chuongddavid@gmail.com', 0, '0387845823', '$2b$10$4FcUYv0PIkDakeVgSX/y.uPdK7AVEkSX3.o.C5iKEPoxSuYgtTe96');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `customer`
--

INSERT INTO `customer` (`id`, `name`, `phone_number`, `email`) VALUES
(1, 'Chương Dương', '0387845823', 'chuongddavid@gmail.com'),
(2, 'Trung Tín', '0387845822', 'trungtin@gmail.com');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `product_id` varchar(50) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `transaction_id`, `product_id`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
(3, 11, 'NlWVCHOlK2z', 10, 600000, '2021-03-25 08:59:49', NULL),
(4, 11, 'tLtRQbN4u0g', 2, 500000, '2021-03-25 08:59:49', NULL);

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
('i2IMVCPobVN', 'Dung Dịch Tẩy Da Chết Paula’s Choice BHA 2% 30ml', 'Dung Dịch Loại Bỏ Tế Bào Chết Paula’s Choice Skin Perfecting 2% BHA Liquid Exfoliant đến từ thương hiệu dược mỹ phẩm Paula\'s Choice nổi tiếng của Mỹ là sản phẩm tẩy tế bào chết hóa học với nồng độ 2% BHA (Salicylic Acid) giúp làm sạch sâu lỗ chân lông, cải thiện tình trạng mụn ẩn - mụn đầu đen, đồng thời làm mờ nếp nhăn sâu, cải thiện tông màu da, mang lại cho bạn làn da sáng mịn, rạng rỡ và khỏe mạnh. Công thức sản phẩm dịu nhẹ, không gây bào mòn da, dễ dàng thẩm thấu mà không làm bít tắc lỗ chân lông.', 'Water (Aqua), Methylpropanediol (hydration), Butylene Glycol (hydration), Salicylic Acid (beta hydroxy acid/exfoliant), Polysorbate 20 (stabilizer), Camellia Oleifera Leaf Extract (green tea/skin calming/antioxidant), Sodium Hydroxide (pH balancer), Tetrasodium EDTA (stabilizer).', 'Paula’s Choice ', ' Xỉn Màu & Thâm Sạm ', 'dung-dich-loai-bo-te-bao-chet-paula-s-choice-bha-2-30ml-1_img_80x80_d200c5_fit_center.jpg'),
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
  `volume_unit` varchar(10) DEFAULT 'ml',
  `quantity` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `product_attr`
--

INSERT INTO `product_attr` (`id`, `volume`, `price`, `volume_unit`, `quantity`) VALUES
('1A3_ByRTtNq', 123, 600000, 'ml', 30),
('1u4fC8cHsyU', 30, 300000, 'ml', -2),
('IaG_14qioJ2', 200, 500000, 'g', 0),
('LUtol_sFp2E', 125, 138000, 'ml', 0),
('mYlBCc4zwSm', 118, 200000, 'ml', 0),
('QzLMhMXJ3eN', 150, 500000, 'g', -2);

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
('0P8tOst6FH_', 'i2IMVCPobVN', 'mYlBCc4zwSm'),
('4OF7jrj-4y9', 'i2IMVCPobVN', '1u4fC8cHsyU'),
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
(7, 'tLtRQbN4u0g', '2021-10-23', '2020-12-09', 500, 123456, '2021-03-23 02:49:00', NULL),
(9, '0P8tOst6FH_', '2022-01-24', '2021-01-23', 200, 600000, '2021-03-24 03:26:02', NULL),
(10, '4OF7jrj-4y9', '2021-03-26', '2021-03-11', 12000, 120000, '2021-03-24 05:26:03', '2021-03-24 07:45:36');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transaction`
--

CREATE TABLE `transaction` (
  `id` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `transaction`
--

INSERT INTO `transaction` (`id`, `amount`, `user_id`, `created_at`, `updated_at`) VALUES
(11, 7000000, 1, '2021-03-25 08:59:49', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `product_id` (`product_id`);

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
-- Chỉ mục cho bảng `transaction`
--
ALTER TABLE `transaction`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `product_package`
--
ALTER TABLE `product_package`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT cho bảng `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `product_detailed` (`id`);

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
