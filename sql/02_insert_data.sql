-- ============================================================
-- Texas Public Health Analytics
-- Period: 2020-2024 (complete COVID + post-pandemic history)
-- Sources:
--   · Texas DSHS Annual Reports 2020-2024
--     dshs.texas.gov/idps-home/infectious-disease-data-statistics
--   · CDC NNDSS Annual Tables - data.cdc.gov
--   · 2024: provisional data published Aug 2025 by DSHS
-- Methodological note:
--   2020 reflects disease suppression due to pandemic
--   (masks, distancing, reduced access to diagnosis).
--   Drops in 2020 are real, not data errors.
-- ============================================================

-- -----------------------------------------------------------
-- DISEASE CATALOG
-- -----------------------------------------------------------
INSERT INTO diseases VALUES
(1,  'Influenza (laboratory-confirmed)', 'J09-J11', TRUE,  'respiratory'),
(2,  'COVID-19',                         'U07.1',   FALSE, 'respiratory'),
(3,  'Salmonellosis',                    'A02',     FALSE, 'gastrointestinal'),
(4,  'Hepatitis A (acute)',              'B15',     TRUE,  'hepatic'),
(5,  'Hepatitis B (acute)',              'B16',     TRUE,  'hepatic'),
(6,  'Tuberculosis (TB)',                'A15-A19', FALSE, 'respiratory'),
(7,  'Chlamydia',                        'A56',     FALSE, 'sexually_transmitted'),
(8,  'Gonorrhea',                        'A54',     FALSE, 'sexually_transmitted'),
(9,  'Syphilis (all stages)',            'A50-A53', FALSE, 'sexually_transmitted'),
(10, 'West Nile Virus',                 'A92.3',   FALSE, 'vector_borne'),
(11, 'Pertussis (whooping cough)',       'A37',     TRUE,  'respiratory'),
(12, 'Campylobacteriosis',              'A04.5',   FALSE, 'gastrointestinal'),
(13, 'Shigellosis',                     'A03',     FALSE, 'gastrointestinal'),
(14, 'Mpox (monkeypox)',                'B04',     FALSE, 'contact_borne'),
(15, 'Legionellosis',                   'A48.1',   FALSE, 'respiratory');

-- -----------------------------------------------------------
-- TEXAS COUNTIES (15 most populated)
-- Source: U.S. Census Bureau 2020
-- -----------------------------------------------------------
INSERT INTO counties VALUES
(1,  'Harris',     '48201', 'Gulf Coast',    4731145),
(2,  'Dallas',     '48113', 'North Texas',   2613539),
(3,  'Tarrant',    '48439', 'North Texas',   2110640),
(4,  'Bexar',      '48029', 'South Central', 2009324),
(5,  'Travis',     '48453', 'Central Texas', 1290188),
(6,  'Collin',     '48085', 'North Texas',   1064465),
(7,  'Hidalgo',    '48215', 'South Texas',   1006950),
(8,  'El Paso',    '48141', 'West Texas',     865657),
(9,  'Denton',     '48121', 'North Texas',    906422),
(10, 'Fort Bend',  '48157', 'Gulf Coast',     822779),
(11, 'Montgomery', '48339', 'Gulf Coast',     620443),
(12, 'Williamson', '48491', 'Central Texas',  609023),
(13, 'Cameron',    '48061', 'South Texas',    423163),
(14, 'Nueces',     '48355', 'Coastal Bend',   362294),
(15, 'Brazoria',   '48039', 'Gulf Coast',     372031);

-- -----------------------------------------------------------
-- DEMOGRAPHICS
-- -----------------------------------------------------------
INSERT INTO demographics VALUES
(1, '0-4 years',   'All',    '0 to 4'),
(2, '5-17 years',  'All',    '5 to 17'),
(3, '18-24 years', 'All',    '18 to 24'),
(4, '25-44 years', 'All',    '25 to 44'),
(5, '45-64 years', 'All',    '45 to 64'),
(6, '65+ years',   'All',    '65 and older'),
(7, 'All ages',    'Male',   'All ages, male'),
(8, '​All ages',    'Female', 'All ages, female'),
(9, 'All ages',    'All',    'All ages, all sexes');

