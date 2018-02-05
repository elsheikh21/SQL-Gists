-- Retrieve everything from a table

SELECT *
FROM cd.facilities;

-- Retrieve everything from a table

SELECT f.name,
       f.membercost
FROM cd.facilities AS f;

-- Control which rows are retrieved

SELECT *
FROM cd.facilities AS f
WHERE NOT(f.membercost = 0);

-- Control which rows are retrieved - part 2

SELECT f.facid,
       f.name,
       f.membercost,
       f.monthlymaintenance
FROM cd.facilities AS f
WHERE f.membercost > 0
    AND f.membercost < f.monthlymaintenance / 50.0;

-- Basic string searches

SELECT f.*
FROM cd.facilities AS f
WHERE f.name LIKE '%Tennis%';

-- Matching against multiple possible values

SELECT f.*
FROM cd.facilities AS f
WHERE f.facid IN (1,
                  5);

-- Classify results into buckets

SELECT f.name,
       CASE
           WHEN f.monthlymaintenance > 100 THEN 'expensive'
           ELSE 'cheap'
       END AS cost
FROM cd.facilities AS f;

-- Working with dates

SELECT m.memid,
       m.surname,
       m.firstname,
       m.joindate
FROM cd.members AS m
WHERE m.joindate >= '2012-09-01';

-- Removing duplicates, and ordering results

SELECT DISTINCT m.surname
FROM cd.members AS m
ORDER BY 1
LIMIT 10;

-- Combining results from multiple queries

SELECT m.surname
FROM cd.members AS m
UNION
SELECT f.name
FROM cd.facilities AS f;

-- Simple aggregation

SELECT MAX(m.joindate)
FROM cd.members AS m;

-- More aggregation

SELECT m.firstname,
       m.surname,
       m.joindate
FROM cd.members AS m
WHERE m.joindate =
        (SELECT MAX(m.joindate)
         FROM cd.members AS m);