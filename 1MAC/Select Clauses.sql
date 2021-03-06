SELECT id,
       account_id,
       occurred_at
FROM orders;


SELECT occurred_at,
       account_id,
       channel
FROM web_events
LIMIT 15;


SELECT id,
       occurred_at,
       total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;


SELECT id,
       account_id,
       total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;


SELECT id,
       account_id,
       total
FROM orders
ORDER BY total
LIMIT 20;


SELECT *
FROM orders
ORDER BY occurred_at DESC,
         total_amt_usd DESC
LIMIT 5;


SELECT *
FROM orders
ORDER BY occurred_at,
         total_amt_usd
LIMIT 10;


SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;


SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;


SELECT name,
       website,
       primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';


SELECT id,
       account_id,
       standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;


SELECT id,
       account_id,
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders;


SELECT name
FROM accounts
WHERE name LIKE 'C%';


SELECT name
FROM accounts
WHERE name LIKE '%one%';


SELECT name
FROM accounts
WHERE name LIKE '%s';


SELECT name,
       primary_poc,
       sales_rep_id
FROM accounts
WHERE name IN ('Walmart',
               'Target',
               'Nordstrom');


SELECT *
FROM web_events
WHERE channel IN ('organic',
                  'adwords');


SELECT name,
       primary_poc,
       sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart',
                   'Target',
                   'Nordstrom');


SELECT *
FROM web_events
WHERE channel NOT IN ('organic',
                      'adwords');


SELECT name
FROM accounts
WHERE name NOT LIKE 'C%';


SELECT name
FROM accounts
WHERE name NOT LIKE '%one%';


SELECT name
FROM accounts
WHERE name NOT LIKE '%s';


SELECT *
FROM orders
WHERE standard_qty > 1000
    AND poster_qty = 0
    AND gloss_qty = 0;


SELECT name
FROM accounts
WHERE name NOT LIKE 'C%'
    AND name LIKE '%s';


SELECT *
FROM web_events
WHERE channel IN ('organic',
                  'adwords')
    AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;


SELECT id
FROM orders
WHERE gloss_qty > 4000
    OR poster_qty > 4000;


SELECT *
FROM orders
WHERE standard_qty = 0
    AND (gloss_qty > 1000
         OR poster_qty > 1000);


SELECT *
FROM accounts
WHERE (name LIKE 'C%'
       OR name LIKE 'W%')
    AND ((primary_poc LIKE '%ana%'
          OR primary_poc LIKE '%Ana%')
         AND primary_poc NOT LIKE '%eana%');