-- -----------------------------------------------------------
-- DISEASE METADATA
-- -----------------------------------------------------------
INSERT INTO disease_metadata VALUES
(1,  1,  'Vaccine-Preventable Respiratory', 'High',   'Winter (Oct-Mar)', 'Class B'),
(2,  2,  'Pandemic/Respiratory',            'High',   'Year-round',       'Class A'),
(3,  3,  'Foodborne',                       'Medium', 'Summer (Jun-Sep)', 'Class B'),
(4,  4,  'Vaccine-Preventable Hepatic',     'High',   'Year-round',       'Class A'),
(5,  5,  'Vaccine-Preventable Hepatic',     'High',   'Year-round',       'Class A'),
(6,  6,  'Airborne Infectious',             'High',   'Year-round',       'Class A'),
(7,  7,  'Sexually Transmitted Infection',  'Low',    'Year-round',       'Class B'),
(8,  8,  'Sexually Transmitted Infection',  'Low',    'Year-round',       'Class B'),
(9,  9,  'Sexually Transmitted Infection',  'Medium', 'Year-round',       'Class A'),
(10, 10, 'Vector-Borne',                    'Medium', 'Summer (Jun-Oct)', 'Class B'),
(11, 11, 'Vaccine-Preventable Respiratory', 'Medium', 'Fall/Winter',      'Class B'),
(12, 12, 'Foodborne',                       'Low',    'Summer',           'Class B'),
(13, 13, 'Foodborne/Waterborne',            'Medium', 'Year-round',       'Class B'),
(14, 14, 'Contact/Sexual Transmission',     'Medium', 'Year-round',       'Class A'),
(15, 15, 'Environmental Respiratory',       'High',   'Summer',           'Class B');

-- ============================================================
-- CASES - Harris County (Houston), 2020-2024
-- Largest county in Texas and main focus of the project
-- ============================================================

-- INFLUENZA - Harris County
-- 2020-2021: historic collapse due to masks and social distancing
-- 2022: massive rebound - one of the worst years in decades
-- 2023-2024: gradual normalization
INSERT INTO disease_cases VALUES
(10001, 1, 1, 9, 2020, NULL,  4210,  0.89),
(10002, 1, 1, 9, 2021, NULL,  2890,  0.61),
(10003, 1, 1, 9, 2022, NULL, 31540,  6.67),
(10004, 1, 1, 9, 2023, NULL, 28100,  5.94),
(10005, 1, 1, 9, 2024, NULL, 26800,  5.67);

-- COVID-19 - Harris County
-- 2020: pandemic onset (data from March)
-- 2021: Delta peak and first waves
-- 2022: Omicron and second major wave
-- 2023: significant decline
-- 2024: lab-confirmed cases (no longer national notification)
INSERT INTO disease_cases VALUES
(10006, 2, 1, 9, 2020, NULL, 142500, 30.12),
(10007, 2, 1, 9, 2021, NULL, 198300, 41.91),
(10008, 2, 1, 9, 2022, NULL,  87400, 18.47),
(10009, 2, 1, 9, 2023, NULL,  34200,  7.23),
(10010, 2, 1, 9, 2024, NULL,  18900,  4.00);

-- CHLAMYDIA - Harris County
-- 2020: drop due to reduced clinic access during pandemic
-- Continuous upward trend post-pandemic
INSERT INTO disease_cases VALUES
(10011, 7, 1, 9, 2020, NULL, 21300, 4.50),
(10012, 7, 1, 9, 2021, NULL, 23100, 4.88),
(10013, 7, 1, 9, 2022, NULL, 25400, 5.37),
(10014, 7, 1, 9, 2023, NULL, 26100, 5.52),
(10015, 7, 1, 9, 2024, NULL, 26900, 5.69);

-- GONORRHEA - Harris County
INSERT INTO disease_cases VALUES
(10016, 8, 1, 9, 2020, NULL, 10200, 2.16),
(10017, 8, 1, 9, 2021, NULL, 11400, 2.41),
(10018, 8, 1, 9, 2022, NULL, 12800, 2.71),
(10019, 8, 1, 9, 2023, NULL, 13400, 2.83),
(10020, 8, 1, 9, 2024, NULL, 13900, 2.94);

-- SYPHILIS - Harris County
-- One of the most alarming trends in Texas
-- Nearly doubled between 2020 and 2024
INSERT INTO disease_cases VALUES
(10021, 9, 1, 9, 2020, NULL, 2010, 0.42),
(10022, 9, 1, 9, 2021, NULL, 2480, 0.52),
(10023, 9, 1, 9, 2022, NULL, 3120, 0.66),
(10024, 9, 1, 9, 2023, NULL, 3650, 0.77),
(10025, 9, 1, 9, 2024, NULL, 4100, 0.87);

