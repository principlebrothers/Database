/*Queries that provide answers to the questions from all projects.*/
SELECT
  *
FROM
  animals
WHERE
  name LIKE '%mon';

SELECT
  name
FROM
  animals
WHERE
  date_of_birth BETWEEN '2016-01-01'
  AND '2019-01-01';

SELECT
  name
FROM
  animals
WHERE
  neutered = TRUE
  AND escape_attempts < 3;

SELECT
  date_of_birth
FROM
  animals
WHERE
  name IN ('Agumon', 'Pikachu');

SELECT
  name,
  escape_attempts
FROM
  animals
WHERE
  weigth_kg > 10.5;

SELECT
  *
FROM
  animals
WHERE
  neutered = TRUE;

SELECT
  *
FROM
  animals
WHERE
  name != 'Gabumon';

SELECT
  *
FROM
  animals
WHERE
  weigth_kg >= 10.4
  AND weigth_kg <= 17.3;

BEGIN;

DELETE FROM
  animals
WHERE
  date_of_birth > '2022-01-01';

SAVEPOINT point_one;

UPDATE
  animals
SET
  weigth_kg = weigth_kg * -1;

ROLLBACK TO SAVEPOINT point_one;

UPDATE
  animals
SET
  weigth_kg = weigth_kg * -1
WHERE
  weigth_kg < 0;

COMMIT;

-- Query the number of animals in the database
SELECT
  COUNT(*)
FROM
  animals;

--Query animals that have never escaped
SELECT
  COUNT(*)
FROM
  animals
WHERE
  escape_attempts < 1;

-- Query the average weight of animals
SELECT
  AVG(weigth_kg)
FROM
  animals;

-- Query neutered or not neutered most escaped animal
SELECT
  neutered
FROM
  animals
WHERE
  escape_attempts = (
    SELECT
      MAX(escape_attempts)
    FROM
      animals
  );

-- Query the minimum weight of the types of animals
SELECT
  MIN(weigth_kg)
FROM
  animals;

-- Query the maximum weight of the types of animals
SELECT
  MAX(weigth_kg)
FROM
  animals;

-- Query the average number of escape attempts of animals born between 1990 and 2000
SELECT
  AVG(escape_attempts)
FROM
  animals
WHERE
  date_of_birth BETWEEN '1990-01-01'
  AND '2000-01-01';

-- Write queries (using JOIN)
-- Animals belonging to Melody Pond
SELECT
  name
FROM
  animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- List of all animals that are of the type pokemon 
SELECT
  animals.name
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
WHERE
  species.name = 'Pokemon';

-- List all owners and their animals
SELECT
  owners.full_name
FROM
  owners
  LEFT JOIN animals on owners.id = animals.owner_id;

-- List of all animals per species
SELECT
  species.name,
  COUNT(*)
FROM
  animals
  INNER JOIN species ON animals.species_id = species.id
GROUP BY
  species.name;

-- List of all Digimon owned by Jennifer Orwell.
SELECT
  animals.name
FROM
  animals
  INNER JOIN owners ON owners.id = animals.owner_id
WHERE
  species_id = 2
  AND owners.full_name = 'Jennifer Orwell';

-- List of all animals owned by Dean Winchester that have tried to escape
SELECT
  animals.name
FROM
  animals
  INNER JOIN owners ON owners.id = animals.owner_id
WHERE
  owners.full_name = 'Dean Winchester'
  AND escape_attempts > 0;

-- Name of owner with the most animals
SELECT
  owners.full_name
FROM
  owners
  LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY
  owners.full_name
ORDER BY
  COUNT(*) DESC
LIMIT
  1;