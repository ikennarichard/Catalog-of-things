CREATE TABLE genre (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
);

CREATE TABLE music_album (
  id SERIAL PRIMARY KEY,
  publish_date DATE,
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  source_id INT NOT NULL,
  archived BOOLEAN NOT NULL,
  on_spotify BOOLEAN NOT NULL,
  FOREIGN KEY (genre_id) REFERENCES genres (id)
  FOREIGN KEY (label_id) REFERENCES label (id),
  FOREIGN KEY (author_id) REFERENCES author (id),
  FOREIGN KEY (source_id) REFERENCES source (id),
);

 CREATE TABLE Book (
    id INT NOT NULL,
    publisher VARCHAR(255) NOT NULL,
    cover_state VARCHAR(255) NOT NULL,
    FOREIGN KEY (id) REFERENCES item (id)
  );

CREATE TABLE Label (
  id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  color VARCHAR(255) NOT NULL,
  FOREIGN KEY (id) REFERENCES item (label)
);

CREATE TABLE author (
  id int generated always as identity,
  fisrt_name VARCHAR(250) NOT NULL,
  last_name VARCHAR(250) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE game (
  id int generated always as identity,
  publish_date DATE,
  author_id INT NOT NULL,
  archived BOOLEAN NOT NULL,
  multiplayer VARCHAR(250) NOT NULL,
  last_played_at DATE,
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES author(id),
    primary key (id)
);