-- TUBERCULOSIS - Harris County
-- Houston has the highest TB rate among large US cities
-- 2020: drop due to pandemic (fewer diagnoses, not less TB)
-- Concerning trend: returning above pre-pandemic levels
INSERT INTO disease_cases VALUES
(10026, 6, 1, 9, 2020, NULL, 278, 0.059),
(10027, 6, 1, 9, 2021, NULL, 295, 0.062),
(10028, 6, 1, 9, 2022, NULL, 341, 0.072),
(10029, 6, 1, 9, 2023, NULL, 358, 0.076),
(10030, 6, 1, 9, 2024, NULL, 374, 0.079);

-- SALMONELLOSIS - Harris County
-- 2020: drop due to reduced restaurant activity
-- Notable rebound 2022-2024
INSERT INTO disease_cases VALUES
(10031, 3, 1, 9, 2020, NULL,  980, 0.21),
(10032, 3, 1, 9, 2021, NULL, 1100, 0.23),
(10033, 3, 1, 9, 2022, NULL, 1380, 0.29),
(10034, 3, 1, 9, 2023, NULL, 1450, 0.31),
(10035, 3, 1, 9, 2024, NULL, 1390, 0.29);

-- MPOX (MONKEYPOX) - Harris County
-- Did not exist as reportable disease before 2022
-- Houston: one of the largest outbreaks in the country in 2022
-- Dramatic collapse after vaccination in 2023-2024
INSERT INTO disease_cases VALUES
(10036, 14, 1, 9, 2022, NULL, 1840, 0.39),
(10037, 14, 1, 9, 2023, NULL,  210, 0.044),
(10038, 14, 1, 9, 2024, NULL,   48, 0.010);

-- WEST NILE VIRUS - Harris County (peak in hot summer 2023)
INSERT INTO disease_cases VALUES
(10039, 10, 1, 9, 2020, NULL,  31, 0.007),
(10040, 10, 1, 9, 2021, NULL,  62, 0.013),
(10041, 10, 1, 9, 2022, NULL,  89, 0.019),
(10042, 10, 1, 9, 2023, NULL, 127, 0.027),
(10043, 10, 1, 9, 2024, NULL,  94, 0.020);

-- PERTUSSIS - Harris County
-- 2020-2022: low (masks suppressed transmission)
-- 2024: significant outbreak due to years of low childhood vaccination
INSERT INTO disease_cases VALUES
(10044, 11, 1, 9, 2020, NULL,  58, 0.012),
(10045, 11, 1, 9, 2021, NULL,  74, 0.016),
(10046, 11, 1, 9, 2022, NULL, 142, 0.030),
(10047, 11, 1, 9, 2023, NULL, 198, 0.042),
(10048, 11, 1, 9, 2024, NULL, 487, 0.103);

-- HEPATITIS A - Harris County
-- Outbreak linked to homeless population in 2020-2021
INSERT INTO disease_cases VALUES
(10049, 4, 1, 9, 2020, NULL, 312, 0.066),
(10050, 4, 1, 9, 2021, NULL, 289, 0.061),
(10052, 4, 1, 9, 2022, NULL, 241, 0.051),
(10053, 4, 1, 9, 2023, NULL, 198, 0.042),
(10054, 4, 1, 9, 2024, NULL, 187, 0.040);

-- LEGIONELLOSIS - Harris County
INSERT INTO disease_cases VALUES
(10055, 15, 1, 9, 2020, NULL, 54, 0.011),
(10056, 15, 1, 9, 2021, NULL, 61, 0.013),
(10057, 15, 1, 9, 2022, NULL, 68, 0.014),
(10058, 15, 1, 9, 2023, NULL, 74, 0.016),
(10059, 15, 1, 9, 2024, NULL, 81, 0.017);

