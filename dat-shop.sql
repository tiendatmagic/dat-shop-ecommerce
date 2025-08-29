-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 29, 2025 at 03:30 PM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+07:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dat-shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txhash` varchar(70) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `payment`, `txhash`, `status`, `name`, `email`, `phone`, `address`, `note`, `created_at`, `updated_at`) VALUES
('1c2a0cc3-6c20-44d9-bf2d-4212df0d5aca', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'cash', NULL, 'pending', 'Đạt Mg', 'tiendatmagic8@yopmail.com', '1234567890', 'Nha Trang', NULL, '2025-08-28 22:47:13', '2025-08-28 22:47:13'),
('1e769b46-9ca5-4cc1-9b29-40779e0a8181', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'usdt', '0x44ed52b93ca583894f66848d9b0f72dbf637459325a8dff6da9f796a9194bb62', 'pending', NULL, NULL, NULL, NULL, NULL, '2025-08-28 21:27:44', '2025-08-28 21:27:44'),
('1f8b4b0b-596d-4b21-82c2-362f4526b61c', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'cash', NULL, 'pending', 'Đạt Mg', 'tiendatmagic8@yopmail.com', '1234567890', 'Nha Trang', NULL, '2025-08-28 22:45:01', '2025-08-28 22:45:01'),
('3314c387-5199-492d-b82d-fac64688058e', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'cash', NULL, 'pending', 'Đạt Mg', 'tiendatmagic8@yopmail.com', '1234567890', 'Nha Trang', NULL, '2025-08-28 23:13:09', '2025-08-28 23:13:09'),
('367b5a7f-2248-4239-84a7-c7e3166f2ae9', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'usdt', '0xcb7441269f92426d999c56c539772b2bdd68df49675ae298b7f4eb5ba3ca8eb4', 'pending', 'Đạt Mg', 'tiendatmagic8@yopmail.com', '1234567890', 'Nha Trang', NULL, '2025-08-28 21:31:52', '2025-08-28 21:31:52'),
('55af48a4-a5a8-4f16-944c-d68b3b98ee0e', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'usdt', '0xf8b161a09a1857beea6f41e63cb4ae6160efa89ca9f4d0ef8f0c5277d74adb3c', 'pending', NULL, NULL, NULL, NULL, NULL, '2025-08-28 12:53:00', '2025-08-28 12:53:00'),
('8bd0d101-5f38-4e31-8f49-80afa379c935', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'usdt', '0xcf77c0ea1d4916d4bad6a3d54d8c786e1d3724d7b295b6ecfa3ae73dac9d2c70', 'pending', 'Đạt Mg', 'tiendatmagic8@yopmail.com', '1234567890', 'Nha Trang', NULL, '2025-08-29 07:18:34', '2025-08-29 07:18:34'),
('a956e297-cdbf-40e0-969c-e9203ca16729', 'e0f8acd1-b5a9-4516-a12c-739e4728b0fe', 'usdt', '0xa223d6de37ed85d994c633e643bb29813dfd027f0f3a7cb0a5c629cd79d731e4', 'pending', 'User63361', 'tiendatmagic9@yopmail.com', '123456789876', '123', NULL, '2025-08-29 08:01:50', '2025-08-29 08:01:50'),
('ad87d71a-d68d-4237-9613-f7b588c8e4d7', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'usdt', '0xea21a2438d45aadac03c535bd33fd85e1a2baa52da7ac7f368d17441a17b6d2b', 'pending', NULL, NULL, NULL, NULL, NULL, '2025-08-28 03:21:38', '2025-08-28 03:21:38'),
('ba11f4c3-f663-45f6-9546-96e95cdd27a9', '8e8fea86-fe33-4910-8d28-6ef614286d25', 'cash', NULL, 'pending', NULL, NULL, NULL, NULL, NULL, '2025-08-28 21:26:19', '2025-08-28 21:26:19');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` char(36) COLLATE utf8mb4_unicode_ci NOT NULL,
  `size` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` bigint NOT NULL,
  `price` bigint NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `size`, `quantity`, `price`, `created_at`, `updated_at`) VALUES
('0958b234-0938-40dd-a737-31070b45cb21', 'a956e297-cdbf-40e0-969c-e9203ca16729', '1', 'XL', 1, 1, '2025-08-29 08:01:50', '2025-08-29 08:01:50'),
('1e19815c-25ab-4039-930e-3f8726f5a05e', '1f8b4b0b-596d-4b21-82c2-362f4526b61c', '1', 'XXL', 1, 1, '2025-08-28 22:45:01', '2025-08-28 22:45:01'),
('2621c16b-6ce0-450c-882f-2a34ade9d959', '1c2a0cc3-6c20-44d9-bf2d-4212df0d5aca', '2', 'L', 1, 50, '2025-08-28 22:47:13', '2025-08-28 22:47:13'),
('4e92c626-3243-4dac-8e15-79d3b111d340', '1f8b4b0b-596d-4b21-82c2-362f4526b61c', '1', 'XXL', 1, 1, '2025-08-28 22:45:01', '2025-08-28 22:45:01'),
('538e1461-9954-4e7f-a5df-e98daafeb873', '1e769b46-9ca5-4cc1-9b29-40779e0a8181', '1', 'XXL', 1, 1, '2025-08-28 21:27:44', '2025-08-28 21:27:44'),
('54aa8227-826f-4800-8b5d-ff800d97ca05', '1c2a0cc3-6c20-44d9-bf2d-4212df0d5aca', '1', 'XXL', 1, 1, '2025-08-28 22:47:13', '2025-08-28 22:47:13'),
('554a759b-fea3-49bd-afb0-b196ed571d8a', '3314c387-5199-492d-b82d-fac64688058e', '1', 'XXL', 1, 1, '2025-08-28 23:13:09', '2025-08-28 23:13:09'),
('5e7f164e-4404-4d44-a851-f57e63a99cd7', '367b5a7f-2248-4239-84a7-c7e3166f2ae9', '1', 'XXL', 1, 1, '2025-08-28 21:31:52', '2025-08-28 21:31:52'),
('60056de0-3430-4bde-a667-60e7f8f76a87', 'ba11f4c3-f663-45f6-9546-96e95cdd27a9', '1', 'XXL', 1, 1, '2025-08-28 21:26:19', '2025-08-28 21:26:19'),
('7009e2d6-6777-463f-8d34-f4c6fb9c7e32', 'a956e297-cdbf-40e0-969c-e9203ca16729', '1', 'XXL', 1, 1, '2025-08-29 08:01:50', '2025-08-29 08:01:50'),
('8d126d04-02aa-4372-8a7d-76b630563de1', 'ad87d71a-d68d-4237-9613-f7b588c8e4d7', '1', 'XXL', 1, 1, '2025-08-28 03:21:39', '2025-08-28 03:21:39'),
('99428a96-8f40-4e75-a171-f24ca0f71813', '55af48a4-a5a8-4f16-944c-d68b3b98ee0e', '1', 'XXL', 1, 1, '2025-08-28 12:53:00', '2025-08-28 12:53:00'),
('c33ab377-79de-427f-9414-75cdd921d745', '3314c387-5199-492d-b82d-fac64688058e', '3', 'L', 3, 30, '2025-08-28 23:13:09', '2025-08-28 23:13:09'),
('dda2b3c1-933d-4d10-bed0-fb63163da98d', '1f8b4b0b-596d-4b21-82c2-362f4526b61c', '2', 'L', 1, 50, '2025-08-28 22:45:01', '2025-08-28 22:45:01'),
('ef3b376f-6d3b-4ce7-8fb1-64dbbf59d2b8', '8bd0d101-5f38-4e31-8f49-80afa379c935', '1', 'XXL', 1, 1, '2025-08-29 07:18:34', '2025-08-29 07:18:34');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` json NOT NULL,
  `size` json NOT NULL,
  `category` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_best_seller` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `image`, `size`, `category`, `is_best_seller`, `created_at`, `updated_at`) VALUES
(1, 'Football Jersey', 1.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063577/b1devpuovnvqwdo8pfia.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063577/o7kcxzpkbvobb05iu949.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063577/iwopzvmpc5olrt7anheh.jpg\"]', '[\"S\", \"M\", \"XL\", \"XXL\"]', 'men', 1, NULL, NULL),
(2, 'Hampton Long Sleeve Shirt', 50.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063302/wowbtd0tlj6tpfxvkxcg.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063302/kjfejg6lvpqwib89qwfy.jpg\"]', '[\"S\", \"M\", \"L\"]', 'men', 0, NULL, NULL),
(3, 'Cropped Fit Graphic T-Shirt', 30.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063623/gnttim2dl0vxljmpejlu.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063623/fwtx0axdz5iowwgarff7.jpg\"]', '[\"S\", \"M\", \"XL\", \"XXL\", \"L\"]', 'men', 0, NULL, NULL),
(4, 'Easy Short', 25.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063667/qudc6bwwlvnzfsgmx2ah.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063667/ocu1bqsqtipqrk1dt61i.jpg\"]', '[\"S\", \"M\", \"L\"]', 'men', 0, NULL, NULL),
(5, 'Alina Shirred Halter Top', 35.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063762/ggjerydhpsewxvm8kbyd.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063762/jqoik9izii3hv5j2z2b4.jpg\"]', '[\"S\", \"M\", \"L\", \"XL\"]', 'women', 1, NULL, NULL),
(6, 'Mikki Drop Hem Mini Dress', 60.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063815/hbrtbquoemjpaghclydx.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063815/hk4ofjpoxe8ocrfvagkz.jpg\"]', '[\"S\", \"M\", \"L\", \"XL\"]', 'women', 1, NULL, NULL),
(7, 'Haven Wide Leg Pant', 30.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063885/cnffks7xikrhgjan9zil.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753063885/e6xpjggzveoxjospfxos.jpg\"]', '[\"S\", \"M\", \"L\", \"XL\"]', 'women', 0, NULL, NULL),
(8, 'Kaia Faux Leather Bomber', 109.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753064020/zc0xgahhdyl4jttwci2e.jpg\", \"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753064020/mwzlfoxgfofmncknwecv.jpg\"]', '[\"S\", \"M\", \"L\", \"XL\", \"XXL\"]', 'women', 1, NULL, NULL),
(9, 'Sammy Oversize Hoodie', 34.00, '[\"https://res.cloudinary.com/dfyykwzsa/image/upload/v1753064102/ri8zbzu6eq3z2ajkrwff.jpg\"]', '[\"S\", \"M\", \"L\"]', 'kids', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(20,5) NOT NULL DEFAULT '0.00000',
  `is_admin` tinyint(1) NOT NULL DEFAULT '0',
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `full_name`, `phone`, `address`, `email`, `email_verified_at`, `password`, `amount`, `is_admin`, `remember_token`, `created_at`, `updated_at`) VALUES
('23726979-b7d3-4a13-b797-7297f89094b6', 'User12288', 'User47075', NULL, NULL, 'tiendatmagic88888@yopmail.com', NULL, '$2y$12$BXSTU1gc3kPNN.kPuYItq.LvLudUcxtHCO8daOcwvUWb2CXVZBEMa', 0.00000, 0, NULL, '2025-08-29 07:53:38', '2025-08-29 07:53:38'),
('32b0a01f-bb67-4269-a60b-ec1b8df37521', 'User16398', 'User91815', NULL, NULL, 'tiendatmagic888@yopmail.com', NULL, '$2y$12$B/VHCD7C7ghHJvm910rLkuJf/R7tpUhEDcOAt3X6kvR17MbNEcPWy', 0.00000, 0, NULL, '2025-08-29 07:50:00', '2025-08-29 07:50:00'),
('7b973397-c4a4-4166-824f-0bffcd06945f', 'User02545', 'User63714', NULL, NULL, 'tiendatmagic88@yopmail.com', NULL, '$2y$12$K1Q95Ya1gQZD2p93kuif6uXyqPJB7irORrdf3xxS5eLfpNM0NJlIa', 0.00000, 0, NULL, '2025-08-29 07:47:07', '2025-08-29 07:47:07'),
('8e8fea86-fe33-4910-8d28-6ef614286d25', 'User82210', 'Đạt Mg', '1234567890', 'Nha Trang', 'tiendatmagic8@yopmail.com', NULL, '$2y$12$I/UGVtopHukSw7BHdk1AbOgK/70SfTarknv1bGLRb/vcZhzoO3iby', 0.00000, 0, NULL, '2025-08-24 10:00:57', '2025-08-29 01:05:08'),
('e0f8acd1-b5a9-4516-a12c-739e4728b0fe', 'User73407', 'User63361', '123456789876', '123', 'tiendatmagic9@yopmail.com', NULL, '$2y$12$kDcqueX0nC0GmKvezB4xnePsAL0UFq5ejyfjOIyhg4wKW5TKF2OVm', 0.00000, 0, NULL, '2025-08-29 07:43:15', '2025-08-29 08:01:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
