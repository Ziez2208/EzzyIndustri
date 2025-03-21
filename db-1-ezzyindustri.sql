-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Waktu pembuatan: 21 Mar 2025 pada 18.37
-- Versi server: 8.0.37
-- Versi PHP: 8.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db-1-ezzyindustri`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `checksheet_entries`
--

CREATE TABLE `checksheet_entries` (
  `id` bigint UNSIGNED NOT NULL,
  `task_id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED DEFAULT NULL,
  `shift_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `result` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `photo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `checksheet_entries`
--

INSERT INTO `checksheet_entries` (`id`, `task_id`, `production_id`, `machine_id`, `shift_id`, `user_id`, `result`, `notes`, `photo_path`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 4, 1, 2, 'ok', NULL, NULL, '2025-03-18 23:35:36', '2025-03-18 23:35:36'),
(2, 3, 1, 4, 1, 2, 'ok', NULL, NULL, '2025-03-18 23:35:36', '2025-03-18 23:35:36'),
(3, 4, 1, 4, 1, 2, 'ok', NULL, NULL, '2025-03-18 23:35:36', '2025-03-18 23:35:36'),
(4, 5, 4, 6, 1, 2, 'ok', NULL, NULL, '2025-03-19 00:14:25', '2025-03-19 00:14:25'),
(5, 6, 4, 6, 1, 2, 'ok', NULL, NULL, '2025-03-19 00:14:25', '2025-03-19 00:14:25'),
(6, 7, 4, 6, 1, 2, 'ok', NULL, NULL, '2025-03-19 00:14:25', '2025-03-19 00:14:25'),
(7, 2, 8, 4, 1, 2, 'ok', NULL, NULL, '2025-03-20 12:01:40', '2025-03-20 12:01:40'),
(8, 5, 4, 6, 1, 2, 'ok', NULL, NULL, '2025-03-20 12:38:10', '2025-03-20 12:38:10');

-- --------------------------------------------------------

--
-- Struktur dari tabel `checksheet_histories`
--

