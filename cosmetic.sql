-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th3 27, 2021 lúc 12:15 PM
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
(13, 'Dương Thụy Chương', 'chuongddavid@gmail.com', 0, '0387845823', '$2b$10$4FcUYv0PIkDakeVgSX/y.uPdK7AVEkSX3.o.C5iKEPoxSuYgtTe96'),
(15, 'Phan Khang Vĩ', 'khangvi1412@gmail.com', 0, '0909829304', '$2b$10$8Y8c2ivsOr0rbEyaXGZ0Ee6JLg88vWq5O65VIGVfmfpSB.fiLI4Y6');

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
(2, 'Trung Tín', '0387845822', 'trungtin@gmail.com'),
(3, 'Khang Vĩ', '0909829305', 'khangvi1412@gmail.com');

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
(7, 13, 'EapqJ8D3oL0', 1, 300000, '2021-03-27 10:29:37', NULL),
(8, 13, 'h4-0a6Myekm', 1, 400000, '2021-03-27 10:29:37', NULL),
(9, 13, 'prD9sJn_icH', 1, 150000, '2021-03-27 10:29:37', NULL),
(10, 14, 'prD9sJn_icH', 2, 150000, '2021-03-27 10:30:27', NULL),
(11, 14, 'uDdsKLCSgts', 1, 1360000, '2021-03-27 10:30:27', NULL),
(12, 15, '_dWtBquWyLm', 1, 126000, '2021-03-27 10:38:16', NULL),
(13, 15, 'h4-0a6Myekm', 1, 400000, '2021-03-27 10:38:16', NULL),
(14, 15, 'prD9sJn_icH', 1, 150000, '2021-03-27 10:38:16', NULL),
(15, 16, 'uDdsKLCSgts', 1, 1360000, '2021-03-27 10:38:59', NULL),
(16, 16, 'us4yYZfAHqp', 1, 250000, '2021-03-27 10:38:59', NULL),
(17, 16, 'vifLW1TNfzc', 1, 420000, '2021-03-27 10:38:59', NULL),
(19, 17, 'T6-6g_DCWQe', 1, 260000, '2021-03-27 10:40:25', NULL);

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
('928rnJStvXk', 'Sữa Chống Nắng Anessa', 'Sữa Chống Nắng Dưỡng Da Bảo Vệ Hoàn Hảo Anessa Perfect UV Sunscreen Skincare Milk SPF50+/PA++++ là dòng sản phẩm chống nắng dưỡng da thuộc thương hiệu Anessa (tập đoàn Shiseido) - thương hiệu chống nắng được yêu thích hàng đầu tại Nhật Bản trong suốt 19 năm liền. Phiên bản cải tiến mới của năm 2020 vừa được ra mắt với sự tích hợp của bộ ba công nghệ chống UV vượt trội: Thermal Booster + Aqua Booster EX + Very Water-Resistant, tạo nên lớp màng bảo vệ da tối ưu dưới tác động của ánh nắng mặt trời, đồng thời chứa 50% thành phần dưỡng da giúp đẩy lùi các dấu hiệu lão hóa da, nuôi dưỡng da khỏe mạnh và tươi trẻ.', 'Ethylhexyl Methoxycinnamate, Oxide, Diethylamino Hydroxybenzoyl hexyl benzoate, Bis-ethylhexyloxyphenol methoxyphenyl triazine, Dimethicone, titanium dioxide, Sodium hyaluronate, Polysilicone, Cyclomethicone, water, alcohol, ethylhexylpalmitate.', 'Anessa', 'Sữa, Kem chống nắng', 'suachongnang.png'),
('AJX-I2wnNMF', 'Nước Dưỡng Tóc Cocoon Tinh Dầu Bưởi', 'Nước Dưỡng Tóc Cocoon Tinh Dầu Bưởi Pomelo Hair Tonic 140ml là dòng chăm sóc tóc đến từ thương hiệu mỹ phẩm Cocoon của Việt Nam, sẽ là giải pháp giúp bạn xóa tan đi nỗi lo rụng tóc với tinh dầu vỏ bưởi tự nhiên có đặc tính chống oxy hóa và làm sạch, kết hợp hoạt chất Xylishine và vitamin B5 cung cấp dưỡng chất tuyệt vời cho da đầu, thúc đẩy sự phát triển tóc chắc khỏe.', 'Water, C15-19 Alkane, Isododecane, Glycerin, Xylityglucoside, Anhydroxylitol, Maltitol, Xylitool, Citrus Grandis (Bưởi) Peel Oil, Betaine, Pelvetia Canaliculate Extract, Sodium Lactate, Panthenol (Vitamin B5), Sodium Gluconate, Glycereth-26, Phenoxyethanol, Trisodium Ethylenediamine Disuccinate, Bht, Ethyhexylglycerin.', 'Cocoon', 'Dưỡng tóc', 'duongtoc.jpg'),
('gIMeLBvFZOh', 'Kem Chống Nắng Eucerin Cho Da Nhờn & Mụn', 'Kem Chống Nắng Kiểm Soát Nhờn Eucerin Sun Gel Cream Acne Oil Control SPF 50+ PA+++ là sản phẩm chống nắng đến từ thương hiệu dược mỹ phẩm Eucerin, được thiết kế chuyên biệt dành cho da dầu và da hỗn hợp. Nhờ vào công thức Tinosorb S hình thành bộ lọc tia UVA/UVB thông minh, an toàn giúp bảo vệ làn da hiệu quả dưới tác hại của ánh nắng mặt trời. Sản phẩm có thể sử dụng được với cả những làn da bị mụn trứng cá hay da nhạy cảm do tiếp xúc với hóa chất và tia laser. Đặc biệt là sản phẩm không bị trôi bởi nước, không gây bít tắc lỗ chân lông ngay cả khi thời tiết nóng ẩm.', 'Aqua Isodecyl Neopentanoate Butylene Glycol Dicaprylate/Dicaprate Isopropyl Palmitate Octocrylene Alcohol Denat Methyl Methacrylate Crosspolymer Butyl Methoxydibenzoylmethane Titanium Dioxide (nano) Bis-Ethylhexyloxyphenol Methoxyphenyl Triazine Homosalate Dibutyl Adipate Glycine Polyamide-5   Polymethylsilsesquioxane Ethylhexyl Salicylate Phenylbenzimidazole Sulfonic Acid Arginine HCL Polyglyceryl-4 Diisostearate Polyhydroxystearate Sebacate Glycerine   Sodium Hyaluronate Glycyrrhetinic Acid Glycyrrhiza Inflata Root Extract VP/Hexadecene Copolymer Trimethoxycaprylylsilane Trisodium EDTA Silica Dimethyl Silylate   Dimethicone Ethylhexylglycerin. ', 'Eucerin', 'Sữa, Kem chống nắng', 'kemchongnang.jpg'),
('ikfbaiO9dXX', 'Kem Dưỡng Laneige Dưỡng Ẩm', 'Kem Dưỡng Laneige Dưỡng Ẩm, Ngăn Ngừa Lão Hóa Da 50ml là kem dưỡng thuộc dòng ngừa lão hoá Time Freeze đến từ thương hiệu mỹ phẩm cao cấp Laneige của Hàn Quốc, sử dụng công nghệ Dynamic CollagenTM - công nghệ tái tổng hợp collagen đầu tiên trên thế giới - nhanh chóng từng bước tác động vào các sợi collagen đã lão hóa, thẩm thấu sâu vào da để khôi phục độ đàn hồi và làm trẻ hóa hệ thống collagen mới mềm dẻo hơn, săn chắc hơn. Time Freeze Intensive Cream đã chứng minh hiệu quả phục hồi kết cấu da khỏe mạnh, săn chắc hơn, tốc độ tăng cường độ đàn hồi cho da nhanh hơn.', 'Water, Butylene Glycol, Glycerin, Caprylic/Capric Triglyceride, Cetyl Ethylhexanoate, Butylene Glycol Dicaprylate/Dicaprate, Cyclopentasiloxane, Polyglyceryl-3 Methylglucose Distearate, Glyceryl Stearate, Cyclohexasiloxane, Ceratonia Siliqua (Carob) Fruit Extract, Dipalmitoyl Hydroxyproline, Achillea Millefolium Extract, Copper Tripeptide-1, Polymethyl Methacrylate', 'Laneige', 'Kem dưỡng da', 'kemduongda.jpg'),
('opXvQBOY370', 'Sữa Tắm HATOMUGI Dưỡng Sáng Da', 'Một làn da cơ thể sáng mịn màng, mượt mà và rạng rỡ luôn là ước mơ của bất kì cô gái nào. Thế nhưng nếu đã thử nhiều sản phẩm mà da cơ thể vẫn xỉn màu, sạm đen thì phải làm sao? Đừng lo vì đã có sữa tắm HATOMUGI Moisturizing & Washing đến từ Nhật Bản với thành phần chiết xuất hạt ý dĩ giàu dưỡng chất, không chỉ giúp làm sạch da mà còn nuôi dưỡng cho làn da sáng mịn dần đều từ bên trong. Sữa tắm HATOMUGI Moisturizing & Washing là sản phẩm thường xuyên lọt vào top sữa tắm được yêu thích của các tạp chí làm đẹp hàng đầu tại Nhật, được săn lùng không chỉ ở nước sở tại mà còn lan rộng ra khắp các nước ở khu vực châu Á nhờ độ dưỡng ẩm tốt và khả năng dưỡng sáng da hiệu quả.', '- Chiết xuất từ hạt Coix chứa nhiều axit béo như: axit linoleic, axit palmitic, axit stearic, axit cis-8-oc-tadecenoic,…\r\n\r\n- Vitamin B1, B12 và và vitamin E', 'HATOMUGI', 'Sữa tắm', 'suatamm.jpg'),
('qckKPtrDZyJ', 'Kem Dưỡng La Roche-Posay Làm Dịu, Hỗ Trợ Phục Hồi Da', 'Kem Dưỡng La Roche-Posay Cicaplast Baume B5 Soothing Repairing Balm là sản phẩm kem dưỡng dành cho da nhạy cảm đến từ thương hiệu La Roche-Posay, giúp dưỡng ẩm và làm dịu tình trạng da kích ứng, tổn thương, hỗ trợ phục hồi làn da. Sản phẩm được khuyên dùng sau các liệu trình điều trị thẩm mỹ & kích ứng da nhẹ ở người lớn, trẻ em và trẻ sơ sinh.', 'Aqua/Water, Hydrogenated Polyisobutene, Dimethicone, Glycerin, Butyrospermum Parkii Butter/Shea Butter, Panthenol, Butylene Glycol, Aluminum Starch Octenylsuccinate, Propanediol, Cetyl Pef/PPG-10/1 Dimethicone, Tristearin, Zinc Gluconate, Madecassoside, Manganese Gluconate, Magnesium Sulfate, Disodium Edta, Copper Gluconate, Acetylated Glycol Stearate, Polyglyceryl-4 Isostearate, Sodium Benzonate, Phenoxyethanol, Chlorhexidine Digluconate, CI 77891 / Titanium Dioxide.', 'La Roche-Posay', 'Kem dưỡng da', 'duongda.jpg'),
('ZoenFn99fQO', 'Sữa Tắm Và Gội Cetaphil 2 Trong 1 Dịu Nhẹ', 'Chọn sữa tắm và dầu gội cho con là câu chuyện khá đau đầu của nhiều bà mẹ bỉm sữa, bởi lẽ, da trẻ sơ sinh vô cùng nhạy cảm và có thể phản ứng với bất kỳ loại hóa mỹ phẩm nào, dù đó là sản phẩm được sản xuất dành riêng cho bé. Hãy để Sữa Tắm Gội Dịu Nhẹ Cho Bé Baby Gentle Wash & Shampoo của Cetaphil giúp bạn bớt lo toan vấn đề này. Đây là sản phẩm được chọn lọc kỹ lưỡng từ các thành phần tự nhiên phù hợp cho làn da trẻ từ độ tuổi sơ sinh trở lên, không chứa hóa chất nên hoàn toàn không gây kích ứng cho mọi làn da, kể ca da nhạy cảm. Sản phẩm không những làm sạch bụi bẩn mà còn có tính kháng khuẩn tốt giúp da bé giảm dần sự ngứa ngáy, vết hăm, sảy, mẩn đỏ do vi khuẩn tấn công..', 'Water, Sodium Laureth Sulfate, cocamidopropyl Betaine, Disodium Laureth Sulfosuccinate, Glycerin, Panthenol, PEG-120 Methyl Glucose Dioleate, Glycol distearat, Hydrolyzed Wheat Protein, Calendula Officinalis Flower Extract, Aloe Barbadensis Leaf Juice bột, Fragrance, Citric Acid, natri benzoat, Phenoxyethanol, citrat natri, Laureth-4, Heliotropine, Polyquaternium-10, natri clorua, natri hydroxit, Tocopherol', 'CETAPHIL', 'Sữa tắm', 'suatam.jpg'),
('ztc996Iu5zb', 'Sữa Rửa Mặt Cetaphil Dịu Nhẹ', 'Sữa Rửa Mặt Dịu Nhẹ Cho Mọi Loại Da Cetaphil Gentle Skin Cleanser là sản phẩm đến từ thương hiệu Cetaphil của Canada,thuộc công ty dược nổi tiếng Galderma Laboratories với mạng lưới phân phối rộng khắp thế giới, được các chuyên gia da liễu bào chế với thành phần giúp da mềm mại hoàn toàn không gây kích ứng với cả những làn da nhạy cảm.', 'Water, Cetyl Alcohol, Propylene Glycol, Sodium Lauryl Sulfate, Stearyl Alcohol, Methylparaben, Propylparaben, Butylparaben.', 'CETAPHIL', 'Chăm sóc mặt ', 'suaruamat.jpg');

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
('-BmGlCUpqhm', 250, 260000, 'ml', 49),
('-DIn2XuJ-0o', 500, 300000, 'ml', 99),
('J49e-qD5u5Z', 140, 126000, 'ml', 19),
('KNOqVtcjvKU', 125, 120000, 'ml', 50),
('neCtoSG_Zef', 230, 145000, 'ml', 100),
('NfYgthXUpRR', 50, 400000, 'ml', 0),
('UNmDeajPJhd', 50, 1360000, 'ml', 38),
('utEddx_Zk53', 800, 150000, 'ml', 496),
('wd8TETLHVFd', 40, 250000, 'ml', 49),
('yF09wSxGHUw', 60, 420000, 'ml', 199),
('YjT0w81Z3QV', 500, 400000, 'ml', 118);

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
('EapqJ8D3oL0', 'ZoenFn99fQO', '-DIn2XuJ-0o'),
('h4-0a6Myekm', 'ztc996Iu5zb', 'YjT0w81Z3QV'),
('JTizanwEyUv', 'ZoenFn99fQO', 'neCtoSG_Zef'),
('prD9sJn_icH', 'opXvQBOY370', 'utEddx_Zk53'),
('sXWaJVAyEfv', 'ztc996Iu5zb', 'KNOqVtcjvKU'),
('T6-6g_DCWQe', 'ztc996Iu5zb', '-BmGlCUpqhm'),
('uDdsKLCSgts', 'ikfbaiO9dXX', 'UNmDeajPJhd'),
('us4yYZfAHqp', 'qckKPtrDZyJ', 'wd8TETLHVFd'),
('vifLW1TNfzc', '928rnJStvXk', 'yF09wSxGHUw'),
('YT5ELF1lw-2', 'gIMeLBvFZOh', 'NfYgthXUpRR'),
('_dWtBquWyLm', 'AJX-I2wnNMF', 'J49e-qD5u5Z');

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
(14, 'T6-6g_DCWQe', '2021-12-27', '2021-03-01', 50, 260000, '2021-03-27 09:53:51', NULL),
(16, 'sXWaJVAyEfv', '2021-06-28', '2020-12-28', 50, 120000, '2021-03-27 10:16:40', NULL),
(17, 'uDdsKLCSgts', '2021-08-26', '2021-02-02', 40, 1360000, '2021-03-27 10:18:09', '2021-03-27 10:21:30'),
(18, '_dWtBquWyLm', '2021-12-30', '2021-03-01', 20, 126000, '2021-03-27 10:19:46', NULL),
(19, 'EapqJ8D3oL0', '2022-01-01', '2021-01-01', 100, 300000, '2021-03-27 10:21:02', NULL),
(20, 'h4-0a6Myekm', '2022-01-13', '2021-01-13', 120, 400000, '2021-03-27 10:22:29', NULL),
(21, 'JTizanwEyUv', '2021-11-03', '2021-03-01', 100, 145000, '2021-03-27 10:24:05', NULL),
(22, 'vifLW1TNfzc', '2021-12-01', '2021-02-01', 200, 420000, '2021-03-27 10:25:03', NULL),
(23, 'us4yYZfAHqp', '2022-01-01', '2021-01-01', 50, 250000, '2021-03-27 10:25:41', NULL),
(24, 'prD9sJn_icH', '2022-03-10', '2021-03-10', 500, 150000, '2021-03-27 10:26:36', NULL);

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
(13, 850000, 0, '2021-03-27 10:29:37', NULL),
(14, 1660000, 6, '2021-03-27 10:30:27', NULL),
(15, 676000, 1, '2021-03-27 10:38:16', NULL),
(16, 2030000, 2, '2021-03-27 10:38:59', NULL),
(17, 1100000, 3, '2021-03-27 10:40:25', NULL);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT cho bảng `account`
--
ALTER TABLE `account`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT cho bảng `product_package`
--
ALTER TABLE `product_package`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT cho bảng `transaction`
--
ALTER TABLE `transaction`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
