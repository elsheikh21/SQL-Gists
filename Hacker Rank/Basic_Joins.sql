-- 1. Asian Population
-- Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

SELECT SUM(city.population)
FROM city
INNER JOIN country ON city.countrycode = country.code
AND country.continent = 'Asia';

-- 2. African Cities
-- Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

SELECT city.name
FROM city
INNER JOIN country ON city.countrycode = country.code
AND country.continent = 'Africa';

-- 3. Average Population of Each Continent
-- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and
-- their respective average city populations (CITY.Population) rounded down to the nearest integer.

SELECT country.continent,
       FLOOR(AVG(city.population))
FROM country
INNER JOIN city ON city.countrycode = country.code
GROUP BY country.continent;

-- 4. The Report
-- the NAMES of those students who received a grade lower than 8.
-- The report must be in descending order by grade
--  If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically
 -- if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order.
 -- If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order

SELECT CASE
           WHEN grade > 7 THEN name
           ELSE NULL
       END,
       grade,
       marks
FROM students
INNER JOIN grades ON marks >= grades.min_mark
AND marks <= grades.max_mark
ORDER BY grade DESC,
         name;

-- 5. Top Competitors
-- Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge.
-- Order your output in descending order by the total number of challenges in which the hacker earned a full score.
-- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
 WITH t1 AS
    (SELECT s.score actual_score,
            c.difficulty_level diff_level,
            s.hacker_id hacker,
            d.score expected_score
     FROM submissions s
     INNER JOIN challenges c ON s.challenge_id = c.challenge_id
     INNER JOIN difficulty d ON d.difficulty_level = c.difficulty_level
     AND s.score = d.score),
      t2 AS
    (SELECT t1.hacker hacker,
            COUNT(*) challenges_count
     FROM t1
     WHERE t1.actual_score = t1.expected_score
     GROUP BY t1.hacker)
SELECT t2.hacker,
       h.name
FROM t2
INNER JOIN hackers h ON h.hacker_id = t2.hacker
WHERE t2.challenges_count > 1
ORDER BY t2.challenges_count DESC,
         t2.hacker;

-- 6. Ollivander's Inventory
-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age.
-- Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power.
-- If more than one wand has same power, sort the result in order of descending age.

SELECT wands.id,
       min_prices.age,
       wands.coins_needed,
       wands.power
FROM wands
INNER JOIN
    (SELECT wands.code,
            wands.power,
            min(wands_property.age) AS age,
            min(wands.coins_needed) AS min_price
     FROM wands
     INNER JOIN wands_property ON wands.code = wands_property.code
     WHERE wands_property.is_evil = 0
     GROUP BY wands.code,
              wands.power) min_prices ON wands.code = min_prices.code
AND wands.power = min_prices.power
AND wands.coins_needed = min_prices.min_price
ORDER BY wands.power DESC,
         min_prices.age DESC;

-- 7. Challenges
-- Write a query to print the hacker_id, name, and the total number of challenges created by each student.
-- Sort your results by the total number of challenges in descending order.
-- If more than one student created the same number of challenges, then sort the result by hacker_id.
-- If more than one student created the same number of challenges and the count is less than the maximum number of challenges created,
-- then exclude those students from the result.

SELECT c.hacker_id,
       h.name,
       count(c.hacker_id) c_count
FROM Hackers h
INNER JOIN Challenges c ON c.hacker_id = h.hacker_id
GROUP BY c.hacker_id,
         h.name
HAVING count(c.hacker_id) =
    (SELECT MAX(temp1.cnt)
     FROM
         (SELECT COUNT(hacker_id) cnt
          FROM Challenges
          GROUP BY hacker_id
          ORDER BY hacker_id) temp1)
OR count(c.hacker_id) IN
    (SELECT t.cnt
     FROM
         (SELECT count(*) cnt
          FROM challenges
          GROUP BY hacker_id) t
     GROUP BY t.cnt
     HAVING count(t.cnt) = 1)
ORDER BY c_count DESC,
         c.hacker_id;

-- 8. Contest Leaderboard
-- The total score of a hacker is the sum of their maximum scores for all of the challenges.
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score.
-- If more than one hacker achieved the same total score,
-- then sort the result by ascending hacker_id.
-- Exclude all hackers with a total score of 0 from your result.

SELECT h.hacker_id,
       name,
       sum(score) total_score
FROM hackers h
INNER JOIN
    (SELECT hacker_id,
            max(score) score
     FROM submissions
     GROUP BY challenge_id,
              hacker_id) max_score ON h.hacker_id=max_score.hacker_id
GROUP BY h.hacker_id,
         name
HAVING sum(score) > 0
ORDER BY total_score DESC,
         h.hacker_id;