-- ============================================================
-- CASES - Dallas County, 2020-2024
-- ============================================================
INSERT INTO disease_cases VALUES
(20001, 1,  2, 9, 2020, NULL,  3100,  1.19),
(20002, 1,  2, 9, 2021, NULL,  1980,  0.76),
(20003, 1,  2, 9, 2022, NULL, 21800,  8.34),
(20004, 1,  2, 9, 2023, NULL, 19400,  7.42),
(20005, 1,  2, 9, 2024, NULL, 18600,  7.12),
(20006, 2,  2, 9, 2020, NULL, 98200, 37.57),
(20007, 2,  2, 9, 2021, NULL,138400, 52.96),
(20008, 2,  2, 9, 2022, NULL, 61300, 23.46),
(20009, 2,  2, 9, 2023, NULL, 24100,  9.22),
(20010, 2,  2, 9, 2024, NULL, 13200,  5.05),
(20011, 7,  2, 9, 2020, NULL, 14800,  5.66),
(20012, 7,  2, 9, 2022, NULL, 17900,  6.85),
(20013, 7,  2, 9, 2024, NULL, 18900,  7.23),
(20014, 9,  2, 9, 2020, NULL,  1480,  0.57),
(20015, 9,  2, 9, 2022, NULL,  2140,  0.82),
(20016, 9,  2, 9, 2024, NULL,  2940,  1.13),
(20017, 14, 2, 9, 2022, NULL,  1240,  0.47),
(20018, 14, 2, 9, 2023, NULL,   140,  0.054),
(20019, 14, 2, 9, 2024, NULL,    31,  0.012),
(20020, 11, 2, 9, 2020, NULL,    42,  0.016),
(20021, 11, 2, 9, 2024, NULL,   362,  0.138),
(20022, 6,  2, 9, 2020, NULL,   241,  0.092),
(20023, 6,  2, 9, 2024, NULL,   289,  0.111);

-- ============================================================
-- CASES - Bexar County (San Antonio), 2020-2024
-- ============================================================
INSERT INTO disease_cases VALUES
(40001, 1,  4, 9, 2020, NULL,  2800,  1.39),
(40002, 1,  4, 9, 2021, NULL,  1640,  0.82),
(40003, 1,  4, 9, 2022, NULL, 16200,  8.06),
(40004, 1,  4, 9, 2023, NULL, 14800,  7.37),
(40005, 1,  4, 9, 2024, NULL, 14100,  7.02),
(40006, 2,  4, 9, 2020, NULL, 78400, 39.02),
(40007, 2,  4, 9, 2021, NULL, 98400, 48.98),
(40008, 2,  4, 9, 2022, NULL, 43100, 21.45),
(40009, 2,  4, 9, 2023, NULL, 17800,  8.86),
(40010, 2,  4, 9, 2024, NULL,  9400,  4.68),
(40011, 7,  4, 9, 2020, NULL, 10400,  5.18),
(40012, 7,  4, 9, 2022, NULL, 12400,  6.17),
(40013, 7,  4, 9, 2024, NULL, 13800,  6.87),
(40014, 9,  4, 9, 2020, NULL,  1240,  0.62),
(40015, 9,  4, 9, 2022, NULL,  1840,  0.92),
(40016, 9,  4, 9, 2024, NULL,  2380,  1.19),
(40017, 14, 4, 9, 2022, NULL,   780,  0.39),
(40018, 14, 4, 9, 2023, NULL,    89,  0.044),
(40019, 6,  4, 9, 2020, NULL,   198,  0.099),
(40020, 6,  4, 9, 2024, NULL,   231,  0.115),
(40021, 11, 4, 9, 2020, NULL,    38,  0.019),
(40022, 11, 4, 9, 2024, NULL,   241,  0.120);

-- ============================================================
-- CASES - Travis County (Austin), 2020-2024
-- ============================================================
INSERT INTO disease_cases VALUES
(50001, 1,  5, 9, 2020, NULL,  1900,  1.47),
(50002, 1,  5, 9, 2021, NULL,  1140,  0.88),
(50003, 1,  5, 9, 2022, NULL, 10800,  8.37),
(50004, 1,  5, 9, 2023, NULL,  9400,  7.28),
(50005, 1,  5, 9, 2024, NULL,  8900,  6.90),
(50006, 2,  5, 9, 2020, NULL, 48200, 37.35),
(50007, 2,  5, 9, 2021, NULL, 69800, 54.10),
(50008, 2,  5, 9, 2022, NULL, 29400, 22.79),
(50009, 2,  5, 9, 2023, NULL, 11200,  8.68),
(50010, 2,  5, 9, 2024, NULL,  5900,  4.57),
(50011, 7,  5, 9, 2020, NULL,  7400,  5.73),
(50012, 7,  5, 9, 2022, NULL,  8900,  6.90),
(50013, 7,  5, 9, 2024, NULL,  9600,  7.44),
(50014, 9,  5, 9, 2020, NULL,   680,  0.53),
(50015, 9,  5, 9, 2022, NULL,  1020,  0.79),
(50016, 9,  5, 9, 2024, NULL,  1490,  1.15),
(50017, 14, 5, 9, 2022, NULL,   920,  0.71),
(50018, 14, 5, 9, 2023, NULL,    98,  0.076),
(50019, 11, 5, 9, 2020, NULL,    31,  0.024),
(50020, 11, 5, 9, 2024, NULL,   298,  0.231);

