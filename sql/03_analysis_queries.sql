-- ============================================================
-- Texas Public Health Analytics
-- Analysis Queries - 8 Business Questions
-- Database: texas_health_analytics
-- Author: Juan Pablo Hernandez
-- ============================================================

-- -------------------------------------------------------
-- QUERY 1: Which diseases had the most reported cases
--          in Texas 2020-2024?
-- Skills: JOIN, GROUP BY, SUM, AVG
-- -------------------------------------------------------
SELECT
    d.disease_name,
    d.report_category,
    SUM(dc.case_count)                   AS total_cases,
    ROUND(AVG(dc.case_rate_per_100k), 2) AS avg_rate_per_100k
FROM disease_cases dc
JOIN diseases d ON dc.disease_id = d.disease_id
WHERE dc.demo_id = 9
GROUP BY d.disease_id, d.disease_name, d.report_category
ORDER BY total_cases DESC;

-- -------------------------------------------------------
-- QUERY 2: Which counties have the highest STI rate in 2024?
-- Skills: Multiple JOINs, rate normalization per 100k
-- -------------------------------------------------------
SELECT
    co.county_name,
    co.region,
    co.population_2020,
    SUM(dc.case_count)                                         AS total_sti_cases,
    ROUND(SUM(dc.case_count) / co.population_2020 * 100000, 2) AS cases_per_100k
FROM disease_cases dc
JOIN diseases d  ON dc.disease_id = d.disease_id
JOIN counties co ON dc.county_id  = co.county_id
WHERE dc.report_year    = 2024
  AND dc.demo_id        = 9
  AND d.report_category = 'sexually_transmitted'
GROUP BY co.county_id, co.county_name, co.region, co.population_2020
ORDER BY cases_per_100k DESC;

-- -------------------------------------------------------
-- QUERY 3: Which diseases grew the most between 2020 and 2024?
-- Skills: CASE WHEN, percentage change calculation, NULLIF
-- -------------------------------------------------------
SELECT
    d.disease_name,
    SUM(CASE WHEN dc.report_year = 2020 THEN dc.case_count ELSE 0 END) AS cases_2020,
    SUM(CASE WHEN dc.report_year = 2024 THEN dc.case_count ELSE 0 END) AS cases_2024,
    ROUND(
        (SUM(CASE WHEN dc.report_year = 2024 THEN dc.case_count ELSE 0 END) -
         SUM(CASE WHEN dc.report_year = 2020 THEN dc.case_count ELSE 0 END))
        / NULLIF(SUM(CASE WHEN dc.report_year = 2020 THEN dc.case_count ELSE 0 END), 0)
        * 100
    , 1) AS pct_change,
    CASE
        WHEN SUM(CASE WHEN dc.report_year = 2024 THEN dc.case_count ELSE 0 END) >
             SUM(CASE WHEN dc.report_year = 2020 THEN dc.case_count ELSE 0 END)
        THEN 'Increasing'
        ELSE 'Decreasing'
    END AS trend
FROM disease_cases dc
JOIN diseases d ON dc.disease_id = d.disease_id
WHERE dc.county_id   = 1
  AND dc.demo_id     = 9
  AND dc.report_year IN (2020, 2024)
GROUP BY d.disease_id, d.disease_name
HAVING cases_2020 > 0
ORDER BY pct_change DESC;

-- -------------------------------------------------------
-- QUERY 4: Which age groups are most vulnerable to
--          Influenza in Harris County in 2024?
-- Skills: RANK() window function, multiple JOINs
-- -------------------------------------------------------
SELECT
    dem.age_group,
    dc.case_count,
    dc.case_rate_per_100k,
    RANK() OVER (ORDER BY dc.case_count DESC) AS vulnerability_rank
FROM disease_cases dc
JOIN demographics dem ON dc.demo_id    = dem.demo_id
JOIN diseases d        ON dc.disease_id = d.disease_id
WHERE dc.county_id   = 1
  AND dc.report_year = 2024
  AND d.disease_name LIKE '%Influenza%'
  AND dem.sex        = 'All'
ORDER BY dc.case_count DESC;

