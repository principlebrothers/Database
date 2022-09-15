/* Populate database with sample data. */
INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Agumon', date '2020-02-03', 0, TRUE, 10.23);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Gabumon', date '2018-11-15', 2, TRUE, 8);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Pikachu', date '2021-01-07', 1, FALSE, 15.04);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Devimon', date '2021-05-12', 5, TRUE, 11);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Charmander', date '2020-02-8', 0, FALSE, -11);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Plantmon', date '2021-11-15', 2, TRUE, -5.7);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Squirtle', date '1993-04-02', 3, FALSE, -12.13);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Angemon', date '2005-06-12', 1, TRUE, -45);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Boarmon', date '2005-06-07', 7, TRUE, 20.4);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Blossom', date '1998-10-13', 3, TRUE, 17);

INSERT INTO
  animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weigth_kg
  )
VALUES
  ('Ditto', date '2022-05-14', 4, TRUE, 22);

-- Insert the following data into the owners table
INSERT INTO
  owners (full_name, age)
VALUES
  ('Sam Smith', 34);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Jennifer Orwell', 19);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Bob', 45);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Melody Pond', 77);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Dean Winchester', 14);

INSERT INTO
  owners (full_name, age)
VALUES
  ('Jodie Whittaker', 38);

--  Insert the following data into the species table:
INSERT INTO
  species (name)
VALUES
  ('Pokemon');

INSERT INTO
  species (name)
VALUES
  ('Digimon');

-- Modify inserted animals so it includes the species_id value
UPDATE
  animals
SET
  species_id = 2
WHERE
  name LIKE '%mon';

UPDATE
  animals
SET
  species_id = 1
WHERE
  species_id IS NULL;

-- Modify inserted animals to include owner information (owner_id)
UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Sam Smith'
  )
WHERE
  name = 'Agumon';

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Jennifer Orwell'
  )
WHERE
  name IN ('Gabumon', 'Pikachu');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Bob'
  )
WHERE
  name IN ('Devimon', 'Plantmon');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Melody Pond'
  )
WHERE
  name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE
  animals
SET
  owner_id = (
    SELECT
      id
    FROM
      owners
    WHERE
      full_name = 'Dean Winchester'
  )
WHERE
  name IN ('Angemon', 'Boarmon');