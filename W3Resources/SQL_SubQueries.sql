-- 1. Write a query to find the first_name, last_name and salaries of the employees
-- who have a higher salary than the employee whose last_name is Bull.

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary >
        (SELECT e.salary AS salary
         FROM employees AS e
         WHERE e.last_name = 'Bull');

-- 2. Write a SQL subquery to find the first_name and last_name of all employees who works in the IT department.

SELECT tbl1.first_name,
       tbl1.last_name
FROM
    (SELECT *
     FROM employees AS e
     WHERE e.job_id = 'IT_PROG') AS tbl1;

--3. Write a SQL subquery to find the first_name and last_name of the employees
-- under a manager who works for a department based in the United States.

SELECT e.first_name,
       e.last_name
FROM employees AS e
WHERE e.manager_id IN
        (SELECT e.employee_id
         FROM employees AS e
         WHERE e.department_id IN
                 (SELECT d.department_id
                  FROM departments AS d
                  WHERE d.location_id IN
                          (SELECT l.location_id
                           FROM locations AS l
                           WHERE l.country_id = 'US')));

-- 4. Write a SQL subquery to find the first_name and last_name of the employees who are working as a manager.

SELECT e.first_name,
       e.last_name
FROM employees AS e
WHERE e.employee_id IN
        (SELECT e.manager_id
         FROM employees AS e);

-- 5. Write a SQL subquery to find the first_name, last_name and salary, which is greater than the average salary of the employees.

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary >
        (SELECT ROUND(AVG(e.salary), 2)
         FROM employees AS e);

-- 6. Write a SQL subquery to find the first_name, last_name and salary, which is equal to the minimum salary for this post, he/she is working on.
 -- The solution was

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary =
        (SELECT j.min_salary
         FROM jobs AS j
         WHERE j.job_id = e.job_id);

-- 7. Write a SQL Subquery to find the first_name, last_name and salary of the employees
-- who earn more than the average salary and works in any of the IT departments.

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE (e.salary >
           (SELECT AVG(e.salary)
            FROM employees AS e))
    AND (e.department_id IN
             (SELECT department_id
              FROM departments
              WHERE department_name LIKE '%IT%'));

-- 8. Write a SQL subquery to find the first_name, last_name and salary of the employees
-- who draw a more salary than the employee, which the last name is Bell.

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary >
        (SELECT e.salary
         FROM employees AS e
         WHERE e.last_name = 'Bell');

-- 9. Write a SQL subquery to find all the information of the employees
-- who draws the same salary as the minimum salary for all departments.

SELECT e.*
FROM employees AS e
WHERE e.salary =
        (SELECT MIN(employees.salary)
         FROM employees);

-- 10. Write a SQL subquery to find all the information of the employees
-- whose salary greater than the average salary of all departments.

SELECT e.*
FROM employees AS e
WHERE e.salary >
        (SELECT AVG(employees.salary)
         FROM employees);

-- The solution was

SELECT e.*
FROM employees AS e
WHERE e.salary > ALL
        (SELECT avg(employees.salary)
         FROM employees
         GROUP BY employees.department_id);

-- 11. Write a subquery to find the first_name, last_name, job_id and salary of the employees
-- who draws a salary that is higher than the salary of all the Shipping Clerk (JOB_ID = 'SH_CLERK').
-- Sort the results on salary from the lowest to highest.

SELECT e.first_name,
       e.last_name,
       e.job_id,
       e.salary
FROM employees AS e
WHERE e.salary >
        (SELECT SUM(e.salary)
         FROM employees AS e
         WHERE e.job_id = 'SH_CLERK')
ORDER BY e.salary;

-- the solution was

SELECT first_name,
       last_name,
       job_id,
       salary
FROM employees
WHERE salary > ALL
        (SELECT salary
         FROM employees
         WHERE job_id = 'SH_CLERK')
ORDER BY salary;

-- 12. Write a query to find the names (first_name, last_name) of the employees who are not supervisors.

SELECT e.first_name,
       e.last_name
FROM employees AS e
WHERE e.job_id NOT LIKE 'SPRV';

-- the solution was

SELECT b.first_name,
       b.last_name
FROM employees b
WHERE NOT EXISTS
        (SELECT 'X'
         FROM employees a
         WHERE a.manager_id = b.employee_id);

-- 13. Write a SQL subquery to find the employee ID, first name, last name and department names of all employees.

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       d.department_name
FROM employees AS e
JOIN departments AS d ON d.department_id = e.department_id;

-- 14. Write a SQL subquery to find the employee ID, first name, last name and salary of all employees
-- whose salary is above the average salary for their departments.

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary > ALL
        (SELECT avg(employees.salary)
         FROM employees
         WHERE employees.department_id = e.department_id);

-- 15. Write a subquery to find the 5th maximum salary of all salaries.

SELECT tbl1.salary
FROM
    (SELECT DISTINCT e.salary
     FROM employees AS e
     ORDER BY 1 DESC
     LIMIT 5) AS tbl1
ORDER BY 1
LIMIT 1;

-- the solution was

SELECT DISTINCT salary
FROM employees e1
WHERE 5 =
        (SELECT COUNT(DISTINCT salary)
         FROM employees e2
         WHERE e1.salary <= e2.salary);

-- 16. Write a subquery to find the 4th minimum salary of all the salaries.

SELECT tbl1.salary
FROM
    (SELECT DISTINCT e.salary
     FROM employees AS e
     ORDER BY 1
     LIMIT 4) AS tbl1
ORDER BY 1 DESC
LIMIT 1;

-- the solution was

SELECT DISTINCT salary
FROM employees e1
WHERE 4 =
        (SELECT COUNT(DISTINCT salary)
         FROM employees e2
         WHERE e1.salary >= e2.salary);

-- 17. Write a subquery to select last 10 records from a table.

SELECT *
FROM
    (SELECT e.*
     FROM employees AS e
     ORDER BY e.employee_id DESC
     LIMIT 10) AS tbl1
ORDER BY tbl1.employee_id;

-- 18. Write a query to list department number, the name for all the departments in which there are no employees in the department.

SELECT d.*
FROM departments AS d
WHERE d.manager_id = 0;

-- OR

SELECT e.*
FROM employees AS e
WHERE e.department_id NOT IN
        (SELECT d.department_id
         FROM departments AS d
         WHERE d.manager_id = 0 );

-- 19. Write a query to get three maximum salaries.

SELECT DISTINCT e.salary
FROM employees AS e
ORDER BY 1 DESC
LIMIT 3;

-- 20. Write a query to get three minimum salaries.

SELECT DISTINCT e.salary
FROM employees AS e
ORDER BY 1 ASC
LIMIT 3;

