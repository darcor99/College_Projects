-- This file contains test data for your project.
--
-- INSTRUCTIONS:
--   1. Make sure you have created the two views and compiled the trigger, the stored procedure and the stored function.
--   2. Import this file into your database.
--
-- Please note that the data in this file is real with three exceptions in order to make the test more interesting.
-- The exceptions are:
--   1. The band Parcels is listed as an artist on Daft Punk's album 'Random Access Memories'.
--   2. The song 'LIGHT' of Parcels is included in Daft Punk's album 'Random Access Memories'.
--   3. The song 'Free' of Parcels is included in Daft Punk's album 'Human After All'.

-- ----------- DATA --------------------------------------------------

INSERT INTO artists (artist_name) VALUES ('Daft Punk');
INSERT INTO artists (artist_name) VALUES ('Julian Casablancas');
INSERT INTO artists (artist_name) VALUES ('Pharell Williams');
INSERT INTO artists (artist_name) VALUES ('Parcels');

INSERT INTO albums (album_name, date_of_release) VALUES ('Random Access Memories', '2013-05-17');
INSERT INTO albums (album_name, date_of_release) VALUES ('Human After All', '2005-03-14');
INSERT INTO albums (album_name, date_of_release) VALUES ('Phrazes for the Young', '2009-11-02');
INSERT INTO albums (album_name, date_of_release) VALUES ('Day/Night', '2021-11-05');

INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES
	('Give Life Back to Music', 'house', 4.58, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('The Game of Love', 'house', 5.30, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Giorgio by Moroder', 'house', 9.01, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Within', 'house', 3.75, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Instant Crush', 'house', 5.6, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Lose Yourself to Dance', 'house', 5.9, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Touch', 'house', 8.3, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Get Lucky', 'house', 6.02, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Beyond', 'house', 4.8, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Motherboard', 'house', 5.6, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Fragments of Time', 'house', 4.6, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Doin'' it Right', 'house', 4.2, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Contact', 'house', 6.3, '2013-05-17');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Human After All', 'house', 5.3, '2005-03-14');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('The Prime Time of Your Life', 'house', 4.3, '2005-03-14');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Robot Rock', 'house', 4.6, '2005-03-14');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Steam Machine', 'house', 5.3, '2005-03-14');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Out of the Blue', 'rock', 4.6, '2009-11-02');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Left & Right in the Dark', 'rock', 4.6, '2009-11-02');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('11th Dimension', 'rock', 4.6, '2009-11-02');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('LIGHT', 'funk', 6.2, '2021-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Free', 'funk', 5.3, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Comingback', 'funk', 5.1, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Theworstthing', 'funk', 3.05, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Inthecity', 'funk', 1.9, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('NowIcaresomemore', 'funk', 2.99, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Somethinggreater', 'funk', 5.3, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Daywalk', 'funk', 3.6, '2011-11-05');
INSERT INTO songs (song_name, genre, song_length, date_of_release) VALUES	
	('Outside', 'funk', 7.2, '2011-11-05');

INSERT INTO album_artist 
VALUES 
	(1, 1),
	(1, 4),
	(2, 1),
	(3, 2),
	(4, 4);

INSERT INTO song_album
VALUES
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
	(21, 1, 14),

	(14, 2, 1),
	(15, 2, 2),
	(16, 2, 3),
	(17, 2, 4),
	(22, 2, 5),

	(18, 3, 1),
	(19, 3, 2),
	(20, 3, 3),

	(21, 4, 1),
	(22, 4, 2),
	(23, 4, 3),
	(24, 4, 4),
	(25, 4, 5),
	(26, 4, 6),
	(27, 4, 7),
	(28, 4, 8),
	(29, 4, 9);

INSERT INTO song_artist
VALUES
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