-- 1. Write a query to find the number of jobs available in the employees table.

SELECT COUNT(DISTINCT e.job_id)
FROM employees AS e;

-- 2.Write a query to get the total salaries payable to employees.

SELECT SUM(e.salary)
FROM employees AS e;

-- 3. Write a query to get the minimum salary from employees table.

SELECT MIN(e.salary)
FROM employees AS e;

-- 4. Write a query to get the maximum salary of an employee working as a Programmer.

SELECT MAX(e.salary)
FROM employees AS e
WHERE e.job_id LIKE 'IT_PROG';

-- 5. Write a query to get the average salary and number of employees working in the department which ID is 90.

SELECT AVG(e.salary) AS avg_salary,
       COUNT(e.job_id) AS jobs_count
FROM employees AS e
WHERE e.department_id = 90;

-- 6. Write a query to get the highest, lowest, total, and average salary of all employees.

SELECT ROUND(AVG(e.salary), 2) AS avg_salary,
       ROUND(MAX(e.salary), 2) AS max_salary,
       ROUND(MIN(e.salary), 2) AS min_salary,
       ROUND(SUM(e.salary), 2) AS total_salary
FROM employees AS e;

-- 7. Write a query to get the number of employees working in each post.

SELECT COUNT(e.job_id),
       e.job_id
FROM employees AS e
GROUP BY 2;

-- 8. Write a query to get the difference between the highest and lowest salaries.

SELECT MAX(e.salary) - MIN(e.salary) AS difference
FROM employees AS e;

-- 9. Write a query to find the manager ID and the salary of the lowest-paid employee under that manager.

SELECT e.salary
FROM employees AS e;

-- 10. Write a query to get the department ID and the total salary payable in each department.

SELECT e.manager_id,
       MIN(e.salary)
FROM employees AS e
GROUP BY 1
ORDER BY 2;

-- 11. Write a query to get the average salary for each post excluding programmer.

SELECT ROUND(AVG(e.salary), 2) AS avg_salary,
       e.job_id
FROM employees AS e
WHERE e.job_ID NOT LIKE 'IT_PROG'
GROUP BY 2;

-- OR --

SELECT e.job_id,
       ROUND(AVG(e.salary), 2) AS avg_salary
FROM employees AS e
WHERE e.job_ID <> 'IT_PROG'
GROUP BY e.job_id;

-- 12. Write a query to get the total salary, maximum, minimum and average salary of all posts for those departments which ID 90.

SELECT ROUND(AVG(e.salary), 2) AS avg_salary,
       ROUND(MAX(e.salary), 2) AS max_salary,
       ROUND(MIN(e.salary), 2) AS min_salary,
       ROUND(SUM(e.salary), 2) AS total_salary,
       e.job_id,
       e.department_id
FROM employees AS e
WHERE e.department_id = 90
GROUP BY 5,
         6;

-- 13. Write a query to get the job ID and maximum salary of each post for maximum salary is at or above $4000.

SELECT e.job_id,
       Max(e.salary)
FROM employees AS e
GROUP BY 1
HAVING Max(e.salary) >= 4000;

-- 14. Write a query to get the average salary for all departments working more than 10 employees.

SELECT e.department_id,
       AVG(e.salary),
       COUNT(e.department_id)
FROM employees AS e
GROUP BY 1
HAVING COUNT(e.department_id) > 10;