-- 1.
DELIMITER //
create or replace view Exceptions AS
select distinct a.artist_name AS artist_name,al.album_name AS album_name 
from ((((artists a join song_artist s_a 
on((a.artist_id = s_a.artist_id))) join song_album s_al 
on((s_a.song_id = s_al.song_id))) join albums al 
on((s_al.album_id = al.album_id))) join album_artist a_a 
on((al.album_id = a_a.album_id))) 
where (a.artist_id <> a_a.artist_id);
//
-- ==================================================================================================================================
-- 2. 
DELIMITER //
CREATE or replace VIEW AlbumInfo as
SELECT al.album_name,(
    SELECT GROUP_CONCAT(a.artist_name)
    FROM artists a
    JOIN album_artist a_a ON a.artist_id = a_a.artist_id
    WHERE al.album_id = a_a.album_id
    )
as list_of_artist ,al.date_of_release,(
    SELECT ROUND(SUM(s.song_length),2)
    FROM songs s
    JOIN song_album sal ON s.song_id = sal.song_id
    WHERE sal.album_id = al.album_id
    )  
total_length
FROM albums al
//
 -- ==================================================================================================================================
 
 
 
 
-- 3.
 DELIMITER //
CREATE OR REPLACE TRIGGER CheckReleasedate
AFTER insert on song_album
FOR EACH ROW BEGIN
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
END; //
-- ==================================================================================================================================
-- 4.

DELIMITER //
CREATE OR REPLACE PROCEDURE AddTrack(IN A INT,IN S INT)
MODIFIES SQL DATA
BEGIN
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
                     END;
                     //
-- ==================================================================================================================================
-- 5.
DELIMITER //
CREATE OR REPLACE FUNCTION GetTrackList(A INT(10)) RETURNS VARCHAR(10000)
	DETERMINISTIC
	BEGIN
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
END;
//


-- ==================================================================================================================================