CREATE TABLE `checksheet_histories` (
  `id` bigint UNSIGNED NOT NULL,
  `checksheet_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checksheet_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `action` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_values` json DEFAULT NULL,
  `new_values` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `checksheet_results`
--

CREATE TABLE `checksheet_results` (
  `id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `shift_id` bigint UNSIGNED NOT NULL,
  `task_id` bigint UNSIGNED NOT NULL,
  `operator_id` bigint UNSIGNED NOT NULL,
  `status` enum('baik','perlu_perbaikan','rusak') COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `before_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `after_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `checked_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `checksheet_tasks`
--

CREATE TABLE `checksheet_tasks` (
  `id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `type` enum('am','pm') COLLATE utf8mb4_unicode_ci NOT NULL,
  `frequency` enum('daily','weekly','monthly') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily',
  `task_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `standard_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `max_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requires_photo` tinyint(1) NOT NULL DEFAULT '1',
  `order` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `checksheet_task_results`
--

CREATE TABLE `checksheet_task_results` (
  `id` bigint UNSIGNED NOT NULL,
  `checksheet_id` bigint UNSIGNED NOT NULL,
  `task_id` bigint UNSIGNED NOT NULL,
  `status` enum('baik','perlu_perbaikan','rusak') COLLATE utf8mb4_unicode_ci NOT NULL,
  `actual_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `before_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `after_photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `departments`
--

CREATE TABLE `departments` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `departments`
--

INSERT INTO `departments` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Production', '2025-03-15 16:31:48', '2025-03-15 16:31:48'),
(2, 'Quality Control', '2025-03-15 16:31:48', '2025-03-15 16:31:48'),
(3, 'Maintenance', '2025-03-15 16:31:48', '2025-03-15 16:31:48'),
(4, 'Engineering', '2025-03-15 16:31:48', '2025-03-15 16:31:48'),
(5, 'Warehouse', '2025-03-15 16:31:48', '2025-03-15 16:31:48');

-- --------------------------------------------------------

--
-- Struktur dari tabel `downtime_records`
--

CREATE TABLE `downtime_records` (
  `id` bigint UNSIGNED NOT NULL,
  `oee_record_id` bigint UNSIGNED DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `duration` int DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(2, '2d168432-c69c-4dc6-a10b-294f2ded3f21', 'database', 'default', '{\"uuid\":\"2d168432-c69c-4dc6-a10b-294f2ded3f21\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":6:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:0;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:1;s:13:\\\"\\u0000*\\u0000production\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:21:\\\"App\\\\Models\\\\Production\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:2:\\\"id\\\";s:36:\\\"cf54878b-ed0c-4364-8307-6fb74cf509ad\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 'ErrorException: Attempt to read property \"name\" on string in C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\storage\\framework\\views\\96666c441b8ac79e491648a2a37eab2b.php:69\nStack trace:\n#0 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Bootstrap\\HandleExceptions.php(256): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(2, \'Attempt to read...\', \'C:\\\\Users\\\\ziez2\\\\...\', 69)\n#1 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\storage\\framework\\views\\96666c441b8ac79e491648a2a37eab2b.php(69): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->{closure:Illuminate\\Foundation\\Bootstrap\\HandleExceptions::forwardsTo():255}(2, \'Attempt to read...\', \'C:\\\\Users\\\\ziez2\\\\...\', 69)\n#2 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Filesystem\\Filesystem.php(123): require(\'C:\\\\Users\\\\ziez2\\\\...\')\n#3 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Filesystem\\Filesystem.php(124): Illuminate\\Filesystem\\Filesystem::{closure:Illuminate\\Filesystem\\Filesystem::getRequire():120}()\n#4 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\Engines\\PhpEngine.php(58): Illuminate\\Filesystem\\Filesystem->getRequire(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#5 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\livewire\\livewire\\src\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine.php(22): Illuminate\\View\\Engines\\PhpEngine->evaluatePath(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#6 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\Engines\\CompilerEngine.php(75): Livewire\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine->evaluatePath(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#7 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\livewire\\livewire\\src\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine.php(10): Illuminate\\View\\Engines\\CompilerEngine->get(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#8 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\View.php(209): Livewire\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine->get(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#9 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\View.php(192): Illuminate\\View\\View->getContents()\n#10 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\View.php(161): Illuminate\\View\\View->renderContents()\n#11 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(445): Illuminate\\View\\View->render()\n#12 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(420): Illuminate\\Mail\\Mailer->renderView(\'emails.oee-aler...\', Array)\n#13 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(313): Illuminate\\Mail\\Mailer->addContent(Object(Illuminate\\Mail\\Message), \'emails.oee-aler...\', NULL, NULL, Array)\n#14 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\MailChannel.php(67): Illuminate\\Mail\\Mailer->send(\'emails.oee-aler...\', Array, Object(Closure))\n#15 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(148): Illuminate\\Notifications\\Channels\\MailChannel->send(Object(Illuminate\\Notifications\\AnonymousNotifiable), Object(App\\Notifications\\OeeAlertNotification))\n#16 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(106): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(Illuminate\\Notifications\\AnonymousNotifiable), \'937a31b5-0cba-4...\', Object(App\\Notifications\\OeeAlertNotification), \'mail\')\n#17 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(19): Illuminate\\Notifications\\NotificationSender->{closure:Illuminate\\Notifications\\NotificationSender::sendNow():101}()\n#18 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(101): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#19 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Support\\Collection), Object(App\\Notifications\\OeeAlertNotification), Array)\n#20 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(119): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Support\\Collection), Object(App\\Notifications\\OeeAlertNotification), Array)\n#21 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#22 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#23 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#24 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#25 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#26 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#27 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():123}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#28 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():168}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#29 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#30 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#31 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():121}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#32 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():168}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#33 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#34 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#35 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#36 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#37 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#38 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#39 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#40 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#41 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#42 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#43 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#44 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#45 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#46 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#47 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#48 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#49 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#50 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#51 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#52 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#53 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#54 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#55 {main}\n\nNext Illuminate\\View\\ViewException: Attempt to read property \"name\" on string (View: C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\resources\\views\\emails\\oee-alert.blade.php) in C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\storage\\framework\\views\\96666c441b8ac79e491648a2a37eab2b.php:69\nStack trace:\n#0 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\livewire\\livewire\\src\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine.php(58): Illuminate\\View\\Engines\\CompilerEngine->handleViewException(Object(ErrorException), 0)\n#1 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\Engines\\PhpEngine.php(60): Livewire\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine->handleViewException(Object(ErrorException), 0)\n#2 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\livewire\\livewire\\src\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine.php(22): Illuminate\\View\\Engines\\PhpEngine->evaluatePath(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#3 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\Engines\\CompilerEngine.php(75): Livewire\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine->evaluatePath(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#4 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\livewire\\livewire\\src\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine.php(10): Illuminate\\View\\Engines\\CompilerEngine->get(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#5 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\View.php(209): Livewire\\Mechanisms\\ExtendBlade\\ExtendedCompilerEngine->get(\'C:\\\\Users\\\\ziez2\\\\...\', Array)\n#6 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\View.php(192): Illuminate\\View\\View->getContents()\n#7 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\View\\View.php(161): Illuminate\\View\\View->renderContents()\n#8 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(445): Illuminate\\View\\View->render()\n#9 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(420): Illuminate\\Mail\\Mailer->renderView(\'emails.oee-aler...\', Array)\n#10 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Mail\\Mailer.php(313): Illuminate\\Mail\\Mailer->addContent(Object(Illuminate\\Mail\\Message), \'emails.oee-aler...\', NULL, NULL, Array)\n#11 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\Channels\\MailChannel.php(67): Illuminate\\Mail\\Mailer->send(\'emails.oee-aler...\', Array, Object(Closure))\n#12 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(148): Illuminate\\Notifications\\Channels\\MailChannel->send(Object(Illuminate\\Notifications\\AnonymousNotifiable), Object(App\\Notifications\\OeeAlertNotification))\n#13 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(106): Illuminate\\Notifications\\NotificationSender->sendToNotifiable(Object(Illuminate\\Notifications\\AnonymousNotifiable), \'937a31b5-0cba-4...\', Object(App\\Notifications\\OeeAlertNotification), \'mail\')\n#14 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Support\\Traits\\Localizable.php(19): Illuminate\\Notifications\\NotificationSender->{closure:Illuminate\\Notifications\\NotificationSender::sendNow():101}()\n#15 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\NotificationSender.php(101): Illuminate\\Notifications\\NotificationSender->withLocale(NULL, Object(Closure))\n#16 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\ChannelManager.php(54): Illuminate\\Notifications\\NotificationSender->sendNow(Object(Illuminate\\Support\\Collection), Object(App\\Notifications\\OeeAlertNotification), Array)\n#17 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Notifications\\SendQueuedNotifications.php(119): Illuminate\\Notifications\\ChannelManager->sendNow(Object(Illuminate\\Support\\Collection), Object(App\\Notifications\\OeeAlertNotification), Array)\n#18 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Notifications\\SendQueuedNotifications->handle(Object(Illuminate\\Notifications\\ChannelManager))\n#19 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#20 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#21 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#22 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#23 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(126): Illuminate\\Container\\Container->call(Array)\n#24 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Bus\\Dispatcher->{closure:Illuminate\\Bus\\Dispatcher::dispatchNow():123}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#25 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():168}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#26 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(130): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#27 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(126): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(Illuminate\\Notifications\\SendQueuedNotifications), false)\n#28 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(170): Illuminate\\Queue\\CallQueuedHandler->{closure:Illuminate\\Queue\\CallQueuedHandler::dispatchThroughMiddleware():121}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#29 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(127): Illuminate\\Pipeline\\Pipeline->{closure:Illuminate\\Pipeline\\Pipeline::prepareDestination():168}(Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#30 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(121): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#31 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(69): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Notifications\\SendQueuedNotifications))\n#32 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(102): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#33 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(442): Illuminate\\Queue\\Jobs\\Job->fire()\n#34 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(392): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#35 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(178): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#36 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(149): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#37 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(132): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#38 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#39 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(43): Illuminate\\Container\\BoundMethod::{closure:Illuminate\\Container\\BoundMethod::call():35}()\n#40 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(96): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#41 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(35): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#42 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(754): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#43 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(213): Illuminate\\Container\\Container->call(Array)\n#44 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Command\\Command.php(279): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#45 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(182): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#46 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Application.php(1094): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#47 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Application.php(342): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#48 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\symfony\\console\\Application.php(193): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#49 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(198): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#50 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Application.php(1235): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#51 C:\\Users\\ziez2\\OneDrive\\Desktop\\2-EzzyIndustri-Auth\\artisan(16): Illuminate\\Foundation\\Application->handleCommand(Object(Symfony\\Component\\Console\\Input\\ArgvInput))\n#52 {main}', '2025-03-19 15:17:17');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(34, 'default', '{\"uuid\":\"74681c6f-17a4-4434-95f7-7abb62563dec\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:0;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:3;s:2:\\\"id\\\";s:36:\\\"8b6159fa-15d8-4050-905d-994c20ceaee1\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742406209, 1742406209),
(35, 'default', '{\"uuid\":\"564f2355-ddd2-46cc-b197-8c6c756042c2\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:0;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:4;s:2:\\\"id\\\";s:36:\\\"c36d8044-d56a-49ac-a646-6297f09df251\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742418857, 1742418857),
(36, 'default', '{\"uuid\":\"e91fae66-3bfc-4118-8722-93655d4d4583\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:5;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";i:0;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:6;s:2:\\\"id\\\";s:36:\\\"e2dcfe51-5b2c-4436-a307-25870dbd47ae\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742425220, 1742425220),
(37, 'default', '{\"uuid\":\"e7588caa-c41b-4751-995d-f9f6c8fbb14f\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";i:0;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:7;s:2:\\\"id\\\";s:36:\\\"c4ce507c-4b91-4538-90f6-a8cbda652b16\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742425814, 1742425814),
(38, 'default', '{\"uuid\":\"1dc98f4e-4385-4601-b6fb-283b1e4b0063\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";i:0;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:4;s:2:\\\"id\\\";s:36:\\\"cbfbb9a5-a8f1-4ac4-8c3f-1dd33cced742\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742474859, 1742474859),
(39, 'default', '{\"uuid\":\"1b4840e7-3e7d-44e4-b117-5f4904cc9784\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:37.5;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:5;s:2:\\\"id\\\";s:36:\\\"3c964ad4-173d-433c-8b57-9f32ce0621bd\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742475064, 1742475064),
(40, 'default', '{\"uuid\":\"b6089c74-2220-49d3-a11b-d6e2500ccff7\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:37.5;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:2;s:2:\\\"id\\\";s:36:\\\"d92dc6b4-88e5-4af2-a9e2-57af1649ca57\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742476613, 1742476613),
(41, 'default', '{\"uuid\":\"cdb0824b-e562-4fa1-83af-cd08e6fcdc55\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:50;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:4;s:2:\\\"id\\\";s:36:\\\"20d39b80-f585-4953-92fe-1629a251533d\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742494872, 1742494872),
(42, 'default', '{\"uuid\":\"0dcee5ad-a728-4dc6-b056-12b9efa9c24e\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:7;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:37.5;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:6;s:2:\\\"id\\\";s:36:\\\"edaece84-40e5-4320-a215-f1760d0e7775\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742495637, 1742495637),
(43, 'default', '{\"uuid\":\"308e932f-6190-41a0-90c2-01c5f04bfbc1\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:25;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:7;s:2:\\\"id\\\";s:36:\\\"85b7e070-5735-44eb-b90c-32249b9582bb\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742497999, 1742497999),
(44, 'default', '{\"uuid\":\"ba614662-9195-48e7-8614-ffff82f7a07c\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";s:5:\\\"VMC 2\\\";s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:12.5;s:12:\\\"\\u0000*\\u0000targetOee\\\";i:85;s:15:\\\"\\u0000*\\u0000productionId\\\";i:2;s:2:\\\"id\\\";s:36:\\\"124d5cb9-6a40-4e3b-80e4-d973958991b8\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742507041, 1742507041),
(45, 'default', '{\"uuid\":\"4444a26c-00c4-4123-8ed9-45a3b682fd1a\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";s:5:\\\"VMC 3\\\";s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:18.75;s:12:\\\"\\u0000*\\u0000targetOee\\\";i:85;s:15:\\\"\\u0000*\\u0000productionId\\\";i:3;s:2:\\\"id\\\";s:36:\\\"de744ba6-51f7-4868-97c4-ff118118b238\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742507297, 1742507297),
(46, 'default', '{\"uuid\":\"11e50616-1854-4bb1-a47b-71644972ce30\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";s:8:\\\"BORING 1\\\";s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:18.75;s:12:\\\"\\u0000*\\u0000targetOee\\\";i:85;s:15:\\\"\\u0000*\\u0000productionId\\\";i:4;s:2:\\\"id\\\";s:36:\\\"e4834b79-6599-470d-96ec-9ae64a564e4c\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742507468, 1742507468),
(47, 'default', '{\"uuid\":\"df5500b0-465a-435e-aff5-e6959b2a893a\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:15:\\\"App\\\\Models\\\\User\\\";s:2:\\\"id\\\";a:1:{i:0;i:1;}s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";s:7:\\\"Mesin B\\\";s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:12.499999999999998;s:12:\\\"\\u0000*\\u0000targetOee\\\";i:85;s:15:\\\"\\u0000*\\u0000productionId\\\";i:5;s:2:\\\"id\\\";s:36:\\\"d57ddb15-01ee-4551-8e1d-7be09ea9f705\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742507608, 1742507608),
(48, 'default', '{\"uuid\":\"66916adc-479f-4167-99e6-d87eac8bfd3b\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:12.5;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:1;s:2:\\\"id\\\";s:36:\\\"95134e51-a117-451c-b402-419a2c454f42\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742507913, 1742507913),
(49, 'default', '{\"uuid\":\"deb4108f-ced2-4ab9-8aac-702e82e2c435\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:6;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:12.5;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:2;s:2:\\\"id\\\";s:36:\\\"3f4722e1-c1a8-4b12-af10-bfcdce2374ee\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742508092, 1742508092),
(50, 'default', '{\"uuid\":\"15e85921-a1ee-48e8-ba88-b39fc73145f1\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:4;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:24.999999999999996;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:4;s:2:\\\"id\\\";s:36:\\\"80e7e926-95b3-4d65-a143-820320db11b7\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742509586, 1742509586),
(51, 'default', '{\"uuid\":\"9c7c21d6-bcf4-4855-ac0a-5268a99846a5\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:50;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:5;s:2:\\\"id\\\";s:36:\\\"596ce875-a5c9-49e1-aace-747a44b0e9d5\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742548008, 1742548008),
(52, 'default', '{\"uuid\":\"95adf86d-c46c-4ed3-8979-5a22c63cb663\",\"displayName\":\"App\\\\Notifications\\\\OeeAlertNotification\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\",\"command\":\"O:48:\\\"Illuminate\\\\Notifications\\\\SendQueuedNotifications\\\":3:{s:11:\\\"notifiables\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:44:\\\"Illuminate\\\\Notifications\\\\AnonymousNotifiable\\\":1:{s:6:\\\"routes\\\";a:1:{s:4:\\\"mail\\\";s:18:\\\"ziez2208@gmail.com\\\";}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:12:\\\"notification\\\";O:38:\\\"App\\\\Notifications\\\\OeeAlertNotification\\\":5:{s:10:\\\"\\u0000*\\u0000machine\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:18:\\\"App\\\\Models\\\\Machine\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:11:\\\"\\u0000*\\u0000oeeScore\\\";d:41.86046511627907;s:12:\\\"\\u0000*\\u0000targetOee\\\";s:5:\\\"85.00\\\";s:15:\\\"\\u0000*\\u0000productionId\\\";i:6;s:2:\\\"id\\\";s:36:\\\"5f87aa57-e58c-40aa-a479-e84d8f1fbdb4\\\";}s:8:\\\"channels\\\";a:1:{i:0;s:4:\\\"mail\\\";}}\"}}', 0, NULL, 1742551376, 1742551376);

-- --------------------------------------------------------

--
-- Struktur dari tabel `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `machines`
--

CREATE TABLE `machines` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `oee_target` decimal(5,2) NOT NULL DEFAULT '85.00',
  `alert_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `alert_email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alert_phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `machines`
--

INSERT INTO `machines` (`id`, `name`, `code`, `type`, `description`, `location`, `status`, `created_at`, `updated_at`, `oee_target`, `alert_enabled`, `alert_email`, `alert_phone`) VALUES
(2, 'Mesin B', 'MSN-002', 'Mesin', NULL, 'Line 2', 'active', '2025-03-09 10:19:52', '2025-03-18 22:29:25', 85.00, 1, 'ziez2208@gmail.com', '6285187826862'),
(4, 'VMC 1', 'MSN-003', 'Mesin', 'OKE', 'LINE 2', 'active', '2025-03-09 11:18:55', '2025-03-18 22:29:40', 85.00, 1, 'ziez2208@gmail.com', '6285187826862'),
(5, 'VMC 3', 'MSN-0004', 'Mesin', 'AKTIF', 'LINE PRODUKSI', 'active', '2025-03-10 12:16:07', '2025-03-18 22:29:46', 85.00, 1, 'ziez2208@gmail.com', '6285187826862'),
(6, 'VMC 2', 'MSN-001', 'Mesin', '', 'PRODUKSI LINK', 'active', '2025-03-10 12:58:53', '2025-03-18 22:31:14', 85.00, 1, 'ziez2208@gmail.com', '6285187826862'),
(7, 'BORING 1', 'MSN-0005', 'Mesin', '', 'Machining Link', 'active', '2025-03-17 20:29:04', '2025-03-18 22:29:56', 85.00, 1, 'ziez2208@gmail.com', '6285187826862');

-- --------------------------------------------------------

--
-- Struktur dari tabel `maintenance_schedules`
--

CREATE TABLE `maintenance_schedules` (
  `id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `shift_id` bigint UNSIGNED NOT NULL,
  `maintenance_type` enum('am','pm') COLLATE utf8mb4_unicode_ci NOT NULL,
  `schedule_date` date NOT NULL,
  `status` enum('pending','in_progress','completed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `maintenance_tasks`
--

CREATE TABLE `maintenance_tasks` (
  `id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `maintenance_type` enum('am','pm') COLLATE utf8mb4_unicode_ci NOT NULL,
  `task_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `standard_value` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requires_photo` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `is_daily` tinyint(1) NOT NULL DEFAULT '0',
  `shift_ids` json DEFAULT NULL,
  `preferred_time` time DEFAULT NULL,
  `frequency` enum('daily','weekly','monthly') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'daily',
  `schedule_config` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `maintenance_tasks`
--

INSERT INTO `maintenance_tasks` (`id`, `machine_id`, `maintenance_type`, `task_name`, `description`, `standard_value`, `requires_photo`, `created_at`, `updated_at`, `is_active`, `is_daily`, `shift_ids`, `preferred_time`, `frequency`, `schedule_config`) VALUES
(2, 4, 'am', 'VMC 1 AM HARIAN', 'VMC 1 AM HARIAN', NULL, 0, '2025-03-18 15:45:31', '2025-03-18 15:45:31', 1, 0, '\"[1]\"', NULL, 'daily', NULL),
(3, 4, 'pm', 'VMC 1 PM MINGGUAN', 'VMC 1 PM MINGGUAN', '', 0, '2025-03-18 15:46:12', '2025-03-18 15:46:12', 1, 0, '\"[1]\"', '00:00:00', 'weekly', NULL),
(4, 4, 'am', 'VMC 1 AM BULANAN', 'VMC 1 AM BULANAN', '', 0, '2025-03-18 15:46:40', '2025-03-18 15:46:40', 1, 0, '\"[1]\"', '00:00:00', 'monthly', NULL),
(5, 6, 'am', 'VMC 2 AM HARIAN', 'VMC 2 AM HARIAN', '', 0, '2025-03-18 15:47:34', '2025-03-18 15:47:34', 1, 0, '\"[1]\"', '00:00:00', 'daily', NULL),
(6, 6, 'pm', 'VMC 2 PM MINGGUAN', 'VMC 2 PM MINGGUAN', '', 0, '2025-03-18 15:47:54', '2025-03-18 15:47:54', 1, 0, '\"[1]\"', '00:00:00', 'weekly', NULL),
(7, 6, 'am', 'VMC 2 PM BULANAN', 'VMC 2 PM BULANAN', '', 0, '2025-03-18 15:48:17', '2025-03-18 15:48:17', 1, 0, '\"[1]\"', '00:00:00', 'monthly', NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2020_06_14_000001_create_media_table', 1),
(5, '2024_01_19_create_productions_table', 1),
(6, '2024_01_20_create_production_downtimes_table', 1),
(7, '2024_01_21_create_production_problems_table', 1),
(8, '2024_01_22_add_image_url_to_production_problems_table', 1),
(9, '2024_01_23_create_machines_table', 2),
(10, '2024_01_24_create_shifts_table', 3),
(11, '2024_01_23_create_checksheet_tasks_table', 1),
(12, '2024_01_24_create_checksheet_task_results_table', 1),
(13, '2024_01_25_create_am_checksheets_table', 4),
(14, '2024_01_26_create_pm_checksheets_table', 4),
(15, '2024_01_27_create_checksheet_histories_table', 4),
(16, '2025_03_09_183852_update_shifts_table_status_column', 5),
(17, '2025_03_09_185954_add_frequency_to_checksheet_tasks_table', 6),
(18, '2025_03_10_151105_create_maintenance_tasks_table', 7),
(19, '2025_03_10_151110_create_checksheet_results_table', 7),
(21, '2025_03_10_151111_create_maintenance_schedules_table', 8),
(23, '2025_03_10_155731_create_checksheet_entries_table', 9),
(24, '2024_01_15_add_schedule_columns_to_maintenance_tasks', 10),
(25, '2025_03_10_171441_update_checksheet_entries_make_schedule_nullable', 11),
(26, '2025_03_10_175155_add_shift_id_to_checksheet_entries', 12),
(27, '2025_03_10_181735_add_check_date_to_checksheet_entries', 13),
(29, '2025_03_11_232519_add_production_id_to_checksheet_entries', 14),
(30, '2025_03_11_235000_recreate_checksheet_entries_table', 15),
(31, '2025_03_12_034214_update_production_problems_table_add_enums', 16),
(32, '2025_03_12_042309_update_production_problems_add_resolved_status', 17),
(33, '2025_03_12_220621_add_machine_name_to_productions_table', 18),
(34, '2025_03_12_224658_create_sops_table', 19),
(35, '2025_03_12_232413_create_sop_steps_table', 20),
(36, '2025_03_13_164321_add_machine_id_to_sops_table', 21),
(37, '2025_03_13_174655_create_production_sop_checks_table', 22),
(39, '2025_03_14_004014_create_production_checks_table', 23),
(41, '2025_03_14_015124_create_quality_checks_system_table', 24),
(42, '2025_03_14_015130_create_quality_check_details_system_table', 25),
(43, '2025_03_14_022652_add_product_to_sops_table', 26),
(44, '2025_03_14_023501_create_products_table', 27),
(45, '2025_03_14_025052_rename_product_to_product_id_in_sops_table', 28),
(46, '2024_03_14_000001_add_notes_to_production_downtimes_table', 29),
(47, '2024_03_14_create_add_interval_and_unit_to_sops_table', 30),
(49, '2024_03_14_add_interval_steps_columns_to_sop_steps_table', 31),
(50, '2025_03_15_021427_add_needs_standard_to_sop_steps_table', 32),
(51, '2025_03_15_041849_add_production_target_to_products_table', 33),
(52, '2025_03_15_050055_add_unit_to_products_table', 34),
(53, '2025_03_15_203254_add_sop_id_to_production_sop_checks_table', 35),
(54, '2025_03_15_205350_add_target_per_shift_to_productions_table', 36),
(55, '2025_03_15_212609_add_sop_id_to_sops_table', 37),
(56, '2025_03_15_231027_add_department_id_to_users_table', 38),
(57, '2025_03_15_235747_create_permission_tables', 39),
(58, '2025_03_16_000033_create_personal_access_tokens_table', 40),
(59, '2025_03_16_001843_add_status_to_users_table', 41),
(60, '2025_03_16_033833_add_shift_id_to_productions_table', 42),
(61, '2025_03_16_041041_add_defect_columns_to_quality_checks_table', 43),
(62, '2025_03_17_025001_create_productions_table', 44),
(63, '2025_03_17_042834_create_oee_records_table', 45),
(64, '2025_03_17_044535_add_duration_to_production_problems', 46),
(65, '2025_03_17_050719_update_productions_status_enum', 47),
(66, '2025_03_18_031859_add_oee_target_to_machines_table', 48),
(67, '2023_06_15_create_oee_alerts_table', 49),
(68, '2023_06_15_add_alert_phone_to_machines_table', 50),
(69, '2025_03_22_add_is_initial_record_to_oee_records_table', 51),
(70, '2025_03_19_072858_add_last_updated_to_oee_records_table', 52),
(71, '2025_03_19_230004_add_oee_metrics_columns_to_oee_records_table', 53),
(72, '2025_03_19_232712_add_default_value_to_good_output_in_oee_records', 54),
(73, '2025_03_19_232916_add_default_values_to_oee_metrics_in_oee_records', 55),
(74, '2025_03_20_194135_add_defaults_to_oee_records_table', 56),
(75, '2024_03_20_add_oee_columns_to_productions_table', 57),
(76, '2025_03_21_024247_create_oee_records_table', 58);

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint UNSIGNED NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `oee_alerts`
--

CREATE TABLE `oee_alerts` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED DEFAULT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `oee_score` double NOT NULL,
  `target_oee` double NOT NULL,
  `sent_at` timestamp NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oee_alerts`
--

INSERT INTO `oee_alerts` (`id`, `production_id`, `machine_id`, `oee_score`, `target_oee`, `sent_at`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 0, 85, '2025-03-19 16:49:53', '2025-03-19 16:49:53', '2025-03-19 16:49:53'),
(2, 2, 4, 0, 85, '2025-03-19 17:12:28', '2025-03-19 17:12:28', '2025-03-19 17:12:28'),
(3, 3, 4, 0, 85, '2025-03-19 17:43:29', '2025-03-19 17:43:29', '2025-03-19 17:43:29'),
(4, 4, 2, 0, 85, '2025-03-19 21:14:17', '2025-03-19 21:14:17', '2025-03-19 21:14:17'),
(5, 6, 5, 0, 85, '2025-03-19 23:00:13', '2025-03-19 23:00:13', '2025-03-19 23:00:13'),
(6, 7, 6, 0, 85, '2025-03-19 23:10:14', '2025-03-19 23:10:14', '2025-03-19 23:10:14'),
(7, 4, 6, 0, 85, '2025-03-20 12:47:35', '2025-03-20 12:47:35', '2025-03-20 12:47:35'),
(8, 5, 7, 37.5, 85, '2025-03-20 12:51:04', '2025-03-20 12:51:04', '2025-03-20 12:51:04'),
(9, 2, 2, 37.5, 85, '2025-03-20 13:16:52', '2025-03-20 13:16:52', '2025-03-20 13:16:52'),
(10, 4, 4, 50, 85, '2025-03-20 18:21:08', '2025-03-20 18:21:08', '2025-03-20 18:21:08'),
(11, 6, 7, 37.5, 85, '2025-03-20 18:33:57', '2025-03-20 18:33:57', '2025-03-20 18:33:57'),
(12, 7, 2, 25, 85, '2025-03-20 19:13:19', '2025-03-20 19:13:19', '2025-03-20 19:13:19');

-- --------------------------------------------------------

--
-- Struktur dari tabel `oee_records`
--

CREATE TABLE `oee_records` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `shift_id` bigint UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `planned_production_time` int NOT NULL DEFAULT '0',
  `operating_time` int NOT NULL DEFAULT '0',
  `downtime_problems` int NOT NULL DEFAULT '0',
  `downtime_maintenance` int NOT NULL DEFAULT '0',
  `total_downtime` int NOT NULL DEFAULT '0',
  `total_output` int NOT NULL DEFAULT '0',
  `good_output` int NOT NULL DEFAULT '0',
  `defect_count` int NOT NULL DEFAULT '0',
  `ideal_cycle_time` decimal(10,2) NOT NULL DEFAULT '0.00',
  `availability_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `performance_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `quality_rate` decimal(5,2) NOT NULL DEFAULT '0.00',
  `oee_score` decimal(5,2) NOT NULL DEFAULT '0.00',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `oee_records`
--

INSERT INTO `oee_records` (`id`, `production_id`, `machine_id`, `shift_id`, `date`, `planned_production_time`, `operating_time`, `downtime_problems`, `downtime_maintenance`, `total_downtime`, `total_output`, `good_output`, `defect_count`, `ideal_cycle_time`, `availability_rate`, `performance_rate`, `quality_rate`, `oee_score`, `created_at`, `updated_at`) VALUES
(1, 1, 4, 1, '2025-03-21', 480, 480, 0, 0, 0, 20, 10, 10, 6.00, 100.00, 25.00, 50.00, 12.50, '2025-03-20 21:56:38', '2025-03-20 21:58:30'),
(2, 2, 6, 1, '2025-03-21', 480, 480, 0, 0, 0, 20, 10, 10, 6.00, 100.00, 25.00, 50.00, 12.50, '2025-03-20 22:00:36', '2025-03-20 22:01:32'),
(3, 3, 5, 1, '2025-03-21', 480, 480, 0, 0, 0, 80, 70, 10, 6.00, 100.00, 100.00, 87.50, 87.50, '2025-03-20 22:24:00', '2025-03-20 22:24:43'),
(4, 4, 4, 1, '2025-03-21', 480, 480, 0, 0, 0, 30, 20, 10, 6.00, 100.00, 37.50, 66.67, 25.00, '2025-03-20 22:25:45', '2025-03-20 22:26:23'),
(5, 5, 2, 1, '2025-03-21', 480, 479, 0, 0, 1, 50, 40, 10, 6.00, 99.79, 62.63, 80.00, 50.00, '2025-03-21 08:57:20', '2025-03-21 09:06:43'),
(6, 6, 2, 2, '2025-03-21', 430, 430, 0, 0, 0, 30, 30, 0, 6.00, 100.00, 41.86, 100.00, 41.86, '2025-03-21 09:10:34', '2025-03-21 10:02:56');

-- --------------------------------------------------------

--
-- Struktur dari tabel `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `productions`
--

CREATE TABLE `productions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `machine_id` bigint UNSIGNED NOT NULL,
  `machine` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `product` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_per_shift` int NOT NULL,
  `cycle_time` decimal(8,2) NOT NULL DEFAULT '0.00',
  `downtime_problems` int NOT NULL DEFAULT '0',
  `downtime_maintenance` int NOT NULL DEFAULT '0',
  `total_production` int NOT NULL DEFAULT '0',
  `defect_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `defect_count` int DEFAULT '0',
  `shift_id` bigint UNSIGNED NOT NULL,
  `planned_production_time` int NOT NULL DEFAULT '0',
  `status` enum('waiting_approval','running','problem','finished','paused') COLLATE utf8mb4_unicode_ci DEFAULT 'waiting_approval',
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `productions`
--

INSERT INTO `productions` (`id`, `user_id`, `machine_id`, `machine`, `product_id`, `product`, `target_per_shift`, `cycle_time`, `downtime_problems`, `downtime_maintenance`, `total_production`, `defect_type`, `notes`, `defect_count`, `shift_id`, `planned_production_time`, `status`, `start_time`, `end_time`, `created_at`, `updated_at`) VALUES
(1, 2, 4, 'VMC 1', 2, 'D275', 80, 6.00, 0, 0, 20, NULL, NULL, 10, 1, 480, 'finished', '2025-03-20 21:56:38', '2025-03-20 21:58:30', '2025-03-20 21:56:38', '2025-03-20 21:58:30'),
(2, 2, 6, 'VMC 2', 2, 'D275', 80, 6.00, 0, 0, 20, NULL, NULL, 10, 1, 480, 'finished', '2025-03-20 22:00:36', '2025-03-20 22:01:32', '2025-03-20 22:00:36', '2025-03-20 22:01:32'),
(3, 2, 5, 'VMC 3', 2, 'D275', 80, 6.00, 0, 0, 80, NULL, NULL, 10, 1, 480, 'finished', '2025-03-20 22:24:00', '2025-03-20 22:24:43', '2025-03-20 22:24:00', '2025-03-20 22:24:43'),
(4, 2, 4, 'VMC 1', 2, 'D275', 80, 6.00, 0, 0, 30, NULL, NULL, 10, 1, 480, 'finished', '2025-03-20 22:25:45', '2025-03-20 22:26:23', '2025-03-20 22:25:45', '2025-03-20 22:26:23'),
(5, 2, 2, 'Mesin B', 2, 'D275', 80, 6.00, 0, 0, 50, NULL, NULL, 10, 1, 480, 'finished', '2025-03-21 08:57:20', '2025-03-21 09:06:43', '2025-03-21 08:57:20', '2025-03-21 09:06:43'),
(6, 2, 2, 'Mesin B', 2, 'D275', 80, 6.00, 0, 0, 30, NULL, NULL, 0, 2, 430, 'finished', '2025-03-21 09:10:34', '2025-03-21 10:02:56', '2025-03-21 09:10:34', '2025-03-21 10:02:56');

-- --------------------------------------------------------

--
-- Struktur dari tabel `production_checks`
--

CREATE TABLE `production_checks` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `maintenance_task_id` bigint UNSIGNED NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `photo_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `production_downtimes`
--

CREATE TABLE `production_downtimes` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `reason` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `start_time` timestamp NOT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `duration_minutes` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `production_downtimes`
--

INSERT INTO `production_downtimes` (`id`, `production_id`, `reason`, `notes`, `start_time`, `end_time`, `duration_minutes`, `created_at`, `updated_at`) VALUES
(1, 5, 'uhuy', 'asda', '2025-03-21 08:57:35', '2025-03-21 08:58:55', 1, '2025-03-21 08:57:35', '2025-03-21 08:58:55');

-- --------------------------------------------------------

--
-- Struktur dari tabel `production_problems`
--

CREATE TABLE `production_problems` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `problem_type` enum('mesin','material','operator','lainnya') COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `duration` int NOT NULL DEFAULT '0',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('pending','approved','rejected','resolved') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `reported_at` timestamp NOT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `resolved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `production_sop_checks`
--

CREATE TABLE `production_sop_checks` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `sop_step_id` bigint UNSIGNED NOT NULL,
  `nilai` decimal(10,2) DEFAULT NULL,
  `status` enum('ok','ng') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `sop_id` bigint UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target_per_hour` int DEFAULT NULL,
  `target_per_shift` int DEFAULT NULL,
  `target_per_day` int DEFAULT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `cycle_time` decimal(10,2) DEFAULT NULL COMMENT 'Ideal cycle time in minutes per unit'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `products`
--

INSERT INTO `products` (`id`, `name`, `target_per_hour`, `target_per_shift`, `target_per_day`, `code`, `description`, `unit`, `created_at`, `updated_at`, `cycle_time`) VALUES
(1, 'D375', 20, 160, 480, '0001-D375', NULL, 'SET', '2025-03-13 19:44:44', '2025-03-17 10:38:05', 3.00),
(2, 'D275', 10, 80, 260, '0001-D275', NULL, 'SET', '2025-03-13 19:51:43', '2025-03-17 10:37:43', 6.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `quality_checks`
--

CREATE TABLE `quality_checks` (
  `id` bigint UNSIGNED NOT NULL,
  `production_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `check_time` datetime NOT NULL,
  `sample_size` int NOT NULL,
  `status` enum('ok','ng') COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `defect_count` int DEFAULT NULL,
  `defect_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `defect_notes` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `quality_checks`
--

INSERT INTO `quality_checks` (`id`, `production_id`, `user_id`, `check_time`, `sample_size`, `status`, `notes`, `created_at`, `updated_at`, `defect_count`, `defect_type`, `defect_notes`) VALUES
(1, 1, 2, '2025-03-21 04:57:01', 1, 'ng', NULL, '2025-03-20 21:57:01', '2025-03-20 21:57:01', 10, 'test NG', 'test NG'),
(2, 2, 2, '2025-03-21 05:01:15', 1, 'ng', NULL, '2025-03-20 22:01:15', '2025-03-20 22:01:15', 10, 'test NG', 'test NG'),
(3, 3, 2, '2025-03-21 05:24:34', 1, 'ng', NULL, '2025-03-20 22:24:34', '2025-03-20 22:24:34', 10, 'test NG', 'test NG'),
(4, 4, 2, '2025-03-21 05:26:10', 1, 'ng', NULL, '2025-03-20 22:26:10', '2025-03-20 22:26:10', 10, 'asdasd', 'asdasd'),
(5, 5, 2, '2025-03-21 15:59:19', 1, 'ng', NULL, '2025-03-21 08:59:19', '2025-03-21 08:59:19', 10, 'asdas', 'asdsa'),
(6, 6, 2, '2025-03-21 16:49:51', 1, 'ok', NULL, '2025-03-21 09:17:44', '2025-03-21 09:49:51', 0, NULL, NULL),
(7, 6, 2, '2025-03-21 16:53:14', 1, 'ok', NULL, '2025-03-21 09:53:14', '2025-03-21 09:53:14', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `quality_check_details`
--

CREATE TABLE `quality_check_details` (
  `id` bigint UNSIGNED NOT NULL,
  `quality_check_id` bigint UNSIGNED NOT NULL,
  `parameter` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `standard_value` decimal(15,6) DEFAULT NULL,
  `measured_value` decimal(15,6) DEFAULT NULL,
  `tolerance_min` decimal(15,6) DEFAULT NULL,
  `tolerance_max` decimal(15,6) DEFAULT NULL,
  `status` enum('ok','ng') COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `quality_check_details`
--

INSERT INTO `quality_check_details` (`id`, `quality_check_id`, `parameter`, `standard_value`, `measured_value`, `tolerance_min`, `tolerance_max`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'TEST1', 20.000000, 23.000000, 19.000000, 21.000000, 'ng', '2025-03-20 21:57:01', '2025-03-20 21:57:01'),
(2, 1, 'TEST2', 20.000000, 23.000000, 19.000000, 21.000000, 'ok', '2025-03-20 21:57:01', '2025-03-20 21:57:01'),
(3, 2, 'TEST1', 20.000000, 23.000000, 19.000000, 21.000000, 'ng', '2025-03-20 22:01:15', '2025-03-20 22:01:15'),
(4, 2, 'TEST2', 20.000000, 23.000000, 19.000000, 21.000000, 'ok', '2025-03-20 22:01:15', '2025-03-20 22:01:15'),
(5, 3, 'TEST1', 20.000000, 23.000000, 19.000000, 21.000000, 'ng', '2025-03-20 22:24:34', '2025-03-20 22:24:34'),
(6, 3, 'TEST2', 20.000000, 23.000000, 19.000000, 21.000000, 'ok', '2025-03-20 22:24:34', '2025-03-20 22:24:34'),
(7, 4, 'TEST1', 20.000000, 23.000000, 19.000000, 21.000000, 'ng', '2025-03-20 22:26:10', '2025-03-20 22:26:10'),
(8, 4, 'TEST2', 20.000000, 23.000000, 19.000000, 21.000000, 'ok', '2025-03-20 22:26:10', '2025-03-20 22:26:10'),
(9, 5, 'TEST1', 20.000000, 23.000000, 19.000000, 21.000000, 'ng', '2025-03-21 08:59:19', '2025-03-21 08:59:19'),
(10, 5, 'TEST2', 20.000000, 23.000000, 19.000000, 21.000000, 'ok', '2025-03-21 08:59:19', '2025-03-21 08:59:19'),
(31, 6, 'TEST1', 20.000000, 21.000000, 19.000000, 21.000000, 'ok', '2025-03-21 09:49:51', '2025-03-21 09:49:51'),
(32, 6, 'TEST2', 20.000000, 21.000000, 19.000000, 21.000000, 'ok', '2025-03-21 09:49:51', '2025-03-21 09:49:51'),
(33, 7, 'TEST1', 20.000000, 21.000000, 19.000000, 21.000000, 'ok', '2025-03-21 09:53:14', '2025-03-21 09:53:14'),
(34, 7, 'TEST2', 20.000000, 21.000000, 19.000000, 21.000000, 'ok', '2025-03-21 09:53:14', '2025-03-21 09:53:14');

-- --------------------------------------------------------

--
-- Struktur dari tabel `roles`
--

CREATE TABLE `roles` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('eB4ImhQntYSsMGW6vDn0lPCgEzOvwyyI73Q667w4', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoicDdCUHFkSUJleXFLS1UycDg2SmVEWnhHMGlLeVhWUDFUajRiczlPdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9rYXJ5YXdhbi9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1742551751),
('ExiAwQU5utLYED6OZUCXjLPBYUaYJH6J01ruLHMp', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiZmswa21mc3VPMUM5WU1HMUpncWphbFRTMXRXNFF4blZtSm9NUm5aVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxMzoiY3VycmVudF9zaGlmdCI7YToyOntzOjI6ImlkIjtpOjI7czo0OiJuYW1lIjtzOjc6IlNoaWZ0IDIiO31zOjE4OiJwZW5kaW5nX3Byb2R1Y3Rpb24iO2E6OTp7czoxMDoibWFjaGluZV9pZCI7czoxOiIyIjtzOjEyOiJtYWNoaW5lX25hbWUiO3M6NzoiTWVzaW4gQiI7czo4OiJzaGlmdF9pZCI7czoxOiIyIjtzOjEwOiJwcm9kdWN0X2lkIjtpOjI7czoxMjoicHJvZHVjdF9uYW1lIjtzOjQ6IkQyNzUiO3M6MTY6InRhcmdldF9wZXJfc2hpZnQiO2k6ODA7czoxMDoiY3ljbGVfdGltZSI7czo0OiI2LjAwIjtzOjIzOiJwbGFubmVkX3Byb2R1Y3Rpb25fdGltZSI7aTo0MzA7czoxNDoicXVhbGl0eV9zb3BfaWQiO2k6MTQ7fX0=', 1742551706),
('nkUTeE6Eklumk2ZB9isbS0SATPDJMQUutWm7U9YJ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMFZlS3FPUFVpbFNDbUo0Ym9NcGdWMWdycnA0ZjZZS0syS1NicTgyUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9tYW5hamVyaWFsL29lZS9kYXNoYm9hcmQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1742551502),
('rv7tC7DX7NmStOOAb27toYrsyW9eHQ6GyD25H5rm', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiaUt1dXRpTWQzaXdYZnRiMGd6T2JVVDRrQ3UxSWxzYnI3U2hZckJFbCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjIxOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1742547325),
('RXRP5lQzgghynfqGBVLuYGGjit5tkPAw86XEuQO3', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiaUtNZ2U4R3FwMjhLVWlldEg3M2ZSY2YyYzhpREVDWENNeWhsaDlDMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9rYXJ5YXdhbi9wcm9kdWN0aW9uL3N0YXJ0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MTp7aTowO3M6NToiZXJyb3IiO31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czoxODoicGVuZGluZ19wcm9kdWN0aW9uIjthOjk6e3M6MTA6Im1hY2hpbmVfaWQiO3M6MToiNCI7czoxMjoibWFjaGluZV9uYW1lIjtzOjU6IlZNQyAxIjtzOjg6InNoaWZ0X2lkIjtzOjE6IjIiO3M6MTA6InByb2R1Y3RfaWQiO2k6MjtzOjEyOiJwcm9kdWN0X25hbWUiO3M6NDoiRDI3NSI7czoxNjoidGFyZ2V0X3Blcl9zaGlmdCI7aTo4MDtzOjEwOiJjeWNsZV90aW1lIjtzOjQ6IjYuMDAiO3M6MjM6InBsYW5uZWRfcHJvZHVjdGlvbl90aW1lIjtpOjQzMDtzOjE0OiJxdWFsaXR5X3NvcF9pZCI7aToxNDt9czo1OiJlcnJvciI7czozNToiVGlkYWsgYWRhIHNoaWZ0IHlhbmcgYWt0aWYgc2FhdCBpbmkiO30=', 1742574386);

-- --------------------------------------------------------

--
-- Struktur dari tabel `shifts`
--

CREATE TABLE `shifts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `planned_operation_time` int NOT NULL COMMENT 'in minutes',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `shifts`
--

INSERT INTO `shifts` (`id`, `name`, `start_time`, `end_time`, `planned_operation_time`, `created_at`, `updated_at`, `status`) VALUES
(1, 'Shift 1', '07:00:00', '15:00:00', 480, '2025-03-09 10:19:52', '2025-03-09 11:44:06', 'active'),
(2, 'Shift 2', '15:00:00', '23:00:00', 430, '2025-03-09 10:19:52', '2025-03-09 10:19:52', 'active'),
(3, 'Shfit 3', '11:45:00', '07:30:00', 460, '2025-03-09 11:31:31', '2025-03-09 11:31:31', 'active');

-- --------------------------------------------------------

--
-- Struktur dari tabel `sops`
--

CREATE TABLE `sops` (
  `id` bigint UNSIGNED NOT NULL,
  `no_sop` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kategori` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval_check` int NOT NULL DEFAULT '1' COMMENT 'Interval pengecekan dalam jumlah pcs (khusus quality)',
  `deskripsi` text COLLATE utf8mb4_unicode_ci,
  `versi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1.0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `machine_id` bigint UNSIGNED DEFAULT NULL,
  `product_id` bigint UNSIGNED DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `created_by` bigint UNSIGNED DEFAULT NULL,
  `approved_by` bigint UNSIGNED DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `approval_status` enum('draft','pending','approved','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `submitted_at` timestamp NULL DEFAULT NULL,
  `submitted_by` bigint UNSIGNED DEFAULT NULL,
  `rejection_reason` text COLLATE utf8mb4_unicode_ci,
  `rejected_by` bigint UNSIGNED DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sops`
--

INSERT INTO `sops` (`id`, `no_sop`, `nama`, `kategori`, `interval_check`, `deskripsi`, `versi`, `is_active`, `created_at`, `updated_at`, `machine_id`, `product_id`, `created_date`, `created_by`, `approved_by`, `approved_at`, `approval_status`, `submitted_at`, `submitted_by`, `rejection_reason`, `rejected_by`, `rejected_at`) VALUES
(14, 'SOP-QCD275-15032025', 'SOP IPQC D375', 'quality', 1, 'SOP-QCD275-15032025\nSOP IPQC D375', '1.0', 1, '2025-03-15 14:40:02', '2025-03-15 14:41:51', NULL, 2, '2025-03-15 14:40:02', 1, 1, '2025-03-15 14:41:51', 'approved', NULL, NULL, NULL, NULL, NULL),
(15, 'SOP-PROVMC1-16032025', 'SOP PRODUKSI VMC 1', 'produksi', 1, 'SOP-PROVMC1-16032025\nSOP PRODUKSI VMC 1', '1.0', 1, '2025-03-15 18:39:01', '2025-03-15 18:40:23', 4, NULL, '2025-03-15 18:39:01', 1, 1, '2025-03-15 18:40:23', 'approved', NULL, NULL, NULL, NULL, NULL),
(16, 'SOP-PROVMC2-17032025', 'SOP PRODUKSI VMC 2', 'produksi', 1, 'SOP-PROVMC2-17032025\nSOP PRODUKSI VMC 2', '1.0', 1, '2025-03-16 17:34:23', '2025-03-16 17:39:28', 6, NULL, '2025-03-16 17:34:23', 1, 1, '2025-03-16 17:39:28', 'approved', NULL, NULL, NULL, NULL, NULL),
(17, 'SOP-QCD375-16032025', 'SOP IPQC D375', 'quality', 1, 'SOP-QCD375-16032025\nSOP IPQC D375', '1.0', 1, '2025-03-16 17:35:36', '2025-03-16 17:38:24', NULL, 1, '2025-03-16 17:35:36', 1, 1, '2025-03-16 17:38:24', 'approved', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `sop_steps`
--

CREATE TABLE `sop_steps` (
  `id` bigint UNSIGNED NOT NULL,
  `sop_id` bigint UNSIGNED NOT NULL,
  `urutan` int NOT NULL,
  `judul` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `gambar_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_checkpoint` tinyint(1) NOT NULL DEFAULT '0',
  `needs_standard` tinyint(1) NOT NULL DEFAULT '0',
  `nilai_standar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `toleransi_min` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `toleransi_max` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `measurement_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Satuan pengukuran (mm, cm, m, etc)',
  `measurement_type` enum('length','diameter','weight','temperature','pressure','angle','time','other') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `interval_value` int DEFAULT NULL COMMENT 'Nilai interval pengecekan',
  `interval_unit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Satuan interval (pcs, set, box, batch, hour, shift)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `sop_steps`
--

INSERT INTO `sop_steps` (`id`, `sop_id`, `urutan`, `judul`, `deskripsi`, `gambar_path`, `is_checkpoint`, `needs_standard`, `nilai_standar`, `toleransi_min`, `toleransi_max`, `measurement_unit`, `measurement_type`, `interval_value`, `interval_unit`, `created_at`, `updated_at`) VALUES
(26, 14, 1, 'TEST1', 'TEST1', 'sop-images/1742049647_Besi-CNP.png', 0, 1, '20', '19', '21', 'mm', 'diameter', 10, 'set', '2025-03-15 14:40:47', '2025-03-15 14:40:47'),
(27, 14, 2, 'TEST2', 'TEST2', 'sop-images/1742049697_17.-Perbandingan-Besi-Hollow-Galvanis-dengan-Material-Lain-Teknoscaff-2.jpg', 0, 1, '20', '19', '21', 'mm', 'diameter', 10, 'set', '2025-03-15 14:41:37', '2025-03-15 14:41:37'),
(28, 15, 1, 'Periksa Colant', 'pastikan ada', 'sop-images/1742063978_Besi-CNP.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-15 18:39:38', '2025-03-15 18:39:38'),
(29, 15, 2, 'Periksa Tols', 'Pastikan Insert baru', 'sop-images/1742064012_8b46dd59-352e-4a3e-99d7-184977dc90ae.jpg', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-15 18:40:12', '2025-03-15 18:40:12'),
(30, 17, 1, 'TEST1', 'TEST1', 'sop-images/1742146629_faca7531-a385-4217-82d5-e7c5d6cafe39.jpeg', 0, 1, '0,0072', '0,0070', '0,0074', 'mm', 'diameter', 10, 'set', '2025-03-16 17:37:09', '2025-03-16 17:37:09'),
(31, 17, 2, 'TEST2', 'TEST2', 'sop-images/1742146695_Besi-CNP.png', 0, 1, '0,0082', '0,0080', '0,0084', 'mm', 'diameter', 10, 'set', '2025-03-16 17:38:15', '2025-03-16 18:21:39'),
(32, 16, 1, 'PASTIKAN OLI ADA', 'MIN 3 MAX 3', 'sop-images/1742146742_Besi-CNP.png', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-16 17:39:02', '2025-03-16 17:39:02'),
(33, 16, 2, 'PASTIKAN LISTRIK ADA', 'PASTIKAN LISTRIK ADA', 'sop-images/1742146760_images (3).jpg', 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-03-16 17:39:20', '2025-03-16 17:39:20');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `role` enum('manajerial','karyawan') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'karyawan',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `department_id` bigint UNSIGNED DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `role`, `password`, `remember_token`, `created_at`, `updated_at`, `department_id`, `status`) VALUES
(1, 'manajerial', 'manajerial@example.com', '2025-03-09 10:20:25', 'manajerial', '$2y$12$ZmQQLUC5hjxHqSVcQpn28uE0l18DTfCk31TXAegnleq7iS5ofFTKS', '8UkjtAgBw6FDY9UCTxUTzllfHbKOXgQo0xPqCKnqTn49mIik8VUllzJCdPR4', '2025-03-09 10:20:25', '2025-03-09 10:20:25', NULL, 'active'),
(2, 'karyawa', 'karyawa@example.com', '2025-03-09 10:20:26', 'karyawan', '$2y$12$fKu.8y1pPuQO97zxR3teae.T3BI2GS.ZiZB5yxGshqCVlId/52pEu', 'tIpQKtj9mrXmHjHuQI4EXNEDmKXDuit7V7IsPWq1AxU09c5XYXF9ocH1f1qm', '2025-03-09 10:20:26', '2025-03-15 16:34:11', 1, 'active'),
(3, 'abdul', 'abdul@gmail.com', NULL, 'karyawan', '$2y$12$0diGEG5SsWzidPFQLV4AIu8LA2PwpE2S0yHGluzdY91pvj4mo0ptu', NULL, '2025-03-16 17:52:46', '2025-03-16 17:52:46', 1, 'active');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indeks untuk tabel `checksheet_entries`
--
ALTER TABLE `checksheet_entries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `checksheet_entries_task_id_foreign` (`task_id`),
  ADD KEY `checksheet_entries_production_id_foreign` (`production_id`),
  ADD KEY `checksheet_entries_shift_id_foreign` (`shift_id`),
  ADD KEY `checksheet_entries_user_id_foreign` (`user_id`),
  ADD KEY `machine_id` (`machine_id`);

--
-- Indeks untuk tabel `checksheet_histories`
--
ALTER TABLE `checksheet_histories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `checksheet_histories_checksheet_type_checksheet_id_index` (`checksheet_type`,`checksheet_id`),
  ADD KEY `checksheet_histories_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `checksheet_results`
--
ALTER TABLE `checksheet_results`
  ADD PRIMARY KEY (`id`),
  ADD KEY `checksheet_results_machine_id_foreign` (`machine_id`),
  ADD KEY `checksheet_results_shift_id_foreign` (`shift_id`),
  ADD KEY `checksheet_results_task_id_foreign` (`task_id`),
  ADD KEY `checksheet_results_operator_id_foreign` (`operator_id`);

--
-- Indeks untuk tabel `checksheet_tasks`
--
ALTER TABLE `checksheet_tasks`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `checksheet_task_results`
--
ALTER TABLE `checksheet_task_results`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `downtime_records`
--
ALTER TABLE `downtime_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oee_record_id` (`oee_record_id`);

--
-- Indeks untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indeks untuk tabel `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indeks untuk tabel `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `machines`
--
ALTER TABLE `machines`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `machines_code_unique` (`code`);

--
-- Indeks untuk tabel `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `maintenance_schedules_machine_id_foreign` (`machine_id`),
  ADD KEY `maintenance_schedules_shift_id_foreign` (`shift_id`);

--
-- Indeks untuk tabel `maintenance_tasks`
--
ALTER TABLE `maintenance_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `maintenance_tasks_machine_id_foreign` (`machine_id`);

--
-- Indeks untuk tabel `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indeks untuk tabel `oee_alerts`
--
ALTER TABLE `oee_alerts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `oee_alerts_production_id_machine_id_unique` (`production_id`,`machine_id`),
  ADD KEY `oee_alerts_machine_id_foreign` (`machine_id`);

--
-- Indeks untuk tabel `oee_records`
--
ALTER TABLE `oee_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oee_records_production_id_foreign` (`production_id`),
  ADD KEY `oee_records_machine_id_foreign` (`machine_id`),
  ADD KEY `oee_records_shift_id_foreign` (`shift_id`);

--
-- Indeks untuk tabel `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indeks untuk tabel `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indeks untuk tabel `productions`
--
ALTER TABLE `productions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productions_user_id_foreign` (`user_id`),
  ADD KEY `productions_machine_id_foreign` (`machine_id`),
  ADD KEY `productions_product_id_foreign` (`product_id`),
  ADD KEY `productions_shift_id_foreign` (`shift_id`);

--
-- Indeks untuk tabel `production_checks`
--
ALTER TABLE `production_checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_checks_production_id_foreign` (`production_id`),
  ADD KEY `production_checks_maintenance_task_id_foreign` (`maintenance_task_id`);

--
-- Indeks untuk tabel `production_downtimes`
--
ALTER TABLE `production_downtimes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_downtimes_production_id_foreign` (`production_id`);

--
-- Indeks untuk tabel `production_problems`
--
ALTER TABLE `production_problems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_problems_production_id_foreign` (`production_id`);

--
-- Indeks untuk tabel `production_sop_checks`
--
ALTER TABLE `production_sop_checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `production_sop_checks_production_id_foreign` (`production_id`),
  ADD KEY `production_sop_checks_sop_step_id_foreign` (`sop_step_id`),
  ADD KEY `production_sop_checks_sop_id_foreign` (`sop_id`);

--
-- Indeks untuk tabel `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `quality_checks`
--
ALTER TABLE `quality_checks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `quality_checks_production_id_foreign` (`production_id`),
  ADD KEY `quality_checks_user_id_foreign` (`user_id`);

--
-- Indeks untuk tabel `quality_check_details`
--
ALTER TABLE `quality_check_details`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indeks untuk tabel `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indeks untuk tabel `shifts`
--
ALTER TABLE `shifts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `sops`
--
ALTER TABLE `sops`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sops_created_by_foreign` (`created_by`),
  ADD KEY `sops_approved_by_foreign` (`approved_by`),
  ADD KEY `submitted_by` (`submitted_by`),
  ADD KEY `rejected_by` (`rejected_by`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `machine_id` (`machine_id`);

--
-- Indeks untuk tabel `sop_steps`
--
ALTER TABLE `sop_steps`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sop_steps_sop_id_foreign` (`sop_id`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_department_id_foreign` (`department_id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `checksheet_entries`
--
ALTER TABLE `checksheet_entries`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `checksheet_histories`
--
ALTER TABLE `checksheet_histories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `checksheet_results`
--
ALTER TABLE `checksheet_results`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `checksheet_tasks`
--
ALTER TABLE `checksheet_tasks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `checksheet_task_results`
--
ALTER TABLE `checksheet_task_results`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT untuk tabel `downtime_records`
--
ALTER TABLE `downtime_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT untuk tabel `machines`
--
ALTER TABLE `machines`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `maintenance_tasks`
--
ALTER TABLE `maintenance_tasks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT untuk tabel `oee_alerts`
--
ALTER TABLE `oee_alerts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT untuk tabel `oee_records`
--
ALTER TABLE `oee_records`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `productions`
--
ALTER TABLE `productions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `production_checks`
--
ALTER TABLE `production_checks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `production_downtimes`
--
ALTER TABLE `production_downtimes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `production_problems`
--
ALTER TABLE `production_problems`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `production_sop_checks`
--
ALTER TABLE `production_sop_checks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `quality_checks`
--
ALTER TABLE `quality_checks`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT untuk tabel `quality_check_details`
--
ALTER TABLE `quality_check_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT untuk tabel `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `shifts`
--
ALTER TABLE `shifts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `sops`
--
ALTER TABLE `sops`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT untuk tabel `sop_steps`
--
ALTER TABLE `sop_steps`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `checksheet_entries`
--
ALTER TABLE `checksheet_entries`
  ADD CONSTRAINT `checksheet_entries_ibfk_1` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`),
  ADD CONSTRAINT `checksheet_entries_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checksheet_entries_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checksheet_entries_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `maintenance_tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checksheet_entries_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `checksheet_histories`
--
ALTER TABLE `checksheet_histories`
  ADD CONSTRAINT `checksheet_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `checksheet_results`
--
ALTER TABLE `checksheet_results`
  ADD CONSTRAINT `checksheet_results_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checksheet_results_operator_id_foreign` FOREIGN KEY (`operator_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checksheet_results_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `checksheet_results_task_id_foreign` FOREIGN KEY (`task_id`) REFERENCES `maintenance_tasks` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `downtime_records`
--
ALTER TABLE `downtime_records`
  ADD CONSTRAINT `downtime_records_ibfk_1` FOREIGN KEY (`oee_record_id`) REFERENCES `oee_records` (`id`);

--
-- Ketidakleluasaan untuk tabel `maintenance_schedules`
--
ALTER TABLE `maintenance_schedules`
  ADD CONSTRAINT `maintenance_schedules_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `maintenance_schedules_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `maintenance_tasks`
--
ALTER TABLE `maintenance_tasks`
  ADD CONSTRAINT `maintenance_tasks_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `oee_alerts`
--
ALTER TABLE `oee_alerts`
  ADD CONSTRAINT `oee_alerts_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `oee_alerts_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `oee_records`
--
ALTER TABLE `oee_records`
  ADD CONSTRAINT `oee_records_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`),
  ADD CONSTRAINT `oee_records_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `oee_records_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`);

--
-- Ketidakleluasaan untuk tabel `productions`
--
ALTER TABLE `productions`
  ADD CONSTRAINT `productions_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`),
  ADD CONSTRAINT `productions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `productions_shift_id_foreign` FOREIGN KEY (`shift_id`) REFERENCES `shifts` (`id`),
  ADD CONSTRAINT `productions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `production_checks`
--
ALTER TABLE `production_checks`
  ADD CONSTRAINT `production_checks_maintenance_task_id_foreign` FOREIGN KEY (`maintenance_task_id`) REFERENCES `maintenance_tasks` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `production_checks_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `production_downtimes`
--
ALTER TABLE `production_downtimes`
  ADD CONSTRAINT `production_downtimes_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `production_problems`
--
ALTER TABLE `production_problems`
  ADD CONSTRAINT `production_problems_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `production_sop_checks`
--
ALTER TABLE `production_sop_checks`
  ADD CONSTRAINT `production_sop_checks_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `production_sop_checks_sop_id_foreign` FOREIGN KEY (`sop_id`) REFERENCES `sops` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `production_sop_checks_sop_step_id_foreign` FOREIGN KEY (`sop_step_id`) REFERENCES `sop_steps` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `quality_checks`
--
ALTER TABLE `quality_checks`
  ADD CONSTRAINT `quality_checks_production_id_foreign` FOREIGN KEY (`production_id`) REFERENCES `productions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `quality_checks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Ketidakleluasaan untuk tabel `sops`
--
ALTER TABLE `sops`
  ADD CONSTRAINT `sops_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `sops_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `sops_ibfk_1` FOREIGN KEY (`submitted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sops_ibfk_2` FOREIGN KEY (`rejected_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `sops_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `sops_ibfk_4` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`),
  ADD CONSTRAINT `sops_machine_id_foreign` FOREIGN KEY (`machine_id`) REFERENCES `machines` (`id`),
  ADD CONSTRAINT `sops_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Ketidakleluasaan untuk tabel `sop_steps`
--
ALTER TABLE `sop_steps`
  ADD CONSTRAINT `sop_steps_sop_id_foreign` FOREIGN KEY (`sop_id`) REFERENCES `sops` (`id`) ON DELETE CASCADE;

--
-- Ketidakleluasaan untuk tabel `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
