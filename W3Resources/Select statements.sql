-- 1. Write a query to display the names (first_name, last_name) using an alias name “First Name", "Last Name".
 
SELECT e.first_name AS "First Name", 
       e.last_name AS "Last Name"
FROM employees AS e;

-- 2. Write a query to get a unique department ID from employee table.

SELECT DISTINCT e.department_id
FROM employees AS e;

-- 3. Write a query to get the details of all employees from the employee table in descending order by their first name.

SELECT e.*
FROM employees AS e
ORDER BY e.first_name DESC;

-- 4. Write a query to get the names (first_name, last_name), salary and 15% of salary as PF for all the employees.

SELECT e.first_name AS "First Name",
       e.last_name AS "Last Name",
       e.salary AS "Salary",
       e.salary * 0.15 AS "PF"
FROM employees AS e;

-- 5. Write a query to get the employee ID, names (first_name, last_name) and salary in ascending order according to their salary.

SELECT e.employee_id AS "Employee ID",
       e.first_name AS "First Name",
       e.last_name AS "Last Name",
       e.salary AS "Salary"
FROM employees AS e
ORDER BY e.salary;

-- 6. Write a query to get the total salaries payable to employees.

SELECT SUM(e.salary) AS total_salaries
FROM employees AS e;

-- 7. Write a query to get the maximum and minimum salary paid to the employees.

SELECT MIN(e.salary) AS minimum,
       MAX(e.salary) AS maximum
FROM employees AS e;

-- 8. Write a query to get the average salary and number of employees are working.

SELECT AVG(e.salary) AS average,
       COUNT(e.employee_id) AS COUNT
FROM employees AS e;

-- 9. Write a query to get the number of employees working with the company.

SELECT COUNT(e.employee_id) AS COUNT
FROM employees AS e;

-- 10. Write a query to get the unique number of designations available in the employees table.

SELECT COUNT(DISTINCT e.job_id)
FROM employees AS e;

-- 11. Write a query to get all the first name from the employees table in upper case.

SELECT UPPER(e.first_name) AS first_name
FROM employees AS e;

-- 12. Write a query to get the first three characters of the first name for all the employees in the employees table.

SELECT LEFT(e.first_name, 3)
FROM employees AS e;

-- OR --

SELECT SUBSTRING(first_name,1,3)
FROM employees;

-- 13. Write a query to calculate the expression 171*214+625.

SELECT 171*214+625;

-- This will print out the statement for each row in employees table

SELECT 171 * 214 + 625
FROM employees;

-- 14. Write a query to get the name, including first name and last name of all the employees from employees table.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM employees AS e;

-- 16. Write a query to get the first name, last name and the length of the name,
-- including first_name and last_name of all the employees from employees table.

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name,
       LENGTH(CONCAT(e.first_name, ' ', e.last_name))AS name_length
FROM employees AS e;

-- OR --

SELECT LENGTH(e.first_name),
       LENGTH(e.last_name)
FROM employees AS e;

-- 17. Write a query to check whether the first_name column of the employees table containing any number.

SELECT e.first_name
FROM employees AS e
WHERE e.first_name NOT LIKE '%[0-9]%';

-- 18. Write a query to select first ten records from a table.

SELECT e.*
FROM employees AS e
LIMIT 10;

-- 19. Write a query to get a monthly salary (rounded up to 2 decimal places) of each employee.

SELECT e.first_name,
       e.last_name,
       ROUND(e.salary / 12, 2) AS monthly_salary
FROM employees AS e;