-- 1. Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
-- Hint : Use NATURAL JOIN.

SELECT c.*,
       l.*
FROM countries AS c
JOIN locations AS l ON l.country_id = c.country_id;

-- 2. Write a query to make a join with employees and departments table to find the name of the employee,
-- including first_name and last name, department ID and name of departments.

SELECT e.first_name,
       e.last_name,
       d.department_id,
       d.department_name
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id;

-- 3. Write a SQL query to make a join with three tables employees, departments and locations to find the name,
-- including first_name and last_name, jobs, department name and ID, of the employees working in London.

SELECT e.first_name,
       e.last_name,
       e.job_id,
       d.department_id,
       d.department_name,
       l.city
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
JOIN locations AS l ON l.location_id = d.location_id
WHERE l.city = 'London';

-- 4. Write a query to make a join with two tables employees and itself to find the employee id,
-- last_name as Employee along with their manager_id and last name as Manager.

SELECT e.last_name,
       e.employee_id,
       em.employee_id,
       em.last_name
FROM employees AS e
JOIN employees AS em ON em.manager_id = e.employee_id;

-- 5. Write a query to make a join with a table employees and itself to find the name,
-- including first_name and last_name and hire date for those employees who were hired after the employee Jones.

SELECT e.first_name,
       e.last_name,
       e.hire_date
FROM employees AS e
WHERE e.hire_date >
        (SELECT e.hire_date
         FROM employees AS e
         WHERE e.last_name = 'Jones');

-- 6. Write a query to make a join with two tables employees
-- and departments to get the department name and number of employees working in each department.

SELECT d.department_name,
       COUNT(*)
FROM employees AS e
JOIN departments AS d ON e.department_id = d.department_id
GROUP BY 1
ORDER BY 1;

-- 7. Write a query to make a join to find the employee ID, job title and number of days an employee worked,
-- for all the employees who worked in a department which ID is 90.

SELECT employee_id,
       job_title,
       end_date-start_date Days
FROM job_history
NATURAL JOIN jobs
WHERE department_id = 90;

-- 8. Write a query to make a join with two tables employees and departments to display the department ID,
 -- department name and the first name of the manager.

SELECT d.department_id,
       d.department_name,
       e.manager_id,
       e.first_name
FROM departments AS d
JOIN employees AS e ON d.manager_id = e.employee_id;

-- 9. Write a query to make a join with three tables departments, employees, and locations
-- to display the department name, manager name, and city.

SELECT e.first_name,
       d.department_name,
       l.city
FROM departments AS d
JOIN employees AS e ON d.manager_id = e.employee_id
JOIN locations AS l ON l.location_id = d.location_id;

-- 10. Write a query to make a join with two tables employees and jobs
-- to display the job title and average salary of employees.

SELECT e.job_id,
       ROUND(AVG(e.salary), 2)
FROM employees AS e
GROUP BY 1;

-- 11. Write a query to make a join with two tables employees and
-- jobs to display the job title, employee name, and the difference between salary and the minimum salary of the employees.

SELECT e.job_id,
       e.first_name,
       e.salary,
       e.salary -
    (SELECT MIN(salary)
     FROM employees)
FROM employees AS e
GROUP BY 1,
         2,
         3;

-- 12. Write a query to make a join with two tables job_history and employees
-- to display the status of employees who is currently drawing the salary above 10000.

SELECT j.*
FROM employees AS e
JOIN Job_history AS j ON e.employee_id = j.employee_id
WHERE e.salary > 10000;

-- 13. Write a query to make a join with two tables employees and departments
-- to display department name, first_name and last_name, hire date and salary for all the managers
-- who achieved a working experience is more than 15 years.

SELECT d.department_name,
       e.first_name,
       e.last_name,
       e.hire_date,
       e.salary,
       date_part('year', age(now(), e.hire_date)) AS Experience
FROM departments AS d
JOIN employees AS e ON (d.manager_id = e.employee_id)
WHERE date_part('year',age(now(), e.hire_date)) > 15;