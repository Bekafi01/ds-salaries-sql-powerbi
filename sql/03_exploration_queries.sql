/* --------------------------------------------------------------------- */
/* 03_exploration_queries.sql */
/* --------------------------------------------------------------------- */
-- Purpose: short, runnable queries to understand dataset composition and quality

-- 1) Row counts and coverage
SELECT COUNT(*) AS total_rows FROM ds_salaries;
SELECT COUNT(DISTINCT job_title) AS unique_job_titles FROM ds_salaries;

-- 2) Distribution across years
SELECT work_year, COUNT(*) AS num_jobs, ROUND(AVG(salary_in_usd),2) AS avg_salary
FROM ds_salaries
GROUP BY work_year
ORDER BY work_year;

-- 3) Top job titles by frequency
SELECT job_title, COUNT(*) AS cnt
FROM ds_salaries
GROUP BY job_title
ORDER BY cnt DESC
LIMIT 20;

-- 4) Salary ranges overall and by year
SELECT MIN(salary_in_usd) AS min_salary, ROUND(AVG(salary_in_usd),2) AS avg_salary, MAX(salary_in_usd) AS max_salary
FROM ds_salaries;

SELECT work_year,
MIN(salary_in_usd) AS min_salary,
ROUND(AVG(salary_in_usd),2) AS avg_salary,
MAX(salary_in_usd) AS max_salary
FROM ds_salaries
GROUP BY work_year 
ORDER BY work_year;

-- 5) Quick cross-tabs (experience x employment type)
SELECT experience_level_clean, employment_type_clean, COUNT(*) AS cnt, ROUND(AVG(salary_in_usd),2) AS avg_salary
FROM ds_salaries
GROUP BY experience_level_clean, employment_type_clean
ORDER BY experience_level_clean, employment_type_clean;

-- 6) Top countries by average salary (with at least 10 jobs to avoid tiny-sample noise)
WITH country_stats AS (
	SELECT employee_residence, COUNT(*) AS cnt, AVG(salary_in_usd) AS avg_salary
	FROM ds_salaries
	GROUP BY employee_residence
)
SELECT employee_residence, cnt, ROUND(avg_salary,2) as avg_salary
FROM country_stats
WHERE cnt >= 10
ORDER BY avg_salary DESC
LIMIT 20;