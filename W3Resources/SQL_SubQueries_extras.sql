--  get employees who earn more than avg salary earned by IT personal

SELECT e.first_name,
       e.last_name,
       e.salary
FROM employees AS e
WHERE e.salary >
        (SELECT ROUND(AVG(tbl1.salary), 2)
         FROM
             ( SELECT e.salary AS salary,
                      e.department_id
              FROM employees AS e
              WHERE e.department_id IN
                      (SELECT d.department_id
                       FROM departments AS d
                       WHERE d.department_name LIKE 'IT') ) AS tbl1);