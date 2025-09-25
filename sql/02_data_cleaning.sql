/* --------------------------------------------------------------------- */
/* 02_data_cleaning.sql */
/* --------------------------------------------------------------------- */
-- Purpose: standardize categorical values, create cleaned columns

ALTER TABLE ds_salaries
ADD (
	experience_level_clean VARCHAR(20), 
    employment_type_clean VARCHAR(20),
    remote_type VARCHAR(20),
    company_size_clean VARCHAR(10)
    );

-- 1) Map experience codes to human-friendly labels
UPDATE ds_salaries
SET experience_level_clean = CASE
    WHEN experience_level = 'EN' THEN 'Entry'
    WHEN experience_level = 'MI' THEN 'Mid'
    WHEN experience_level = 'SE' THEN 'Senior'
    WHEN experience_level = 'EX' THEN 'Executive'
    ELSE experience_level
END;

-- 2) Map employment type codes
UPDATE ds_salaries
SET employment_type_clean = CASE
    WHEN employment_type = 'FT' THEN 'Full-time'
    WHEN employment_type = 'PT' THEN 'Part-time'
    WHEN employment_type = 'CT' THEN 'Contract'
    WHEN employment_type = 'FL' THEN 'Freelance'
    ELSE employment_type
END;

-- 3) Map company size codes
UPDATE ds_salaries
SET company_size_clean = CASE
    WHEN company_size = 'S' THEN 'Small'
    WHEN company_size = 'M' THEN 'Medium'
    WHEN company_size = 'L' THEN 'Large'
    ELSE company_size
END;
-- 4) Map remote_ratio codes
UPDATE ds_salaries
SET remote_type = CASE
    WHEN remote_ratio = 100 THEN 'Remote'
    WHEN remote_ratio = 50  THEN 'Hybrid'
    WHEN remote_ratio = 0   THEN 'On-site'
    WHEN remote_ratio IS NULL THEN NULL
    ELSE 'Unknown'
END;