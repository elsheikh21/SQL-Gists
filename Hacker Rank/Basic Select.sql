-- 1. Query all columns for all American cities in CITY with populations larger than 100000. The CountryCode for America is USA.

SELECT CITY.*
FROM CITY
WHERE CITY.population > 100000
    AND CITY.countrycode = 'USA';

-- 2. Query the names of all American cities in CITY with populations larger than 120000. The CountryCode for America is USA.

SELECT CITY.name
FROM CITY
WHERE CITY.population > 120000
    AND CITY.countrycode = 'USA';

-- 3. Query all columns (attributes) for every row in the CITY table.

SELECT city.*
FROM city;

-- 4. Query all columns for a city in CITY with the ID 1661.

SELECT city.*
FROM city
WHERE city.id = 1661;

-- 5. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT *
FROM city
WHERE city.countrycode = 'JPN';

-- 6. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT city.name
FROM city
WHERE city.countrycode = 'JPN';

-- 7. Query a list of CITY and STATE from the STATION table.

SELECT city,
       state
FROM STATION;

-- 8. Query a list of CITY names from STATION with even ID numbers only.
-- You may print the results in any order, but must exclude duplicates from your answer.

SELECT DISTINCT city
FROM station
WHERE MOD (id,
           2) = 0;

-- 9. Let N be the number of CITY entries in STATION, and let N' be the number of distinct CITY names in STATION;
 -- query the value of N - N' from STATION. In other words,
 -- find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
 WITH t1 AS
    (SELECT COUNT(city) AS cnt
     FROM station),
      t2 AS
    (SELECT COUNT(DISTINCT city) AS cntd
     FROM station)
SELECT t1.cnt - t2.cntd
FROM t1,
     t2;

-- 10. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths
-- (i.e.: number of characters in the name). If there is more than one smallest or largest city,
 -- choose the one that comes first when ordered alphabetically.

SELECT STATION.CITY,
       LENGTH(STATION.CITY)
FROM STATION
WHERE LENGTH(STATION.CITY) =
        (SELECT MIN(t1.len)
         FROM
             (SELECT LENGTH(station.city) AS len
              FROM station) t1)
ORDER BY 1
LIMIT 1;


SELECT STATION.CITY,
       LENGTH(STATION.CITY)
FROM STATION
WHERE LENGTH(STATION.CITY) =
        (SELECT MAX(t1.len)
         FROM
             (SELECT LENGTH(station.city) AS len
              FROM station) t1)
ORDER BY 1
LIMIT 1;

-- Oracle SQL

SELECT *
FROM
    (SELECT STATION.CITY,
            LENGTH(STATION.CITY)
     FROM STATION
     WHERE LENGTH(STATION.CITY) =
             (SELECT MIN(t1.len)
              FROM
                  (SELECT LENGTH(station.city) AS len
                   FROM station) t1)
     ORDER BY 1)
WHERE ROWNUM = 1;


SELECT *
FROM
    (SELECT STATION.CITY,
            LENGTH(STATION.CITY)
     FROM STATION
     WHERE LENGTH(STATION.CITY) =
             (SELECT MAX(t1.len)
              FROM
                  (SELECT LENGTH(station.city) AS len
                   FROM station) t1)
     ORDER BY 1)
WHERE ROWNUM = 1;

-- 11. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION.
-- Your result cannot contain duplicates.

SELECT DISTINCT station.city
FROM station
WHERE LEFT(station.city, 1) IN ('a',
                                'e',
                                'i',
                                'o',
                                'u');

-- Oracle SQL

SELECT DISTINCT city
FROM station
WHERE LOWER(SUBSTR(city, 1, 1)) IN ('a',
                                    'e',
                                    'i',
                                    'o',
                                    'u');

-- 12. Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

SELECT DISTINCT city
FROM station
WHERE substr(city, length(city), length(city)) IN ('a',
                                                   'e',
                                                   'i',
                                                   'o',
                                                   'u');

-- 13. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
-- Your result cannot contain duplicates.

SELECT DISTINCT city
FROM station
WHERE LOWER(SUBSTR(city, 1, 1)) IN ('a',
                                    'e',
                                    'i',
                                    'o',
                                    'u')
    AND substr(city, length(city), length(city)) IN ('a',
                                                     'e',
                                                     'i',
                                                     'o',
                                                     'u');

-- 14. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

SELECT DISTINCT city
FROM station
WHERE LOWER(SUBSTR(city, 1, 1)) NOT IN ('a',
                                        'e',
                                        'i',
                                        'o',
                                        'u');

-- 15. Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

SELECT DISTINCT city
FROM station
WHERE substr(city, length(city), length(city)) NOT IN ('a',
                                                       'e',
                                                       'i',
                                                       'o',
                                                       'u');

-- 16. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels.
 -- Your result cannot contain duplicates.

SELECT DISTINCT city
FROM station
WHERE LOWER(SUBSTR(city, 1, 1)) NOT IN ('a',
                                        'e',
                                        'i',
                                        'o',
                                        'u')
    OR substr(city, length(city), length(city)) NOT IN ('a',
                                                        'e',
                                                        'i',
                                                        'o',
                                                        'u');

-- 17.Query the list of CITY names from STATION that do not start with vowels and do not end with vowels.
-- Your result cannot contain duplicates.

SELECT DISTINCT city
FROM station
WHERE LOWER(SUBSTR(city, 1, 1)) NOT IN ('a',
                                        'e',
                                        'i',
                                        'o',
                                        'u')
    AND substr(city, length(city), length(city)) NOT IN ('a',
                                                         'e',
                                                         'i',
                                                         'o',
                                                         'u');

-- 18. Query the Name of any student in STUDENTS who scored higher than 75 Marks.
-- Order your output by the last three characters of each name.
-- If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.),
-- secondary sort them by ascending ID.

SELECT name
FROM students
WHERE marks > 75
ORDER BY substr(Name, -3),
         ID;

-- 19. Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name
FROM employee
ORDER BY 1;

-- 20. Write a query that prints a list of employee names (i.e.: the name attribute) for employees
-- in Employee having a salary greater than 2000 per month who have been employees for less than 10 months.
-- Sort your result by ascending employee_id.

SELECT name
FROM employee
WHERE months < 10
    AND salary > 2000
ORDER BY employee_id;