-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Client: localhost
-- Généré le: Dim 02 Décembre 2012 à 16:58
-- Version du serveur: 5.5.24-log
-- Version de PHP: 5.3.13

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `setsettal`
--

-- --------------------------------------------------------

--
-- Structure de la table `actions`
--

CREATE TABLE IF NOT EXISTS `actions` (
  `action_id` int(11) NOT NULL AUTO_INCREMENT,
  `action` varchar(75) NOT NULL,
  `qualifiers` text NOT NULL,
  `response` varchar(75) NOT NULL,
  `response_vars` text NOT NULL,
  `active` tinyint(4) NOT NULL,
  PRIMARY KEY (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user defined actions triggered by certain events' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `actions_log`
--

CREATE TABLE IF NOT EXISTS `actions_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `action_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `action_id` (`action_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of triggered actions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `alert`
--

CREATE TABLE IF NOT EXISTS `alert` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `alert_type` tinyint(4) NOT NULL COMMENT '1 - MOBILE, 2 - EMAIL',
  `alert_recipient` varchar(200) DEFAULT NULL,
  `alert_code` varchar(30) DEFAULT NULL,
  `alert_confirmed` tinyint(4) NOT NULL DEFAULT '0',
  `alert_lat` varchar(150) DEFAULT NULL,
  `alert_lon` varchar(150) DEFAULT NULL,
  `alert_radius` tinyint(4) NOT NULL DEFAULT '20',
  `alert_ip` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_alert_code` (`alert_code`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores alerts subscribers information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `alert_category`
--

CREATE TABLE IF NOT EXISTS `alert_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alert_id` bigint(20) unsigned DEFAULT NULL,
  `category_id` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alert_id` (`alert_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores subscriber alert categories' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `alert_sent`
--

CREATE TABLE IF NOT EXISTS `alert_sent` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `alert_id` bigint(20) unsigned NOT NULL,
  `alert_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `alert_id` (`alert_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores a log of alerts sent out to subscribers' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `api_banned`
--

CREATE TABLE IF NOT EXISTS `api_banned` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `banned_ipaddress` varchar(50) NOT NULL,
  `banned_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For logging banned API IP addresses' AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- Structure de la table `api_log`
--

CREATE TABLE IF NOT EXISTS `api_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `api_task` varchar(10) NOT NULL,
  `api_parameters` varchar(100) NOT NULL,
  `api_records` tinyint(11) NOT NULL,
  `api_ipaddress` varchar(50) NOT NULL,
  `api_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='For logging API activities' AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- Structure de la table `api_settings`
--

CREATE TABLE IF NOT EXISTS `api_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `default_record_limit` int(11) NOT NULL DEFAULT '20',
  `max_record_limit` int(11) DEFAULT NULL,
  `max_requests_per_ip_address` int(11) DEFAULT NULL,
  `max_requests_quota_basis` int(11) DEFAULT NULL,
  `modification_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='For storing API logging settings' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `badge`
--

CREATE TABLE IF NOT EXISTS `badge` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores description of badges to be assigned' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `badge_users`
--

CREATE TABLE IF NOT EXISTS `badge_users` (
  `user_id` int(11) unsigned NOT NULL,
  `badge_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`badge_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores assigned badge information';

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `locale` varchar(10) NOT NULL DEFAULT 'en_US',
  `category_position` tinyint(4) NOT NULL DEFAULT '0',
  `category_title` varchar(255) DEFAULT NULL,
  `category_description` text,
  `category_color` varchar(20) DEFAULT NULL,
  `category_image` varchar(255) DEFAULT NULL,
  `category_image_thumb` varchar(255) DEFAULT NULL,
  `category_visible` tinyint(4) NOT NULL DEFAULT '1',
  `category_trusted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `category_visible` (`category_visible`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information about categories defined for a deployment' AUTO_INCREMENT=13 ;

--
-- Contenu de la table `category`
--

INSERT INTO `category` (`id`, `parent_id`, `locale`, `category_position`, `category_title`, `category_description`, `category_color`, `category_image`, `category_image_thumb`, `category_visible`, `category_trusted`) VALUES
(1, 0, 'en_US', 0, 'Canalisations', 'Incidents relatifs aux canalisations', '0022cc', 'category_1_1354391752.png', 'category_1_1354391752_16x16.png', 1, 0),
(2, 0, 'en_US', 1, 'Ordures', 'Incidents relatifs aux ordures de tous genre', 'dbb311', 'category_2_1354389919.png', 'category_2_1354389919_16x16.png', 1, 0),
(3, 0, 'en_US', 4, 'Eaux usées', 'Incidents relatifs aux eaux usées', '663300', 'category_3_1354436241.png', 'category_3_1354436241_16x16.png', 1, 0),
(4, 0, 'en_US', 5, 'Rapports de confiance', 'Rapports provenant d''observateurs agréés', '339900', 'category_4_1354392832.png', 'category_4_1354392832_16x16.png', 1, 1),
(6, 2, 'fr_FR', 3, 'déchets ménagers', 'Ordures de natures ménagères ou dérivés', '298bcc', NULL, NULL, 1, 0),
(7, 2, 'fr_FR', 2, 'déchets plastiques', 'ordures d''origines plastique ou dérivés plastiques', '0f0b0f', NULL, NULL, 1, 0),
(8, 2, 'fr_FR', 0, 'déchets métalliques', 'ordures d''origines métalliques ou dérivés de métaux', '82807e', NULL, NULL, 1, 0),
(9, 1, 'fr_FR', 0, 'Tuyaux endommagés', 'Incidents relatifs aux tuyaux perforés et dérivés', '838cb3', NULL, NULL, 1, 0),
(10, 1, 'fr_FR', 0, 'Canalisations bouchées', 'Incidents relatifs aux tuyaux obstrués et dérivés', '346d99', NULL, NULL, 1, 0),
(11, 3, 'fr_FR', 0, 'Reflux d''égouts', 'Incidents relatifs aux reflux d''eaux usées d''égouts et dérivés', '224716', NULL, NULL, 1, 0),
(12, 3, 'fr_FR', 0, 'Débordement fosses septiques', 'Incidents relatifs aux fosses débordantes et dérivés', '998e1a', NULL, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `category_lang`
--

CREATE TABLE IF NOT EXISTS `category_lang` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(11) unsigned NOT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `category_title` varchar(255) DEFAULT NULL,
  `category_description` text,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for category titles and descriptions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `checkin`
--

CREATE TABLE IF NOT EXISTS `checkin` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  `incident_id` bigint(20) unsigned DEFAULT '0',
  `checkin_description` varchar(255) DEFAULT NULL,
  `checkin_date` datetime NOT NULL,
  `checkin_auto` enum('0','1') DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores checkin information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `city`
--

CREATE TABLE IF NOT EXISTS `city` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `city` varchar(200) DEFAULT NULL,
  `city_lat` varchar(150) DEFAULT NULL,
  `city_lon` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores cities of countries retrieved by user.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `cluster`
--

CREATE TABLE IF NOT EXISTS `cluster` (
  `id` int(11) NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  `latitude_min` double NOT NULL,
  `longitude_min` double NOT NULL,
  `latitude_max` double NOT NULL,
  `longitude_max` double NOT NULL,
  `child_count` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `left_side` int(11) NOT NULL,
  `right_side` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_id` (`incident_id`),
  KEY `category_id` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores information used for clustering of reports on the map.';

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

CREATE TABLE IF NOT EXISTS `comment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `checkin_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT '0',
  `comment_author` varchar(100) DEFAULT NULL,
  `comment_email` varchar(120) DEFAULT NULL,
  `comment_description` text,
  `comment_ip` varchar(100) DEFAULT NULL,
  `comment_spam` tinyint(4) NOT NULL DEFAULT '0',
  `comment_active` tinyint(4) NOT NULL DEFAULT '0',
  `comment_date` datetime DEFAULT NULL,
  `comment_date_gmt` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `checkin_id` (`checkin_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores comments made on reports/checkins' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `country`
--

CREATE TABLE IF NOT EXISTS `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iso` varchar(10) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `capital` varchar(100) DEFAULT NULL,
  `cities` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a list of all countries and their capital cities' AUTO_INCREMENT=248 ;

--
-- Contenu de la table `country`
--

INSERT INTO `country` (`id`, `iso`, `country`, `capital`, `cities`) VALUES
(1, 'AD', 'Andorra', 'Andorra la Vella', 0),
(2, 'AE', 'United Arab Emirates', 'Abu Dhabi', 0),
(3, 'AF', 'Afghanistan', 'Kabul', 0),
(4, 'AG', 'Antigua and Barbuda', 'St. John''s', 0),
(5, 'AI', 'Anguilla', 'The Valley', 0),
(6, 'AL', 'Albania', 'Tirana', 0),
(7, 'AM', 'Armenia', 'Yerevan', 0),
(8, 'AN', 'Netherlands Antilles', 'Willemstad', 0),
(9, 'AO', 'Angola', 'Luanda', 0),
(10, 'AQ', 'Antarctica', '', 0),
(11, 'AR', 'Argentina', 'Buenos Aires', 0),
(12, 'AS', 'American Samoa', 'Pago Pago', 0),
(13, 'AT', 'Austria', 'Vienna', 0),
(14, 'AU', 'Australia', 'Canberra', 0),
(15, 'AW', 'Aruba', 'Oranjestad', 0),
(16, 'AX', 'Aland Islands', 'Mariehamn', 0),
(17, 'AZ', 'Azerbaijan', 'Baku', 0),
(18, 'BA', 'Bosnia and Herzegovina', 'Sarajevo', 0),
(19, 'BB', 'Barbados', 'Bridgetown', 0),
(20, 'BD', 'Bangladesh', 'Dhaka', 0),
(21, 'BE', 'Belgium', 'Brussels', 0),
(22, 'BF', 'Burkina Faso', 'Ouagadougou', 0),
(23, 'BG', 'Bulgaria', 'Sofia', 0),
(24, 'BH', 'Bahrain', 'Manama', 0),
(25, 'BI', 'Burundi', 'Bujumbura', 0),
(26, 'BJ', 'Benin', 'Porto-Novo', 0),
(27, 'BL', 'Saint BarthÃ©lemy', 'Gustavia', 0),
(28, 'BM', 'Bermuda', 'Hamilton', 0),
(29, 'BN', 'Brunei', 'Bandar Seri Begawan', 0),
(30, 'BO', 'Bolivia', 'La Paz', 0),
(31, 'BR', 'Brazil', 'BrasÃ­lia', 0),
(32, 'BS', 'Bahamas', 'Nassau', 0),
(33, 'BT', 'Bhutan', 'Thimphu', 0),
(34, 'BV', 'Bouvet Island', '', 0),
(35, 'BW', 'Botswana', 'Gaborone', 0),
(36, 'BY', 'Belarus', 'Minsk', 0),
(37, 'BZ', 'Belize', 'Belmopan', 0),
(38, 'CA', 'Canada', 'Ottawa', 0),
(39, 'CC', 'Cocos Islands', 'West Island', 0),
(40, 'CD', 'Democratic Republic of the Congo', 'Kinshasa', 0),
(41, 'CF', 'Central African Republic', 'Bangui', 0),
(42, 'CG', 'Congo Brazzavile', 'Brazzaville', 0),
(43, 'CH', 'Switzerland', 'Berne', 0),
(44, 'CI', 'Ivory Coast', 'Yamoussoukro', 0),
(45, 'CK', 'Cook Islands', 'Avarua', 0),
(46, 'CL', 'Chile', 'Santiago', 0),
(47, 'CM', 'Cameroon', 'YaoundÃ©', 0),
(48, 'CN', 'China', 'Beijing', 0),
(49, 'CO', 'Colombia', 'BogotÃ¡', 0),
(50, 'CR', 'Costa Rica', 'San JosÃ©', 0),
(51, 'CS', 'Serbia and Montenegro', 'Belgrade', 0),
(52, 'CU', 'Cuba', 'Havana', 0),
(53, 'CV', 'Cape Verde', 'Praia', 0),
(54, 'CX', 'Christmas Island', 'Flying Fish Cove', 0),
(55, 'CY', 'Cyprus', 'Nicosia', 0),
(56, 'CZ', 'Czech Republic', 'Prague', 0),
(57, 'DE', 'Germany', 'Berlin', 0),
(58, 'DJ', 'Djibouti', 'Djibouti', 0),
(59, 'DK', 'Denmark', 'Copenhagen', 0),
(60, 'DM', 'Dominica', 'Roseau', 0),
(61, 'DO', 'Dominican Republic', 'Santo Domingo', 0),
(62, 'DZ', 'Algeria', 'Algiers', 0),
(63, 'EC', 'Ecuador', 'Quito', 0),
(64, 'EE', 'Estonia', 'Tallinn', 0),
(65, 'EG', 'Egypt', 'Cairo', 0),
(66, 'EH', 'Western Sahara', 'El-Aaiun', 0),
(67, 'ER', 'Eritrea', 'Asmara', 0),
(68, 'ES', 'Spain', 'Madrid', 0),
(69, 'ET', 'Ethiopia', 'Addis Ababa', 0),
(70, 'FI', 'Finland', 'Helsinki', 0),
(71, 'FJ', 'Fiji', 'Suva', 0),
(72, 'FK', 'Falkland Islands', 'Stanley', 0),
(73, 'FM', 'Micronesia', 'Palikir', 0),
(74, 'FO', 'Faroe Islands', 'TÃ³rshavn', 0),
(75, 'FR', 'France', 'Paris', 0),
(76, 'GA', 'Gabon', 'Libreville', 0),
(77, 'GB', 'United Kingdom', 'London', 0),
(78, 'GD', 'Grenada', 'St. George''s', 0),
(79, 'GE', 'Georgia', 'Tbilisi', 0),
(80, 'GF', 'French Guiana', 'Cayenne', 0),
(81, 'GG', 'Guernsey', 'St Peter Port', 0),
(82, 'GH', 'Ghana', 'Accra', 0),
(83, 'GI', 'Gibraltar', 'Gibraltar', 0),
(84, 'GL', 'Greenland', 'Nuuk', 0),
(85, 'GM', 'Gambia', 'Banjul', 0),
(86, 'GN', 'Guinea', 'Conakry', 0),
(87, 'GP', 'Guadeloupe', 'Basse-Terre', 0),
(88, 'GQ', 'Equatorial Guinea', 'Malabo', 0),
(89, 'GR', 'Greece', 'Athens', 0),
(90, 'GS', 'South Georgia and the South Sandwich Islands', 'Grytviken', 0),
(91, 'GT', 'Guatemala', 'Guatemala City', 0),
(92, 'GU', 'Guam', 'HagÃ¥tÃ±a', 0),
(93, 'GW', 'Guinea-Bissau', 'Bissau', 0),
(94, 'GY', 'Guyana', 'Georgetown', 0),
(95, 'HK', 'Hong Kong', 'Hong Kong', 0),
(96, 'HM', 'Heard Island and McDonald Islands', '', 0),
(97, 'HN', 'Honduras', 'Tegucigalpa', 0),
(98, 'HR', 'Croatia', 'Zagreb', 0),
(99, 'HT', 'Haiti', 'Port-au-Prince', 0),
(100, 'HU', 'Hungary', 'Budapest', 0),
(101, 'ID', 'Indonesia', 'Jakarta', 0),
(102, 'IE', 'Ireland', 'Dublin', 0),
(103, 'IL', 'Israel', 'Jerusalem', 0),
(104, 'IM', 'Isle of Man', 'Douglas, Isle of Man', 0),
(105, 'IN', 'India', 'New Delhi', 0),
(106, 'IO', 'British Indian Ocean Territory', 'Diego Garcia', 0),
(107, 'IQ', 'Iraq', 'Baghdad', 0),
(108, 'IR', 'Iran', 'Tehran', 0),
(109, 'IS', 'Iceland', 'ReykjavÃ­k', 0),
(110, 'IT', 'Italy', 'Rome', 0),
(111, 'JE', 'Jersey', 'Saint Helier', 0),
(112, 'JM', 'Jamaica', 'Kingston', 0),
(113, 'JO', 'Jordan', 'Amman', 0),
(114, 'JP', 'Japan', 'Tokyo', 0),
(115, 'KE', 'Kenya', 'Nairobi', 0),
(116, 'KG', 'Kyrgyzstan', 'Bishkek', 0),
(117, 'KH', 'Cambodia', 'Phnom Penh', 0),
(118, 'KI', 'Kiribati', 'South Tarawa', 0),
(119, 'KM', 'Comoros', 'Moroni', 0),
(120, 'KN', 'Saint Kitts and Nevis', 'Basseterre', 0),
(121, 'KP', 'North Korea', 'Pyongyang', 0),
(122, 'KR', 'South Korea', 'Seoul', 0),
(123, 'KW', 'Kuwait', 'Kuwait City', 0),
(124, 'KY', 'Cayman Islands', 'George Town', 0),
(125, 'KZ', 'Kazakhstan', 'Astana', 0),
(126, 'LA', 'Laos', 'Vientiane', 0),
(127, 'LB', 'Lebanon', 'Beirut', 0),
(128, 'LC', 'Saint Lucia', 'Castries', 0),
(129, 'LI', 'Liechtenstein', 'Vaduz', 0),
(130, 'LK', 'Sri Lanka', 'Colombo', 0),
(131, 'LR', 'Liberia', 'Monrovia', 0),
(132, 'LS', 'Lesotho', 'Maseru', 0),
(133, 'LT', 'Lithuania', 'Vilnius', 0),
(134, 'LU', 'Luxembourg', 'Luxembourg', 0),
(135, 'LV', 'Latvia', 'Riga', 0),
(136, 'LY', 'Libya', 'Tripolis', 0),
(137, 'MA', 'Morocco', 'Rabat', 0),
(138, 'MC', 'Monaco', 'Monaco', 0),
(139, 'MD', 'Moldova', 'Chi_in_u', 0),
(140, 'ME', 'Montenegro', 'Podgorica', 0),
(141, 'MF', 'Saint Martin', 'Marigot', 0),
(142, 'MG', 'Madagascar', 'Antananarivo', 0),
(143, 'MH', 'Marshall Islands', 'Uliga', 0),
(144, 'MK', 'Macedonia', 'Skopje', 0),
(145, 'ML', 'Mali', 'Bamako', 0),
(146, 'MM', 'Myanmar', 'Yangon', 0),
(147, 'MN', 'Mongolia', 'Ulan Bator', 0),
(148, 'MO', 'Macao', 'Macao', 0),
(149, 'MP', 'Northern Mariana Islands', 'Saipan', 0),
(150, 'MQ', 'Martinique', 'Fort-de-France', 0),
(151, 'MR', 'Mauritania', 'Nouakchott', 0),
(152, 'MS', 'Montserrat', 'Plymouth', 0),
(153, 'MT', 'Malta', 'Valletta', 0),
(154, 'MU', 'Mauritius', 'Port Louis', 0),
(155, 'MV', 'Maldives', 'MalÃ©', 0),
(156, 'MW', 'Malawi', 'Lilongwe', 0),
(157, 'MX', 'Mexico', 'Mexico City', 0),
(158, 'MY', 'Malaysia', 'Kuala Lumpur', 0),
(159, 'MZ', 'Mozambique', 'Maputo', 0),
(160, 'NA', 'Namibia', 'Windhoek', 0),
(161, 'NC', 'New Caledonia', 'NoumÃ©a', 0),
(162, 'NE', 'Niger', 'Niamey', 0),
(163, 'NF', 'Norfolk Island', 'Kingston', 0),
(164, 'NG', 'Nigeria', 'Abuja', 0),
(165, 'NI', 'Nicaragua', 'Managua', 0),
(166, 'NL', 'Netherlands', 'Amsterdam', 0),
(167, 'NO', 'Norway', 'Oslo', 0),
(168, 'NP', 'Nepal', 'Kathmandu', 0),
(169, 'NR', 'Nauru', 'Yaren', 0),
(170, 'NU', 'Niue', 'Alofi', 0),
(171, 'NZ', 'New Zealand', 'Wellington', 0),
(172, 'OM', 'Oman', 'Muscat', 0),
(173, 'PA', 'Panama', 'Panama City', 0),
(174, 'PE', 'Peru', 'Lima', 0),
(175, 'PF', 'French Polynesia', 'Papeete', 0),
(176, 'PG', 'Papua New Guinea', 'Port Moresby', 0),
(177, 'PH', 'Philippines', 'Manila', 0),
(178, 'PK', 'Pakistan', 'Islamabad', 0),
(179, 'PL', 'Poland', 'Warsaw', 0),
(180, 'PM', 'Saint Pierre and Miquelon', 'Saint-Pierre', 0),
(181, 'PN', 'Pitcairn', 'Adamstown', 0),
(182, 'PR', 'Puerto Rico', 'San Juan', 0),
(183, 'PS', 'Palestinian Territory', 'East Jerusalem', 0),
(184, 'PT', 'Portugal', 'Lisbon', 0),
(185, 'PW', 'Palau', 'Koror', 0),
(186, 'PY', 'Paraguay', 'AsunciÃ³n', 0),
(187, 'QA', 'Qatar', 'Doha', 0),
(188, 'RE', 'Reunion', 'Saint-Denis', 0),
(189, 'RO', 'Romania', 'Bucharest', 0),
(190, 'RS', 'Serbia', 'Belgrade', 0),
(191, 'RU', 'Russia', 'Moscow', 0),
(192, 'RW', 'Rwanda', 'Kigali', 0),
(193, 'SA', 'Saudi Arabia', 'Riyadh', 0),
(194, 'SB', 'Solomon Islands', 'Honiara', 0),
(195, 'SC', 'Seychelles', 'Victoria', 0),
(196, 'SD', 'Sudan', 'Khartoum', 0),
(197, 'SE', 'Sweden', 'Stockholm', 0),
(198, 'SG', 'Singapore', 'Singapur', 0),
(199, 'SH', 'Saint Helena', 'Jamestown', 0),
(200, 'SI', 'Slovenia', 'Ljubljana', 0),
(201, 'SJ', 'Svalbard and Jan Mayen', 'Longyearbyen', 0),
(202, 'SK', 'Slovakia', 'Bratislava', 0),
(203, 'SL', 'Sierra Leone', 'Freetown', 0),
(204, 'SM', 'San Marino', 'San Marino', 0),
(205, 'SN', 'Senegal', 'Dakar', 0),
(206, 'SO', 'Somalia', 'Mogadishu', 0),
(207, 'SR', 'Suriname', 'Paramaribo', 0),
(208, 'ST', 'Sao Tome and Principe', 'SÃ£o TomÃ©', 0),
(209, 'SV', 'El Salvador', 'San Salvador', 0),
(210, 'SY', 'Syria', 'Damascus', 0),
(211, 'SZ', 'Swaziland', 'Mbabane', 0),
(212, 'TC', 'Turks and Caicos Islands', 'Cockburn Town', 0),
(213, 'TD', 'Chad', 'N''Djamena', 0),
(214, 'TF', 'French Southern Territories', 'Martin-de-ViviÃ¨s', 0),
(215, 'TG', 'Togo', 'LomÃ©', 0),
(216, 'TH', 'Thailand', 'Bangkok', 0),
(217, 'TJ', 'Tajikistan', 'Dushanbe', 0),
(218, 'TK', 'Tokelau', '', 0),
(219, 'TL', 'East Timor', 'Dili', 0),
(220, 'TM', 'Turkmenistan', 'Ashgabat', 0),
(221, 'TN', 'Tunisia', 'Tunis', 0),
(222, 'TO', 'Tonga', 'Nuku''alofa', 0),
(223, 'TR', 'Turkey', 'Ankara', 0),
(224, 'TT', 'Trinidad and Tobago', 'Port of Spain', 0),
(225, 'TV', 'Tuvalu', 'Vaiaku', 0),
(226, 'TW', 'Taiwan', 'Taipei', 0),
(227, 'TZ', 'Tanzania', 'Dar es Salaam', 0),
(228, 'UA', 'Ukraine', 'Kiev', 0),
(229, 'UG', 'Uganda', 'Kampala', 0),
(230, 'UM', 'United States Minor Outlying Islands', '', 0),
(231, 'US', 'United States', 'Washington', 0),
(232, 'UY', 'Uruguay', 'Montevideo', 0),
(233, 'UZ', 'Uzbekistan', 'Tashkent', 0),
(234, 'VA', 'Vatican', 'Vatican City', 0),
(235, 'VC', 'Saint Vincent and the Grenadines', 'Kingstown', 0),
(236, 'VE', 'Venezuela', 'Caracas', 0),
(237, 'VG', 'British Virgin Islands', 'Road Town', 0),
(238, 'VI', 'U.S. Virgin Islands', 'Charlotte Amalie', 0),
(239, 'VN', 'Vietnam', 'Hanoi', 0),
(240, 'VU', 'Vanuatu', 'Port Vila', 0),
(241, 'WF', 'Wallis and Futuna', 'MatÃ¢''Utu', 0),
(242, 'WS', 'Samoa', 'Apia', 0),
(243, 'YE', 'Yemen', 'Sanâ€˜aâ€™', 0),
(244, 'YT', 'Mayotte', 'Mamoudzou', 0),
(245, 'ZA', 'South Africa', 'Pretoria', 0),
(246, 'ZM', 'Zambia', 'Lusaka', 0),
(247, 'ZW', 'Zimbabwe', 'Harare', 0);

-- --------------------------------------------------------

--
-- Structure de la table `externalapp`
--

CREATE TABLE IF NOT EXISTS `externalapp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Info on external apps(mobile) that work with your deployment' AUTO_INCREMENT=3 ;

--
-- Contenu de la table `externalapp`
--

INSERT INTO `externalapp` (`id`, `name`, `url`) VALUES
(1, 'iPhone', 'http://download.ushahidi.com/track_download.php?download=ios'),
(2, 'Android', 'http://download.ushahidi.com/track_download.php?download=android');

-- --------------------------------------------------------

--
-- Structure de la table `feed`
--

CREATE TABLE IF NOT EXISTS `feed` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `feed_name` varchar(255) DEFAULT NULL,
  `feed_url` varchar(255) DEFAULT NULL,
  `feed_cache` text,
  `feed_active` tinyint(4) DEFAULT '1',
  `feed_update` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Information about RSS Feeds a deployment subscribes to' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `feed_item`
--

CREATE TABLE IF NOT EXISTS `feed_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `feed_id` int(11) unsigned NOT NULL,
  `location_id` bigint(20) unsigned DEFAULT '0',
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `item_title` varchar(255) DEFAULT NULL,
  `item_description` text,
  `item_link` varchar(255) DEFAULT NULL,
  `item_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feed_id` (`feed_id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores feed items pulled from each RSS Feed' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `form`
--

CREATE TABLE IF NOT EXISTS `form` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_title` varchar(200) NOT NULL,
  `form_description` text,
  `form_active` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores all report submission forms created(default+custom)' AUTO_INCREMENT=2 ;

--
-- Contenu de la table `form`
--

INSERT INTO `form` (`id`, `form_title`, `form_description`, `form_active`) VALUES
(1, 'Default Form', 'Default form, for report entry', 1);

-- --------------------------------------------------------

--
-- Structure de la table `form_field`
--

CREATE TABLE IF NOT EXISTS `form_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_id` int(11) NOT NULL DEFAULT '1',
  `field_name` varchar(200) DEFAULT NULL,
  `field_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - TEXTFIELD, 2 - TEXTAREA (FREETEXT), 3 - DATE, 4 - PASSWORD, 5 - RADIO, 6 - CHECKBOX',
  `field_required` tinyint(4) DEFAULT '0',
  `field_position` tinyint(4) NOT NULL DEFAULT '0',
  `field_default` varchar(200) DEFAULT NULL,
  `field_maxlength` int(11) NOT NULL DEFAULT '0',
  `field_width` smallint(6) NOT NULL DEFAULT '0',
  `field_height` tinyint(4) DEFAULT '5',
  `field_isdate` tinyint(4) NOT NULL DEFAULT '0',
  `field_ispublic_visible` tinyint(4) NOT NULL DEFAULT '0',
  `field_ispublic_submit` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `field_name` (`field_name`),
  KEY `fk_form_id` (`form_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores all custom form fields created by users' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `form_field_option`
--

CREATE TABLE IF NOT EXISTS `form_field_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `form_field_id` int(11) NOT NULL DEFAULT '0',
  `option_name` varchar(200) DEFAULT NULL,
  `option_value` text,
  PRIMARY KEY (`id`),
  KEY `form_field_id` (`form_field_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Options related to custom form fields' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `form_response`
--

CREATE TABLE IF NOT EXISTS `form_response` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_field_id` int(11) NOT NULL,
  `incident_id` bigint(20) unsigned NOT NULL,
  `form_response` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_form_field_id` (`form_field_id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores responses to custom form fields' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `frontlinesms`
--

CREATE TABLE IF NOT EXISTS `frontlinesms` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `frontlinesms_key` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `frontlinesms`
--

INSERT INTO `frontlinesms` (`id`, `frontlinesms_key`) VALUES
(1, 'IGMU1OQG');

-- --------------------------------------------------------

--
-- Structure de la table `geometry`
--

CREATE TABLE IF NOT EXISTS `geometry` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `geometry` geometry NOT NULL,
  `geometry_label` varchar(150) DEFAULT NULL,
  `geometry_comment` varchar(255) DEFAULT NULL,
  `geometry_color` varchar(20) DEFAULT NULL,
  `geometry_strokewidth` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  SPATIAL KEY `geometry` (`geometry`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores map geometries i.e polygons, lines etc' AUTO_INCREMENT=5 ;

--
-- Contenu de la table `geometry`
--

INSERT INTO `geometry` (`id`, `incident_id`, `geometry`, `geometry_label`, `geometry_comment`, `geometry_color`, `geometry_strokewidth`) VALUES
(1, 4, '\0\0\0\0\0\0\0�z��r1�sƴM�c-@', '', '', '', '2.5'),
(2, 4, '\0\0\0\0\0\0\0}z�r1��:t�d-@', '', '', '', '2.5'),
(3, 5, '\0\0\0\0\0\0\0�z�Vx1�z`�t-@', '', '', '', '2.5'),
(4, 5, '\0\0\0\0\0\0\0\0\0\0\0\0\0�zP�x1�J����v-@DzP�w1��=	v-@�z�Hx1�z[�Jt-@MzPy1�QM\0�eu-@�zP�x1��j5��v-@�zP�x1�J����v-@', '', '', '', '2.5');

-- --------------------------------------------------------

--
-- Structure de la table `incident`
--

CREATE TABLE IF NOT EXISTS `incident` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned NOT NULL,
  `form_id` int(11) NOT NULL DEFAULT '1',
  `locale` varchar(10) NOT NULL DEFAULT 'en_US',
  `user_id` int(11) unsigned DEFAULT NULL,
  `incident_title` varchar(255) DEFAULT NULL,
  `incident_description` longtext,
  `incident_date` datetime DEFAULT NULL,
  `incident_mode` tinyint(4) NOT NULL DEFAULT '1' COMMENT '1 - WEB, 2 - SMS, 3 - EMAIL, 4 - TWITTER',
  `incident_active` tinyint(4) NOT NULL DEFAULT '0',
  `incident_verified` tinyint(4) NOT NULL DEFAULT '0',
  `incident_dateadd` datetime DEFAULT NULL,
  `incident_dateadd_gmt` datetime DEFAULT NULL,
  `incident_datemodify` datetime DEFAULT NULL,
  `incident_alert_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 - Not Tagged for Sending, 1 - Tagged for Sending, 2 - Alerts Have Been Sent',
  `incident_zoom` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_id` (`location_id`),
  KEY `incident_active` (`incident_active`),
  KEY `incident_date` (`incident_date`),
  KEY `form_id` (`form_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores reports submitted' AUTO_INCREMENT=8 ;

--
-- Contenu de la table `incident`
--

INSERT INTO `incident` (`id`, `location_id`, `form_id`, `locale`, `user_id`, `incident_title`, `incident_description`, `incident_date`, `incident_mode`, `incident_active`, `incident_verified`, `incident_dateadd`, `incident_dateadd_gmt`, `incident_datemodify`, `incident_alert_status`, `incident_zoom`) VALUES
(1, 1, 1, 'en_US', 1, 'Hello Ushahidi!', 'Welcome to Ushahidi. Please replace this report with a valid incident', '2012-04-04 12:54:31', 1, 1, 1, NULL, NULL, NULL, 0, NULL),
(2, 2, 1, 'en_US', NULL, 'incident test', 'canalisation bouchée', '2012-12-02 01:51:00', 1, 1, 1, '2012-12-02 08:52:55', NULL, '2012-12-02 08:58:10', 2, 13),
(3, 3, 1, 'en_US', 1, 'Ordures ménagères', 'Je suis a idev-IC et il ya un ts d''ordure dans le quartier depuis 1 semaine.merci\n- ousmanesamba@gmail.com\n- Vous pouvez repondre', '2012-12-02 09:04:00', 2, 1, 1, '2012-12-02 09:12:58', NULL, '2012-12-02 09:58:07', 2, 15),
(4, 4, 0, 'en_US', 1, 'reflux d''eau d''égout', 'eaux d''égouts, vers le monument de l''indépendance.', '2012-12-02 01:16:00', 1, 1, 1, '2012-12-02 09:26:35', NULL, NULL, 2, 16),
(5, 5, 1, 'en_US', 1, 'Eaux usées', 'Signalement eaux usées a liberté 6 extension.', '2012-12-02 09:59:00', 2, 1, 1, '2012-12-02 10:02:42', NULL, NULL, 2, 14),
(6, 6, 1, 'en_US', 1, 'Canalisation eau usée cassée', 'Canalisation eau usée cassée à Point E, près de la piscine.', '2012-12-02 10:47:00', 2, 1, 0, '2012-12-02 10:52:50', NULL, NULL, 2, 8),
(7, 7, 1, 'en_US', 1, 'Tas d''ordures au marché Tilène', 'Signalisation d''un tas d''ordures a marché Tilène.', '2012-12-02 11:20:00', 2, 1, 0, '2012-12-02 11:23:37', NULL, '2012-12-02 11:28:30', 2, 15);

-- --------------------------------------------------------

--
-- Structure de la table `incident_category`
--

CREATE TABLE IF NOT EXISTS `incident_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL DEFAULT '0',
  `category_id` int(11) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `incident_category_ids` (`incident_id`,`category_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores submitted reports categories' AUTO_INCREMENT=12 ;

--
-- Contenu de la table `incident_category`
--

INSERT INTO `incident_category` (`id`, `incident_id`, `category_id`) VALUES
(1, 1, 1),
(3, 2, 10),
(6, 3, 6),
(5, 4, 11),
(7, 5, 11),
(8, 6, 9),
(9, 6, 11),
(11, 7, 7);

-- --------------------------------------------------------

--
-- Structure de la table `incident_lang`
--

CREATE TABLE IF NOT EXISTS `incident_lang` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned NOT NULL,
  `locale` varchar(10) DEFAULT NULL,
  `incident_title` varchar(255) DEFAULT NULL,
  `incident_description` longtext,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds translations for report titles and descriptions' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `incident_person`
--

CREATE TABLE IF NOT EXISTS `incident_person` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `person_first` varchar(200) DEFAULT NULL,
  `person_last` varchar(200) DEFAULT NULL,
  `person_email` varchar(120) DEFAULT NULL,
  `person_phone` varchar(60) DEFAULT NULL,
  `person_ip` varchar(50) DEFAULT NULL,
  `person_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds information provided by people who submit reports' AUTO_INCREMENT=10 ;

--
-- Contenu de la table `incident_person`
--

INSERT INTO `incident_person` (`id`, `incident_id`, `person_first`, `person_last`, `person_email`, `person_phone`, `person_ip`, `person_date`) VALUES
(2, 2, 'jacob', 'sawadogo', '', NULL, NULL, '2012-12-02 08:58:10'),
(5, 3, '', '', '', NULL, NULL, '2012-12-02 09:58:07'),
(4, 4, 'moussa', 'ndiaye', '', NULL, NULL, '2012-12-02 09:26:36'),
(6, 5, 'ousmane', 'samba', '', NULL, NULL, '2012-12-02 10:02:43'),
(7, 6, '', '', '', NULL, NULL, '2012-12-02 10:52:50'),
(9, 7, 'ousmane', 'samba', '', NULL, NULL, '2012-12-02 11:28:30');

-- --------------------------------------------------------

--
-- Structure de la table `incident_status`
--

CREATE TABLE IF NOT EXISTS `incident_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` int(11) NOT NULL,
  `waiting` tinyint(4) NOT NULL DEFAULT '1',
  `taken_on` tinyint(4) NOT NULL DEFAULT '0',
  `resolved` tinyint(4) NOT NULL DEFAULT '0',
  `summary` varchar(255) DEFAULT NULL,
  `datetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `incident_status`
--

INSERT INTO `incident_status` (`id`, `incident_id`, `waiting`, `taken_on`, `resolved`, `summary`, `datetime`) VALUES
(1, 2, 1, 0, 0, '', '2012-12-02 01:51:00'),
(2, 3, 1, 0, 0, '', '2012-12-02 09:04:00'),
(3, 5, 1, 0, 0, '', '2012-12-02 09:59:00'),
(4, 6, 1, 0, 0, '', '2012-12-02 10:47:00'),
(5, 7, 1, 0, 0, '', '2012-12-02 11:20:00');

-- --------------------------------------------------------

--
-- Structure de la table `layer`
--

CREATE TABLE IF NOT EXISTS `layer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layer_name` varchar(255) DEFAULT NULL,
  `layer_url` varchar(255) DEFAULT NULL,
  `layer_file` varchar(100) DEFAULT NULL,
  `layer_color` varchar(20) DEFAULT NULL,
  `layer_visible` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Holds static layer information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `level`
--

CREATE TABLE IF NOT EXISTS `level` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `level_title` varchar(200) DEFAULT NULL,
  `level_description` varchar(200) DEFAULT NULL,
  `level_weight` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores level of trust assigned to reporters of the platform' AUTO_INCREMENT=6 ;

--
-- Contenu de la table `level`
--

INSERT INTO `level` (`id`, `level_title`, `level_description`, `level_weight`) VALUES
(1, 'SPAM + Delete', 'SPAM + Delete', -2),
(2, 'SPAM', 'SPAM', -1),
(3, 'Untrusted', 'Untrusted', 0),
(4, 'Trusted', 'Trusted', 1),
(5, 'Trusted + Verify', 'Trusted + Verify', 2);

-- --------------------------------------------------------

--
-- Structure de la table `linkreports`
--

CREATE TABLE IF NOT EXISTS `linkreports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `from_incident_id` bigint(20) unsigned NOT NULL,
  `to_incident_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `location`
--

CREATE TABLE IF NOT EXISTS `location` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_name` varchar(255) DEFAULT NULL,
  `country_id` int(11) NOT NULL DEFAULT '0',
  `latitude` double NOT NULL DEFAULT '0',
  `longitude` double NOT NULL DEFAULT '0',
  `location_visible` tinyint(4) NOT NULL DEFAULT '1',
  `location_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores location information' AUTO_INCREMENT=8 ;

--
-- Contenu de la table `location`
--

INSERT INTO `location` (`id`, `location_name`, `country_id`, `latitude`, `longitude`, `location_visible`, `location_date`) VALUES
(1, 'Nairobi', 115, -1.28730007070501, 36.8214511820082, 1, '2009-06-30 00:00:00'),
(2, 'patte d''oie', 205, 14.74548, -17.434284, 1, '2012-12-02 08:58:10'),
(3, 'nabil shouchair, patte d''oie', 205, 14.743238, -17.441065, 1, '2012-12-02 09:58:07'),
(4, 'marché colobane', 205, 14.695588, -17.447379, 1, '2012-12-02 09:26:35'),
(5, 'Liberté 6 extension', 205, 14.72973, -17.470237, 1, '2012-12-02 10:02:42'),
(6, 'Point E', 205, 14.695754, -17.459862, 1, '2012-12-02 10:52:50'),
(7, 'Marché Tilène', 205, 14.681806, -17.450034, 1, '2012-12-02 11:28:30');

-- --------------------------------------------------------

--
-- Structure de la table `maintenance`
--

CREATE TABLE IF NOT EXISTS `maintenance` (
  `allowed_ip` varchar(15) NOT NULL,
  PRIMARY KEY (`allowed_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Puts a site in maintenance mode if data exists in this table';

-- --------------------------------------------------------

--
-- Structure de la table `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `checkin_id` bigint(20) unsigned DEFAULT NULL,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `badge_id` int(11) DEFAULT NULL,
  `media_type` tinyint(4) DEFAULT NULL COMMENT '1 - IMAGES, 2 - VIDEO, 3 - AUDIO, 4 - NEWS, 5 - PODCAST',
  `media_title` varchar(255) DEFAULT NULL,
  `media_description` longtext,
  `media_link` varchar(255) DEFAULT NULL,
  `media_medium` varchar(255) DEFAULT NULL,
  `media_thumb` varchar(255) DEFAULT NULL,
  `media_date` datetime DEFAULT NULL,
  `media_active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`),
  KEY `location_id` (`location_id`),
  KEY `checkin_id` (`checkin_id`),
  KEY `badge_id` (`badge_id`),
  KEY `message_id` (`message_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores any media submitted along with a report/checkin' AUTO_INCREMENT=2 ;

--
-- Contenu de la table `media`
--

INSERT INTO `media` (`id`, `location_id`, `incident_id`, `checkin_id`, `message_id`, `badge_id`, `media_type`, `media_title`, `media_description`, `media_link`, `media_medium`, `media_thumb`, `media_date`, `media_active`) VALUES
(1, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, 'banner_1354437760.png', 'banner_1354437760_m.png', 'banner_1354437760_t.png', '2012-12-02 08:42:40', 1);

-- --------------------------------------------------------

--
-- Structure de la table `message`
--

CREATE TABLE IF NOT EXISTS `message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT '0',
  `incident_id` bigint(20) unsigned DEFAULT '0',
  `user_id` int(11) unsigned DEFAULT '0',
  `reporter_id` bigint(20) unsigned DEFAULT NULL,
  `service_messageid` varchar(100) DEFAULT NULL,
  `message_from` varchar(100) DEFAULT NULL,
  `message_to` varchar(100) DEFAULT NULL,
  `message` text,
  `message_detail` text,
  `message_type` tinyint(4) DEFAULT '1' COMMENT '1 - INBOX, 2 - OUTBOX (From Admin), 3 - DELETED',
  `message_date` datetime DEFAULT NULL,
  `message_level` tinyint(4) DEFAULT '0' COMMENT '0 - UNREAD, 1 - READ, 99 - SPAM',
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `reporter_id` (`reporter_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores tweets, emails and SMS messages' AUTO_INCREMENT=8 ;

--
-- Contenu de la table `message`
--

INSERT INTO `message` (`id`, `parent_id`, `incident_id`, `user_id`, `reporter_id`, `service_messageid`, `message_from`, `message_to`, `message`, `message_detail`, `message_type`, `message_date`, `message_level`, `latitude`, `longitude`) VALUES
(1, 0, 0, 0, 1, NULL, '221779423489', '', 'Test frontline', NULL, 1, '2012-12-01 16:29:26', 0, NULL, NULL),
(2, 0, 3, 0, 2, NULL, '221774699041', '', 'Je suis a idev-IC et il ya un ts d''ordure dans le quartier depuis 1 semaine.merci\n- ousmanesamba@gmail.com\n- Vous pouvez repondre', NULL, 1, '2012-12-02 09:04:20', 0, NULL, NULL),
(3, 0, 0, 0, 2, NULL, '221774699041', '', '(Gmail) ousmanesamba@gmail.com a initié un chat avec vous. Vous pouvez envoyer une réponse à ce message ou répondre AIDE pour obtenir davantage d''informations.', NULL, 1, '2012-12-02 09:04:24', 0, NULL, NULL),
(4, 0, 5, 0, 3, NULL, '221775171783', '', 'Signalement eaux usées a liberté 6 extension. ', NULL, 1, '2012-12-02 09:59:07', 0, NULL, NULL),
(5, 0, 6, 0, 4, NULL, '221774558039', '', 'Canalisation eau usée cassée à Point E, près de la piscine.', NULL, 1, '2012-12-02 10:47:37', 0, NULL, NULL),
(6, 0, 7, 0, 3, NULL, '221775171783', '', 'Signalisation d''un tas d''ordures a marché Tilène. ', NULL, 1, '2012-12-02 11:20:57', 0, NULL, NULL),
(7, 0, 0, 0, 1, NULL, '221779423489', '', 'Signalisation de tas d ordures a marché Tiléne', NULL, 1, '2012-12-02 11:23:54', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `openid`
--

CREATE TABLE IF NOT EXISTS `openid` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `openid` varchar(255) NOT NULL,
  `openid_email` varchar(127) NOT NULL,
  `openid_server` varchar(255) NOT NULL,
  `openid_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores usersâ€™ openid information' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_title` varchar(255) NOT NULL,
  `page_description` longtext,
  `page_tab` varchar(100) NOT NULL,
  `page_active` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores user created pages' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `permissions`
--

CREATE TABLE IF NOT EXISTS `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COMMENT='Stores permissions used for access control' AUTO_INCREMENT=20 ;

--
-- Contenu de la table `permissions`
--

INSERT INTO `permissions` (`id`, `name`) VALUES
(1, 'reports_view'),
(2, 'reports_edit'),
(4, 'reports_comments'),
(5, 'reports_download'),
(6, 'reports_upload'),
(7, 'messages'),
(8, 'messages_reporters'),
(9, 'stats'),
(10, 'settings'),
(11, 'manage'),
(12, 'users'),
(13, 'manage_roles'),
(14, 'checkin'),
(15, 'checkin_admin'),
(16, 'reports_verify'),
(17, 'reports_approve'),
(18, 'admin_ui'),
(19, 'member_ui');

-- --------------------------------------------------------

--
-- Structure de la table `permissions_roles`
--

CREATE TABLE IF NOT EXISTS `permissions_roles` (
  `role_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COMMENT='Stores permissions assigned to roles';

--
-- Contenu de la table `permissions_roles`
--

INSERT INTO `permissions_roles` (`role_id`, `permission_id`) VALUES
(1, 14),
(2, 1),
(2, 2),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 14),
(2, 15),
(2, 16),
(2, 17),
(2, 18),
(3, 1),
(3, 2),
(3, 4),
(3, 5),
(3, 6),
(3, 7),
(3, 8),
(3, 9),
(3, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(3, 18),
(4, 19);

-- --------------------------------------------------------

--
-- Structure de la table `plugin`
--

CREATE TABLE IF NOT EXISTS `plugin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `plugin_name` varchar(100) NOT NULL,
  `plugin_url` varchar(250) DEFAULT NULL,
  `plugin_description` text,
  `plugin_priority` tinyint(4) DEFAULT '0',
  `plugin_active` tinyint(4) DEFAULT '0',
  `plugin_installed` tinyint(4) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugin_name` (`plugin_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Holds a list of all plugins installed on a deployment' AUTO_INCREMENT=10 ;

--
-- Contenu de la table `plugin`
--

INSERT INTO `plugin` (`id`, `plugin_name`, `plugin_url`, `plugin_description`, `plugin_priority`, `plugin_active`, `plugin_installed`) VALUES
(1, 'clickatell', NULL, NULL, 0, 0, 0),
(2, 'frontlinesms', NULL, NULL, 0, 1, 1),
(3, 'sharing', NULL, NULL, 0, 0, 0),
(4, 'smssync', NULL, NULL, 0, 0, 0),
(5, 'viddler', NULL, NULL, 0, 0, 0),
(6, 'fullscreenmap', NULL, NULL, 0, 1, 1),
(7, 'incidentstatus', NULL, NULL, 0, 1, 1),
(8, 'smsautomate-master', NULL, NULL, 0, 0, 0),
(9, 'linkreports', NULL, NULL, 0, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `private_message`
--

CREATE TABLE IF NOT EXISTS `private_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT '0',
  `user_id` int(11) unsigned NOT NULL,
  `from_user_id` int(11) DEFAULT '0',
  `private_subject` varchar(255) NOT NULL,
  `private_message` text NOT NULL,
  `private_message_date` datetime NOT NULL,
  `private_message_new` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores private messages sent between Members' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `rating`
--

CREATE TABLE IF NOT EXISTS `rating` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT '0',
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `comment_id` bigint(20) unsigned DEFAULT NULL,
  `rating` tinyint(4) DEFAULT '0',
  `rating_ip` varchar(100) DEFAULT NULL,
  `rating_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `incident_id` (`incident_id`),
  KEY `comment_id` (`comment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores credibility ratings for reports and comments' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `reporter`
--

CREATE TABLE IF NOT EXISTS `reporter` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) unsigned DEFAULT NULL,
  `service_id` int(10) unsigned DEFAULT NULL,
  `level_id` int(11) unsigned DEFAULT NULL,
  `service_account` varchar(255) DEFAULT NULL,
  `reporter_first` varchar(200) DEFAULT NULL,
  `reporter_last` varchar(200) DEFAULT NULL,
  `reporter_email` varchar(120) DEFAULT NULL,
  `reporter_phone` varchar(60) DEFAULT NULL,
  `reporter_ip` varchar(50) DEFAULT NULL,
  `reporter_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `location_id` (`location_id`),
  KEY `service_id` (`service_id`),
  KEY `level_id` (`level_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Information on report submitters via email, twitter and sms' AUTO_INCREMENT=5 ;

--
-- Contenu de la table `reporter`
--

INSERT INTO `reporter` (`id`, `location_id`, `user_id`, `service_id`, `level_id`, `service_account`, `reporter_first`, `reporter_last`, `reporter_email`, `reporter_phone`, `reporter_ip`, `reporter_date`) VALUES
(1, NULL, NULL, 1, 3, '221779423489', NULL, NULL, NULL, NULL, NULL, '2012-12-01 00:00:00'),
(2, NULL, NULL, 1, 3, '221774699041', NULL, NULL, NULL, NULL, NULL, '2012-12-02 00:00:00'),
(3, NULL, NULL, 1, 3, '221775171783', NULL, NULL, NULL, NULL, NULL, '2012-12-02 00:00:00'),
(4, NULL, NULL, 1, 3, '221774558039', NULL, NULL, NULL, NULL, NULL, '2012-12-02 00:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL,
  `access_level` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Defines user access levels and privileges on a deployment' AUTO_INCREMENT=5 ;

--
-- Contenu de la table `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `access_level`) VALUES
(1, 'login', 'Login privileges, granted after account confirmation', 0),
(2, 'admin', 'Administrative user, has access to almost everything.', 90),
(3, 'superadmin', 'Super administrative user, has access to everything.', 100),
(4, 'member', 'Regular user with access only to the member area', 10);

-- --------------------------------------------------------

--
-- Structure de la table `roles_users`
--

CREATE TABLE IF NOT EXISTS `roles_users` (
  `user_id` int(11) unsigned NOT NULL,
  `role_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `fk_role_id` (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores roles assigned to users registered on a deployment';

--
-- Contenu de la table `roles_users`
--

INSERT INTO `roles_users` (`user_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `scheduler`
--

CREATE TABLE IF NOT EXISTS `scheduler` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `scheduler_name` varchar(100) NOT NULL,
  `scheduler_last` int(10) unsigned NOT NULL DEFAULT '0',
  `scheduler_weekday` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_day` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_hour` smallint(6) NOT NULL DEFAULT '-1',
  `scheduler_minute` smallint(6) NOT NULL,
  `scheduler_controller` varchar(100) NOT NULL,
  `scheduler_active` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores schedules for cron jobs' AUTO_INCREMENT=6 ;

--
-- Contenu de la table `scheduler`
--

INSERT INTO `scheduler` (`id`, `scheduler_name`, `scheduler_last`, `scheduler_weekday`, `scheduler_day`, `scheduler_hour`, `scheduler_minute`, `scheduler_controller`, `scheduler_active`) VALUES
(1, 'Feeds', 1354464835, -1, -1, -1, 0, 's_feeds', 1),
(2, 'Alerts', 1354464865, -1, -1, -1, -1, 's_alerts', 1),
(3, 'Email', 1354464837, -1, -1, -1, 0, 's_email', 1),
(4, 'Twitter', 1354464837, -1, -1, -1, 0, 's_twitter', 1),
(5, 'Cleanup', 1354464837, -1, -1, -1, 0, 's_cleanup', 1);

-- --------------------------------------------------------

--
-- Structure de la table `scheduler_log`
--

CREATE TABLE IF NOT EXISTS `scheduler_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `scheduler_id` int(10) unsigned NOT NULL,
  `scheduler_status` varchar(20) DEFAULT NULL,
  `scheduler_date` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `scheduler_id` (`scheduler_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores a log of scheduler actions' AUTO_INCREMENT=201 ;

--
-- Contenu de la table `scheduler_log`
--

INSERT INTO `scheduler_log` (`id`, `scheduler_id`, `scheduler_status`, `scheduler_date`) VALUES
(1, 1, '200', 1354371995),
(2, 2, '200', 1354371996),
(3, 3, '200', 1354371996),
(4, 4, '200', 1354371996),
(5, 5, '200', 1354371996),
(6, 2, '200', 1354372029),
(7, 2, '200', 1354372094),
(8, 2, '200', 1354372178),
(9, 2, '200', 1354372341),
(10, 2, '200', 1354372385),
(11, 2, '200', 1354372879),
(12, 2, '200', 1354373048),
(13, 1, '200', 1354377418),
(14, 2, '200', 1354377419),
(15, 3, '200', 1354377419),
(16, 4, '200', 1354377419),
(17, 5, '200', 1354377419),
(18, 2, '200', 1354377469),
(19, 1, '200', 1354377762),
(20, 2, '200', 1354377763),
(21, 3, '200', 1354377764),
(22, 4, '200', 1354377764),
(23, 5, '200', 1354377764),
(24, 2, '200', 1354377796),
(25, 2, '200', 1354377893),
(26, 2, '200', 1354378546),
(27, 2, '200', 1354378697),
(28, 2, '200', 1354378792),
(29, 2, '200', 1354378980),
(30, 2, '200', 1354378988),
(31, 2, '200', 1354379403),
(32, 2, '200', 1354379524),
(33, 2, '200', 1354380244),
(34, 2, '200', 1354380305),
(35, 2, '200', 1354380691),
(36, 1, '200', 1354381373),
(37, 2, '200', 1354381374),
(38, 3, '200', 1354381374),
(39, 4, '200', 1354381375),
(40, 5, '200', 1354381375),
(41, 2, '200', 1354382210),
(42, 2, '200', 1354382306),
(43, 1, '200', 1354385330),
(44, 2, '200', 1354385332),
(45, 3, '200', 1354385332),
(46, 4, '200', 1354385333),
(47, 5, '200', 1354385333),
(48, 2, '200', 1354385365),
(49, 2, '200', 1354385818),
(50, 2, '200', 1354385914),
(51, 2, '200', 1354386090),
(52, 2, '200', 1354386232),
(53, 2, '200', 1354386260),
(54, 2, '200', 1354386597),
(55, 2, '200', 1354386616),
(56, 2, '200', 1354386892),
(57, 2, '200', 1354386958),
(58, 2, '200', 1354386982),
(59, 2, '200', 1354387106),
(60, 2, '200', 1354387148),
(61, 2, '200', 1354387243),
(62, 2, '200', 1354387974),
(63, 2, '200', 1354387995),
(64, 2, '200', 1354388073),
(65, 2, '200', 1354388192),
(66, 2, '200', 1354388230),
(67, 1, '200', 1354389027),
(68, 2, '200', 1354389028),
(69, 3, '200', 1354389028),
(70, 4, '200', 1354389028),
(71, 5, '200', 1354389028),
(72, 2, '200', 1354389242),
(73, 2, '200', 1354389328),
(74, 2, '200', 1354389415),
(75, 2, '200', 1354389481),
(76, 2, '200', 1354389666),
(77, 2, '200', 1354389800),
(78, 2, '200', 1354389873),
(79, 2, '200', 1354389922),
(80, 2, '200', 1354390699),
(81, 2, '200', 1354390748),
(82, 2, '200', 1354391428),
(83, 2, '200', 1354391642),
(84, 2, '200', 1354391756),
(85, 1, '200', 1354392262),
(86, 2, '200', 1354392263),
(87, 3, '200', 1354392263),
(88, 4, '200', 1354392263),
(89, 5, '200', 1354392263),
(90, 2, '200', 1354392443),
(91, 2, '200', 1354392610),
(92, 2, '200', 1354392728),
(93, 2, '200', 1354392835),
(94, 2, '200', 1354392848),
(95, 1, '200', 1354401540),
(96, 2, '200', 1354401541),
(97, 3, '200', 1354401541),
(98, 4, '200', 1354401541),
(99, 5, '200', 1354401542),
(100, 2, '200', 1354401604),
(101, 2, '200', 1354401669),
(102, 2, '200', 1354401740),
(103, 1, '200', 1354435925),
(104, 2, '200', 1354435926),
(105, 3, '200', 1354435926),
(106, 4, '200', 1354435926),
(107, 5, '200', 1354435927),
(108, 2, '200', 1354436223),
(109, 2, '200', 1354436631),
(110, 2, '200', 1354436664),
(111, 2, '200', 1354437056),
(112, 2, '200', 1354437062),
(113, 2, '200', 1354437127),
(114, 2, '200', 1354437192),
(115, 2, '200', 1354437381),
(116, 2, '200', 1354437433),
(117, 2, '200', 1354437563),
(118, 2, '200', 1354437702),
(119, 2, '200', 1354437764),
(120, 2, '200', 1354437852),
(121, 2, '200', 1354437914),
(122, 2, '200', 1354438000),
(123, 2, '200', 1354438049),
(124, 2, '200', 1354438164),
(125, 2, '200', 1354438322),
(126, 2, '200', 1354438381),
(127, 2, '200', 1354438502),
(128, 2, '200', 1354438631),
(129, 2, '200', 1354438696),
(130, 1, '200', 1354439096),
(131, 2, '200', 1354439097),
(132, 3, '200', 1354439097),
(133, 4, '200', 1354439097),
(134, 5, '200', 1354439098),
(135, 2, '200', 1354439105),
(136, 2, '200', 1354439203),
(137, 2, '200', 1354439523),
(138, 2, '200', 1354439583),
(139, 2, '200', 1354439719),
(140, 2, '200', 1354439766),
(141, 2, '200', 1354440402),
(142, 2, '200', 1354440452),
(143, 2, '200', 1354440487),
(144, 2, '200', 1354440560),
(145, 2, '200', 1354440613),
(146, 2, '200', 1354440681),
(147, 2, '200', 1354441368),
(148, 2, '200', 1354441425),
(149, 2, '200', 1354441619),
(150, 2, '200', 1354441717),
(151, 2, '200', 1354441755),
(152, 2, '200', 1354441832),
(153, 2, '200', 1354441881),
(154, 2, '200', 1354441924),
(155, 2, '200', 1354442114),
(156, 2, '200', 1354442190),
(157, 2, '200', 1354442247),
(158, 2, '200', 1354442292),
(159, 2, '200', 1354442343),
(160, 1, '200', 1354442568),
(161, 2, '200', 1354442569),
(162, 3, '200', 1354442569),
(163, 4, '200', 1354442569),
(164, 5, '200', 1354442569),
(165, 2, '200', 1354442617),
(166, 2, '200', 1354442655),
(167, 2, '200', 1354442812),
(168, 2, '200', 1354442889),
(169, 2, '200', 1354443024),
(170, 2, '200', 1354444956),
(171, 2, '200', 1354445333),
(172, 2, '200', 1354445353),
(173, 2, '200', 1354445579),
(174, 2, '200', 1354445591),
(175, 1, '200', 1354446358),
(176, 2, '200', 1354446359),
(177, 3, '200', 1354446359),
(178, 4, '200', 1354446360),
(179, 5, '200', 1354446360),
(180, 2, '200', 1354446911),
(181, 2, '200', 1354446962),
(182, 2, '200', 1354447029),
(183, 2, '200', 1354447084),
(184, 2, '200', 1354447222),
(185, 2, '200', 1354447268),
(186, 2, '200', 1354447359),
(187, 2, '200', 1354447386),
(188, 2, '200', 1354447493),
(189, 2, '200', 1354447523),
(190, 2, '200', 1354447579),
(191, 2, '200', 1354447676),
(192, 2, '200', 1354447683),
(193, 2, '200', 1354447745),
(194, 2, '200', 1354447847),
(195, 1, '200', 1354464835),
(196, 2, '200', 1354464836),
(197, 3, '200', 1354464837),
(198, 4, '200', 1354464837),
(199, 5, '200', 1354464837),
(200, 2, '200', 1354464865);

-- --------------------------------------------------------

--
-- Structure de la table `service`
--

CREATE TABLE IF NOT EXISTS `service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(100) DEFAULT NULL,
  `service_description` varchar(255) DEFAULT NULL,
  `service_url` varchar(255) DEFAULT NULL,
  `service_api` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Info on input sources i.e SMS, Email, Twitter' AUTO_INCREMENT=4 ;

--
-- Contenu de la table `service`
--

INSERT INTO `service` (`id`, `service_name`, `service_description`, `service_url`, `service_api`) VALUES
(1, 'SMS', 'Text messages from phones', NULL, NULL),
(2, 'Email', 'Email messages sent to your deployment', NULL, NULL),
(3, 'Twitter', 'Tweets tweets tweets', 'http://twitter.com', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `session_id` varchar(127) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Stores session information';

--
-- Contenu de la table `sessions`
--

INSERT INTO `sessions` (`session_id`, `last_activity`, `data`) VALUES
('bvtktgqll0n3vep81dsofkgog1', 1354464925, 'PrVI4Hx/o90dQCMlB4FxASQM5QbtgfMB3BzdzsfM7w2dBiRELzWHSE3GoXkCEvJQU2LrPFSW8KrNItHDj0zg+VxSTf0wWhb/GCDvAK8u7sLvBvXbbT1UkNdaC/vr6Fj1msrTHc6rSYTF6jHl6SAhP3pChbteSAbLzvoF4NSzjC0KMTNd5Wuv4YFVHWPOq9eHRSrPEnqQZlYxy+PIgMKp26ZlDcYW0uO5Li4qppiAUpkQMAuWUNnQl2S2Tt1iJbmMgbdIcBv1FTMPbEGzJvX2/HnC6EFys5tjtU7ZGDB0KjiLSmX3t9S5hzjVgOQdhTF2TmcAQEF1UNCe8NfSdTABLGeFCiNuCrjYhcGpzeaT5Jbg5EF7CLBiRX2bVMxlc5TGXK9ngl3kZSqry6KpV4dG4n/RL8DCWJ2bHs+IZMNycjV9PPy3R8OW2Zx2qS4cpLMVvoqqAXnUaIaCPcDHu9GR7QCvbnKDaEYBjMJu66SOsmB2oYpQhudjGlv2pqiRwZ0ovaNsCH6R7yP//RnOTkFPnQDnoISLzvFEYXgZLMRlI/jH5zX0UbDwlUvOqHlQE1uVf+BU3pb2Jk1SQSZQcwlKm48DWG4D+5Q3Kk1ZrsGAyLiqzvW9S8ZB7z/HYuz5eMiiXaHslffOgiPaL3/ODsUntG+1LrLvNUccY0eJsCUuvdEN1mGmVjoc6q1BrXAANFxKExPpTaiqE4L/hpAB/iNLMKcY4CytAXLgTRrJchclkj++kKMlZvc/78KQ66tZurfbi8YtYBmBAFPOaeoMrhf2nO4ndzdTQGRgqdJHE2FdUn5rUBqMItE5txt9NwubHncNJksZsBm25XAlXjKR6/wwnlX9TxWYTiXb8+CB6jjbLkyJMOm5MGjbF7p+Q1ovryNJ5w0XZPqDF+BuaEwQ3aNBTgjT8ZeQ0rjKG/6/HS8tGGDkTah/4xMdPjD5KmRel4zGfNFxqknCZPt1Sb2KznLxP/OoXD8InFPhW1kLztH4rHobSD1dY61adYSeTL4elrZpyJzfmcE08ZFKnVxGbfOxls8oufskgzKEmItsFmmJLupcOjblj+kfbw3AzUtILbPOrFsVtll3dNbcizydkeucKZ1aEydnF3uKQDjFL7SaUPQo79QqxW0pXIzy0qxcGR3JhJlmXlOU/Qxr7/FY2gYlyxiBD0I5UuqhO/D3DVPYUwxqeHmaK2jRepC/14FVXeUIL8Lo3zDsZjshL4NPgr8cKraUC4IpNzD9O148pC8hsGWOJLiU/Q0=');

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE IF NOT EXISTS `settings` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) NOT NULL DEFAULT '' COMMENT 'Unique identifier for the configuration parameter',
  `value` text COMMENT 'Value for the settings parameter',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_settings_key` (`key`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=66 ;

--
-- Contenu de la table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`) VALUES
(1, 'site_name', 'Set Settal'),
(2, 'site_tagline', 'Pour une ville plus propre'),
(3, 'site_banner_id', '1'),
(4, 'site_email', 'pjsawadogo68@gmail.com'),
(5, 'site_key', NULL),
(6, 'site_language', 'fr_FR'),
(7, 'site_style', 'set'),
(8, 'site_timezone', 'Africa/Dakar'),
(9, 'site_contact_page', '1'),
(10, 'site_help_page', '1'),
(11, 'site_message', 'Set Settal, un SMS, un cadre de vie Sain !'),
(12, 'site_copyright_statement', ''),
(13, 'site_submit_report_message', ''),
(14, 'allow_reports', '1'),
(15, 'allow_comments', '1'),
(16, 'allow_feed', '1'),
(17, 'allow_stat_sharing', '1'),
(18, 'allow_clustering', '1'),
(19, 'cache_pages', '0'),
(20, 'cache_pages_lifetime', '1800'),
(21, 'private_deployment', '0'),
(22, 'default_map', 'google_normal'),
(23, 'default_map_all', 'cf1010'),
(24, 'default_map_all_icon_id', NULL),
(25, 'api_google', ''),
(26, 'api_live', 'Apumcka0uPOF2lKLorq8aeo4nuqfVVeNRqJjqOcLMJ9iMCTsnMsNd9_OvpA8gR0i'),
(27, 'api_akismet', ''),
(28, 'default_country', '205'),
(29, 'multi_country', '0'),
(30, 'default_city', 'nairobi'),
(31, 'default_lat', '14.726885503483649'),
(32, 'default_lon', '-17.45848849277135'),
(33, 'default_zoom', '12'),
(34, 'items_per_page', '5'),
(35, 'items_per_page_admin', '20'),
(36, 'sms_provider', 'frontlinesms'),
(37, 'sms_no1', '778555642'),
(38, 'sms_no2', ''),
(39, 'sms_no3', ''),
(40, 'google_analytics', ''),
(41, 'twitter_hashtags', ''),
(42, 'blocks', 'reports_block|news_block'),
(43, 'blocks_per_row', '2'),
(44, 'date_modify', '2012-12-02 11:17:59'),
(45, 'stat_id', '47889'),
(46, 'stat_key', '6c4de10b63fcd9c9e16b38ca909838'),
(47, 'email_username', NULL),
(48, 'email_password', NULL),
(49, 'email_port', NULL),
(50, 'email_host', NULL),
(51, 'email_servertype', NULL),
(52, 'email_ssl', NULL),
(53, 'ftp_server', NULL),
(54, 'ftp_user_name', NULL),
(55, 'alerts_email', 'pjsawadogo68@gmail.com'),
(56, 'checkins', '0'),
(57, 'facebook_appid', NULL),
(58, 'facebook_appsecret', NULL),
(59, 'db_version', '102'),
(60, 'ushahidi_version', '2.6.1'),
(61, 'allow_alerts', '1'),
(62, 'require_email_confirmation', '0'),
(63, 'manually_approve_users', '0'),
(64, 'enable_timeline', '0'),
(65, 'forgot_password_secret', 'q1}0(S9i!qAx.),RbD}w$.~hzeq{%m6,#yrD`AHVTJHx3CaKptsG9)7$Z&9s#fEO');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `riverid` varchar(128) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `email` varchar(127) NOT NULL,
  `username` varchar(100) NOT NULL DEFAULT '',
  `password` char(50) NOT NULL,
  `logins` int(10) unsigned NOT NULL DEFAULT '0',
  `last_login` int(10) unsigned DEFAULT NULL,
  `notify` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Flag incase admin opts in for email notifications',
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `color` varchar(6) NOT NULL DEFAULT 'FF0000',
  `code` varchar(30) DEFAULT NULL,
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `public_profile` tinyint(1) NOT NULL DEFAULT '1',
  `approved` tinyint(1) NOT NULL DEFAULT '1',
  `needinfo` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_username` (`username`),
  UNIQUE KEY `uniq_email` (`email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores registered usersâ€™ information' AUTO_INCREMENT=2 ;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `riverid`, `name`, `email`, `username`, `password`, `logins`, `last_login`, `notify`, `updated`, `color`, `code`, `confirmed`, `public_profile`, `approved`, `needinfo`) VALUES
(1, '', 'Administrator', 'pjsawadogo68@gmail.com', 'admin', '1f922f3b3ad4f8c62e8f257c9a724b1aee4a398f95b953686e', 6, 1354461187, 0, '2012-12-02 15:13:07', 'FF0000', NULL, 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `user_devices`
--

CREATE TABLE IF NOT EXISTS `user_devices` (
  `id` varchar(255) NOT NULL,
  `user_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='Works with checkins';

-- --------------------------------------------------------

--
-- Structure de la table `user_tokens`
--

CREATE TABLE IF NOT EXISTS `user_tokens` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `user_agent` varchar(40) NOT NULL,
  `token` varchar(64) NOT NULL,
  `created` int(10) unsigned NOT NULL,
  `expires` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_token` (`token`),
  KEY `fk_user_id` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores browser tokens assigned to users' AUTO_INCREMENT=3 ;

--
-- Contenu de la table `user_tokens`
--

INSERT INTO `user_tokens` (`id`, `user_id`, `user_agent`, `token`, `created`, `expires`) VALUES
(1, 1, 'd2578374f014d9a357f9fa9e918ca2db0ff420f5', 'VQnVrTKh2cC2ggbvHXK46xowE1kFDC40', 1354401533, 1355611133),
(2, 1, '0fa5fa73fe65672e898b703b29080cdc6b4f651b', 'XqqxZYfZRh2SicibLhiJ801R8WUVVKQe', 1354446925, 1355656525);

-- --------------------------------------------------------

--
-- Structure de la table `verified`
--

CREATE TABLE IF NOT EXISTS `verified` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `incident_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `verified_date` datetime DEFAULT NULL,
  `verified_status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `incident_id` (`incident_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Stores all verified reports' AUTO_INCREMENT=14 ;

--
-- Contenu de la table `verified`
--

INSERT INTO `verified` (`id`, `incident_id`, `user_id`, `verified_date`, `verified_status`) VALUES
(1, 2, 1, '2012-12-02 08:54:59', 2),
(2, 2, 1, '2012-12-02 08:55:20', 1),
(3, 2, 1, '2012-12-02 08:58:10', 1),
(4, 3, 1, '2012-12-02 09:12:58', 1),
(5, 4, 1, '2012-12-02 09:28:14', 2),
(6, 4, 1, '2012-12-02 09:28:20', 1),
(7, 3, 1, '2012-12-02 09:58:07', 1),
(8, 5, 1, '2012-12-02 10:02:42', 0),
(9, 5, 1, '2012-12-02 10:03:52', 1),
(10, 5, 1, '2012-12-02 10:08:05', 1),
(11, 6, 1, '2012-12-02 10:52:50', 1),
(12, 7, 1, '2012-12-02 11:23:37', 1),
(13, 7, 1, '2012-12-02 11:28:30', 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
