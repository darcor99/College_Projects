-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2022 at 05:20 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `album_collection_schema`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AddTrack` (IN `A` INT, IN `S` INT)  MODIFIES  DATA BEGIN
DECLARE TN int;
IF (SELECT MAX(track_no) FROM song_album WHERE album_id = A) is not NULL THEN
		SET TN = (SELECT MAX(track_no)
          	FROM song_album
          	WHERE album_id = A);
ElSE SET TN = 0;
END IF;
    IF (A IN (SELECT album_id 
              FROM albums))
              AND
    	(S IN (SELECT song_id
               FROM songs)) THEN
                     INSERT INTO song_album
                     VALUES(S,A,TN + 1);
                     END IF;
                     END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `GetTrackList` (`A` INT(10)) RETURNS VARCHAR(10000) CHARSET utf8mb4 COLLATE utf8mb4_unicode_ci  BEGIN
	DECLARE LIST  VARCHAR(10000);

	IF (SELECT EXISTS(SELECT * FROM song_album WHERE album_id = A)) THEN

		SET LIST = (SELECT GROUP_CONCAT(DISTINCT song_name
						 ORDER BY track_no SEPARATOR ', ') as "album song"
		FROM song_album NATURAL JOIN songs
		WHERE ALBUM_ID = A
		GROUP BY ALBUM_ID);

		IF ISNULL(LIST) THEN
			RETURN 'No songs in the album';
		END IF;

		RETURN LIST;
	ELSE
		RETURN 'The given album_id does not exist';	

	END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `albuminfo`
-- (See below for the actual view)
--
CREATE TABLE `albuminfo` (
`album_name` varchar(256)
,`list_of_artist` mediumtext
,`date_of_release` date
,`total_length` double
);

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `album_id` int(10) NOT NULL,
  `album_name` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_release` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`album_id`, `album_name`, `date_of_release`) VALUES
(1, 'Random Access Memories', '2013-05-17'),
(2, 'Human After All', '2005-03-14'),
(3, 'Phrazes for the Young', '2009-11-02'),
(4, 'Day/Night', '2021-11-05');

-- --------------------------------------------------------

--
-- Table structure for table `album_artist`
--

CREATE TABLE `album_artist` (
  `album_id` int(10) NOT NULL,
  `artist_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `album_artist`
--

INSERT INTO `album_artist` (`album_id`, `artist_id`) VALUES
(1, 1),
(2, 1),
(3, 2),
(1, 4),
(4, 4);

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `artist_id` int(10) NOT NULL,
  `artist_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`artist_id`, `artist_name`) VALUES
(1, 'Daft Punk'),
(2, 'Julian Casablancas'),
(3, 'Pharell Williams'),
(4, 'Parcels');

-- --------------------------------------------------------

--
-- Stand-in structure for view `exceptions`
-- (See below for the actual view)
--
CREATE TABLE `exceptions` (
`artist_name` varchar(128)
,`album_name` varchar(256)
);

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `song_id` int(10) NOT NULL,
  `song_name` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `genre` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `song_length` float DEFAULT NULL,
  `date_of_release` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`song_id`, `song_name`, `genre`, `song_length`, `date_of_release`) VALUES
(1, 'Give Life Back to Music', 'house', 4.58, '2013-05-17'),
(2, 'The Game of Love', 'house', 5.3, '2013-05-17'),
(3, 'Giorgio by Moroder', 'house', 9.01, '2013-05-17'),
(4, 'Within', 'house', 3.75, '2013-05-17'),
(5, 'Instant Crush', 'house', 5.6, '2013-05-17'),
(6, 'Lose Yourself to Dance', 'house', 5.9, '2013-05-17'),
(7, 'Touch', 'house', 8.3, '2013-05-17'),
(8, 'Get Lucky', 'house', 6.02, '2013-05-17'),
(9, 'Beyond', 'house', 4.8, '2013-05-17'),
(10, 'Motherboard', 'house', 5.6, '2013-05-17'),
(11, 'Fragments of Time', 'house', 4.6, '2013-05-17'),
(12, 'Doin\' it Right', 'house', 4.2, '2013-05-17'),
(13, 'Contact', 'house', 6.3, '2013-05-17'),
(14, 'Human After All', 'house', 5.3, '2005-03-14'),
(15, 'The Prime Time of Your Life', 'house', 4.3, '2005-03-14'),
(16, 'Robot Rock', 'house', 4.6, '2005-03-14'),
(17, 'Steam Machine', 'house', 5.3, '2005-03-14'),
(18, 'Out of the Blue', 'rock', 4.6, '2009-11-02'),
(19, 'Left & Right in the Dark', 'rock', 4.6, '2009-11-02'),
(20, '11th Dimension', 'rock', 4.6, '2009-11-02'),
(21, 'LIGHT', 'funk', 6.2, '2021-11-05'),
(22, 'Free', 'funk', 5.3, '2011-11-05'),
(23, 'Comingback', 'funk', 5.1, '2011-11-05'),
(24, 'Theworstthing', 'funk', 3.05, '2011-11-05'),
(25, 'Inthecity', 'funk', 1.9, '2011-11-05'),
(26, 'NowIcaresomemore', 'funk', 2.99, '2011-11-05'),
(27, 'Somethinggreater', 'funk', 5.3, '2011-11-05'),
(28, 'Daywalk', 'funk', 3.6, '2011-11-05'),
(29, 'Outside', 'funk', 7.2, '2011-11-05');

