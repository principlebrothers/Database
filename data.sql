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

-- Day 4: Add "join table" for visits

-- Insert the following data for vets
INSERT INTO
  vets (name, age, date_of_graduation)
VALUES
  ('William Tatcher', 45, date '2000-04-23'),
  ('Maisy Smith', 26, date '2019-01-17'),
  ('Stephanie Mendez', 64, date '1981-05-04'),
  ('Jack Harkness', 38, date '2008-06-08');

-- Insert the following data for specialties
INSERT INTO
  specializations (species_id, vets_id)
VALUES
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Pokemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    )
  ),
  (
    (
      SELECT
        id
      FROM
        species
      WHERE
        name = 'Digimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    )
  );

-- Insert the following data for visits
INSERT INTO
  visits (animals_id, vets_id, date_of_visit)
VALUES
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    date '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Agumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    date '2020-07-22'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Gabumon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    date '2021-02-02'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2020-01-05'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2020-03-08'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Pikachu'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2020-03-14'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Devimon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    date '2021-05-04'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Charmander'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    date '2021-02-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2019-12-21'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    date '2020-08-10'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Plantmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2021-04-07'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Squirtle'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    date '2019-09-29'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    date '2020-10-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Angemon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Jack Harkness'
    ),
    date '2020-11-04'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2019-01-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2019-05-15'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2020-02-27'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Boarmon'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Maisy Smith'
    ),
    date '2020-08-03'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'Stephanie Mendez'
    ),
    date '2020-05-24'
  ),
  (
    (
      SELECT
        id
      FROM
        animals
      WHERE
        name = 'Blossom'
    ),
    (
      SELECT
        id
      FROM
        vets
      WHERE
        name = 'William Tatcher'
    ),
    date '2021-01-11'
  );