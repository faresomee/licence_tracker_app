-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: Jul 08, 2025 at 02:25 AM
-- Server version: 9.2.0
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `traffic_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE `admin_users` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `img_profile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT (now()),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`id`, `name`, `email`, `password_hash`, `role`, `status`, `img_profile`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'Oliver Weston', 'mohamedo7x@hotmail.com', '$2b$10$4fRXoIfJ43mmnuqullqSreMuOS9/0x2fZTwsgQ8/E.itSjRCwn7qm', 'superadmin', 'active', 'default.png', '2025-07-07 21:03:03', '2023-04-18 15:05:43', '2025-04-06 02:31:14'),
(15, 'TestingB', 'al3l8_11@gmcc.com', '$2b$10$7UD4Luf0CqCLxZm.vhf1KuBSc0Ou4sjvN7hEwMPs7Numv8CfroVjW', 'admin', 'active', 'df663843caa09da57dac.png', NULL, '2025-07-02 14:15:34', '2025-07-02 14:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `AuditLogs`
--

CREATE TABLE `AuditLogs` (
  `id` int NOT NULL,
  `timestamp` timestamp NULL DEFAULT (now()),
  `level` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `message` text NOT NULL,
  `meta` json NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `AuditLogs`
--

INSERT INTO `AuditLogs` (`id`, `timestamp`, `level`, `message`, `meta`, `created_at`) VALUES
(1, '2025-07-05 13:10:05', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:10:05:105\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"45ms\"}', '2025-07-05 13:10:05'),
(2, '2025-07-05 13:11:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:11:38:1138\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"12ms\"}', '2025-07-05 13:11:38'),
(3, '2025-07-05 13:14:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:14:38:1438\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"23ms\"}', '2025-07-05 13:14:38'),
(4, '2025-07-05 13:24:55', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 404, \"timestamp\": \"2025-07-05 13:24:55:2455\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"id\": \"1\"}, \"responseTime\": \"7ms\"}', '2025-07-05 13:24:55'),
(5, '2025-07-05 13:25:02', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:25:02:252\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"47ms\"}', '2025-07-05 13:25:02'),
(6, '2025-07-05 13:25:08', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:25:08:258\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"9ms\"}', '2025-07-05 13:25:08'),
(7, '2025-07-05 13:27:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:27:23:2723\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"id\": \"1\"}, \"responseTime\": \"69ms\"}', '2025-07-05 13:27:23'),
(8, '2025-07-05 13:27:32', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:27:32:2732\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"id\": \"2\"}, \"responseTime\": \"7ms\"}', '2025-07-05 13:27:32'),
(9, '2025-07-05 13:27:34', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:27:34:2734\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"id\": \"3\"}, \"responseTime\": \"5ms\"}', '2025-07-05 13:27:34'),
(10, '2025-07-05 13:27:37', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:27:37:2737\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"id\": \"4\"}, \"responseTime\": \"6ms\"}', '2025-07-05 13:27:37'),
(11, '2025-07-05 13:28:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:28:16:2816\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"36ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-05 13:28:16'),
(12, '2025-07-05 13:28:28', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:28:28:2828\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"9ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-05 13:28:28'),
(13, '2025-07-05 13:29:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:29:03:293\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"16ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-05 13:29:03'),
(14, '2025-07-05 13:29:36', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:29:36:2936\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"38ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-05 13:29:36'),
(15, '2025-07-05 13:42:57', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:42:57:4257\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"16ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-05 13:42:57'),
(16, '2025-07-05 13:42:59', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 13:42:59:4259\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"5ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-05 13:42:59'),
(17, '2025-07-05 16:37:40', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 16:37:40:3740\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"67ms\"}', '2025-07-05 16:37:40'),
(18, '2025-07-05 16:47:13', '[32mhttp[39m', '[32mUnauthorized Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/police/logout\", \"stack\": \"UnauthorizedError: Token has expired. Please login again.\\n    at validateJWTToken (/usr/src/app/src/auth/police_user.access.ts:50:13)\\n    at validatePoliceToken (/usr/src/app/src/auth/police_user.access.ts:72:37)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at Route.dispatch (/usr/src/app/node_modules/express/lib/router/route.js:119:3)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at /usr/src/app/node_modules/express/lib/router/index.js:284:15\\n    at Function.process_params (/usr/src/app/node_modules/express/lib/router/index.js:346:12)\\n    at next (/usr/src/app/node_modules/express/lib/router/index.js:280:10)\\n    at Function.handle (/usr/src/app/node_modules/express/lib/router/index.js:175:3)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"UnauthorizedError\", \"errorType\": \"UnauthorizedError\", \"timestamp\": \"2025-07-05 16:47:13:4713\", \"statusCode\": 401, \"requestBody\": {\"password\": \"12x3123\", \"username\": \"mohamedo7x\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-05 16:47:13'),
(19, '2025-07-05 16:47:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-05 16:47:13:4713\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"password\": \"12x3123\", \"username\": \"mohamedo7x\"}, \"responseTime\": \"39ms\"}', '2025-07-05 16:47:14'),
(20, '2025-07-05 16:52:24', '[32mhttp[39m', '[32mUnauthorized Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/police/generate-otp/password\", \"stack\": \"UnauthorizedError: Token has expired. Please login again.\\n    at validateJWTToken (/usr/src/app/src/auth/police_user.access.ts:50:13)\\n    at validatePoliceToken (/usr/src/app/src/auth/police_user.access.ts:72:37)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at Route.dispatch (/usr/src/app/node_modules/express/lib/router/route.js:119:3)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at /usr/src/app/node_modules/express/lib/router/index.js:284:15\\n    at Function.process_params (/usr/src/app/node_modules/express/lib/router/index.js:346:12)\\n    at next (/usr/src/app/node_modules/express/lib/router/index.js:280:10)\\n    at Function.handle (/usr/src/app/node_modules/express/lib/router/index.js:175:3)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"UnauthorizedError\", \"errorType\": \"UnauthorizedError\", \"timestamp\": \"2025-07-05 16:52:24:5224\", \"statusCode\": 401, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-05 16:52:24'),
(21, '2025-07-05 16:52:24', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-05 16:52:24:5224\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"8ms\"}', '2025-07-05 16:52:24'),
(22, '2025-07-05 16:52:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 16:52:31:5231\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"67ms\"}', '2025-07-05 16:52:31'),
(23, '2025-07-05 16:52:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 16:52:38:5238\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"8983\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"194ms\"}', '2025-07-05 16:52:38'),
(24, '2025-07-05 16:52:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 16:52:42:5242\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"31ms\"}', '2025-07-05 16:52:42'),
(25, '2025-07-05 19:50:51', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-05 19:50:51:5051\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"8983\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"63ms\"}', '2025-07-05 19:50:51'),
(26, '2025-07-05 19:50:55', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 19:50:55:5055\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"34ms\"}', '2025-07-05 19:50:55'),
(27, '2025-07-05 19:51:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 19:51:03:513\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"5312\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"132ms\"}', '2025-07-05 19:51:03'),
(28, '2025-07-05 19:56:37', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 19:56:37:5637\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"44ms\"}', '2025-07-05 19:56:37'),
(29, '2025-07-05 19:56:50', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 19:56:50:5650\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"1441\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"140ms\"}', '2025-07-05 19:56:50'),
(30, '2025-07-05 19:59:10', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-05 19:59:10:5910\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"1441\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"80ms\"}', '2025-07-05 19:59:10'),
(31, '2025-07-05 19:59:13', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 19:59:13:5913\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"37ms\"}', '2025-07-05 19:59:13'),
(32, '2025-07-05 19:59:21', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 19:59:21:5921\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"8304\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"118ms\"}', '2025-07-05 19:59:21'),
(33, '2025-07-05 20:00:11', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 20:00:11:011\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"48ms\"}', '2025-07-05 20:00:11'),
(34, '2025-07-05 20:00:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 20:00:16:016\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"5443\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"147ms\"}', '2025-07-05 20:00:16'),
(35, '2025-07-05 20:02:11', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 20:02:11:211\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"22ms\", \"requestParams\": {\"id\": \"29503212568912\"}}', '2025-07-05 20:02:11'),
(36, '2025-07-05 20:02:59', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 20:02:59:259\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"5ms\", \"requestParams\": {\"id\": \"29503212568912\"}}', '2025-07-05 20:02:59'),
(37, '2025-07-05 20:07:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 20:07:14:714\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"19ms\", \"requestParams\": {\"id\": \"29503212568912\"}}', '2025-07-05 20:07:14'),
(38, '2025-07-05 20:07:19', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 20:07:19:719\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"6ms\", \"requestParams\": {\"id\": \"29503212568912\"}}', '2025-07-05 20:07:19'),
(39, '2025-07-05 20:07:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 20:07:30:730\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"41ms\"}', '2025-07-05 20:07:30'),
(40, '2025-07-05 20:07:34', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 20:07:34:734\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"2151\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"152ms\"}', '2025-07-05 20:07:34'),
(41, '2025-07-05 20:07:45', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 404, \"timestamp\": \"2025-07-05 20:07:45:745\", \"userAgent\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36\", \"responseTime\": \"3ms\"}', '2025-07-05 20:07:45'),
(42, '2025-07-05 23:28:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:28:42:2842\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"77ms\", \"requestParams\": {\"id\": \"BF35WOKTLA\"}}', '2025-07-05 23:28:42'),
(43, '2025-07-05 23:35:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:35:44:3544\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"10ms\"}', '2025-07-05 23:35:44'),
(44, '2025-07-05 23:36:43', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:36:43:3643\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"11ms\"}', '2025-07-05 23:36:43'),
(45, '2025-07-05 23:37:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:37:16:3716\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"36ms\"}', '2025-07-05 23:37:16'),
(46, '2025-07-05 23:37:41', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:37:41:3741\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"10ms\"}', '2025-07-05 23:37:41'),
(47, '2025-07-05 23:38:35', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:38:35:3835\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"11ms\"}', '2025-07-05 23:38:35'),
(48, '2025-07-05 23:40:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 23:40:14:4014\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"36ms\"}', '2025-07-05 23:40:14'),
(49, '2025-07-05 23:40:20', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-05 23:40:20:4020\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"9861\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"172ms\"}', '2025-07-05 23:40:20'),
(50, '2025-07-05 23:40:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:40:44:4044\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"6ms\"}', '2025-07-05 23:40:44'),
(51, '2025-07-05 23:41:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:41:31:4131\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"6ms\"}', '2025-07-05 23:41:31'),
(52, '2025-07-05 23:42:20', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/violation\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-05 23:42:20:4220\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"paied\", \"location\": \"Zagazig\", \"description\": \"تسجيل مخالفه بحيث ان الشخص تجاوز السرعه المسموحة في منطقه ممنوع السير بسرعه اكثر من 30\", \"action_taken\": \"4\", \"vehicle_plate\": \"CA05LKO\", \"violation_type\": \"1\"}, \"responseTime\": \"52ms\"}', '2025-07-05 23:42:20'),
(53, '2025-07-05 23:42:22', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:42:22:4222\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"7ms\"}', '2025-07-05 23:42:22'),
(54, '2025-07-05 23:45:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:45:23:4523\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"48ms\"}', '2025-07-05 23:45:23'),
(55, '2025-07-05 23:45:51', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:45:51:4551\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"30ms\"}', '2025-07-05 23:45:51'),
(56, '2025-07-05 23:46:48', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-05 23:46:48:4648\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"18ms\"}', '2025-07-05 23:46:48'),
(57, '2025-07-06 00:06:33', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 00:06:33:633\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"51ms\"}', '2025-07-06 00:06:33'),
(58, '2025-07-06 00:16:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 00:16:03:163\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"62ms\"}', '2025-07-06 00:16:03'),
(59, '2025-07-06 00:16:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 00:16:14:1614\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"5952\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"153ms\"}', '2025-07-06 00:16:14'),
(60, '2025-07-06 00:21:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-06 00:21:58:2158\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"5952\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"70ms\"}', '2025-07-06 00:21:58'),
(61, '2025-07-06 00:25:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 00:25:58:2558\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"22ms\"}', '2025-07-06 00:25:58'),
(62, '2025-07-06 00:26:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-06 00:26:01:261\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"5952\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"64ms\"}', '2025-07-06 00:26:01'),
(63, '2025-07-06 00:26:08', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 00:26:08:268\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"3644\", \"password\": \"123123\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"160ms\"}', '2025-07-06 00:26:08'),
(64, '2025-07-06 00:26:20', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 00:26:20:2620\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"phone_number\": \"0569876543\"}, \"responseTime\": \"38ms\"}', '2025-07-06 00:26:20'),
(65, '2025-07-06 00:26:48', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-06 00:26:48:2648\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"sms_otp\": \"1581\", \"password\": \"1231223\", \"username\": \"mohamedo7x\", \"phone_number\": \"0569876543\"}, \"responseTime\": \"76ms\"}', '2025-07-06 00:26:48'),
(66, '2025-07-06 01:12:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-06 01:12:18:1218\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"5ms\"}', '2025-07-06 01:12:18'),
(67, '2025-07-06 01:12:24', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/police\", \"user\": \"أحمد سامي عبد الرحمن\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-06 01:12:24:1224\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"29ms\"}', '2025-07-06 01:12:24'),
(68, '2025-07-06 01:43:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 01:43:18:4318\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"@\"}, \"responseTime\": \"28ms\"}', '2025-07-06 01:43:18'),
(69, '2025-07-06 01:43:46', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 01:43:46:4346\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"@\"}, \"responseTime\": \"22ms\"}', '2025-07-06 01:43:46'),
(70, '2025-07-06 01:44:06', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 01:44:06:446\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"@\"}, \"responseTime\": \"22ms\"}', '2025-07-06 01:44:06'),
(71, '2025-07-06 01:44:53', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/register\", \"stack\": \"ValidationError: National ID is required., National ID must be exactly 14 digits., National ID must contain only numbers., Email is required., Invalid email address., Password is required., Password must be between 5 and 20 characters.\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-06 01:44:53:4453\", \"statusCode\": 400, \"requestBody\": {\"email\": \"@\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-06 01:44:53'),
(72, '2025-07-06 01:44:53', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-06 01:44:53:4453\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"@\"}, \"responseTime\": \"27ms\"}', '2025-07-06 01:44:53'),
(73, '2025-07-06 01:45:31', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/register\", \"stack\": \"ValidationError: National ID is required., National ID must be exactly 14 digits., National ID must contain only numbers., Email is required., Invalid email address., Password is required., Password must be between 5 and 20 characters.\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-06 01:45:31:4531\", \"statusCode\": 400, \"requestBody\": {\"email\": \"@\", \"password\": \"\", \"national_id\": \"\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-06 01:45:31'),
(74, '2025-07-06 01:45:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-06 01:45:31:4531\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"@\", \"password\": \"\", \"national_id\": \"\"}, \"responseTime\": \"6ms\"}', '2025-07-06 01:45:31'),
(75, '2025-07-06 01:45:47', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/register\", \"stack\": \"ValidationError: Email is required., Invalid email address., Password is required., Password must be between 5 and 20 characters.\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-06 01:45:47:4547\", \"statusCode\": 400, \"requestBody\": {\"email\": \"@\", \"password\": \"\", \"national_id\": \"29503212568912\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-06 01:45:47'),
(76, '2025-07-06 01:45:47', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-06 01:45:47:4547\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"@\", \"password\": \"\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"5ms\"}', '2025-07-06 01:45:47'),
(77, '2025-07-06 01:45:58', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/register\", \"stack\": \"ValidationError: Password is required., Password must be between 5 and 20 characters.\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-06 01:45:58:4558\", \"statusCode\": 400, \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"\", \"national_id\": \"29503212568912\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-06 01:45:58'),
(78, '2025-07-06 01:45:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-06 01:45:58:4558\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"4ms\"}', '2025-07-06 01:45:58'),
(79, '2025-07-06 01:46:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 01:46:01:461\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"7ms\"}', '2025-07-06 01:46:01'),
(80, '2025-07-06 01:47:00', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 01:47:00:470\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"21ms\"}', '2025-07-06 01:47:00'),
(81, '2025-07-06 01:48:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 01:48:23:4823\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"34ms\"}', '2025-07-06 01:48:23'),
(82, '2025-07-06 01:58:49', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-06 01:58:49:5849\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503232568912\"}, \"responseTime\": \"22ms\"}', '2025-07-06 01:58:49'),
(83, '2025-07-06 01:59:06', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 01:59:06:596\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"117ms\"}', '2025-07-06 01:59:06'),
(84, '2025-07-06 01:59:27', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 01:59:27:5927\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29808072548691\"}, \"responseTime\": \"123ms\"}', '2025-07-06 01:59:27'),
(85, '2025-07-06 02:00:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:00:14:014\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29808072548691\"}, \"responseTime\": \"145ms\"}', '2025-07-06 02:00:14'),
(86, '2025-07-06 02:00:19', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:00:19:019\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"94ms\"}', '2025-07-06 02:00:19'),
(87, '2025-07-06 02:01:13', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:01:13:113\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"164ms\"}', '2025-07-06 02:01:13'),
(88, '2025-07-06 02:01:19', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:01:19:119\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29707182759612\"}, \"responseTime\": \"116ms\"}', '2025-07-06 02:01:19'),
(89, '2025-07-06 02:02:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:02:03:23\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29707182759612\"}, \"responseTime\": \"118ms\"}', '2025-07-06 02:02:03'),
(90, '2025-07-06 02:03:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 409, \"timestamp\": \"2025-07-06 02:03:14:314\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29707182759612\"}, \"responseTime\": \"20ms\"}', '2025-07-06 02:03:14'),
(91, '2025-07-06 02:03:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:03:18:318\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29905112578938\"}, \"responseTime\": \"117ms\"}', '2025-07-06 02:03:18'),
(92, '2025-07-06 02:03:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:03:37:337\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29905112578938\"}, \"responseTime\": \"135ms\"}', '2025-07-06 02:03:38'),
(93, '2025-07-06 02:03:43', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:03:43:343\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29802142563984\"}, \"responseTime\": \"121ms\"}', '2025-07-06 02:03:43'),
(94, '2025-07-06 02:04:21', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:04:21:421\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29802142563984\"}, \"responseTime\": \"146ms\"}', '2025-07-06 02:04:21'),
(95, '2025-07-06 02:04:28', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:04:28:428\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29905112578938\"}, \"responseTime\": \"112ms\"}', '2025-07-06 02:04:28'),
(96, '2025-07-06 02:05:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:05:30:530\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29905112578938\"}, \"responseTime\": \"153ms\"}', '2025-07-06 02:05:30'),
(97, '2025-07-06 02:05:37', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:05:37:537\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29707182759612\"}, \"responseTime\": \"120ms\"}', '2025-07-06 02:05:37'),
(98, '2025-07-06 02:05:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 409, \"timestamp\": \"2025-07-06 02:05:44:544\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29707182759612\"}, \"responseTime\": \"8ms\"}', '2025-07-06 02:05:44'),
(99, '2025-07-06 02:06:26', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:06:26:626\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29707182759612\"}, \"responseTime\": \"124ms\"}', '2025-07-06 02:06:26'),
(100, '2025-07-06 02:06:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:06:31:631\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"95ms\"}', '2025-07-06 02:06:31'),
(101, '2025-07-06 02:07:34', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:07:34:734\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"151ms\"}', '2025-07-06 02:07:34'),
(102, '2025-07-06 02:07:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 409, \"timestamp\": \"2025-07-06 02:07:38:738\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29905112578938\"}, \"responseTime\": \"6ms\"}', '2025-07-06 02:07:38'),
(103, '2025-07-06 02:07:47', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 409, \"timestamp\": \"2025-07-06 02:07:47:747\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"6ms\"}', '2025-07-06 02:07:47'),
(104, '2025-07-06 02:10:19', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-06 02:10:19:1019\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"\"}, \"responseTime\": \"5ms\"}', '2025-07-06 02:10:19'),
(105, '2025-07-06 02:10:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-06 02:10:23:1023\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"\"}, \"responseTime\": \"2ms\"}', '2025-07-06 02:10:23'),
(106, '2025-07-06 02:10:32', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/login\", \"stack\": \"ValidationError: Password is required., Password must be between 5 and 20 characters.\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-06 02:10:32:1032\", \"statusCode\": 400, \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-06 02:10:32'),
(107, '2025-07-06 02:10:32', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-06 02:10:32:1032\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"\"}, \"responseTime\": \"20ms\"}', '2025-07-06 02:10:32'),
(108, '2025-07-06 02:14:50', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-06 02:14:50:1450\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\", \"national_id\": \"29503212568912\"}, \"responseTime\": \"137ms\"}', '2025-07-06 02:14:50'),
(109, '2025-07-06 02:30:25', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 02:30:25:3025\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"119ms\"}', '2025-07-06 02:30:25'),
(110, '2025-07-06 02:31:11', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 02:31:11:3111\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"102ms\"}', '2025-07-06 02:31:11'),
(111, '2025-07-06 02:32:35', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 02:32:35:3235\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"93ms\"}', '2025-07-06 02:32:35'),
(112, '2025-07-06 02:32:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-06 02:32:38:3238\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"1223123\"}, \"responseTime\": \"86ms\"}', '2025-07-06 02:32:38');
INSERT INTO `AuditLogs` (`id`, `timestamp`, `level`, `message`, `meta`, `created_at`) VALUES
(113, '2025-07-06 02:32:41', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-06 02:32:41:3241\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"go2go@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"3ms\"}', '2025-07-06 02:32:41'),
(114, '2025-07-06 02:32:51', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-06 02:32:51:3251\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gog2o@x.ts\", \"password\": \"1223123\"}, \"responseTime\": \"4ms\"}', '2025-07-06 02:32:51'),
(115, '2025-07-06 02:32:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-06 02:32:54:3254\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"86ms\"}', '2025-07-06 02:32:54'),
(116, '2025-07-07 00:41:07', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 00:41:07:417\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"120ms\"}', '2025-07-07 00:41:07'),
(117, '2025-07-07 00:42:35', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 00:42:35:4235\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"95ms\"}', '2025-07-07 00:42:35'),
(118, '2025-07-07 00:54:36', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 404, \"timestamp\": \"2025-07-07 00:54:36:5436\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"5ms\"}', '2025-07-07 00:54:36'),
(119, '2025-07-07 00:54:58', '[32mhttp[39m', '[32mUnauthorized Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/veh/11\", \"stack\": \"UnauthorizedError: Authorization header is missing. Please provide a valid token.\\n    at extractJWTToken (/usr/src/app/src/auth/police_user.access.ts:30:11)\\n    at validateUserToken (/usr/src/app/src/auth/user.access.ts:19:34)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at Route.dispatch (/usr/src/app/node_modules/express/lib/router/route.js:119:3)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at /usr/src/app/node_modules/express/lib/router/index.js:284:15\\n    at param (/usr/src/app/node_modules/express/lib/router/index.js:365:14)\\n    at param (/usr/src/app/node_modules/express/lib/router/index.js:376:14)\\n    at Function.process_params (/usr/src/app/node_modules/express/lib/router/index.js:421:3)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"UnauthorizedError\", \"errorType\": \"UnauthorizedError\", \"timestamp\": \"2025-07-07 00:54:58:5458\", \"statusCode\": 401, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 00:54:58'),
(120, '2025-07-07 00:54:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 401, \"timestamp\": \"2025-07-07 00:54:58:5458\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"12ms\"}', '2025-07-07 00:54:58'),
(121, '2025-07-07 00:55:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 00:55:03:553\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"97ms\"}', '2025-07-07 00:55:03'),
(122, '2025-07-07 01:08:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:08:16:816\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"30ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:08:16'),
(123, '2025-07-07 01:10:06', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:10:06:106\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"19ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:10:06'),
(124, '2025-07-07 01:11:13', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:11:13:1113\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"16ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:11:13'),
(125, '2025-07-07 01:12:10', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:12:10:1210\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"5ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:12:10'),
(126, '2025-07-07 01:12:19', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:12:19:1219\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"4ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:12:19'),
(127, '2025-07-07 01:13:00', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:13:00:130\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"3ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:13:00'),
(128, '2025-07-07 01:14:12', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:14:12:1412\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"4ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:14:12'),
(129, '2025-07-07 01:18:13', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:18:13:1813\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"19ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:18:13'),
(130, '2025-07-07 01:38:05', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:38:05:385\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"31ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:38:05'),
(131, '2025-07-07 01:38:36', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:38:36:3836\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"24ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:38:36'),
(132, '2025-07-07 01:39:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:39:54:3954\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"16ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:39:54'),
(133, '2025-07-07 01:40:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 01:40:44:4044\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"16ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 01:40:44'),
(134, '2025-07-07 02:02:48', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:02:48:248\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"24ms\", \"requestParams\": {\"id\": \"CA12XYZ\"}}', '2025-07-07 02:02:48'),
(135, '2025-07-07 02:28:39', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"ValidationError: Name is required., Phone is required., National ID is required., National ID must be exactly 14 digits., National ID must contain only numbers., Address is required., Date is required., Date must be in a valid ISO 8601 format (e.g. YYYY-MM-DD)., Vehicle types are required., Description is required.\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 02:28:39:2839\", \"statusCode\": 400, \"requestBody\": {\"date\": \"\", \"name\": \"\", \"phone\": \"\", \"address\": \"\", \"attachments\": \"\", \"description\": \"\", \"national_id\": \"\", \"vehcile_types\": \"\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:28:39'),
(136, '2025-07-07 02:28:39', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-07 02:28:39:2839\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"\", \"name\": \"\", \"phone\": \"\", \"address\": \"\", \"attachments\": \"\", \"description\": \"\", \"national_id\": \"\", \"vehcile_types\": \"\"}, \"responseTime\": \"65ms\"}', '2025-07-07 02:28:39'),
(137, '2025-07-07 02:30:04', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"MulterError: Unexpected field\\n    at wrappedFileFilter (/usr/src/app/node_modules/multer/index.js:40:19)\\n    at Multipart.<anonymous> (/usr/src/app/node_modules/multer/lib/make-middleware.js:109:7)\\n    at Multipart.emit (node:events:518:28)\\n    at Multipart.emit (node:domain:489:12)\\n    at HeaderParser.cb (/usr/src/app/node_modules/busboy/lib/types/multipart.js:358:14)\\n    at HeaderParser.push (/usr/src/app/node_modules/busboy/lib/types/multipart.js:162:20)\\n    at SBMH.ssCb [as _cb] (/usr/src/app/node_modules/busboy/lib/types/multipart.js:394:37)\\n    at feed (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:219:14)\\n    at SBMH.push (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:104:16)\\n    at Multipart._write (/usr/src/app/node_modules/busboy/lib/types/multipart.js:567:19)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"MulterError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:30:04:304\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:30:04'),
(138, '2025-07-07 02:30:04', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 500, \"timestamp\": \"2025-07-07 02:30:04:304\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"16ms\"}', '2025-07-07 02:30:04'),
(139, '2025-07-07 02:31:29', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"MulterError: Unexpected field\\n    at wrappedFileFilter (/usr/src/app/node_modules/multer/index.js:40:19)\\n    at Multipart.<anonymous> (/usr/src/app/node_modules/multer/lib/make-middleware.js:109:7)\\n    at Multipart.emit (node:events:518:28)\\n    at Multipart.emit (node:domain:489:12)\\n    at HeaderParser.cb (/usr/src/app/node_modules/busboy/lib/types/multipart.js:358:14)\\n    at HeaderParser.push (/usr/src/app/node_modules/busboy/lib/types/multipart.js:162:20)\\n    at SBMH.ssCb [as _cb] (/usr/src/app/node_modules/busboy/lib/types/multipart.js:394:37)\\n    at feed (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:219:14)\\n    at SBMH.push (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:104:16)\\n    at Multipart._write (/usr/src/app/node_modules/busboy/lib/types/multipart.js:567:19)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"MulterError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:31:29:3129\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:31:29'),
(140, '2025-07-07 02:31:29', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 500, \"timestamp\": \"2025-07-07 02:31:29:3129\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"35ms\"}', '2025-07-07 02:31:29'),
(141, '2025-07-07 02:31:41', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"MulterError: Unexpected field\\n    at wrappedFileFilter (/usr/src/app/node_modules/multer/index.js:40:19)\\n    at Multipart.<anonymous> (/usr/src/app/node_modules/multer/lib/make-middleware.js:109:7)\\n    at Multipart.emit (node:events:518:28)\\n    at Multipart.emit (node:domain:489:12)\\n    at HeaderParser.cb (/usr/src/app/node_modules/busboy/lib/types/multipart.js:358:14)\\n    at HeaderParser.push (/usr/src/app/node_modules/busboy/lib/types/multipart.js:162:20)\\n    at SBMH.ssCb [as _cb] (/usr/src/app/node_modules/busboy/lib/types/multipart.js:394:37)\\n    at feed (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:248:10)\\n    at SBMH.push (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:104:16)\\n    at Multipart._write (/usr/src/app/node_modules/busboy/lib/types/multipart.js:567:19)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"MulterError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:31:41:3141\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:31:41'),
(142, '2025-07-07 02:31:41', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 500, \"timestamp\": \"2025-07-07 02:31:41:3141\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"5ms\"}', '2025-07-07 02:31:41'),
(143, '2025-07-07 02:32:01', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"ValidationError: Date must be in a valid ISO 8601 format (e.g. YYYY-MM-DD).\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 02:32:01:321\", \"statusCode\": 400, \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:32:01'),
(144, '2025-07-07 02:32:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-07 02:32:01:321\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-14-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"21ms\"}', '2025-07-07 02:32:01'),
(145, '2025-07-07 02:32:13', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"ValidationError: Date must be in a valid ISO 8601 format (e.g. YYYY-MM-DD).\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 02:32:13:3213\", \"statusCode\": 400, \"requestBody\": {\"date\": \"\'2003-14-05\'\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:32:13'),
(146, '2025-07-07 02:32:13', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-07 02:32:13:3213\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"\'2003-14-05\'\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"5ms\"}', '2025-07-07 02:32:13'),
(147, '2025-07-07 02:32:45', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:32:45:3245\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"3ms\"}', '2025-07-07 02:32:45'),
(148, '2025-07-07 02:32:49', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"MulterError: Unexpected field\\n    at wrappedFileFilter (/usr/src/app/node_modules/multer/index.js:40:19)\\n    at Multipart.<anonymous> (/usr/src/app/node_modules/multer/lib/make-middleware.js:109:7)\\n    at Multipart.emit (node:events:518:28)\\n    at Multipart.emit (node:domain:489:12)\\n    at HeaderParser.cb (/usr/src/app/node_modules/busboy/lib/types/multipart.js:358:14)\\n    at HeaderParser.push (/usr/src/app/node_modules/busboy/lib/types/multipart.js:162:20)\\n    at SBMH.ssCb [as _cb] (/usr/src/app/node_modules/busboy/lib/types/multipart.js:394:37)\\n    at feed (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:200:10)\\n    at SBMH.push (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:104:16)\\n    at Multipart._write (/usr/src/app/node_modules/busboy/lib/types/multipart.js:567:19)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"MulterError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:32:49:3249\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:32:49'),
(149, '2025-07-07 02:32:49', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 500, \"timestamp\": \"2025-07-07 02:32:49:3249\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"6ms\"}', '2025-07-07 02:32:49'),
(150, '2025-07-07 02:35:41', '[32mhttp[39m', '[32mUnauthorized Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"UnauthorizedError: Authorization header is missing. Please provide a valid token.\\n    at extractJWTToken (/usr/src/app/src/auth/police_user.access.ts:30:11)\\n    at validateUserToken (/usr/src/app/src/auth/user.access.ts:19:34)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at Route.dispatch (/usr/src/app/node_modules/express/lib/router/route.js:119:3)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at /usr/src/app/node_modules/express/lib/router/index.js:284:15\\n    at Function.process_params (/usr/src/app/node_modules/express/lib/router/index.js:346:12)\\n    at next (/usr/src/app/node_modules/express/lib/router/index.js:280:10)\\n    at Function.handle (/usr/src/app/node_modules/express/lib/router/index.js:175:3)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"UnauthorizedError\", \"errorType\": \"UnauthorizedError\", \"timestamp\": \"2025-07-07 02:35:41:3541\", \"statusCode\": 401, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:35:41'),
(151, '2025-07-07 02:35:41', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 02:35:41:3541\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"16ms\"}', '2025-07-07 02:35:41'),
(152, '2025-07-07 02:35:51', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:35:51:3551\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"102ms\"}', '2025-07-07 02:35:51'),
(153, '2025-07-07 02:35:54', '[32mhttp[39m', '[32mUnauthorized Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"UnauthorizedError: Authorization header is missing. Please provide a valid token.\\n    at extractJWTToken (/usr/src/app/src/auth/police_user.access.ts:30:11)\\n    at validateUserToken (/usr/src/app/src/auth/user.access.ts:19:34)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at Route.dispatch (/usr/src/app/node_modules/express/lib/router/route.js:119:3)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at /usr/src/app/node_modules/express/lib/router/index.js:284:15\\n    at Function.process_params (/usr/src/app/node_modules/express/lib/router/index.js:346:12)\\n    at next (/usr/src/app/node_modules/express/lib/router/index.js:280:10)\\n    at Function.handle (/usr/src/app/node_modules/express/lib/router/index.js:175:3)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"UnauthorizedError\", \"errorType\": \"UnauthorizedError\", \"timestamp\": \"2025-07-07 02:35:54:3554\", \"statusCode\": 401, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:35:54'),
(154, '2025-07-07 02:35:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 02:35:54:3554\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"2ms\"}', '2025-07-07 02:35:54'),
(155, '2025-07-07 02:36:05', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"MulterError: Unexpected field\\n    at wrappedFileFilter (/usr/src/app/node_modules/multer/index.js:40:19)\\n    at Multipart.<anonymous> (/usr/src/app/node_modules/multer/lib/make-middleware.js:109:7)\\n    at Multipart.emit (node:events:518:28)\\n    at Multipart.emit (node:domain:489:12)\\n    at HeaderParser.cb (/usr/src/app/node_modules/busboy/lib/types/multipart.js:358:14)\\n    at HeaderParser.push (/usr/src/app/node_modules/busboy/lib/types/multipart.js:162:20)\\n    at SBMH.ssCb [as _cb] (/usr/src/app/node_modules/busboy/lib/types/multipart.js:394:37)\\n    at feed (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:200:10)\\n    at SBMH.push (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:104:16)\\n    at Multipart._write (/usr/src/app/node_modules/busboy/lib/types/multipart.js:567:19)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"MulterError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:36:05:365\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:36:05'),
(156, '2025-07-07 02:36:05', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 500, \"timestamp\": \"2025-07-07 02:36:05:365\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"14ms\"}', '2025-07-07 02:36:05'),
(157, '2025-07-07 02:37:10', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"MulterError: Unexpected field\\n    at wrappedFileFilter (/usr/src/app/node_modules/multer/index.js:40:19)\\n    at Multipart.<anonymous> (/usr/src/app/node_modules/multer/lib/make-middleware.js:109:7)\\n    at Multipart.emit (node:events:518:28)\\n    at Multipart.emit (node:domain:489:12)\\n    at HeaderParser.cb (/usr/src/app/node_modules/busboy/lib/types/multipart.js:358:14)\\n    at HeaderParser.push (/usr/src/app/node_modules/busboy/lib/types/multipart.js:162:20)\\n    at SBMH.ssCb [as _cb] (/usr/src/app/node_modules/busboy/lib/types/multipart.js:394:37)\\n    at feed (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:219:14)\\n    at SBMH.push (/usr/src/app/node_modules/streamsearch/lib/sbmh.js:104:16)\\n    at Multipart._write (/usr/src/app/node_modules/busboy/lib/types/multipart.js:567:19)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"MulterError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:37:10:3710\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:37:10'),
(158, '2025-07-07 02:37:10', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 500, \"timestamp\": \"2025-07-07 02:37:10:3710\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"31ms\"}', '2025-07-07 02:37:10'),
(159, '2025-07-07 02:37:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:37:16:3716\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"15ms\"}', '2025-07-07 02:37:16'),
(160, '2025-07-07 02:39:24', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:39:24:3924\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"38ms\"}', '2025-07-07 02:39:24'),
(161, '2025-07-07 02:39:50', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:39:50:3950\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"national_id\": \"29503212568912\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"31ms\"}', '2025-07-07 02:39:50'),
(162, '2025-07-07 02:48:40', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:48:40:4840\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"74ms\"}', '2025-07-07 02:48:40'),
(163, '2025-07-07 02:48:40', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report\", \"stack\": \"Error: Cannot set headers after they are sent to the client\\n    at ServerResponse.setHeader (node:_http_outgoing:700:11)\\n    at ServerResponse.header (/usr/src/app/node_modules/express/lib/response.js:794:10)\\n    at ServerResponse.send (/usr/src/app/node_modules/express/lib/response.js:174:12)\\n    at ServerResponse.json (/usr/src/app/node_modules/express/lib/response.js:278:15)\\n    at /usr/src/app/src/controller/user.controller.ts:179:25\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/controller/user.controller.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"Error\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 02:48:40:4840\", \"statusCode\": 500, \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:48:40'),
(164, '2025-07-07 02:50:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-07 02:50:01:501\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"95ms\"}', '2025-07-07 02:50:01'),
(165, '2025-07-07 02:51:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-07 02:51:30:5130\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"110ms\"}', '2025-07-07 02:51:30'),
(166, '2025-07-07 02:51:43', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-07 02:51:43:5143\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"116ms\"}', '2025-07-07 02:51:43'),
(167, '2025-07-07 02:53:02', '[32mhttp[39m', '[32mForbidden Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/custome/getSpesific/1\", \"stack\": \"ForbiddenError: Access denied. Admin privileges required.\\n    at /usr/src/app/src/middleware/admin.middleware.ts:41:13\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/middleware/admin.middleware.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"ForbiddenError\", \"errorType\": \"ForbiddenError\", \"timestamp\": \"2025-07-07 02:53:02:532\", \"statusCode\": 403, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 02:53:02'),
(168, '2025-07-07 02:53:02', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 403, \"timestamp\": \"2025-07-07 02:53:02:532\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"22ms\"}', '2025-07-07 02:53:02'),
(169, '2025-07-07 02:53:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 02:53:16:5316\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"mohamedo7x@hotmail.com\", \"password\": \"test@2003\"}, \"responseTime\": \"115ms\"}', '2025-07-07 02:53:16'),
(170, '2025-07-07 02:53:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:53:18:5318\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"13ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 02:53:18'),
(171, '2025-07-07 02:53:41', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:53:41:5341\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"7ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 02:53:41'),
(172, '2025-07-07 02:56:15', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:56:15:5615\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"31ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 02:56:15'),
(173, '2025-07-07 02:57:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:57:31:5731\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"23ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 02:57:31'),
(174, '2025-07-07 02:57:56', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:57:56:5756\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"23ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 02:57:56'),
(175, '2025-07-07 02:58:50', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 02:58:50:5850\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"28ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 02:58:50'),
(176, '2025-07-07 03:05:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:05:23:523\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"15ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:05:23'),
(177, '2025-07-07 03:08:36', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:08:36:836\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"29ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:08:36'),
(178, '2025-07-07 03:14:55', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:14:55:1455\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"29ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:14:55'),
(179, '2025-07-07 03:15:35', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:15:35:1535\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"20ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:15:35'),
(180, '2025-07-07 03:16:13', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:16:13:1613\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"19ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:16:13'),
(181, '2025-07-07 03:16:37', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:16:37:1637\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"18ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:16:37'),
(182, '2025-07-07 03:16:55', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 03:16:55:1655\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"20ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 03:16:55'),
(183, '2025-07-07 03:17:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 404, \"timestamp\": \"2025-07-07 03:17:18:1718\", \"userAgent\": \"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36\", \"responseTime\": \"7ms\"}', '2025-07-07 03:17:18'),
(184, '2025-07-07 03:30:45', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-07 03:30:45:3045\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"\", \"description\": \"\"}, \"responseTime\": \"19ms\"}', '2025-07-07 03:30:45'),
(185, '2025-07-07 03:30:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-07 03:30:54:3054\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1111111111111\", \"description\": \"\"}, \"responseTime\": \"1ms\"}', '2025-07-07 03:30:54'),
(186, '2025-07-07 03:30:57', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-07 03:30:57:3057\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1111111111111\", \"description\": \"22222\"}, \"responseTime\": \"1ms\"}', '2025-07-07 03:30:57'),
(187, '2025-07-07 03:31:16', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/objection\", \"stack\": \"ValidationError: report_id must be exactly 14 digits long\\n    at validateRequest (/usr/src/app/src/middleware/validateRequest.ts:13:11)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at middleware (/usr/src/app/node_modules/express-validator/lib/middlewares/check.js:16:13)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"POST\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 03:31:16:3116\", \"statusCode\": 400, \"requestBody\": {\"report_id\": \"1111111111111\", \"description\": \"22222\"}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 03:31:16'),
(188, '2025-07-07 03:31:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 400, \"timestamp\": \"2025-07-07 03:31:16:3116\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1111111111111\", \"description\": \"22222\"}, \"responseTime\": \"29ms\"}', '2025-07-07 03:31:16'),
(189, '2025-07-07 03:57:02', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 03:57:02:572\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"21\", \"description\": \"22222\"}, \"responseTime\": \"27ms\"}', '2025-07-07 03:57:02'),
(190, '2025-07-07 03:58:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 03:58:54:5854\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"21\", \"description\": \"22222\"}, \"responseTime\": \"32ms\"}', '2025-07-07 03:58:54'),
(191, '2025-07-07 03:59:12', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-07 03:59:12:5912\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"21\", \"description\": \"22222\"}, \"responseTime\": \"21ms\"}', '2025-07-07 03:59:12'),
(192, '2025-07-07 03:59:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 03:59:18:5918\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"14ms\"}', '2025-07-07 03:59:18'),
(193, '2025-07-07 04:00:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 04:00:01:01\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"44ms\"}', '2025-07-07 04:00:01'),
(194, '2025-07-07 04:00:08', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:00:08:08\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"5ms\"}', '2025-07-07 04:00:08'),
(195, '2025-07-07 04:00:20', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 04:00:20:020\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"24ms\"}', '2025-07-07 04:00:20'),
(196, '2025-07-07 04:01:00', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 04:01:00:10\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"60ms\"}', '2025-07-07 04:01:00'),
(197, '2025-07-07 04:01:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 04:01:01:11\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"25ms\"}', '2025-07-07 04:01:01'),
(198, '2025-07-07 04:01:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 04:01:03:13\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"34ms\"}', '2025-07-07 04:01:03'),
(199, '2025-07-07 04:01:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 04:01:30:130\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"53ms\"}', '2025-07-07 04:01:30');
INSERT INTO `AuditLogs` (`id`, `timestamp`, `level`, `message`, `meta`, `created_at`) VALUES
(200, '2025-07-07 04:01:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:01:31:131\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"5ms\"}', '2025-07-07 04:01:31'),
(201, '2025-07-07 04:01:32', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:01:32:132\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"5ms\"}', '2025-07-07 04:01:32'),
(202, '2025-07-07 04:01:33', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:01:33:133\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"6ms\"}', '2025-07-07 04:01:33'),
(203, '2025-07-07 04:02:22', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:02:22:222\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"9ms\"}', '2025-07-07 04:02:22'),
(204, '2025-07-07 04:02:26', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:02:26:226\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"7ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 04:02:26'),
(205, '2025-07-07 04:02:38', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:02:38:238\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"14ms\"}', '2025-07-07 04:02:38'),
(206, '2025-07-07 04:02:49', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 201, \"timestamp\": \"2025-07-07 04:02:49:249\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"date\": \"2003-10-05\", \"name\": \"Mohamed Khalid\", \"phone\": \"233312322\", \"address\": \"22 naser city of co\", \"description\": \"nah just test\", \"vehcile_types\": \"red color , and white window\"}, \"responseTime\": \"92ms\"}', '2025-07-07 04:02:49'),
(207, '2025-07-07 04:03:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:03:03:33\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"7ms\"}', '2025-07-07 04:03:03'),
(208, '2025-07-07 04:03:15', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:03:15:315\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"7ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 04:03:15'),
(209, '2025-07-07 04:03:26', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 04:03:26:326\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"2ms\"}', '2025-07-07 04:03:26'),
(210, '2025-07-07 04:05:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:05:54:554\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"26ms\"}', '2025-07-07 04:05:54'),
(211, '2025-07-07 04:05:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:05:58:558\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"2\", \"limit\": \"10\"}, \"responseTime\": \"6ms\"}', '2025-07-07 04:05:58'),
(212, '2025-07-07 04:06:07', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:06:07:67\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"8ms\"}', '2025-07-07 04:06:07'),
(213, '2025-07-07 04:06:39', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:06:39:639\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"9ms\"}', '2025-07-07 04:06:39'),
(214, '2025-07-07 04:06:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:06:54:654\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"5ms\"}', '2025-07-07 04:06:54'),
(215, '2025-07-07 04:08:57', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:08:57:857\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"24ms\"}', '2025-07-07 04:08:57'),
(216, '2025-07-07 04:09:02', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:09:02:92\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"1\"}, \"responseTime\": \"6ms\"}', '2025-07-07 04:09:02'),
(217, '2025-07-07 04:12:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:12:58:1258\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"25ms\"}', '2025-07-07 04:12:58'),
(218, '2025-07-07 04:13:07', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:13:07:137\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"2\"}, \"responseTime\": \"8ms\"}', '2025-07-07 04:13:07'),
(219, '2025-07-07 04:13:12', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/reports\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:13:12:1312\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"8ms\"}', '2025-07-07 04:13:12'),
(220, '2025-07-07 04:13:32', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:13:32:1332\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"7ms\"}', '2025-07-07 04:13:32'),
(221, '2025-07-07 04:16:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:16:44:1644\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"24ms\"}', '2025-07-07 04:16:44'),
(222, '2025-07-07 04:17:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/person/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:17:44:1744\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"24ms\"}', '2025-07-07 04:17:44'),
(223, '2025-07-07 04:18:07', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:18:07:187\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"8ms\"}', '2025-07-07 04:18:07'),
(224, '2025-07-07 04:19:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:19:42:1942\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"21ms\"}', '2025-07-07 04:19:42'),
(225, '2025-07-07 04:20:08', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:20:08:208\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"17ms\"}', '2025-07-07 04:20:08'),
(226, '2025-07-07 04:21:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/custome\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:21:23:2123\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"37ms\"}', '2025-07-07 04:21:23'),
(227, '2025-07-07 04:21:43', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/wanted\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:21:43:2143\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"7ms\"}', '2025-07-07 04:21:43'),
(228, '2025-07-07 04:21:53', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:21:53:2153\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"1\"}, \"responseTime\": \"8ms\"}', '2025-07-07 04:21:53'),
(229, '2025-07-07 04:22:01', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/wanted\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 04:22:01:221\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"3ms\"}', '2025-07-07 04:22:01'),
(230, '2025-07-07 20:43:03', '[32mhttp[39m', '[32mUnauthorized Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/user/report/1\", \"stack\": \"UnauthorizedError: Token has expired. Please login again.\\n    at validateJWTToken (/usr/src/app/src/auth/police_user.access.ts:50:13)\\n    at validateUserToken (/usr/src/app/src/auth/user.access.ts:21:37)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at Route.dispatch (/usr/src/app/node_modules/express/lib/router/route.js:119:3)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at /usr/src/app/node_modules/express/lib/router/index.js:284:15\\n    at param (/usr/src/app/node_modules/express/lib/router/index.js:365:14)\\n    at param (/usr/src/app/node_modules/express/lib/router/index.js:376:14)\\n    at Function.process_params (/usr/src/app/node_modules/express/lib/router/index.js:421:3)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"UnauthorizedError\", \"errorType\": \"UnauthorizedError\", \"timestamp\": \"2025-07-07 20:43:03:433\", \"statusCode\": 401, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 20:43:03'),
(231, '2025-07-07 20:43:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 401, \"timestamp\": \"2025-07-07 20:43:03:433\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"25ms\"}', '2025-07-07 20:43:03'),
(232, '2025-07-07 20:43:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 20:43:16:4316\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"gogo@x.ts\", \"password\": \"123123\"}, \"responseTime\": \"91ms\"}', '2025-07-07 20:43:16'),
(233, '2025-07-07 20:43:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 20:43:18:4318\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"5ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 20:43:18'),
(234, '2025-07-07 20:43:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 404, \"timestamp\": \"2025-07-07 20:43:23:4323\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"2ms\"}', '2025-07-07 20:43:23'),
(235, '2025-07-07 20:43:27', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 20:43:27:4327\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"4ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 20:43:27'),
(236, '2025-07-07 20:43:33', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 20:43:33:4333\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"17ms\", \"requestParams\": {\"id\": \"3\"}}', '2025-07-07 20:43:33'),
(237, '2025-07-07 20:43:41', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 20:43:41:4341\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"4ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 20:43:41'),
(238, '2025-07-07 20:51:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 20:51:14:5114\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"60ms\"}', '2025-07-07 20:51:14'),
(239, '2025-07-07 20:51:18', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 401, \"timestamp\": \"2025-07-07 20:51:18:5118\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"6ms\"}', '2025-07-07 20:51:18'),
(240, '2025-07-07 20:51:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-07 20:51:42:5142\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"8ms\"}', '2025-07-07 20:51:42'),
(241, '2025-07-07 20:51:56', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 20:51:56:5156\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"7ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 20:51:56'),
(242, '2025-07-07 21:02:47', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/admin/users\", \"stack\": \"ValidationError: Invalid admin ID format\\n    at validateAdminId (/usr/src/app/src/middleware/admin.middleware.ts:61:13)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at /usr/src/app/src/middleware/admin.middleware.ts:45:5\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/middleware/admin.middleware.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 21:02:47:247\", \"statusCode\": 400, \"requestBody\": {}, \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"requestParams\": {}}', '2025-07-07 21:02:47'),
(243, '2025-07-07 21:02:47', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 400, \"timestamp\": \"2025-07-07 21:02:47:247\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"32ms\"}', '2025-07-07 21:02:47'),
(244, '2025-07-07 21:02:52', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 21:02:52:252\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"mohamedo7x@hotmail.com\", \"password\": \"test@2003\"}, \"responseTime\": \"148ms\"}', '2025-07-07 21:02:52'),
(245, '2025-07-07 21:02:56', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/admin/users\", \"stack\": \"ValidationError: Invalid admin ID format\\n    at validateAdminId (/usr/src/app/src/middleware/admin.middleware.ts:61:13)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at /usr/src/app/src/middleware/admin.middleware.ts:45:5\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/middleware/admin.middleware.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 21:02:56:256\", \"statusCode\": 400, \"requestBody\": {}, \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"requestParams\": {}}', '2025-07-07 21:02:56'),
(246, '2025-07-07 21:02:56', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 400, \"timestamp\": \"2025-07-07 21:02:56:256\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"7ms\"}', '2025-07-07 21:02:56'),
(247, '2025-07-07 21:02:58', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/admin/users\", \"stack\": \"ValidationError: Invalid admin ID format\\n    at validateAdminId (/usr/src/app/src/middleware/admin.middleware.ts:61:13)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at /usr/src/app/src/middleware/admin.middleware.ts:45:5\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/middleware/admin.middleware.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 21:02:58:258\", \"statusCode\": 400, \"requestBody\": {}, \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"requestParams\": {}}', '2025-07-07 21:02:58'),
(248, '2025-07-07 21:02:58', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 400, \"timestamp\": \"2025-07-07 21:02:58:258\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"7ms\"}', '2025-07-07 21:02:58'),
(249, '2025-07-07 21:03:02', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 21:03:02:32\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"email\": \"mohamedo7x@hotmail.com\", \"password\": \"test@2003\"}, \"responseTime\": \"126ms\"}', '2025-07-07 21:03:02'),
(250, '2025-07-07 21:03:14', '[32mhttp[39m', '[32mValidation Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/admin/users\", \"stack\": \"ValidationError: Invalid admin ID format\\n    at validateAdminId (/usr/src/app/src/middleware/admin.middleware.ts:61:13)\\n    at Layer.handle [as handle_request] (/usr/src/app/node_modules/express/lib/router/layer.js:95:5)\\n    at next (/usr/src/app/node_modules/express/lib/router/route.js:149:13)\\n    at /usr/src/app/src/middleware/admin.middleware.ts:45:5\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/middleware/admin.middleware.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"ValidationError\", \"errorType\": \"ValidationError\", \"timestamp\": \"2025-07-07 21:03:14:314\", \"statusCode\": 400, \"requestBody\": {}, \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"requestParams\": {}}', '2025-07-07 21:03:14'),
(251, '2025-07-07 21:03:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 400, \"timestamp\": \"2025-07-07 21:03:14:314\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"9ms\"}', '2025-07-07 21:03:14'),
(252, '2025-07-07 21:03:56', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:03:56:356\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"19ms\"}', '2025-07-07 21:03:56'),
(253, '2025-07-07 21:06:32', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:06:32:632\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"24ms\"}', '2025-07-07 21:06:32'),
(254, '2025-07-07 21:07:31', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:07:31:731\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"23ms\"}', '2025-07-07 21:07:31'),
(255, '2025-07-07 21:10:12', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:10:12:1012\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"18ms\"}', '2025-07-07 21:10:12'),
(256, '2025-07-07 21:10:21', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 404, \"timestamp\": \"2025-07-07 21:10:21:1021\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"12ms\"}', '2025-07-07 21:10:21'),
(257, '2025-07-07 21:10:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/user\", \"user\": \"ADMIN\", \"method\": \"POST\", \"status\": 200, \"timestamp\": \"2025-07-07 21:10:30:1030\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"report_id\": \"1\", \"description\": \"22222\"}, \"responseTime\": \"26ms\"}', '2025-07-07 21:10:30'),
(258, '2025-07-07 21:10:33', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:10:33:1033\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"6ms\"}', '2025-07-07 21:10:33'),
(259, '2025-07-07 21:11:27', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:11:27:1127\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"22ms\"}', '2025-07-07 21:11:27'),
(260, '2025-07-07 21:12:28', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:12:28:1228\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"24ms\"}', '2025-07-07 21:12:28'),
(261, '2025-07-07 21:14:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:14:30:1430\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"19ms\"}', '2025-07-07 21:14:30'),
(262, '2025-07-07 21:14:54', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:14:54:1454\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"7ms\"}', '2025-07-07 21:14:54'),
(263, '2025-07-07 21:15:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:15:03:153\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestQuery\": {\"page\": \"1\", \"limit\": \"10\"}, \"responseTime\": \"6ms\"}', '2025-07-07 21:15:03'),
(264, '2025-07-07 21:35:16', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:35:16:3516\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"accepted\"}, \"responseTime\": \"29ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 21:35:16'),
(265, '2025-07-07 21:36:32', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:36:32:3632\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"59ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 21:36:32'),
(266, '2025-07-07 21:36:36', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:36:36:3636\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"7ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-07 21:36:36'),
(267, '2025-07-07 21:39:14', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:39:14:3914\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"31ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-07 21:39:14'),
(268, '2025-07-07 21:39:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:39:42:3942\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"28ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-07 21:39:42'),
(269, '2025-07-07 21:40:15', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:40:15:4015\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"60ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-07 21:40:15'),
(270, '2025-07-07 21:40:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 404, \"timestamp\": \"2025-07-07 21:40:42:4042\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"33ms\", \"requestParams\": {\"id\": \"2\"}}', '2025-07-07 21:40:42'),
(271, '2025-07-07 21:41:22', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 404, \"timestamp\": \"2025-07-07 21:41:22:4122\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"accepted\"}, \"responseTime\": \"32ms\", \"requestParams\": {\"id\": \"13\"}}', '2025-07-07 21:41:22'),
(272, '2025-07-07 21:41:29', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/admin\", \"user\": \"ADMIN\", \"method\": \"PUT\", \"status\": 200, \"timestamp\": \"2025-07-07 21:41:29:4129\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"requestBody\": {\"status\": \"closed\"}, \"responseTime\": \"9ms\", \"requestParams\": {\"id\": \"1\"}}', '2025-07-07 21:41:29'),
(273, '2025-07-07 21:47:30', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 21:47:30:4730\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"48ms\"}', '2025-07-07 21:47:30'),
(274, '2025-07-07 22:04:59', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:04:59:459\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"39ms\"}', '2025-07-07 22:04:59'),
(275, '2025-07-07 22:05:45', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:05:45:545\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"27ms\"}', '2025-07-07 22:05:45'),
(276, '2025-07-07 22:06:06', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:06:06:66\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"28ms\"}', '2025-07-07 22:06:06'),
(277, '2025-07-07 22:07:07', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:07:07:77\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"24ms\"}', '2025-07-07 22:07:07'),
(278, '2025-07-07 22:07:33', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:07:33:733\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"41ms\"}', '2025-07-07 22:07:33'),
(279, '2025-07-07 22:08:09', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:08:09:89\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"25ms\"}', '2025-07-07 22:08:09'),
(280, '2025-07-07 22:11:03', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/home/\", \"stack\": \"TypeError: Cannot read properties of undefined (reading \'result\')\\n    at /usr/src/app/src/controller/Home.controller.ts:121:37\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/controller/Home.controller.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"TypeError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 22:11:03:113\", \"statusCode\": 500, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 22:11:03'),
(281, '2025-07-07 22:11:03', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 500, \"timestamp\": \"2025-07-07 22:11:03:113\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"46ms\"}', '2025-07-07 22:11:03'),
(282, '2025-07-07 22:11:08', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/home/\", \"stack\": \"TypeError: Cannot read properties of undefined (reading \'result\')\\n    at /usr/src/app/src/controller/Home.controller.ts:121:37\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/controller/Home.controller.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"TypeError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 22:11:08:118\", \"statusCode\": 500, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 22:11:08'),
(283, '2025-07-07 22:11:08', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 500, \"timestamp\": \"2025-07-07 22:11:08:118\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"8ms\"}', '2025-07-07 22:11:08'),
(284, '2025-07-07 22:11:56', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:11:56:1156\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"25ms\"}', '2025-07-07 22:11:56'),
(285, '2025-07-07 22:12:51', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:12:51:1251\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"29ms\"}', '2025-07-07 22:12:51'),
(286, '2025-07-07 22:13:06', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:13:06:136\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"10ms\"}', '2025-07-07 22:13:06'),
(287, '2025-07-07 22:13:08', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:13:08:138\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"6ms\"}', '2025-07-07 22:13:08'),
(288, '2025-07-07 22:13:50', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:13:50:1350\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"24ms\"}', '2025-07-07 22:13:50'),
(289, '2025-07-07 22:15:52', '[32mhttp[39m', '[32mInternal Server Error[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"path\": \"/home/\", \"stack\": \"SyntaxError: \\\"[object Object]\\\" is not valid JSON\\n    at JSON.parse (<anonymous>)\\n    at /usr/src/app/src/controller/Home.controller.ts:127:31\\n    at Generator.next (<anonymous>)\\n    at fulfilled (/usr/src/app/src/controller/Home.controller.ts:5:58)\\n    at processTicksAndRejections (node:internal/process/task_queues:105:5)\", \"method\": \"GET\", \"userId\": null, \"errorName\": \"SyntaxError\", \"errorType\": \"InternalServerError\", \"timestamp\": \"2025-07-07 22:15:52:1552\", \"statusCode\": 500, \"requestBody\": {}, \"requestQuery\": {}, \"requestParams\": {}}', '2025-07-07 22:15:52'),
(290, '2025-07-07 22:15:52', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 500, \"timestamp\": \"2025-07-07 22:15:52:1552\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"55ms\"}', '2025-07-07 22:15:52'),
(291, '2025-07-07 22:16:44', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:16:44:1644\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"27ms\"}', '2025-07-07 22:16:44'),
(292, '2025-07-07 22:17:09', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:17:09:179\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"26ms\"}', '2025-07-07 22:17:09'),
(293, '2025-07-07 22:17:42', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:17:42:1742\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"27ms\"}', '2025-07-07 22:17:42'),
(294, '2025-07-07 22:18:15', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 22:18:15:1815\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"23ms\"}', '2025-07-07 22:18:15'),
(295, '2025-07-07 23:44:23', '[32mhttp[39m', '[32mHTTP Request[39m', '{\"ip\": \"::ffff:172.18.0.1\", \"url\": \"/home\", \"user\": \"ADMIN\", \"method\": \"GET\", \"status\": 200, \"timestamp\": \"2025-07-07 23:44:23:4423\", \"userAgent\": \"PostmanRuntime/7.44.1\", \"responseTime\": \"40ms\"}', '2025-07-07 23:44:23');

-- --------------------------------------------------------

--
-- Table structure for table `driver_license`
--

CREATE TABLE `driver_license` (
  `number` varchar(50) NOT NULL,
  `driver_id` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `education` varchar(100) DEFAULT NULL,
  `nationality` varchar(50) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `traffic_department` varchar(100) DEFAULT NULL,
  `traffic_office` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `driver_license`
--

INSERT INTO `driver_license` (`number`, `driver_id`, `type`, `education`, `nationality`, `issue_date`, `expiry_date`, `traffic_department`, `traffic_office`) VALUES
('BF35WOKTLA', '29905112578938', 'A', 'ثانوية عامة', 'عراقي', '2020-04-12', '2025-04-12', 'مرور أسيوط', 'مكتب الوليدية'),
('EP61ZGQXMC', '29503212568912', 'B', 'دبلوم', 'فلسطيني', '2018-11-30', '2023-11-30', 'مرور طنطا', 'مرور طنطا'),
('GV52AXJLKT', '29808072548691', 'A', 'بكالوريوس', 'سعودي', '2021-12-18', '2026-12-18', 'مرور 6 أكتوبر', 'مكتب الحصري'),
('HY60NEPQWR', '29909012258931', 'T', 'دبلوم', 'يمني', '2016-08-05', '2021-08-05', 'مرور قنا', 'مكتب وسط البلد'),
('KR29DHJVLE', '29802142563984', 'C', 'دكتوراه', 'لبناني', '2022-01-10', '2027-01-10', 'مرور المنصورة', 'مكتب الجامعة'),
('MU47CEXYQN', '30010162547893', 'B', 'بكالوريوس', 'أردني', '2017-07-19', '2022-07-19', 'مرور بني سويف', 'مكتب شرق النيل'),
('QN72VCEKJD', '29707182759612', 'E', 'ثانوية عامة', 'سوري', '2019-03-21', '2024-03-21', 'مرور الجيزة', 'مكتب فيصل'),
('WD84RTYUIO', '30106052398174', 'B', 'ماجستير', 'مصري', '2021-09-01', '2026-09-01', 'مرور الإسكندرية', 'مكتب سموحة'),
('XA93LMBTZQ', '29905122578934', 'B', 'بكالوريوس', 'أردني', '2020-06-15', '2025-06-15', 'مرور القاهرة', 'مكتب عبود'),
('ZT18MRLVCB', '29611282579365', 'E', 'ماجستير', 'سوداني', '2023-02-28', '2028-02-28', 'مرور الزقازيق', 'مكتب أول الزقازيق');

-- --------------------------------------------------------

--
-- Table structure for table `inspected_vehicles`
--

CREATE TABLE `inspected_vehicles` (
  `id` int NOT NULL,
  `plate` varchar(10) DEFAULT NULL,
  `police_id` int DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `inspected_vehicles`
--

INSERT INTO `inspected_vehicles` (`id`, `plate`, `police_id`, `create_at`) VALUES
(1, 'CA07TRE', 2, '2025-07-02 16:14:28'),
(2, 'CA07TRE', 2, '2025-07-02 16:21:34'),
(3, 'CA07TRE', 2, '2025-07-02 16:21:35'),
(4, 'CA07TRE', 2, '2025-07-02 16:21:35'),
(5, 'CA07TRE', 2, '2025-07-02 16:21:35'),
(6, 'CA07TRE', 2, '2025-07-05 02:36:17'),
(7, 'CA07TRE', 2, '2025-07-05 02:38:47'),
(8, 'CA07TRE', 2, '2025-07-05 02:39:45'),
(9, 'CA07TRE', 2, '2025-07-05 03:05:27'),
(10, 'CA07TRE', 2, '2025-07-05 03:05:40'),
(11, 'CA07TRE', 2, '2025-07-05 19:51:32'),
(12, 'CA07TRE', 2, '2025-07-05 19:52:09'),
(13, 'CA07TRE', 2, '2025-07-05 23:40:42');

-- --------------------------------------------------------

--
-- Table structure for table `license_types`
--

CREATE TABLE `license_types` (
  `code` char(1) NOT NULL,
  `type_name` varchar(100) NOT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `license_types`
--

INSERT INTO `license_types` (`code`, `type_name`, `description`) VALUES
('A', 'دراجة نارية', 'مخصصة للموتوسيكلات والسكوتر'),
('B', 'درجة ثالثة (ملاكي)', 'مخصصة للسيارات الخاصة فقط'),
('C', 'درجة ثانية', 'للأجرة والنقل الخفيف'),
('D', 'درجة أولى', 'للشاحنات الثقيلة والأتوبيسات'),
('E', 'مهنية', 'مزاولة مهنة القيادة'),
('T', 'تحت التدريب', 'رخصة مؤقتة لتعلم القيادة');

-- --------------------------------------------------------

--
-- Table structure for table `notification_police`
--

CREATE TABLE `notification_police` (
  `id` int NOT NULL,
  `type` varchar(100) DEFAULT NULL,
  `police_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notification_police`
--

INSERT INTO `notification_police` (`id`, `type`, `police_id`, `created_at`) VALUES
(1, 'password change', 2, '2025-05-24 14:28:52'),
(2, 'report', 2, '2025-05-24 15:05:36');

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE `person` (
  `national_id` varchar(14) NOT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `gender` enum('ذكر','انثى') DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `social_status` enum('عازب','مطلق','متزوج','ارملة') DEFAULT NULL,
  `religion` varchar(40) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `criminal_status` tinyint(1) DEFAULT '0',
  `changed` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`national_id`, `full_name`, `gender`, `date_of_birth`, `social_status`, `religion`, `address`, `issue_date`, `expired_date`, `criminal_status`, `changed`) VALUES
('29503212568912', 'بسمة مجدي عوض عبدالله', 'انثى', '1986-04-05', 'عازب', 'مسلم', '٢٢ شارع مصطفى النحاس، مدينة نصر، القاهرة', '2011-06-25', '2021-06-25', 1, '2025-05-24 19:23:04'),
('29611282579365', 'علي عبدالفتاح حسين عبدالعزيز', 'ذكر', '1972-11-28', 'ارملة', 'مسيحي', '٤٤ شارع النزهة، مصر الجديدة، القاهرة', '1995-01-01', '2005-01-01', 1, '2025-05-24 19:22:50'),
('29707182759612', 'سارة فتحي عبدالله سالم', 'انثى', '1993-12-12', 'ارملة', 'بدون', '١١ شارع رمسيس، وسط البلد، القاهرة', '2017-09-10', '2027-09-10', 0, '2025-05-24 19:22:50'),
('29802142563984', 'فاطمة عبدالحليم زكريا عوض', 'انثى', '1990-08-22', 'عازب', 'مسلم', '٢٥ شارع النيل، المعادي، القاهرة', '2015-05-01', '2025-05-01', 0, '2025-05-24 19:22:50'),
('29808072548691', 'خالد حسن الزهار سالم', 'ذكر', '1980-08-07', 'متزوج', 'يهودي', '٦٥ شارع الهرم، العمرانية، الجيزة', '2010-01-01', '2020-01-01', 0, '2025-05-24 19:22:50'),
('29905112578938', 'سعيد عثمان سليمان زكريا', 'ذكر', '1975-02-28', 'مطلق', 'بدون', '٣٧ شارع القصر العيني، وسط البلد، القاهرة', '2003-03-15', '2013-03-15', 0, '2025-06-02 02:51:52'),
('29905122578934', 'أحمد عبدالحليم سالم الزهار', 'ذكر', '1985-03-15', 'متزوج', 'مسلم', '١٠ شارع التحرير، الدقي، الجيزة', '2010-04-10', '2020-04-10', 0, '2025-05-24 19:22:50'),
('29909012258931', 'مصطفى فاروق عبدالعزيز عوض', 'ذكر', '1988-06-18', 'متزوج', 'مسلم', '٥٧ شارع الملك فيصل، الهرم، الجيزة', '2012-03-15', '2022-03-15', 0, '2025-05-24 19:22:50'),
('30010162547893', 'محمد سامي حسين عبدالرحمن', 'ذكر', '1978-01-01', 'مطلق', 'مسيحي', '٣٣ شارع سوريا، المهندسين، الجيزة', '2005-07-20', '2015-07-20', 1, '2025-05-24 19:22:50'),
('30106052398174', 'إيمان نبيل سليمان الزهار', 'انثى', '1981-10-30', 'مطلق', 'مسلم', '١٨ شارع الطيران، مدينة نصر، القاهرة', '2009-11-01', '2019-11-01', 0, '2025-05-24 19:22:50');

-- --------------------------------------------------------

--
-- Table structure for table `police_reports`
--

CREATE TABLE `police_reports` (
  `id` int NOT NULL,
  `police_id` int NOT NULL,
  `report_id` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `police_reports`
--

INSERT INTO `police_reports` (`id`, `police_id`, `report_id`, `created_at`) VALUES
(2, 1, '770cf126b2914a5889045152499dbf9d', '2025-05-24 16:39:25'),
(3, 2, '1c00923a11e44a6cb77f375105890f6f', '2025-05-24 16:39:25'),
(4, 2, '77d8b110267c466e92f7fc539e644137', '2025-05-31 22:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `police_users`
--

CREATE TABLE `police_users` (
  `id` int NOT NULL,
  `military_id` varchar(50) NOT NULL,
  `name` varchar(100) NOT NULL,
  `rank_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `last_login` timestamp NULL DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `username` varchar(100) NOT NULL,
  `online` tinyint(1) NOT NULL DEFAULT '0',
  `password_hash` varchar(255) NOT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `img_profile` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `police_users`
--

INSERT INTO `police_users` (`id`, `military_id`, `name`, `rank_id`, `department`, `city`, `last_login`, `active`, `username`, `online`, `password_hash`, `phone_number`, `img_profile`, `created_at`, `updated_at`) VALUES
(1, 'MIL654321', 'Abdullah Al-Ghamdi', 'First Lieutenant', 'Jeddah Traffic Department', 'Zagazig', '2025-05-18 23:54:33', 1, 'medo', 0, '$2b$10$BD7UTDr7QuhNmQkvoDdER.Ar1MNXR2Rt7EtxDl5EWvyCjSrzkiyEG', '0569876541', 'ac9c37a5e457387f45c7.png', '2025-04-07 01:51:25', '2025-05-23 14:18:54'),
(2, 'MIL654300', 'أحمد سامي عبد الرحمن', 'نقيب', 'إدارة مرور الإسكندرية', 'الإسكندرية', '2025-07-06 00:26:09', 1, 'mohamedo7x', 1, '$2b$10$4njLSXLZD47kn6LOBubIKuodxQ1ls1MQ3cOKtkMgRPkTapByGrHWG', '0569876543', '242a262657ef48b751d9.jpg', '2025-05-18 21:03:37', '2025-07-06 00:26:08'),
(3, 'MIL654200', 'Mohamed Dama Fc', 'Second Lieutenant', 'Giza Traffic Department', 'cairo', NULL, 0, 'mohamedo7xx', 0, '$2b$10$JDEBaQmiwBSZ1HI9oLGff.18.e9Dv.Ci1/Shvui/Wv1NDb06bLZBS', '0569876543', '3ec60e2bb6cd52ae8cfd.png', '2025-07-01 00:16:21', '2025-07-02 14:13:43');

-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE `reports` (
  `id` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `type` int NOT NULL,
  `description` text NOT NULL,
  `status` enum('close','complete','processing') NOT NULL DEFAULT 'processing',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `reports`
--

INSERT INTO `reports` (`id`, `title`, `type`, `description`, `status`, `date`) VALUES
('1c00923a11e44a6cb77f375105890f6f', 'تقرير تصادم مركبات', 4, 'تقرير حول حادث تصادم بين مركبتين في شارع الملك فهد، يتضمن التفاصيل الأولية عن الأضرار والإصابات والإجراءات المتخذة من قبل الجهات المعنية.', 'complete', '2025-05-18 21:06:47'),
('770cf126b2914a5889045152499dbf9d', 'تحليل حركة المرور في المنطقة التجارية', 1, 'تحليل لحركة المرور في المنطقة التجارية خلال ساعات الذروة، مع رصد لأكثر التقاطعات ازدحاماً وتوصيات لتحسين تدفق المركبات وتقليل الاختناقات.', 'processing', '2024-01-22 14:18:36'),
('77d8b110267c466e92f7fc539e644137', 'تقرير تصادم مركبات', 4, 'تقرير حول حادث تصادم بين مركبتين في شارع الملك فهد، يتضمن التفاصيل الأولية عن الأضرار والإصابات والإجراءات المتخذة من قبل الجهات المعنية.', 'processing', '2025-05-31 22:08:11');

-- --------------------------------------------------------

--
-- Table structure for table `report_type`
--

CREATE TABLE `report_type` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `point` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `report_type`
--

INSERT INTO `report_type` (`id`, `name`, `point`) VALUES
(1, 'تقرير حادث مروري', 10),
(2, 'تقرير إشارة حمراء', 8),
(3, 'تقرير وقوف غير نظامي', 3),
(4, 'تقرير تصادم مركبات', 9),
(5, 'تقرير عدم ارتداء حزام الأمان', 4),
(6, 'تقرير قيادة متهورة', 7),
(7, 'تقرير القيادة تحت التأثير', 10),
(8, 'تقرير انتهاء صلاحية الرخصة', 5),
(9, 'تقرير انعطاف غير قانوني', 6),
(10, 'تقرير عدم وجود تأمين', 7);

-- --------------------------------------------------------

--
-- Table structure for table `sms_otp`
--

CREATE TABLE `sms_otp` (
  `otp` varchar(4) DEFAULT NULL,
  `police_id` int DEFAULT NULL,
  `type` enum('login','password') NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sms_otp`
--

INSERT INTO `sms_otp` (`otp`, `police_id`, `type`, `created_at`) VALUES
('1581', 2, 'login', '2025-07-06 00:26:20');

-- --------------------------------------------------------

--
-- Table structure for table `user_accounts`
--

CREATE TABLE `user_accounts` (
  `id` int NOT NULL,
  `national_id` varchar(14) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(30) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_accounts`
--

INSERT INTO `user_accounts` (`id`, `national_id`, `password`, `email`, `created_at`) VALUES
(1, '29503212568912', '$2b$10$DBjgG1oA/Rpp0VnDxgc42.DOpIDMxLvkVsrR6WyLGt/.sEf58BIjS', 'gogo@x.ts', '2025-07-06 02:14:50');

-- --------------------------------------------------------

--
-- Table structure for table `user_objections`
--

CREATE TABLE `user_objections` (
  `id` int NOT NULL,
  `report_id` int NOT NULL,
  `national_id` varchar(14) DEFAULT NULL,
  `description` text NOT NULL,
  `status` enum('pending','under_review','resolved','rejected','closed') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_objections`
--

INSERT INTO `user_objections` (`id`, `report_id`, `national_id`, `description`, `status`, `created_at`) VALUES
(1, 1, '29503212568912', '22222', 'closed', '2025-07-07 21:10:30');

-- --------------------------------------------------------

--
-- Table structure for table `user_report`
--

CREATE TABLE `user_report` (
  `id` int NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(30) NOT NULL,
  `national_id` varchar(14) NOT NULL,
  `address` varchar(255) NOT NULL,
  `date` varchar(100) NOT NULL,
  `vehcile_types` varchar(300) NOT NULL,
  `description` text NOT NULL,
  `status` enum('pending','accepted','rejected') NOT NULL DEFAULT 'pending',
  `attachment` json NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_report`
--

INSERT INTO `user_report` (`id`, `name`, `phone`, `national_id`, `address`, `date`, `vehcile_types`, `description`, `status`, `attachment`, `created_at`) VALUES
(1, 'Mohamed Khalid', '233312322', '29503212568912', '22 naser city of co', '2003-10-05', 'red color , and white window', 'nah just test', 'rejected', '[\"072e1a67806516722ff3.png\", \"b809bfca62ec7539fe00.png\", \"8b3b537531bd85a8d338.png\"]', '2025-07-07 04:02:17'),
(2, 'Mohamed Khalid', '233312322', '29503212568912', '22 naser city of co', '2003-10-05', 'red color , and white window', 'nah just test', 'accepted', '[\"3d5b36553a78fcd083d0.png\"]', '2025-07-07 04:02:49');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle`
--

CREATE TABLE `vehicle` (
  `plate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `brand` varchar(20) DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `chassis_number` varchar(30) DEFAULT NULL,
  `engine_number` varchar(20) DEFAULT NULL,
  `glass_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `classification` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `model` year NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `vehicle`
--

INSERT INTO `vehicle` (`plate`, `brand`, `name`, `type`, `chassis_number`, `engine_number`, `glass_type`, `classification`, `model`) VALUES
('CA02BNM', 'فيات', 'فيات دوكاتو فان', 'فان', 'ZFA26300006123456', 'ENG4455667788', 'زجاج أكريليك', 'مركبة', '2003'),
('CA04PLK', 'بيجو', 'بيجو 3008', 'دفع رباعي', 'VF3XHNPZZFE012345', 'ENG7788990011', 'زجاج مصفح', 'مركبة', '2020'),
('CA05LKO', 'دوكاتي', 'دوكاتي مونستر', 'دراجة نارية', 'ZDM1RB5T9DB012345', 'ENG2233557799', 'زجاج مقسى', 'دراجة نارية', '2019'),
('CA06YUI', 'إيسوزو', 'إيسوزو NPR', 'شاحنة نقل', 'JAANLT149E7101234', 'ENG6644221100', 'زجاج أكريليك', 'شاحنة نقل', '2025'),
('CA07TRE', 'سيتروين', 'سيتروين C3', 'هاتشباك', 'VF7NC9HP0DY012345', 'ENG7770001112', 'زجاج مصفح', 'مركبة', '2022'),
('CA09XCV', 'كيا', 'كيا بيك أب', 'بيك أب', 'KNAFX5A82E5123456', 'ENG1029384756', 'زجاج أكريليك', 'مركبة', '2000'),
('CA10UYT', 'ألفا روميو', 'ألفا روميو 156', 'سيدان', 'ZARFAMAN7J7612345', 'ENG5566771234', 'زجاج مصفح', 'مركبة', '1999'),
('CA11MNO', 'هيونداي', 'هيونداي سانتافي', 'دفع رباعي', 'KMHCT41GP7U012345', 'ENG3344556677', 'زجاج مصفح', 'مركبة', '1980'),
('CA12NWR', 'نيسان', 'نيسان إكس-تريل', 'دفع رباعي', 'JN8AS5MT5CW123456', 'ENG1112131415', 'زجاج مصفح', 'مركبة', '2013'),
('CA12XYZ', 'تويوتا', 'تويوتا كورولا', 'سيدان', 'JTMBFREV3DJ123456', 'ENG1234567890', 'زجاج مقسى', 'مركبة', '2011');

-- --------------------------------------------------------

--
-- Table structure for table `vehicle_license`
--

CREATE TABLE `vehicle_license` (
  `id` int NOT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `inspection_date` date DEFAULT NULL,
  `vehicle_plate` varchar(10) DEFAULT NULL,
  `driving_license_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `type` varchar(200) NOT NULL,
  `color` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `vehicle_license`
--

INSERT INTO `vehicle_license` (`id`, `issue_date`, `expiry_date`, `inspection_date`, `vehicle_plate`, `driving_license_id`, `type`, `color`) VALUES
(1, '2020-05-10', '2025-05-10', '2023-05-10', 'CA10UYT', 'EP61ZGQXMC', 'ملاكي', 'أحمر'),
(2, '2019-07-22', '2024-07-22', '2022-07-22', 'CA06YUI', 'ZT18MRLVCB', 'نقل', 'أبيض'),
(3, '2021-01-15', '2026-01-15', '2024-01-15', 'CA04PLK', 'QN72VCEKJD', 'أجرة', 'أسود'),
(4, '2018-11-30', '2023-11-30', '2021-11-30', 'CA12XYZ', 'KR29DHJVLE', 'دبلوماسي', 'أسود'),
(5, '2022-03-08', '2027-03-08', '2023-03-08', 'CA05LKO', 'GV52AXJLKT', 'ملاكي', 'أزرق'),
(6, '2019-02-25', '2024-02-25', '2022-02-25', 'CA11MNO', 'WD84RTYUIO', 'نقل', 'كحلي'),
(7, '2021-12-01', '2026-12-01', '2023-12-01', 'CA12NWR', 'MU47CEXYQN', 'دبلوماسي', 'ذهبي'),
(8, '2023-06-12', '2028-06-12', '2024-06-12', 'CA09XCV', 'HY60NEPQWR', 'ملاكي', 'فضي'),
(9, '2017-04-04', '2022-04-04', '2021-04-04', 'CA02BNM', 'XA93LMBTZQ', 'أجرة', 'أخضر'),
(10, '2020-09-19', '2025-09-19', '2022-09-19', 'CA07TRE', 'BF35WOKTLA', 'نقل', 'رمادي');

-- --------------------------------------------------------

--
-- Table structure for table `violations`
--

CREATE TABLE `violations` (
  `id` int NOT NULL,
  `police_id` int NOT NULL,
  `plate_id` varchar(10) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `status` enum('paied','unpaied','under_review') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'unpaied',
  `action` int DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `attachments` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `violations`
--

INSERT INTO `violations` (`id`, `police_id`, `plate_id`, `location`, `type`, `status`, `action`, `description`, `attachments`, `created_at`) VALUES
(1, 1, 'CA02BNM', 'Zagazig', 1, 'paied', 5, 'قطع اشاره مرور', '[\"072e1a67806516722ff3.png\", \"b809bfca62ec7539fe00.png\", \"8b3b537531bd85a8d338.png\"]', '2025-05-23 00:30:07'),
(2, 2, 'CA02BNM', 'cairo', 2, 'unpaied', 1, 'None', NULL, '2025-07-01 00:38:01'),
(3, 2, 'CA07TRE', 'Zagazig', 1, 'paied', 5, 'cvcv', NULL, '2025-07-01 01:34:35'),
(4, 2, 'CA07TRE', 'Cairo', 3, 'under_review', 2, NULL, NULL, '2025-07-01 02:25:04'),
(8, 2, 'CA05LKO', 'Zagazig', 1, 'paied', 4, 'تسجيل مخالفه بحيث ان الشخص تجاوز السرعه المسموحة في منطقه ممنوع السير بسرعه اكثر من 30', NULL, '2025-07-05 23:42:20'),
(9, 1, 'CA12XYZ', 'zagazig', 1, 'unpaied', 4, 'ffffff', NULL, '2025-07-07 01:12:57'),
(10, 2, 'CA12XYZ', 'xxxxxxxx', 5, 'unpaied', 4, 'xxxxxxxxxxxxx', NULL, '2025-07-07 01:14:07');

-- --------------------------------------------------------

--
-- Table structure for table `violation_action`
--

CREATE TABLE `violation_action` (
  `id` int NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `violation_action`
--

INSERT INTO `violation_action` (`id`, `code`, `name`, `description`) VALUES
(1, 'FINE_ONLY', 'غرامة مالية فقط', 'تم فرض غرامة مالية بدون اتخاذ إجراءات إضافية'),
(2, 'FINE_AND_POINTS', 'غرامة مع خصم نقاط', 'تم فرض غرامة مالية مع خصم نقاط من سجل السائق'),
(3, 'VEHICLE_IMPOUND', 'حجز المركبة', 'تم حجز المركبة بسبب جسامة المخالفة'),
(4, 'LICENSE_SUSPENSION', 'سحب الرخصة مؤقتًا', 'تم سحب رخصة القيادة لمدة محددة'),
(5, 'WARNING', 'إنذار فقط', 'تم تسجيل مخالفة دون غرامة كتحذير أول'),
(6, 'COURT_REFERRAL', 'إحالة إلى المحكمة', 'تمت إحالة المخالفة إلى الجهات القضائية للبت فيها'),
(7, 'VEHICLE_CONFISCATION', 'مصادرة المركبة', 'تمت مصادرة المركبة نهائيًا حسب الأنظمة');

-- --------------------------------------------------------

--
-- Table structure for table `violation_type`
--

CREATE TABLE `violation_type` (
  `ID` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `desctiption` text,
  `score` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `violation_type`
--

INSERT INTO `violation_type` (`ID`, `name`, `desctiption`, `score`) VALUES
(1, 'تجاوز السرعة', 'القيادة بسرعة تفوق الحد المسموح به', 6),
(2, 'قطع الإشارة الحمراء', 'عدم التوقف عند الإشارة الحمراء', 8),
(3, 'الوقوف في مكان ممنوع', 'إيقاف المركبة في منطقة محظورة', 2),
(4, 'عدم ربط حزام الأمان', 'القيادة دون ارتداء حزام الأمان', 2),
(5, 'استخدام الهاتف أثناء القيادة', 'الانشغال بالهاتف خلال القيادة', 4),
(6, 'القيادة بدون رخصة', 'قيادة المركبة بدون رخصة سارية', 10),
(7, 'القيادة تحت تأثير الكحول', 'القيادة بعد تناول الكحول أو المخدرات', 12),
(8, 'الانعطاف غير القانوني', 'القيام بانعطاف غير مسموح به', 3),
(9, 'عدم الالتزام بخط السير', 'تغيير المسار بشكل مخالف', 4),
(10, 'عدم إعطاء أفضلية المرور', 'عدم إعطاء الأولوية للمشاة أو المركبات الأخرى', 5);

-- --------------------------------------------------------

--
-- Table structure for table `wanted_vehicle`
--

CREATE TABLE `wanted_vehicle` (
  `id` int NOT NULL,
  `plate` varchar(10) DEFAULT NULL,
  `location` varchar(100) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `AuditLogs`
--
ALTER TABLE `AuditLogs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `driver_license`
--
ALTER TABLE `driver_license`
  ADD PRIMARY KEY (`number`),
  ADD KEY `pk_name` (`driver_id`),
  ADD KEY `pk_types` (`type`);

--
-- Indexes for table `inspected_vehicles`
--
ALTER TABLE `inspected_vehicles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate` (`plate`),
  ADD KEY `police_id` (`police_id`);

--
-- Indexes for table `license_types`
--
ALTER TABLE `license_types`
  ADD PRIMARY KEY (`code`);

--
-- Indexes for table `notification_police`
--
ALTER TABLE `notification_police`
  ADD PRIMARY KEY (`id`),
  ADD KEY `police_id` (`police_id`);

--
-- Indexes for table `person`
--
ALTER TABLE `person`
  ADD PRIMARY KEY (`national_id`);

--
-- Indexes for table `police_reports`
--
ALTER TABLE `police_reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `police_id` (`police_id`),
  ADD KEY `report_id` (`report_id`);

--
-- Indexes for table `police_users`
--
ALTER TABLE `police_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `military_id` (`military_id`);

--
-- Indexes for table `reports`
--
ALTER TABLE `reports`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type` (`type`);

--
-- Indexes for table `report_type`
--
ALTER TABLE `report_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sms_otp`
--
ALTER TABLE `sms_otp`
  ADD KEY `police_id` (`police_id`);

--
-- Indexes for table `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `national_id` (`national_id`);

--
-- Indexes for table `user_objections`
--
ALTER TABLE `user_objections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `report_id` (`report_id`),
  ADD KEY `national_id` (`national_id`);

--
-- Indexes for table `user_report`
--
ALTER TABLE `user_report`
  ADD PRIMARY KEY (`id`),
  ADD KEY `national_id` (`national_id`);

--
-- Indexes for table `vehicle`
--
ALTER TABLE `vehicle`
  ADD PRIMARY KEY (`plate`);

--
-- Indexes for table `vehicle_license`
--
ALTER TABLE `vehicle_license`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pks_name` (`vehicle_plate`),
  ADD KEY `pks_types` (`driving_license_id`);

--
-- Indexes for table `violations`
--
ALTER TABLE `violations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate_id` (`plate_id`),
  ADD KEY `type` (`type`),
  ADD KEY `violations_ibfk_3` (`action`),
  ADD KEY `police_ibfk_4` (`police_id`);

--
-- Indexes for table `violation_action`
--
ALTER TABLE `violation_action`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `violation_type`
--
ALTER TABLE `violation_type`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `wanted_vehicle`
--
ALTER TABLE `wanted_vehicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `plate` (`plate`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `AuditLogs`
--
ALTER TABLE `AuditLogs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=296;

--
-- AUTO_INCREMENT for table `inspected_vehicles`
--
ALTER TABLE `inspected_vehicles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `notification_police`
--
ALTER TABLE `notification_police`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `police_reports`
--
ALTER TABLE `police_reports`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `police_users`
--
ALTER TABLE `police_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `report_type`
--
ALTER TABLE `report_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_accounts`
--
ALTER TABLE `user_accounts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_objections`
--
ALTER TABLE `user_objections`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user_report`
--
ALTER TABLE `user_report`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `vehicle_license`
--
ALTER TABLE `vehicle_license`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `violations`
--
ALTER TABLE `violations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `violation_action`
--
ALTER TABLE `violation_action`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `violation_type`
--
ALTER TABLE `violation_type`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `wanted_vehicle`
--
ALTER TABLE `wanted_vehicle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `driver_license`
--
ALTER TABLE `driver_license`
  ADD CONSTRAINT `pk_name` FOREIGN KEY (`driver_id`) REFERENCES `person` (`national_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `pk_types` FOREIGN KEY (`type`) REFERENCES `license_types` (`code`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `inspected_vehicles`
--
ALTER TABLE `inspected_vehicles`
  ADD CONSTRAINT `inspected_vehicles_ibfk_1` FOREIGN KEY (`plate`) REFERENCES `vehicle` (`plate`),
  ADD CONSTRAINT `inspected_vehicles_ibfk_2` FOREIGN KEY (`police_id`) REFERENCES `police_users` (`id`);

--
-- Constraints for table `notification_police`
--
ALTER TABLE `notification_police`
  ADD CONSTRAINT `notification_police_ibfk_1` FOREIGN KEY (`police_id`) REFERENCES `police_users` (`id`);

--
-- Constraints for table `police_reports`
--
ALTER TABLE `police_reports`
  ADD CONSTRAINT `police_reports_ibfk_1` FOREIGN KEY (`police_id`) REFERENCES `police_users` (`id`),
  ADD CONSTRAINT `police_reports_ibfk_2` FOREIGN KEY (`report_id`) REFERENCES `reports` (`id`);

--
-- Constraints for table `reports`
--
ALTER TABLE `reports`
  ADD CONSTRAINT `reports_ibfk_1` FOREIGN KEY (`type`) REFERENCES `report_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sms_otp`
--
ALTER TABLE `sms_otp`
  ADD CONSTRAINT `sms_otp_ibfk_1` FOREIGN KEY (`police_id`) REFERENCES `police_users` (`id`);

--
-- Constraints for table `user_accounts`
--
ALTER TABLE `user_accounts`
  ADD CONSTRAINT `user_accounts_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `person` (`national_id`);

--
-- Constraints for table `user_objections`
--
ALTER TABLE `user_objections`
  ADD CONSTRAINT `user_objections_ibfk_1` FOREIGN KEY (`report_id`) REFERENCES `user_report` (`id`),
  ADD CONSTRAINT `user_objections_ibfk_2` FOREIGN KEY (`national_id`) REFERENCES `person` (`national_id`);

--
-- Constraints for table `user_report`
--
ALTER TABLE `user_report`
  ADD CONSTRAINT `user_report_ibfk_1` FOREIGN KEY (`national_id`) REFERENCES `person` (`national_id`);

--
-- Constraints for table `vehicle_license`
--
ALTER TABLE `vehicle_license`
  ADD CONSTRAINT `pks_name` FOREIGN KEY (`vehicle_plate`) REFERENCES `vehicle` (`plate`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pks_types` FOREIGN KEY (`driving_license_id`) REFERENCES `driver_license` (`number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `violations`
--
ALTER TABLE `violations`
  ADD CONSTRAINT `police_ibfk_4` FOREIGN KEY (`police_id`) REFERENCES `police_users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `violations_ibfk_1` FOREIGN KEY (`plate_id`) REFERENCES `vehicle` (`plate`),
  ADD CONSTRAINT `violations_ibfk_2` FOREIGN KEY (`type`) REFERENCES `violation_type` (`ID`),
  ADD CONSTRAINT `violations_ibfk_3` FOREIGN KEY (`action`) REFERENCES `violation_action` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `wanted_vehicle`
--
ALTER TABLE `wanted_vehicle`
  ADD CONSTRAINT `wanted_vehicle_ibfk_1` FOREIGN KEY (`plate`) REFERENCES `vehicle` (`plate`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
