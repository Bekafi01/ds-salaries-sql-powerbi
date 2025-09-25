/* --------------------------------------------------------------------- */
/* 01_create_schema.sql */
/* --------------------------------------------------------------------- */
-- Purpose: create schema and table(s) for the ds_salaries dataset

CREATE DATABASE data_science_salaries;
USE data_science_salaries;

CREATE TABLE ds_salaries (
    work_year INT,
    experience_level VARCHAR(10),
    employment_type VARCHAR(10),
    job_title VARCHAR(25),
    salary DECIMAL(12,2),
    salary_currency VARCHAR(10),
    salary_in_usd DECIMAL(12,2),
    employee_residence VARCHAR(10),
    remote_ratio INT,
    company_location VARCHAR(10),
    company_size VARCHAR(5)
);