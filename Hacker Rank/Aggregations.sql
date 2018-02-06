-- 1. Query a count of the number of cities in CITY having a Population larger than 100,000.

SELECT COUNT(c.*)
FROM CITY AS c
WHERE c.population > 100000;

-- 2. Query the total population of all cities in CITY where District is California.

SELECT SUM(population)
FROM CITY
WHERE district = 'California';

-- 3. Query the average population of all cities in CITY where District is California.

SELECT AVG(population)
FROM CITY
WHERE district = 'California';

-- 4. Query the average population for all cities in CITY, rounded down to the nearest integer.

SELECT ROUND(AVG(population), 1)
FROM CITY;

-- 5. Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

SELECT SUM(population)
FROM CITY
WHERE countrycode = 'JPN';

-- 6. Query the difference between the maximum and minimum populations in CITY.

SELECT MAX(population) - MIN(population)
FROM CITY;

-- 7. The Blunder

SELECT CEIL(AVG(Salary) - AVG(REPLACE(Salary, '0', '')))
FROM EMPLOYEES;

-- 8. Top Earners

SELECT t2.earning,
       COUNT(*)
FROM
    (SELECT name,
            salary * months AS earning
     FROM employee
     WHERE (salary * months) =
             (SELECT MAX(t1.earning)
              FROM
                  (SELECT salary * months AS earning
                   FROM employee) AS t1)) AS t2
GROUP BY t2.earning;

-- 9. Weather Observation Station 2
 -- Query the following two values from the STATION table:
-- The sum of all values in LAT_N rounded to a scale of 2 decimal places.
-- The sum of all values in LONG_W rounded to a scale of 2 decimal places.

SELECT ROUND(SUM(LAT_N), 2) AS lat,
       ROUND(SUM(LONG_W), 2) AS lon
FROM STATION;

-- 10. Weather Observation Station 13
-- Query the sum of Northern Latitudes (LAT_N) from STATION having values greater than 38.7880 and less than 137.2345.
 -- Truncate your answer to  decimal places.

SELECT ROUND(SUM(t1.lat_n), 4)
FROM
    (SELECT lat_n
     FROM station
     WHERE lat_n > 38.7880
         AND lat_n < 137.2345) AS t1;

-- 11. Weather Observation Station 14
-- Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137.2345.
-- Truncate your answer to 4 decimal places.

SELECT ROUND(MAX(t1.lat_n), 4)
FROM
    (SELECT lat_n
     FROM station
     WHERE lat_n < 137.2345) AS t1;

-- 12. Weather Observation Station 15
-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345.
 -- Round your answer to 4 decimal places.

SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n =
        (SELECT MAX(t1.lat_n)
         FROM
             (SELECT lat_n
              FROM station
              WHERE lat_n < 137.2345) AS t1);

-- 13. Weather Observation Station 16
-- Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7880.
-- Round your answer to 4 decimal places.

SELECT ROUND(MIN(t1.lat_n), 4)
FROM
    (SELECT lat_n
     FROM station
     WHERE lat_n > 38.7880) t1;

-- 14. Weather Observation Station 17
-- Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7880.
 -- Round your answer to  decimal places.

SELECT ROUND(long_w, 4)
FROM station
WHERE lat_n =
        (SELECT MIN(t1.lat_n)
         FROM
             (SELECT lat_n
              FROM station
              WHERE lat_n > 38.7880) t1);

-- 15. Weather Observation Station 18
-- Query the Manhattan Distance between points P1(a, b) and P2(c, d) and round it to a scale of 4 decimal places
-- Manhattan Distance is |a - c| + |b - d|

SELECT ROUND(ABS(MIN(lat_n) - MAX(lat_n)) + ABS(MIN(long_w) - MAX(long_w)), 4)
FROM station;

-- 16. Weather Observation Station 19
-- Query the Euclidean Distance between points P1(a, b) and P2(c, d) and round it to a scale of 4 decimal places
-- Euclidean Distance is (((a - c) ^ 2) + ((b - d) ^ 2)) ^ 0.5

SELECT ROUND(SQRT(POWER(MIN(lat_n) - MAX(lat_n), 2) + POWER(MIN(long_w) - MAX(long_w), 2)), 4)
FROM station;

-- 17. Weather Observation Station 20
-- A median is defined as a number separating the higher half of a data set from the lower half.
-- Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.

SELECT ROUND(MEDIAN(LAT_N), 4)
FROM STATION;

-- without using the oracle expressions

SELECT ROUND(MAX(lat_n), 4)
FROM
    (SELECT lat_n,
             ntile(2) OVER (ORDER BY lat_n) AS bucket
     FROM station) AS t
WHERE bucket = 1
GROUP BY bucket;