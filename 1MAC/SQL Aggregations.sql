-- Quiz: Sum
-- 1

SELECT SUM(poster_qty) AS total_amt_poster
FROM orders;

-- 2

SELECT SUM(standard_qty) AS total_amt_standard_qty
FROM orders;

-- 3

SELECT SUM(total_amt_usd) AS total_amt_usd
FROM orders;

-- 4

SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

-- 5

SELECT (SUM(standard_amt_usd)/ SUM(standard_qty)) AS Average
FROM orders;

-- Quiz: MIN, MAX, & AVG
 -- 1

SELECT MIN(orders.occurred_at) AS order_date
FROM orders;

-- 2

SELECT orders.occurred_at AS order_date
FROM orders
ORDER BY orders.occurred_at
LIMIT 1;

-- 3

SELECT MAX(web_events.occurred_at) AS order_date
FROM web_events;

-- 4

SELECT web_events.occurred_at AS order_date
FROM web_events
ORDER BY web_events.occurred_at DESC
LIMIT 1;

-- 5

SELECT ROUND(AVG(o.gloss_qty),2) AS avg_glossy,
       ROUND(AVG(o.gloss_amt_usd),2) AS avg_glossy_sales,
       ROUND(AVG(o.poster_qty),2) AS avg_poster,
       ROUND(AVG(o.poster_amt_usd),2) AS avg_poster_sales,
       ROUND(AVG(o.standard_qty),2) AS avg_standard,
       ROUND(AVG(o.standard_amt_usd),2) AS avg_standard_sales
FROM orders AS o;

-- 6

