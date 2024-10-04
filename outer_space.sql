-- from the terminal run:
-- psql < outer_space.sql

DROP DATABASE IF EXISTS outer_space;

CREATE DATABASE outer_space;

\c outer_space

CREATE TABLE planets
(
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  orbital_period_in_years FLOAT NOT NULL,
  orbits_around TEXT NOT NULL,
  galaxy TEXT NOT NULL,
  moons TEXT[]
);

INSERT INTO planets
  (name, orbital_period_in_years, orbits_around, galaxy, moons)
VALUES
  ('Earth', 1.00, 'The Sun', 'Milky Way', '{"The Moon"}'),
  ('Mars', 1.88, 'The Sun', 'Milky Way', '{"Phobos", "Deimos"}'),
  ('Venus', 0.62, 'The Sun', 'Milky Way', '{}'),
  ('Neptune', 164.8, 'The Sun', 'Milky Way', '{"Naiad", "Thalassa", "Despina", "Galatea", "Larissa", "S/2004 N 1", "Proteus", "Triton", "Nereid", "Halimede", "Sao", "Laomedeia", "Psamathe", "Neso"}'),
  ('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', '{}'),
  ('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', '{}');

CREATE TABLE CelestialBodies (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    orbital_period_in_years FLOAT,
    orbits_around VARCHAR(255),
    galaxy VARCHAR(255),
    type VARCHAR(50) CHECK (type IN ('Planet', 'Moon', 'Star')),
    diameter FLOAT,  -- Optional
    mass FLOAT       -- Optional
);

CREATE TABLE Moons (
    moon_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    celestial_body_id INT REFERENCES CelestialBodies(id)
);

INSERT INTO CelestialBodies (name, orbital_period_in_years, orbits_around, galaxy, type)
VALUES
('Earth', 1, 'The Sun', 'Milky Way', 'Planet'),
('Mars', 1.88, 'The Sun', 'Milky Way', 'Planet'),
('Venus', 0.62, 'The Sun', 'Milky Way', 'Planet'),
('Neptune', 164.8, 'The Sun', 'Milky Way', 'Planet'),
('Proxima Centauri b', 0.03, 'Proxima Centauri', 'Milky Way', 'Planet'),
('Gliese 876 b', 0.23, 'Gliese 876', 'Milky Way', 'Planet');

INSERT INTO Moons (name, celestial_body_id)
VALUES
('The Moon', 1),
('Phobos', 2),
('Deimos', 2),
('Naiad', 4),
('Thalassa', 4),
('Despina', 4),
('Galatea', 4),
('Larissa', 4),
('S/2004 N 1', 4),
('Proteus', 4),
('Triton', 4),
('Nereid', 4),
('Halimede', 4),
('Sao', 4),
('Laomedeia', 4),
('Psamathe', 4),
('Neso', 4);