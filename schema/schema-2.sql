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