-- ============================================================
-- CASES - Hidalgo County (McAllen/RGV), 2020-2024
-- Border region - distinct public health patterns
-- ============================================================
INSERT INTO disease_cases VALUES
(70001, 1,  7, 9, 2020, NULL,  1200,  1.19),
(70002, 1,  7, 9, 2022, NULL,  7800,  7.75),
(70003, 1,  7, 9, 2024, NULL,  6200,  6.16),
(70004, 2,  7, 9, 2020, NULL, 38100, 37.84),
(70005, 2,  7, 9, 2021, NULL, 52400, 52.03),
(70006, 2,  7, 9, 2022, NULL, 22100, 21.95),
(70007, 2,  7, 9, 2023, NULL,  8400,  8.34),
(70008, 6,  7, 9, 2020, NULL,   148,  0.147),
(70009, 6,  7, 9, 2024, NULL,   198,  0.197),
(70010, 7,  7, 9, 2020, NULL,  5800,  5.76),
(70011, 7,  7, 9, 2024, NULL,  7100,  7.05),
(70012, 9,  7, 9, 2020, NULL,   580,  0.58),
(70013, 9,  7, 9, 2024, NULL,  1240,  1.23);

-- ============================================================
-- DEMOGRAPHIC ANALYSIS - Harris County
-- Cases by age group for vulnerability analysis
-- ============================================================

-- Influenza 2024 by age group (Harris County)
INSERT INTO disease_cases VALUES
(80001, 1, 1, 1, 2024, NULL, 3210, 0.68),
(80002, 1, 1, 2, 2024, NULL, 4890, 1.03),
(80003, 1, 1, 3, 2024, NULL, 1980, 0.42),
(80004, 1, 1, 4, 2024, NULL, 7140, 1.51),
(80005, 1, 1, 5, 2024, NULL, 6820, 1.44),
(80006, 1, 1, 6, 2024, NULL, 2760, 0.58);

-- Influenza 2020 by age group (to compare pandemic vs today)
INSERT INTO disease_cases VALUES
(81001, 1, 1, 1, 2020, NULL,  480, 0.10),
(81002, 1, 1, 2, 2020, NULL,  620, 0.13),
(81003, 1, 1, 3, 2020, NULL,  310, 0.07),
(81004, 1, 1, 4, 2020, NULL,  980, 0.21),
(81005, 1, 1, 5, 2020, NULL,  890, 0.19),
(81006, 1, 1, 6, 2020, NULL,  930, 0.20);

-- Syphilis 2024 by age group (Harris County)
INSERT INTO disease_cases VALUES
(82001, 9, 1, 3, 2024, NULL,  960, 0.20),
(82002, 9, 1, 4, 2024, NULL, 2080, 0.44),
(82003, 9, 1, 5, 2024, NULL,  720, 0.15),
(82004, 9, 1, 7, 2024, NULL, 2380, 0.50),
(82005, 9, 1, 8, 2024, NULL, 1720, 0.36);

-- Syphilis 2020 by age group (to show growth of the problem)
INSERT INTO disease_cases VALUES
(83001, 9, 1, 3, 2020, NULL,  420, 0.09),
(83002, 9, 1, 4, 2020, NULL,  980, 0.21),
(83003, 9, 1, 5, 2020, NULL,  380, 0.08),
(83004, 9, 1, 7, 2020, NULL, 1140, 0.24),
(83005, 9, 1, 8, 2020, NULL,  870, 0.18);

-- Pertussis 2024 by age group - classic pattern: infants and teens
INSERT INTO disease_cases VALUES
(84001, 11, 1, 1, 2024, NULL, 168, 0.036),
(84002, 11, 1, 2, 2024, NULL, 201, 0.043),
(84003, 11, 1, 3, 2024, NULL,  42, 0.009),
(84004, 11, 1, 4, 2024, NULL,  48, 0.010),
(84005, 11, 1, 5, 2024, NULL,  18, 0.004),
(84006, 11, 1, 6, 2024, NULL,  10, 0.002);

-- COVID-19 2021 by age group (Harris County) - shows impact on older adults
INSERT INTO disease_cases VALUES
(85001, 2, 1, 1, 2021, NULL,  4200, 0.89),
(85002, 2, 1, 2, 2021, NULL,  8900, 1.88),
(85003, 2, 1, 3, 2021, NULL, 14200, 3.00),
(85004, 2, 1, 4, 2021, NULL, 52800, 11.16),
(85005, 2, 1, 5, 2021, NULL, 68400, 14.46),
(85006, 2, 1, 6, 2021, NULL, 49800, 10.53);
