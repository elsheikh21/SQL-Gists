-- 1. Write a query identifying the type of each record in the TRIANGLES table using its three side lengths.
-- Output one of the following statements for each record in the table:
-- Equilateral, Isosceles, Scalene, Not A Triangle

SELECT CASE
           WHEN ((a + b <= c)
                 OR (a + c <= b)
                 OR (b + c <= a)) THEN 'Not A Triangle'
           WHEN (a = b
                 AND b = c
                 AND a = c) THEN 'Equilateral'
           WHEN (a != b
                 AND a != c
                 AND b != c) THEN 'Scalene'
           WHEN (((a = b)
                  OR (a = c))
                 AND ((a != c)
                      OR (b != c))) THEN 'Isosceles'
       END
FROM TRIANGLES;

-- 2[a]. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical
-- (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).

SELECT name || '(' || SUBSTR(occupation, 1, 1) || ')'
FROM OCCUPATIONS
ORDER BY name;

-- 2[b]. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order,
-- and output them in the following format: "There are a total of [occupation_count] [occupation]s."

SELECT 'There are a total of ' || CAST(count(occupation) AS VARCHAR(5)) || ' ' || LOWER(occupation) || 's.'
FROM OCCUPATIONS
GROUP BY occupation
ORDER BY count(occupation),
         occupation;

-- 3.Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation.
 -- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
 -- {{{{{
 --  		MSSQL >>>> Solution was copied
 -- }}}}}

SET @r1=0,
    @r2=0,
    @r3=0,
    @r4=0;


SELECT min(Doctor),
       min(Professor),
       min(Singer),
       min(Actor)
FROM
    (SELECT CASE
                WHEN Occupation='Doctor' THEN (@r1:=@r1+1)
                WHEN Occupation='Professor' THEN (@r2:=@r2+1)
                WHEN Occupation='Singer' THEN (@r3:=@r3+1)
                WHEN Occupation='Actor' THEN (@r4:=@r4+1)
            END AS RowNumber,
            CASE
                WHEN Occupation='Doctor' THEN Name
            END AS Doctor,
            CASE
                WHEN Occupation='Professor' THEN Name
            END AS Professor,
            CASE
                WHEN Occupation='Singer' THEN Name
            END AS Singer,
            CASE
                WHEN Occupation='Actor' THEN Name
            END AS Actor
     FROM OCCUPATIONS
     ORDER BY Name) TEMP
GROUP BY RowNumber;

-- 4. You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree,
 -- and P is the parent of N.

SELECT N,
       CASE
           WHEN P IS NULL THEN 'Root'
           WHEN N IN
                    (SELECT P
                     FROM BST) THEN 'Inner'
           ELSE 'Leaf'
       END
FROM BST
ORDER BY N;

-- 5.

SELECT employee.company_code,
       company.founder,
       COUNT(DISTINCT employee.lead_manager_code),
       COUNT(DISTINCT employee.senior_manager_code),
       COUNT(DISTINCT employee.manager_code),
       COUNT(DISTINCT employee.employee_code)
FROM employee employee
INNER JOIN company company ON employee.company_code = company.company_code
GROUP BY employee.company_code,
         company.founder
ORDER BY employee.company_code;