-- -------------------------------------------------------
-- QUERY 5: What percentage of cases are vaccine-preventable?
-- Skills: Subquery in SELECT, percentage calculation
-- -------------------------------------------------------
SELECT
    CASE d.is_vaccine_prev
        WHEN 1 THEN 'Vaccine-preventable'
        WHEN 0 THEN 'Not vaccine-preventable'
    END AS prevention_type,
    COUNT(DISTINCT d.disease_id)  AS num_diseases,
    SUM(dc.case_count)            AS total_cases,
    ROUND(
        SUM(dc.case_count) * 100.0 /
        (SELECT SUM(case_count)
         FROM disease_cases
         WHERE county_id   = 1
           AND report_year = 2024
           AND demo_id     = 9)
    , 1) AS pct_of_total
FROM disease_cases dc
JOIN diseases d ON dc.disease_id = d.disease_id
WHERE dc.county_id   = 1
  AND dc.report_year = 2024
  AND dc.demo_id     = 9
GROUP BY d.is_vaccine_prev
ORDER BY total_cases DESC;

-- -------------------------------------------------------
-- QUERY 6: What is the complete 5-year trend for the
--          top 5 diseases in Harris County (2020-2024)?
-- Skills: IN filter, GROUP BY with year
-- -------------------------------------------------------
SELECT
    d.disease_name,
    dc.report_year,
    SUM(dc.case_count)                   AS annual_cases,
    ROUND(AVG(dc.case_rate_per_100k), 2) AS avg_rate
FROM disease_cases dc
JOIN diseases d ON dc.disease_id = d.disease_id
WHERE dc.county_id  = 1
  AND dc.demo_id    = 9
  AND d.disease_id IN (2, 7, 1, 8, 9)
GROUP BY d.disease_id, d.disease_name, dc.report_year
ORDER BY d.disease_name, dc.report_year;

-- -------------------------------------------------------
-- QUERY 7: Do diseases follow seasonal patterns?
-- Skills: 3-table JOIN, GROUP BY with metadata
-- -------------------------------------------------------
SELECT
    dm.typical_season,
    d.report_category,
    COUNT(DISTINCT d.disease_id)  AS num_diseases,
    SUM(dc.case_count)            AS total_cases,
    ROUND(AVG(dc.case_count), 0)  AS avg_cases_per_entry
FROM disease_cases dc
JOIN diseases d          ON dc.disease_id = d.disease_id
JOIN disease_metadata dm ON d.disease_id  = dm.disease_id
WHERE dc.county_id = 1
GROUP BY dm.typical_season, d.report_category
ORDER BY total_cases DESC;

-- -------------------------------------------------------
-- QUERY 8: What is the complete public health profile
--          of each county? (CTE - Advanced SQL)
-- Skills: CTE (WITH clause), multiple aggregations,
--         ratio calculations, NULLIF
-- -------------------------------------------------------
WITH county_summary AS (
    SELECT
        co.county_id,
        co.county_name,
        co.region,
        co.population_2020,
        SUM(dc.case_count)                              AS total_cases,
        COUNT(DISTINCT d.disease_id)                    AS distinct_diseases,
        SUM(CASE WHEN d.is_vaccine_prev = 1
                 THEN dc.case_count ELSE 0 END)         AS vaccine_prev_cases,
        SUM(CASE WHEN dm.severity_level = 'High'
                 THEN dc.case_count ELSE 0 END)         AS high_severity_cases
    FROM disease_cases dc
    JOIN diseases d          ON dc.disease_id = d.disease_id
    JOIN counties co         ON dc.county_id  = co.county_id
    JOIN disease_metadata dm ON d.disease_id  = dm.disease_id
    WHERE dc.demo_id = 9
    GROUP BY co.county_id, co.county_name, co.region, co.population_2020
)
SELECT
    county_name,
    region,
    population_2020,
    total_cases,
    distinct_diseases,
    ROUND(vaccine_prev_cases * 100.0
          / NULLIF(total_cases, 0), 1)                  AS vaccine_prev_pct,
    ROUND(high_severity_cases * 100.0
          / NULLIF(total_cases, 0), 1)                  AS high_severity_pct,
    ROUND(total_cases * 100000.0
          / population_2020, 1)                         AS overall_rate_per_100k
FROM county_summary
ORDER BY overall_rate_per_100k DESC;
