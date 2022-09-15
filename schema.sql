/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weigth_kg DECIMAL NOT NULL
);

-- Create a table known as owners
CREATE TABLE owners (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    full_name TEXT NOT NULL,
    age INT NOT NULL
);

-- Create a table known as species
CREATE TABLE species (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name TEXT
);

-- Modify animals table: 
-- Remove column species
ALTER TABLE
    animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE
    animals
ADD
    COLUMN species_id INT,
ADD
    FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE
    animals
ADD
    COLUMN owner_id INT,
ADD
    FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;