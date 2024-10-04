-- from the terminal run:
-- psql < music.sql

DROP DATABASE IF EXISTS music;

CREATE DATABASE music;

\c music

CREATE TABLE songs
(
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  duration_in_seconds INTEGER NOT NULL,
  release_date DATE NOT NULL,
  artists TEXT[] NOT NULL,
  album TEXT NOT NULL,
  producers TEXT[] NOT NULL
);

INSERT INTO songs
  (title, duration_in_seconds, release_date, artists, album, producers)
VALUES
  ('MMMBop', 238, '04-15-1997', '{"Hanson"}', 'Middle of Nowhere', '{"Dust Brothers", "Stephen Lironi"}'),
  ('Bohemian Rhapsody', 355, '10-31-1975', '{"Queen"}', 'A Night at the Opera', '{"Roy Thomas Baker"}'),
  ('One Sweet Day', 282, '11-14-1995', '{"Mariah Cary", "Boyz II Men"}', 'Daydream', '{"Walter Afanasieff"}'),
  ('Shallow', 216, '09-27-2018', '{"Lady Gaga", "Bradley Cooper"}', 'A Star Is Born', '{"Benjamin Rice"}'),
  ('How You Remind Me', 223, '08-21-2001', '{"Nickelback"}', 'Silver Side Up', '{"Rick Parashar"}'),
  ('New York State of Mind', 276, '10-20-2009', '{"Jay Z", "Alicia Keys"}', 'The Blueprint 3', '{"Al Shux"}'),
  ('Dark Horse', 215, '12-17-2013', '{"Katy Perry", "Juicy J"}', 'Prism', '{"Max Martin", "Cirkut"}'),
  ('Moves Like Jagger', 201, '06-21-2011', '{"Maroon 5", "Christina Aguilera"}', 'Hands All Over', '{"Shellback", "Benny Blanco"}'),
  ('Complicated', 244, '05-14-2002', '{"Avril Lavigne"}', 'Let Go', '{"The Matrix"}'),
  ('Say My Name', 240, '11-07-1999', '{"Destiny''s Child"}', 'The Writing''s on the Wall', '{"Darkchild"}');

CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE albums (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL UNIQUE,
    release_date DATE NOT NULL
);

CREATE TABLE producers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE songs (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    duration_in_seconds INTEGER NOT NULL,
    album_id INT REFERENCES albums(id) ON DELETE CASCADE
);

CREATE TABLE song_artists (
    song_id INT REFERENCES songs(id) ON DELETE CASCADE,
    artist_id INT REFERENCES artists(id) ON DELETE CASCADE,
    PRIMARY KEY (song_id, artist_id)
);

CREATE TABLE song_producers (
    song_id INT REFERENCES songs(id) ON DELETE CASCADE,
    producer_id INT REFERENCES producers(id) ON DELETE CASCADE,
    PRIMARY KEY (song_id, producer_id)
);

INSERT INTO artists (name) VALUES
('Hanson'),
('Queen'),
('Mariah Carey'),
('Boyz II Men'),
('Lady Gaga'),
('Bradley Cooper'),
('Nickelback'),
('Jay Z'),
('Alicia Keys'),
('Katy Perry'),
('Juicy J'),
('Maroon 5'),
('Christina Aguilera'),
('Avril Lavigne'),
('Destiny\'s Child');

INSERT INTO albums (title, release_date) VALUES
('Middle of Nowhere', '1997-04-15'),
('A Night at the Opera', '1975-10-31'),
('Daydream', '1995-11-14'),
('A Star Is Born', '2018-09-27'),
('Silver Side Up', '2001-08-21'),
('The Blueprint 3', '2009-10-20'),
('Prism', '2013-12-17'),
('Hands All Over', '2011-06-21'),
('Let Go', '2002-05-14'),
('The Writing\'s on the Wall', '1999-11-07');

INSERT INTO producers (name) VALUES
('Dust Brothers'),
('Stephen Lironi'),
('Roy Thomas Baker'),
('Walter Afanasieff'),
('Benjamin Rice'),
('Rick Parashar'),
('Al Shux'),
('Max Martin'),
('Cirkut'),
('Shellback'),
('Benny Blanco'),
('The Matrix'),
('Darkchild');

INSERT INTO songs (title, duration_in_seconds, album_id) VALUES
('MMMBop', 238, 1),
('Bohemian Rhapsody', 355, 2),
('One Sweet Day', 282, 3),
('Shallow', 216, 4),
('How You Remind Me', 223, 5),
('New York State of Mind', 276, 6),
('Dark Horse', 215, 7),
('Moves Like Jagger', 201, 8),
('Complicated', 244, 9),
('Say My Name', 240, 10);

INSERT INTO song_artists (song_id, artist_id) VALUES
(1, 1),  -- MMMBop by Hanson
(2, 2),  -- Bohemian Rhapsody by Queen
(3, 3),  -- One Sweet Day by Mariah Carey
(3, 4),  -- One Sweet Day by Boyz II Men
(4, 5),  -- Shallow by Lady Gaga
(4, 6),  -- Shallow by Bradley Cooper
(5, 7),  -- How You Remind Me by Nickelback
(6, 8),  -- New York State of Mind by Jay Z
(6, 9),  -- New York State of Mind by Alicia Keys
(7, 10), -- Dark Horse by Katy Perry
(7, 11), -- Dark Horse by Juicy J
(8, 12), -- Moves Like Jagger by Maroon 5
(8, 13), -- Moves Like Jagger by Christina Aguilera
(9, 14), -- Complicated by Avril Lavigne
(10, 15); -- Say My Name by Destiny's Child

INSERT INTO song_producers (song_id, producer_id) VALUES
(1, 1),  -- MMMBop producers
(1, 2),
(2, 3),  -- Bohemian Rhapsody producer
(3, 4),  -- One Sweet Day producer
(4, 5),  -- Shallow producer
(5, 6),  -- How You Remind Me producer
(6, 7),  -- New York State of Mind producer
(7, 8),  -- Dark Horse producers
(8, 9),
(9, 10), -- Complicated producer
(10, 11); -- Say My Name producer
