/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weigth_kg DECIMAL NOT NULL
);