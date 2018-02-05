-- [[EXTRA]] Count amount of orders placed by a sales rep in each region

SELECT tbl1.region_name AS region_name,
       COUNT(o.total) AS total_orders
FROM (
SELECT s.name AS sales_rep_name,
       r.name AS region_name,
       MAX(o.total_amt_usd) AS total_USD
FROM orders AS o
JOIN accounts AS a ON o.account_id = a.id
JOIN sales_reps AS s ON a.sales_rep_id = s.id
JOIN region AS r ON r.id = s.region_id
GROUP BY 1,
         2
ORDER BY 3 DESC;

) AS tbl1,
orders AS o
JOIN accounts AS a ON o.account_id = a.id
JOIN sales_reps AS s ON a.sales_rep_id = s.id
JOIN region AS r ON r.id = s.region_id
WHERE r.name = tbl1.region_name
GROUP BY 1;

-- [[EXTRA]] Maximum done by sales rep per region

SELECT s.name AS "Sales Rep Name",
       r.name AS "Region Name",
       MAX(o.total_amt_usd)
FROM sales_reps AS s
JOIN region AS r ON r.id = s.region_id
JOIN accounts AS a ON a.sales_rep_id = s.id
JOIN orders AS o ON o.account_id = a.id
GROUP BY 1,
         2;

-- [[EXTRA]] getting max of orders placed per region

SELECT r.name AS "Region Name",
       MAX(o.total_amt_usd) AS "Max Total"
FROM sales_reps AS s
JOIN region AS r ON r.id = s.region_id
JOIN accounts AS a ON a.sales_rep_id = s.id
JOIN orders AS o ON o.account_id = a.id
GROUP BY 1;