-- --------------------------------------------------------

--
-- Table structure for table `song_album`
--

CREATE TABLE `song_album` (
  `song_id` int(10) NOT NULL,
  `album_id` int(10) NOT NULL,
  `track_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `song_album`
--

INSERT INTO `song_album` (`song_id`, `album_id`, `track_no`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10),
(11, 1, 11),
(12, 1, 12),
(13, 1, 13),
(14, 2, 1),
(15, 2, 2),
(16, 2, 3),
(17, 2, 4),
(18, 3, 1),
(18, 4, 10),
(19, 3, 2),
(20, 3, 3),
(21, 1, 14),
(21, 4, 1),
(22, 2, 5),
(22, 4, 2),
(23, 4, 3),
(24, 4, 4),
(25, 4, 5),
(26, 4, 6),
(27, 4, 7),
(28, 4, 8),
(29, 4, 9);

--
-- Triggers `song_album`
--
DELIMITER $$
CREATE TRIGGER `CheckReleasedate` AFTER INSERT ON `song_album` FOR EACH ROW BEGIN
if (select date_of_release from songs s 
where NEW.song_id=s.song_id)
> 
(select date_of_release from albums a
where NEW.album_id=a.album_id) then 
update songs s_d
set s_d.date_of_release=(select date_of_release from albums a
where NEW.album_id=a.album_id)
where s_d.song_id=NEW.song_id;

END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `song_artist`
--

CREATE TABLE `song_artist` (
  `song_id` int(10) NOT NULL,
  `artist_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `song_artist`
--

INSERT INTO `song_artist` (`song_id`, `artist_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(5, 2),
(6, 1),
(6, 3),
(7, 1),
(8, 1),
(8, 3),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 2),
(19, 2),
(20, 2),
(21, 4),
(22, 4),
(23, 4),
(24, 4),
(25, 4),
(26, 4),
(27, 4),
(28, 4),
(29, 4);

-- --------------------------------------------------------

--
-- Structure for view `albuminfo`
--
DROP TABLE IF EXISTS `albuminfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `albuminfo`  AS SELECT DISTINCT `a`.`album_name` AS `album_name`, group_concat(distinct `ar`.`artist_name` separator ', ') AS `list_of_artist`, `a`.`date_of_release` AS `date_of_release`, (select sum(`so`.`song_length`) / count(distinct `ar`.`artist_name`)) AS `total_length` FROM ((((`albums` `a` join `album_artist` `a_a` on(`a`.`album_id` = `a_a`.`album_id`)) join `artists` `ar` on(`a_a`.`artist_id` = `ar`.`artist_id`)) join `song_album` `s_a` on(`a`.`album_id` = `s_a`.`album_id`)) join `songs` `so` on(`s_a`.`song_id` = `so`.`song_id`)) GROUP BY `a`.`album_id``album_id`  ;

-- --------------------------------------------------------

--
-- Structure for view `exceptions`
--
DROP TABLE IF EXISTS `exceptions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `exceptions`  AS SELECT DISTINCT `a`.`artist_name` AS `artist_name`, `al`.`album_name` AS `album_name` FROM ((((`artists` `a` join `song_artist` `s_a` on(`a`.`artist_id` = `s_a`.`artist_id`)) join `song_album` `s_al` on(`s_a`.`song_id` = `s_al`.`song_id`)) join `albums` `al` on(`s_al`.`album_id` = `al`.`album_id`)) join `album_artist` `a_a` on(`al`.`album_id` = `a_a`.`album_id`)) WHERE `a`.`artist_id` <> `a_a`.`artist_id``artist_id`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`album_id`);

--
-- Indexes for table `album_artist`
--
ALTER TABLE `album_artist`
  ADD PRIMARY KEY (`artist_id`,`album_id`);

--
-- Indexes for table `artists`
--
ALTER TABLE `artists`
  ADD PRIMARY KEY (`artist_id`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`song_id`);

--
-- Indexes for table `song_album`
--
ALTER TABLE `song_album`
  ADD PRIMARY KEY (`song_id`,`album_id`,`track_no`) USING BTREE,
  ADD UNIQUE KEY `album_id` (`album_id`,`track_no`,`song_id`) USING BTREE;

--
-- Indexes for table `song_artist`
--
ALTER TABLE `song_artist`
  ADD PRIMARY KEY (`song_id`,`artist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `album_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `artist_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `song_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
