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

-- Day 3: Join tables
-- Write queries (using JOIN)
-- Animals belonging to Melody Pond
SELECT
  name
FROM
  animals
  JOIN owners ON animals.owner_id = owners.id
WHERE
  owners.full_name = 'Melody Pond';

-- List of all animals that are of the type pokemon 
SELECT
  animals.name
FROM
  animals
  JOIN species ON animals.species_id = species.id
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
  JOIN species ON animals.species_id = species.id
GROUP BY
  species.name;

-- List of all Digimon owned by Jennifer Orwell.
SELECT
  animals.name
FROM
  animals
  JOIN owners ON owners.id = animals.owner_id
WHERE
  species_id = 2
  AND owners.full_name = 'Jennifer Orwell';

-- List of all animals owned by Dean Winchester that have tried to escape
SELECT
  animals.name
FROM
  animals
  JOIN owners ON owners.id = animals.owner_id
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

-- Day 4: Add 'Join table' for visits
-- Queries to answer the following:
-- The last animal seen by William Tatcher
SELECT
  B.name as vet_name,
  Anim.name as animal_name,
  A.date_of_visit as Last_Visit
FROM
  visits A
  RIGHT JOIN vets B ON A.vets_id = B.id
  RIGHT JOIN animals Anim ON A.vets_id = Anim.id
GROUP BY
  B.name,
  A.date_of_visit,
  animal_name
HAVING
  MAX(A.date_of_visit) = (
    SELECT
      MAX(vet_visits.date_of_visit)
    FROM
      (
        SELECT
          *
        From
          visits
        WHERE
          vets_id = (
            SELECT
              id
            FROM
              vets
            WHERE
              name = 'William Tatcher'
          )
      ) as vet_visits
  );

-- Different animals seen by Stephanie Mendez 
SELECT
  COUNT(*) AS total_number_of_animals_Stepahnie_visited
FROM
  visits
WHERE
  vets_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Stephanie Mendez'
  );

-- All vets and their specialties, including vets with no specialties.
SELECT
  vets.name,
  species.name
FROM
  vets
  LEFT JOIN specializations ON vets.id = specializations.vets_id
  LEFT JOIN species ON specializations.species_id = species.id;

-- All animals that visited Stephanie Mendez between April 1st and August 30th, 2020
SELECT
  animals.name
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
WHERE
  visits.vets_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Stephanie Mendez'
  )
  AND visits.date_of_visit BETWEEN date '2020-04-01'
  AND date '2020-08-30';

-- Animal that had the most visits to vets
SELECT
  COUNT(*) as number_of_visits,
  A.name as animal_name
FROM
  visits B
  RIGHT JOIN animals A ON B.animals_id = A.id
GROUP BY
  A.name
HAVING
  COUNT(*) = (
    SELECT
      MAX(count_results.visits_per_animals)
    FROM
      (
        select
          count(A.vets_id) as visits_per_animals
        FROM
          visits A
        GROUP BY
          A.animals_id
      ) as count_results
  );

-- Animal that visited Maisy Smith first
SELECT
  animals.name
FROM
  animals
  JOIN visits ON animals.id = visits.animals_id
WHERE
  visits.vets_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Maisy Smith'
  )
  AND visits.date_of_visit = (
    SELECT
      MIN(date_of_visit)
    FROM
      visits
    WHERE
      visits.vets_id = (
        SELECT
          id
        FROM
          vets
        WHERE
          name = 'Maisy Smith'
      )
  );

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT
  A.id,
  B.name as vet_name,
  C.name as Animal_name,
  A.date_of_visit
FROM
  visits A
  RIGHT JOIN vets B ON A.vets_id = B.id
  RIGHT JOIN animals C ON A.animals_id = C.id
GROUP BY
  C.name,
  B.name,
  A.id,
  A.date_of_visit
HAVING
  MAX(A.date_of_visit) = (
    SELECT
      MAX(date_of_visit)
    FROM
      visits
  );

-- Number of visits that were with a vet that did not specialize in that animal's species
SELECT
  COUNT(visits.animals_id)
FROM
  visits
  JOIN vets ON visits.vets_id = vets.id
  JOIN animals ON animals.id = visits.animals_id
  JOIN specializations ON specializations.species_id = vets.id
WHERE
  specializations.species_id != animals.species_id;

-- Specialty Maisy Smith should consider getting based on the species she gets the most
SELECT
  Vet.name AS vet_name,
  count(SP.name) AS Visited,
  SP.name AS specialty
FROM
  visits V
  LEFT JOIN vets Vet ON Vet.id = V.vets_id
  LEFT JOIN animals A ON A.id = V.animals_id
  LEFT JOIN species SP ON SP.id = A.species_id
WHERE
  V.vets_id = (
    SELECT
      id
    FROM
      vets
    WHERE
      name = 'Maisy Smith'
  )
GROUP BY
  SP.name,
  Vet.name
HAVING
  COUNT(SP.name) = (
    SELECT
      MAX(results.count)
    FROM
      (
        SELECT
          count(visit_per_vet.species_id)
        FROM
          (
            SELECT
              A.species_id as species_id
            FROM
              visits V
              LEFT JOIN animals A ON A.id = V.animals_id
            WHERE
              V.vets_id = (
                SELECT
                  id
                FROM
                  vets
                WHERE
                  name = 'Maisy Smith'
              )
          ) as visit_per_vet
        GROUP BY
          visit_per_vet.species_id
      ) as results
  );