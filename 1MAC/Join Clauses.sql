SELECT orders.*
FROM orders
JOIN accounts ON orders.account_id = accounts.id;


SELECT accounts.name,
       orders.occurred_at
FROM orders
JOIN accounts ON orders.account_id = accounts.id;


SELECT orders.*,
       accounts.*
FROM orders
JOIN accounts ON orders.account_id = accounts.id
LIMIT 10;


SELECT orders.standard_qty,
       orders.gloss_qty,
       orders.poster_qty,
       accounts.website,
       accounts.primary_poc
FROM orders
JOIN accounts ON orders.account_id = accounts.id
LIMIT 10;


SELECT *
FROM web_events
JOIN accounts ON web_events.account_id = accounts.id
JOIN orders ON accounts.id = orders.account_id;


SELECT w.occurred_at,
       w.channel,
       a.primary_poc,
       a.name
FROM web_events AS w
JOIN accounts AS a ON w.id = a.id
WHERE a.name IN ('Walmart');


SELECT s.name AS rep_name,
       r.name AS region_name,
       a.name AS account_name
FROM sales_reps AS s
JOIN region AS r ON s.region_id = r.id
JOIN accounts AS a ON a.sales_rep_id = s.id
ORDER BY a.name ASC;


SELECT r.name AS region_name,
       a.name AS account_name,
       (o.total_amt_usd/(o.total + 0.01)) AS unit_price
FROM orders AS o
JOIN accounts AS a ON o.account_id = a.id
JOIN sales_reps AS s ON s.id = a.sales_rep_id
JOIN region AS r ON r.id = s.region_id;

-- LAST CHECK QUIZ
 -- 1

SELECT r.name AS region_name,
       s.name AS sales_rep_name,
       a.name AS account_name
FROM accounts AS a
JOIN sales_reps AS s ON s.id = a.sales_rep_id
JOIN region AS r ON r.id = s.region_id
AND r.name IN ('Midwest')
ORDER BY a.name ASC;

-- 2

SELECT r.name AS region_name,
       s.name AS sales_rep_name,
       a.name AS account_name
FROM accounts AS a
JOIN sales_reps AS s ON s.id = a.sales_rep_id
AND s.name LIKE 'S%'
JOIN region AS r ON r.id = s.region_id
AND r.name IN ('Midwest')
ORDER BY a.name ASC;

-- 3

SELECT r.name AS region_name,
       s.name AS sales_rep_name,
       a.name AS account_name
FROM accounts AS a
JOIN sales_reps AS s ON s.id = a.sales_rep_id
AND s.name LIKE '% K%'
JOIN region AS r ON r.id = s.region_id
AND r.name IN ('Midwest')
ORDER BY a.name ASC;

-- 4

SELECT r.name AS region_name,
       a.name AS account_name,
       (o.total_amt_usd/(o.total + 0.01)) AS unit_price
FROM region AS r
JOIN sales_reps AS s ON s.region_id = r.id
JOIN accounts AS a ON a.sales_rep_id = s.id
JOIN orders AS o ON o.account_id = a.id
AND o.standard_qty > 100;

-- 5

SELECT r.name AS region_name,
       a.name AS account_name,
       (o.total_amt_usd/(o.total + 0.01)) AS unit_price
FROM region AS r
JOIN sales_reps AS s ON r.id = s.region_id
JOIN accounts AS a ON s.id = a.sales_rep_id
JOIN orders AS o ON a.id = o.account_id
AND o.poster_qty > 50
AND o.standard_qty > 100
ORDER BY unit_price ASC;

-- 6

SELECT r.name AS region_name,
       a.name AS account_name,
       (o.total_amt_usd/(o.total + 0.01)) AS unit_price
FROM region AS r
JOIN sales_reps AS s ON r.id = s.region_id
JOIN accounts AS a ON s.id = a.sales_rep_id
JOIN orders AS o ON a.id = o.account_id
AND o.poster_qty > 50
AND o.standard_qty > 100
ORDER BY unit_price DESC;

-- 7

SELECT DISTINCT w.channel AS channels,
                a.name AS account_name
FROM web_events AS w
JOIN accounts AS a ON a.id = w.account_id
AND a.id = '1001';

-- 8

SELECT o.occurred_at AS occurred_at,
       a.name AS account_name,
       o.total AS order_total,
       o.total_amt_usd AS order_total_amt_usd
FROM accounts AS a
JOIN orders AS o ON o.account_id = a.id
AND o.occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY o.occurred_at DESC;