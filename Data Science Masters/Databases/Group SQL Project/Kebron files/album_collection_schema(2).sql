-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2022 at 05:48 PM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `album_collection_schema`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `albuminfo`
-- (See below for the actual view)
--
CREATE TABLE `albuminfo` (
`album_name` varchar(256)
,`list_of_artist` text
,`date_of_release` date
,`total_length` double
);

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `album_id` int(10) NOT NULL,
  `album_name` varchar(256) DEFAULT NULL,
  `date_of_release` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`album_id`, `album_name`, `date_of_release`) VALUES
(10, 'Christmas', '2022-10-01'),
(11, 'Easter song', '2022-10-02'),
(12, 'Wedding song', '2021-10-02'),
(13, 'Celebration', '2022-10-16');

-- --------------------------------------------------------

--
-- Table structure for table `album_artist`
--

CREATE TABLE `album_artist` (
  `album_id` int(10) NOT NULL,
  `artist_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `album_artist`
--

INSERT INTO `album_artist` (`album_id`, `artist_id`) VALUES
(12, 1),
(13, 1),
(11, 2),
(10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `artists`
--

CREATE TABLE `artists` (
  `artist_id` int(10) NOT NULL,
  `artist_name` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `artists`
--

INSERT INTO `artists` (`artist_id`, `artist_name`) VALUES
(1, 'John'),
(2, 'Paul'),
(3, 'James'),
(4, 'Holson');

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
  `song_name` varchar(128) DEFAULT NULL,
  `genre` varchar(32) DEFAULT NULL,
  `song_length` float DEFAULT NULL,
  `date_of_release` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`song_id`, `song_name`, `genre`, `song_length`, `date_of_release`) VALUES
(100, 'Happy Easter Song', 'Holiday', 3, '2022-10-19'),
(101, 'Merry Christmas Song', 'Holiday', 4, '2022-10-19'),
(102, 'Knighting Song', 'Celebrations', 5, '2022-10-12'),
(103, 'Be happy', 'Wedding', 3, '2022-10-19'),
(104, 'Happy Birthday', 'Celebrations', 2, '2022-10-13'),
(105, 'Gradution Song', 'Celebrations', 5, '2022-10-03');

-- --------------------------------------------------------

--
-- Table structure for table `song_album`
--

CREATE TABLE `song_album` (
  `song_id` int(10) NOT NULL,
  `album_id` int(10) NOT NULL,
  `track_no` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `song_album`
--

INSERT INTO `song_album` (`song_id`, `album_id`, `track_no`) VALUES
(101, 10, 2),
(100, 11, 1),
(103, 12, 6),
(105, 13, 3),
(102, 13, 4),
(104, 13, 8);

-- --------------------------------------------------------

--
-- Table structure for table `song_artist`
--

CREATE TABLE `song_artist` (
  `song_id` int(10) NOT NULL,
  `artist_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `song_artist`
--

INSERT INTO `song_artist` (`song_id`, `artist_id`) VALUES
(100, 2),
(101, 3),
(102, 1),
(103, 1),
(104, 2),
(105, 4);

-- --------------------------------------------------------

--
-- Stand-in structure for view `song_artist_distinct`
-- (See below for the actual view)
--
CREATE TABLE `song_artist_distinct` (
`song_id` int(10)
,`artist_id` int(10)
);

-- --------------------------------------------------------

--
-- Structure for view `albuminfo`
--
DROP TABLE IF EXISTS `albuminfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `albuminfo`  AS  (select distinct `a`.`album_name` AS `album_name`,group_concat(distinct `ar`.`artist_name` separator ', ') AS `list_of_artist`,`a`.`date_of_release` AS `date_of_release`,(select sum(`so`.`song_length`)) AS `total_length` from ((((`albums` `a` left join `song_album` `s_a` on((`a`.`album_id` = `s_a`.`album_id`))) join `song_artist_distinct` `s_ar` on((`s_a`.`song_id` = `s_ar`.`song_id`))) join `songs` `so` on((`s_ar`.`song_id` = `so`.`song_id`))) left join `artists` `ar` on((`s_ar`.`artist_id` = `ar`.`artist_id`))) group by `a`.`album_id`) ;

-- --------------------------------------------------------

--
-- Structure for view `exceptions`
--
DROP TABLE IF EXISTS `exceptions`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `exceptions`  AS  select `a`.`artist_name` AS `artist_name`,`al`.`album_name` AS `album_name` from ((((`artists` `a` join `song_artist` `s_a` on((`a`.`artist_id` = `s_a`.`artist_id`))) join `song_album` `s_al` on((`s_a`.`song_id` = `s_al`.`song_id`))) join `albums` `al` on((`s_al`.`album_id` = `al`.`album_id`))) join `album_artist` `a_a` on((`al`.`album_id` = `a_a`.`album_id`))) where (`a`.`artist_id` <> `a_a`.`artist_id`) ;

-- --------------------------------------------------------

--
-- Structure for view `song_artist_distinct`
--
DROP TABLE IF EXISTS `song_artist_distinct`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `song_artist_distinct`  AS  (select distinct `song_artist`.`song_id` AS `song_id`,`song_artist`.`artist_id` AS `artist_id` from `song_artist`) ;

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
  ADD PRIMARY KEY (`artist_id`,`album_id`),
  ADD KEY `album_id_foreign_key` (`album_id`);

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
  ADD PRIMARY KEY (`song_id`,`album_id`),
  ADD UNIQUE KEY `album_id` (`album_id`,`track_no`);

--
-- Indexes for table `song_artist`
--
ALTER TABLE `song_artist`
  ADD PRIMARY KEY (`song_id`,`artist_id`),
  ADD KEY `artist_song_fk` (`artist_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `album_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `artists`
--
ALTER TABLE `artists`
  MODIFY `artist_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `song_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `album_artist`
--
ALTER TABLE `album_artist`
  ADD CONSTRAINT `album_id_foreign_key` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `artist_id_foreign_key` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `song_album`
--
ALTER TABLE `song_album`
  ADD CONSTRAINT `album_song_id_fk` FOREIGN KEY (`album_id`) REFERENCES `albums` (`album_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `song_id_fk` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `song_artist`
--
ALTER TABLE `song_artist`
  ADD CONSTRAINT `artist_song_fk` FOREIGN KEY (`artist_id`) REFERENCES `artists` (`artist_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `song_id_fk2` FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
