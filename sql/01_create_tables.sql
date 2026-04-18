-- ============================================================
-- Texas Public Health Analytics
-- Database: texas_health_analytics
-- Sources: CDC NNDSS + Texas Department of State Health Services
-- Period: 2020-2024
-- Author: Juan Pablo Hernandez
-- ============================================================

-- Table 1: Disease catalog
-- Why it exists: centralizes disease names to avoid repetition
CREATE TABLE diseases (
    disease_id          INT PRIMARY KEY,
    disease_name        VARCHAR(150) NOT NULL,
    icd10_code          VARCHAR(10),
    is_vaccine_prev     BOOLEAN DEFAULT FALSE,
    report_category     VARCHAR(50)
);

-- Table 2: Texas counties
-- Why it exists: 15 counties - we don't repeat info in every row
CREATE TABLE counties (
    county_id           INT PRIMARY KEY,
    county_name         VARCHAR(100) NOT NULL,
    fips_code           VARCHAR(5),
    region              VARCHAR(50),
    population_2020     INT
);

-- Table 3: Demographic groups
-- Why it exists: analyze vulnerability by age and sex
CREATE TABLE demographics (
    demo_id             INT PRIMARY KEY,
    age_group           VARCHAR(50) NOT NULL,
    sex                 VARCHAR(10),
    age_range_years     VARCHAR(20)
);

-- Table 4: Disease metadata
-- Why it exists: additional info for richer analysis
CREATE TABLE disease_metadata (
    meta_id             INT PRIMARY KEY,
    disease_id          INT NOT NULL,
    category            VARCHAR(100),
    severity_level      VARCHAR(20),
    typical_season      VARCHAR(50),
    notifiable_class    VARCHAR(20),
    FOREIGN KEY (disease_id) REFERENCES diseases(disease_id)
);

-- Table 5: Monthly reported cases (main fact table)
-- Why it exists: this is where the actual numbers live
-- This is the table you will query the most
CREATE TABLE disease_cases (
    case_id             INT PRIMARY KEY,
    disease_id          INT NOT NULL,
    county_id           INT NOT NULL,
    demo_id             INT NOT NULL,
    report_year         INT NOT NULL,
    report_quarter      INT,
    case_count          INT NOT NULL,
    case_rate_per_100k  DECIMAL(10,2),
    FOREIGN KEY (disease_id) REFERENCES diseases(disease_id),
    FOREIGN KEY (county_id)  REFERENCES counties(county_id),
    FOREIGN KEY (demo_id)    REFERENCES demographics(demo_id)
);
