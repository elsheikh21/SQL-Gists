-- 1. Format the names of members

SELECT CONCAT(m.surname,', ', m.firstname) AS name
FROM cd.members AS m;

-- 2. Find facilities by a name prefix

SELECT f.*
FROM cd.facilities AS f
WHERE f.name LIKE 'Tennis%';

-- 3. Perform a case-insensitive search

SELECT f.*
FROM cd.facilities AS f
WHERE UPPER(f.name) LIKE 'TENNIS%';

-- 4. Find telephone numbers with parentheses

SELECT m.memid,
       m.telephone
FROM cd.members AS m
WHERE m.telephone ~ '[()]';

-- 5. Pad zip codes with leading zeroes

SELECT LPAD(TRIM(CAST(m.zipcode AS varchar(6))), 5, '0') AS zip
FROM cd.members AS m
ORDER BY zip;

-- 6. Count the number of members whose surname starts with each letter of the alphabet

SELECT LEFT(m.surname, 1) AS letters,
       COUNT(*)
FROM cd.members AS m
GROUP BY 1
ORDER BY 1;

-- 7. Clean up telephone numbers

SELECT m.memid,
       REPLACE(REPLACE(REPLACE(REPLACE(m.telephone, ' ', ''), '-', ''), '(', ''), ')', '')
FROM cd.members AS m;

-- Better

SELECT m.memid,
       regexp_replace(telephone, '[^0-9]', '', 'g') AS telephone
FROM cd.members AS m;