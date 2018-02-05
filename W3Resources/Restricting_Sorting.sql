-- 1. Write a query to display the name, including first_name and last_name and
-- salary for all employees whose salary is out of the range between $10,000 and $15,000.

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary BETWEEN 10000 AND 15000;

-- 2. Write a query to display the name, including first_name and last_name,
-- and department ID who works in the department 30 or 100 and arrange the result in ascending order according to the department ID.

SELECT e.first_name,
       e.last_name,
       e.department_id
FROM employees AS e
WHERE e.department_id BETWEEN 30 AND 100
ORDER BY e.department_id;

-- 3. Write a query to display the name, including first_name and last_name,
-- and salary who works in the department either 30 or 100 and salary is out of the range between $10,000 and $15,000.

SELECT e.first_name,
       e.last_name,
       e.salary,
       e.department_id
FROM employees AS e
WHERE (e.salary NOT BETWEEN 10000 AND 15000
       AND e.department_id = 30
       OR e.department_id = 100);

-- BETTER --

SELECT first_name,
       last_name,
       salary,
       department_id
FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000
    AND department_id IN (30,
                          100);

-- 4. Write a query to display the name, including first_name and last_name and hire date for all employees who were hired in 1987.

SELECT e.first_name,
       e.last_name,
       e.hire_date
FROM employees AS e
WHERE DATE_PART('year', e.hire_date) = 1987;

-- 5. Write a query to get the first name of the employee who holds the letter 'c' and 'e' in the first name.

SELECT e.first_name
FROM employees AS e
WHERE e.first_name LIKE '%c%'
    AND e.first_name LIKE '%e%';

-- 6. Write a query to display the last name, job, and salary
-- for all those employees who hasn't worked as a Programmer or a Shipping Clerk,
-- and not drawing the salary $4,500, $10,000, or $15,000.
 
SELECT e.last_name, 
       e.job_id, 
       e.salary
FROM employees AS e 
WHERE e.job_id NOT IN ('IT_PROG', 
                       'SH_CLERK')
    OR e.salary NOT IN (4500,
                        10000,
                        15000);

-- 7. Write a query to display the last names of employees whose name contain exactly six characters.

SELECT e.last_name
FROM employees AS e
WHERE LENGTH(e.last_name) = 6;

-- OR --

SELECT last_name
FROM employees
WHERE last_name LIKE '______';

-- 8. Write a query to display the last name of employees having 'e' as the third character.

SELECT e.last_name
FROM employees AS e
WHERE e.last_name LIKE '__e%';

-- 9. Write a query to display the jobs/designations available in the employees table.

SELECT DISTINCT e.job_id
FROM employees AS e;

-- 10. Write a query to display the name, including first_name, last_name, salary and 15% of salary as PF of all employees.

SELECT e.first_name,
       e.last_name,
       e.salary,
       e.salary * 0.15 AS "PF"
FROM employees AS e;

-- 11. Write a query to select all information of employees whose last name is either 'BLAKE' or 'SCOTT' or 'KING' or 'FORD'.

SELECT e.*   
FROM e.employees   
WHERE e.last_name IN('Jones', 'Blake', 'Scott', 'King', 'Ford'); 