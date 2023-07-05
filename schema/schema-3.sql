CREATE TABLE author (
  id SERIAL PRIMARY KEY,
  fisrt_name VARCHAR(250) NOT NULL
  last_name VARCHAR(250) NOT NULL
);

CREATE TABLE game (
  id SERIAL PRIMARY KEY,
  publish_date DATE,
  genre_id INT NOT NULL,
  author_id INT NOT NULL,
  label_id INT NOT NULL,
  source_id INT NOT NULL,
  archived BOOLEAN NOT NULL,
  multiplayer BOOLEAN NOT NULL,
  last_played_at DATE,
  FOREIGN KEY (genre_id) REFERENCES genres (id)
  FOREIGN KEY (label_id) REFERENCES label (id),
  FOREIGN KEY (author_id) REFERENCES author (id),
  FOREIGN KEY (source_id) REFERENCES source (id),
);
