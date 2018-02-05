-- 1. Write a query to get the job_id and the ID(s) for those employees who is working in that post.

SELECT e.job_id,
       ARRAY_AGG(e.department_id)
FROM employees AS e
GROUP BY 1;

-- 2. Write a query to update the phone_number column with '999' where the substring '124' found in that column.

UPDATE employees
SET phone_number = REPLACE(phone_number, '124', '999')
WHERE phone_number LIKE '%124%' -- 3. Write a query to find the details of those employees who contain eight or more characters in their first name.

    SELECT e.first_name,
           e.last_name
    FROM employees AS e WHERE LENGTH(e.first_name) >= 8;

-- 4. Write a query to fill the maximum and minimum salary with leading asterisks
 -- whether these two columns does not contain a seven digit number.

SELECT j.job_id,
       LPAD(trim(to_char(j.min_salary, '9999999')), 7, '*'),
       LPAD(trim(to_char(j.max_salary, '9999999')), 7, '*')
FROM jobs AS j -- 5. Write a query to join the text '@example.com' with the email column.

UPDATE employees
SET CONCAT(email, '@example.com');

-- 6. Write a query to get the employee id, first name and hire month of an employee.

SELECT e.employee_id,
       e.first_name,
       DATE_PART('month', e.hire_date)
FROM employees AS e;

-- OR --

SELECT employee_id,
       first_name,
       hire_date,
       SUBSTR(TO_CHAR(hire_date,'yyyy MM dd'), 6, 2) AS hire_month
FROM employees;

-- 7. Write a query to get the employee id, email id to discard the last three characters.

SELECT REVERSE(SUBSTR(REVERSE(e.email), 4)),
       e.employee_id
FROM employees AS e;

-- 8. Write a query to find all the employees which first name contains all the uppercase letter.

SELECT e.first_name
FROM employees AS e
WHERE e.first_name = UPPER(e.first_name); -- 9. Write a query to extract the last four character of phone numbers.


SELECT RIGHT(e.phone_number, 4)
FROM employees AS e;

-- 10. Write a query to get the information about those locations which
-- contain the characters in its street address is on and below the minimum character length of street_address.

SELECT l.*
FROM locations AS l
WHERE LENGTH(l.street_address)<=
        (SELECT MIN(LENGTH(l.street_address))
         FROM locations AS l);

-- 11. Write a query to display the first word in the job title.

SELECT j.job_title,
       LEFT(j.job_title, POSITION(' ' IN j.job_title) - 1)
FROM jobs AS j;

-- 12. Write a query to display the first name, last name for the employees,
-- which contain a letter 'C' to their last name at 3rd or greater position.

SELECT e.first_name, e.last_name
FROM employees AS e
WHERE POSITION('C' IN e.last_name) > 2;

-- 13. Write a query that displays the first name and the length of the first name for all employees 
-- whose name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. 
-- Sort the results by the employees' first names.

SELECT e.first_name AS first_name, LENGTH(e.first_name) AS length
FROM employees AS e
WHERE LEFT(e.first_name, 1) IN ('A', 'J', 'M')
ORDER BY 1;

-- 14. Write a query to display the first name and salary for all employees. 
-- Form the salary to be 10 characters long, left-padded with the $ symbol. Label the column as SALARY.

SELECT e.first_name, LPAD(TRIM(TO_CHAR(e.salary, '9999999')), 7, '$') AS salary
FROM employees AS e;