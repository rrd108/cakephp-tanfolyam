-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Gép: localhost:3306
-- Létrehozás ideje: 2017. Aug 12. 10:43
-- Kiszolgáló verziója: 5.7.19-0ubuntu0.17.04.1
-- PHP verzió: 5.6.31-4+ubuntu17.04.1+deb.sury.org+4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `quotes`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `authors`
--

CREATE TABLE `authors` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `authors`
--

INSERT INTO `authors` (`id`, `name`) VALUES
(2, 'Bhagavad-gita'),
(3, 'Kínai mondás'),
(4, 'rrd<script>alert(\'xss\');</script>'),
(1, 'Yoda');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cake_d_c_users_phinxlog`
--

CREATE TABLE `cake_d_c_users_phinxlog` (
  `version` bigint(20) NOT NULL,
  `migration_name` varchar(100) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL,
  `end_time` timestamp NULL DEFAULT NULL,
  `breakpoint` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cake_d_c_users_phinxlog`
--

INSERT INTO `cake_d_c_users_phinxlog` (`version`, `migration_name`, `start_time`, `end_time`, `breakpoint`) VALUES
(20150513201111, 'Initial', '2017-08-10 11:47:45', '2017-08-10 11:47:46', 0),
(20161031101316, 'AddSecretToUsers', '2017-08-10 11:47:46', '2017-08-10 11:47:49', 0);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `quotes`
--

CREATE TABLE `quotes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `quote` text COLLATE utf8_hungarian_ci NOT NULL,
  `created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `quotes`
--

INSERT INTO `quotes` (`id`, `user_id`, `author_id`, `quote`, `created`) VALUES
(1, '9f731537-6f6b-4e55-adbb-c0dd4b7eae45', 1, 'Tedd vagy ne tedd, de ne próbáld!', '2017-07-20 09:42:46'),
(2, '5d41bcd1-b100-4556-a8d4-4f20b5d875ff', 2, 'A lélek nem ismer sem születést, sem halált. Soha nem keletkezett, nem most jön létre, és a jövőben sem fog megszületni. Születetlen, örökkévaló, mindig létező és ősi, s ha a testet meg is ölik, ő akkor sem pusztul el.', '2017-07-20 09:43:34'),
(3, '9f731537-6f6b-4e55-adbb-c0dd4b7eae45', 3, 'A sárkány a széllel szemben, és nem a szél irányában emelkedik a magasba!', '2017-07-20 09:43:49');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `quotes_tags`
--

CREATE TABLE `quotes_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `quote_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `quotes_tags`
--

INSERT INTO `quotes_tags` (`id`, `quote_id`, `tag_id`) VALUES
(1, 1, 1),
(2, 1, 3),
(3, 2, 1),
(4, 3, 2),
(5, 3, 3);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `social_accounts`
--

CREATE TABLE `social_accounts` (
  `id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `provider` varchar(255) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `reference` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `description` text,
  `link` varchar(255) NOT NULL,
  `token` varchar(500) NOT NULL,
  `token_secret` varchar(500) DEFAULT NULL,
  `token_expires` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `data` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `tags`
--

INSERT INTO `tags` (`id`, `name`) VALUES
(1, 'bölcsesség'),
(2, 'happy'),
(3, 'pozitív');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `users`
--

CREATE TABLE `users` (
  `id` char(36) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `token_expires` datetime DEFAULT NULL,
  `api_token` varchar(255) DEFAULT NULL,
  `activation_date` datetime DEFAULT NULL,
  `secret` varchar(32) DEFAULT NULL,
  `secret_verified` tinyint(1) DEFAULT NULL,
  `tos_date` datetime DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '0',
  `is_superuser` tinyint(1) NOT NULL DEFAULT '0',
  `role` varchar(255) DEFAULT 'user',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `first_name`, `last_name`, `token`, `token_expires`, `api_token`, `activation_date`, `secret`, `secret_verified`, `tos_date`, `active`, `is_superuser`, `role`, `created`, `modified`) VALUES
('5d41bcd1-b100-4556-a8d4-4f20b5d875ff', 'rrd', 'rrd@webmania.cc', '$2y$10$ZUgQkZM6JSbytQbzQiKMeengnU355ajI//RDWUBfKSzP5kfiwzfai', '', '', '40ed4a9982aa4207b0098505b6ae6552', '2017-08-10 14:53:48', NULL, NULL, NULL, NULL, '2017-08-10 13:53:48', 1, 1, 'superuser', '2017-08-10 13:53:48', '2017-08-10 13:53:48'),
('9f731537-6f6b-4e55-adbb-c0dd4b7eae45', 'Bendegúz', 'bendeguz@sehol.se', '$2y$10$T0.OsNddsEGjpfo8rXbVLepw1oVRFEDpB.axdVxy/d2BRvUHOnuXC', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 'user', '2017-08-10 14:23:07', '2017-08-10 14:23:07');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `authors`
--
ALTER TABLE `authors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- A tábla indexei `cake_d_c_users_phinxlog`
--
ALTER TABLE `cake_d_c_users_phinxlog`
  ADD PRIMARY KEY (`version`);

--
-- A tábla indexei `quotes`
--
ALTER TABLE `quotes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_quotes_authors_idx` (`author_id`),
  ADD KEY `fk_quotes_users1_idx` (`user_id`);

--
-- A tábla indexei `quotes_tags`
--
ALTER TABLE `quotes_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_tags_has_quotes_quotes1_idx` (`quote_id`),
  ADD KEY `fk_tags_has_quotes_tags1_idx` (`tag_id`);

--
-- A tábla indexei `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- A tábla indexei `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_UNIQUE` (`name`);

--
-- A tábla indexei `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `authors`
--
ALTER TABLE `authors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT a táblához `quotes`
--
ALTER TABLE `quotes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT a táblához `quotes_tags`
--
ALTER TABLE `quotes_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT a táblához `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `quotes`
--
ALTER TABLE `quotes`
  ADD CONSTRAINT `fk_quotes_authors` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`),
  ADD CONSTRAINT `fk_quotes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Megkötések a táblához `quotes_tags`
--
ALTER TABLE `quotes_tags`
  ADD CONSTRAINT `fk_tags_has_quotes_quotes1` FOREIGN KEY (`quote_id`) REFERENCES `quotes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_tags_has_quotes_tags1` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`);

--
-- Megkötések a táblához `social_accounts`
--
ALTER TABLE `social_accounts`
  ADD CONSTRAINT `social_accounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
