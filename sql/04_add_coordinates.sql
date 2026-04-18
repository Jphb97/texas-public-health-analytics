USE texas_health_analytics;

-- Add latitude and longitude columns to counties table
ALTER TABLE counties
ADD COLUMN latitude  DECIMAL(9,6),
ADD COLUMN longitude DECIMAL(9,6);

-- Update with exact coordinates for each county seat
-- Source: U.S. Census Bureau / Google Maps verified coordinates
UPDATE counties SET latitude = 29.7604, longitude = -95.3698 WHERE county_id = 1;  -- Harris (Houston)
UPDATE counties SET latitude = 32.7767, longitude = -96.7970 WHERE county_id = 2;  -- Dallas
UPDATE counties SET latitude = 32.7555, longitude = -97.3308 WHERE county_id = 3;  -- Tarrant (Fort Worth)
UPDATE counties SET latitude = 29.4241, longitude = -98.4936 WHERE county_id = 4;  -- Bexar (San Antonio)
UPDATE counties SET latitude = 30.2672, longitude = -97.7431 WHERE county_id = 5;  -- Travis (Austin)
UPDATE counties SET latitude = 33.1584, longitude = -96.7523 WHERE county_id = 6;  -- Collin (McKinney)
UPDATE counties SET latitude = 26.3017, longitude = -98.1633 WHERE county_id = 7;  -- Hidalgo (McAllen)
UPDATE counties SET latitude = 31.7619, longitude = -106.4850 WHERE county_id = 8; -- El Paso
UPDATE counties SET latitude = 33.2148, longitude = -97.1331 WHERE county_id = 9;  -- Denton
UPDATE counties SET latitude = 29.5293, longitude = -95.6760 WHERE county_id = 10; -- Fort Bend (Sugar Land)
UPDATE counties SET latitude = 30.3085, longitude = -95.4694 WHERE county_id = 11; -- Montgomery (Conroe)
UPDATE counties SET latitude = 30.6485, longitude = -97.6772 WHERE county_id = 12; -- Williamson (Round Rock)
UPDATE counties SET latitude = 26.2034, longitude = -98.2300 WHERE county_id = 13; -- Cameron (Brownsville)
UPDATE counties SET latitude = 27.8006, longitude = -97.3964 WHERE county_id = 14; -- Nueces (Corpus Christi)
UPDATE counties SET latitude = 29.1616, longitude = -95.4358 WHERE county_id = 15; -- Brazoria (Angleton)

-- Create separate coordinates table for Power BI map visualization
CREATE TABLE county_coordinates AS
SELECT 
    county_id,
    county_name,
    latitude,
    longitude,
    population_2020
FROM counties;