SELECT *
FROM
    (SELECT total_amt_usd
     FROM orders
     ORDER BY total_amt_usd
     LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

-- Quiz: GROUP BY
 -- 1

SELECT a.name AS account_name,
       MIN(o.occurred_at) AS order_date
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY a.name;

-- 2

SELECT a.name AS account_name,
       SUM(o.total) AS total_order
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY a.name;

-- 3

SELECT a.name AS account_name,
       w.channel AS account_channel,
       MAX(w.occurred_at) AS account_date
FROM web_events AS w
JOIN accounts AS a ON a.id = w.account_id
GROUP BY a.name,
         w.channel
ORDER BY account_date DESC
LIMIT 1;

-- 4

SELECT w.channel AS account_channel,
       COUNT(w.channel) AS channel_count
FROM web_events AS w
GROUP BY w.channel;

-- 5

SELECT a.primary_poc AS primary_contact,
       MIN(w.occurred_at) AS account_date
FROM accounts AS a
JOIN web_events AS w ON a.id = w.account_id
GROUP BY primary_contact
ORDER BY account_date ASC
LIMIT 1;

-- 6

SELECT a.name AS account_name,
       MIN(o.total) AS total_orders
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
WHERE o.total > 0
GROUP BY account_name
ORDER BY total_orders ASC;

-- OR

SELECT a.name AS account_name,
       MIN(o.total) AS total_orders
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY account_name
ORDER BY total_orders ASC;

-- 7

SELECT r.name AS region_name,
       COUNT(s.id) AS region_count
FROM region AS r
JOIN sales_reps AS s ON s.region_id = r.id
GROUP BY region_name
ORDER BY region_count;

-- Quiz: GROUP BY Part II
-- 1

SELECT a.name AS account_name,
       ROUND(AVG(o.gloss_qty), 2) AS avg_gloss,
       ROUND(AVG(o.poster_qty), 2) AS avg_poster,
       ROUND(AVG(o.standard_qty), 2) AS avg_standard
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY account_name;

-- 2

SELECT a.name AS account_name,
       ROUND(AVG(o.gloss_amt_usd), 2) AS avg_gloss,
       ROUND(AVG(o.poster_amt_usd), 2) AS avg_poster,
       ROUND(AVG(o.standard_amt_usd), 2) AS avg_standard
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY account_name;

-- 3

SELECT s.name AS sales_rep_name,
       w.channel AS channel_name,
       COUNT(w.channel) AS channel_freq
FROM web_events AS w
JOIN accounts AS a ON w.account_id = a .id
JOIN sales_reps AS s ON a.sales_rep_id = s.id
GROUP BY sales_rep_name,
         channel_name
ORDER BY channel_freq DESC;

-- 4

SELECT r.name AS region_name,
       w.channel AS channel_name,
       COUNT(w.channel) AS channel_freq
FROM web_events AS w
JOIN accounts AS a ON w.account_id = a .id
JOIN sales_reps AS s ON a.sales_rep_id = s.id
JOIN region AS r ON r.id = s.region_id
GROUP BY region_name,
         channel_name
ORDER BY channel_freq DESC;

-- Quiz: DISTINCT
 -- 1

SELECT DISTINCT id,
                name
FROM accounts;

-- 2

SELECT DISTINCT id,
                name
FROM sales_reps;

-- Quiz: Having
-- 1

SELECT s.name AS sales_rep_name,
       COUNT(a.name) AS accounts_count
FROM accounts AS a
JOIN sales_reps AS s ON a.sales_rep_id = s.id
GROUP BY sales_rep_name
HAVING COUNT(a.name) > 5
ORDER BY COUNT(a.name);

-- 2

SELECT a.name AS account_name,
       COUNT(o.account_id) AS orders_count
FROM orders AS o
JOIN accounts AS a ON o.account_id = a.id
GROUP BY account_name
HAVING COUNT(o.account_id) > 20
ORDER BY COUNT(o.account_id);

-- 3

SELECT a.name AS account_name,
       COUNT(o.total) AS orders_total
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY account_name
ORDER BY orders_total DESC
LIMIT 1;

-- 4

SELECT a.name AS account_name,
       SUM(o.total) AS accounts_spend
FROM accounts AS a
JOIN orders AS o ON a.id = o.account_id
GROUP BY account_name
HAVING SUM(o.total) > 30000;

-- to get the count

SELECT COUNT(*)
FROM
    (SELECT a.name AS account_name,
            SUM(o.total) AS accounts_spend
     FROM accounts AS a
     JOIN orders AS o ON a.id = o.account_id
     GROUP BY account_name
     HAVING SUM(o.total) > 30000) AS table4;

-- 5

SELECT a.name AS account_name,
       SUM(o.total) AS accounts_spend
FROM accounts AS a
JOIN orders AS o ON a.id = o.account_id
GROUP BY account_name
HAVING SUM(o.total) < 1000;

-- to get the count

SELECT COUNT(*)
FROM
    (SELECT a.name AS account_name,
            SUM(o.total) AS accounts_spend
     FROM accounts AS a
     JOIN orders AS o ON a.id = o.account_id
     GROUP BY account_name
     HAVING SUM(o.total) < 1000) AS table5;

-- 6

SELECT a.name AS account_name,
       SUM(o.total) AS accounts_spend
FROM accounts AS a
JOIN orders AS o ON a.id = o.account_id
GROUP BY account_name
ORDER BY SUM(o.total) DESC;

-- 7

SELECT a.name AS account_name,
       SUM(o.total) AS accounts_spend
FROM accounts AS a
JOIN orders AS o ON a.id = o.account_id
GROUP BY account_name
ORDER BY SUM(o.total);

-- 8

SELECT a.name AS account_name,
       COUNT(w.channel) AS channel_freq
FROM web_events AS w
JOIN accounts AS a ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY account_name
HAVING COUNT(w.channel) > 6;

-- 9

SELECT a.name AS account_name,
       COUNT(w.channel) AS channel_freq
FROM web_events AS w
JOIN accounts AS a ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY account_name
ORDER BY COUNT(w.channel) DESC
LIMIT 1;

-- 10

SELECT a.name AS account_name,
       w.channel AS channel_name,
       COUNT(w.channel) AS channel_freq
FROM web_events AS w
JOIN accounts AS a ON a.id = w.account_id
GROUP BY account_name,
         channel_name
ORDER BY COUNT(w.channel) DESC
LIMIT 1;

-- Quiz: Date
-- 1

SELECT DATE_PART('year', o.occurred_at) AS per_year,
       SUM(o.total) AS total
FROM orders AS o
GROUP BY 1
ORDER BY 1 DESC;

-- 2

SELECT DATE_PART('month', o.occurred_at) AS per_month,
       SUM(o.total) AS total
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC;

-- 3

SELECT DATE_PART('year', o.occurred_at) AS per_year,
       COUNT(o.total) AS total
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC;

-- 4

SELECT DATE_PART('month', o.occurred_at) AS per_month,
       COUNT(o.total) AS total
FROM orders AS o
GROUP BY 1
ORDER BY 2 DESC;

-- 5

SELECT DATE_TRUNC('month', o.occurred_at) AS MONTH,
       SUM(o.total) AS total,
       a.name AS account_name
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
AND a.name LIKE 'Walmart'
GROUP BY 1,
         3
ORDER BY 2 DESC
LIMIT 1;

-- Quiz: CASE
-- 1

SELECT CASE
           WHEN SUM(o.total) > 200000 THEN 'High'
           WHEN SUM(o.total) > 100000 THEN 'Mid_Level'
           ELSE 'Low'
       END AS customer_level,
       SUM(o.total) AS total,
       a.name AS account_name
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
GROUP BY a.name
ORDER BY 2 DESC;

-- 2

SELECT CASE
           WHEN SUM(o.total) > 200000 THEN 'High'
           WHEN SUM(o.total) > 100000 THEN 'Mid'
           ELSE 'Low'
       END AS customer_level,
       SUM(o.total) AS total,
       a.name AS account_name,
       o.occurred_at AS order_date
FROM orders AS o
JOIN accounts AS a ON a.id = o.account_id
AND o.occurred_at BETWEEN '2016-01-01' AND '2018-01-01'
GROUP BY 3,
         4
ORDER BY 2 DESC;

-- 3

SELECT s.name AS sales_reps_name,
       COUNT(o.total) AS orders_count,
       CASE
           WHEN COUNT(o.total) > 200 THEN 'Top'
           ELSE 'Not'
       END AS rep_ran
FROM sales_reps AS s
JOIN accounts AS a ON a.sales_rep_id = s.id
JOIN orders AS o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;

-- 4

SELECT s.name AS sales_reps_name,
       COUNT(o.total) AS orders_count,
       SUM(o.total) AS amount_sales,
       CASE
           WHEN ((COUNT(o.total) > 200)
                 OR (SUM(o.total) > 750000)) THEN 'Top'
           WHEN ((COUNT(o.total) > 150 AND COUNT(o.total) < 200)
                 OR (SUM(o.total) > 500000)) THEN 'Middle'
           ELSE 'Low'
       END AS rep_rank
FROM sales_reps AS s
JOIN accounts AS a ON a.sales_rep_id = s.id
JOIN orders AS o ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;