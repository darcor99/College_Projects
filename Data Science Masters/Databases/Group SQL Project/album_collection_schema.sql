CREATE TABLE IF NOT EXISTS artists (
  artist_id INTEGER(10) AUTO_INCREMENT PRIMARY KEY,
  artist_name varchar(128)
);

CREATE TABLE IF NOT EXISTS albums (
  album_id INTEGER(10) AUTO_INCREMENT PRIMARY KEY,
  album_name varchar(256), -- note that two different albums may have the same name
  date_of_release DATE -- date of release of the album
);

CREATE TABLE IF NOT EXISTS songs (
  song_id INTEGER(10) AUTO_INCREMENT PRIMARY KEY,
  song_name varchar(128),
  genre varchar(32),
  song_length FLOAT, -- length of the song in minutes
  date_of_release DATE -- date of release of the song (may be different form the date of release of any album the song is on)
);

CREATE TABLE IF NOT EXISTS album_artist (
  album_id INTEGER(10) REFERENCES albums(album_id),
  artist_id INTEGER(10) REFERENCES artists(artist_id), -- artist who is listed as one of the artists on the album
  PRIMARY KEY(artist_id, album_id)
);

CREATE TABLE IF NOT EXISTS song_artist (
  -- note that a song may have multiple artists collaborating on it
  song_id INTEGER(10) REFERENCES songs(song_id),
  artist_id INTEGER(10) REFERENCES artists(artist_id),
  PRIMARY KEY(song_id, artist_id)
);

CREATE TABLE IF NOT EXISTS song_album (
  -- note that a song may appear on multiple albums
  song_id INTEGER(10) REFERENCES songs(song_id),
  album_id INTEGER(10) REFERENCES albums(album_id),
  track_no INTEGER NOT NULL, -- position of the song on the tracklist of the album
  PRIMARY KEY(song_id, album_id),
  UNIQUE(album_id, track_no)
);