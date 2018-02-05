-- Quiz: POSITION, STRPOS, & SUBSTR - AME DATA AS QUIZ 1
-- 1

SELECT a.primary_poc,
       LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)) AS first_name,
       RIGHT(a.primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
FROM accounts AS a;

-- 2

SELECT name,
       LEFT(name, POSITION(' ' IN name)) AS first_name,
       RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) AS last_name
FROM sales_reps;

-- Quiz: CONCAT
-- 1
WITH t1 AS
    (SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
            RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name,
            name
     FROM accounts)
SELECT first_name,
       last_name,
       CONCAT(first_name, '.', last_name, '@', name, '.com')
FROM t1;

-- 2
 WITH t1 AS
    (SELECT LOWER(replace(primary_poc, ' ', '.')) AS primary_poc,
            LOWER(replace(name, ' ', '')) AS name
     FROM accounts)
SELECT CONCAT(t1.primary_poc, '@', t1.name, '.com') AS email
FROM t1;

-- 3
-- requirements:
 -- 1. first letter of the primary_poc first name (lowercase),
 -- 2. last letter of their first name (lowercase),
 -- 3. first letter of their last name (lowercase),
 -- 4. last letter of their last name (lowercase),
 -- 5. number of letters in their first name,
 -- 6. number of letters in their last name,
 -- 7. name of the company they are working with,
 -- 8. capitalized with no spaces.
 WITH t1 AS
    (SELECT LEFT(primary_poc, 1) AS firstLetter_primary_poc
     FROM accounts),
      t2 AS
    (SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ') -1) first_name,
            RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name,
            name
     FROM accounts),
      t21 AS
    (SELECT LOWER(RIGHT(t2.first_name, 1)) AS first_letter_first_name,
            LOWER(LEFT(t2.last_name, 1)) AS first_letter_last_name,
            LOWER(RIGHT(t2.last_name, 1)) AS last_letter_last_name
     FROM t2),
      t3 AS
    (SELECT LENGTH(t2.first_name) AS first_name_length,
            LENGTH(t2.last_name) AS last_name_length
     FROM t2),
      t4 AS
    (SELECT LOWER(replace(name, ' ', '')) AS name
     FROM accounts),
      t5 AS
    (SELECT CONCAT(t1.firstLetter_primary_poc, '', t21.first_letter_first_name, '', t21.first_letter_last_name, '', t21.last_letter_last_name, '', t3.first_name_length, '', t3.last_name_length, '', t4.name) AS pass
     FROM t1,
          t21,
          t3,
          t4),
      t6 AS
    (SELECT UPPER(t5.pass)
     FROM t5) 
SELECT *
FROM t6;

-- Quiz: CAST
-- 1

SELECT *
FROM sf_crime_data
LIMIT 10;

-- 2 & 3 & 4
-- DATE Format is: yyyy-mm-dd

SELECT date, (SUBSTRING(date, 7, 4) || '-' || SUBSTRING(date, 1, 2) || '-' || SUBSTRING(date, 4, 2)):: date AS datum,
             SUBSTRING(date, 12, 2) || ':' || SUBSTRING(date, 15, 2) || ':' || SUBSTRING(date, 18, 2) AS zeit
FROM sf_crime_data
LIMIT 10;

-- Quiz: COALESCE
-- 1

SELECT *
FROM accounts a
LEFT JOIN orders o ON a.id = o.account_id
WHERE o.total IS NULL;

-- 2

SELECT coalesce(a.id, o.account_id) AS id,
       a.name,
       a.website,
       a.lat,
       a.long,
       a.primary_poc,
       a.sales_rep_id,
       o.*
FROM accounts AS a
LEFT JOIN orders AS o ON a.id = o.account_id
WHERE o.total IS NULL;

-- 3

SELECT COALESCE(a.id, a.id) filled_id,
       a.name,
       a.website,
       a.lat,
       a.long,
       a.primary_poc,
       a.sales_rep_id,
       COALESCE(o.account_id, a.id) account_id,
       o.occurred_at,
       o.standard_qty,
       o.gloss_qty,
       o.poster_qty,
       o.total,
       o.standard_amt_usd,
       o.gloss_amt_usd,
       o.poster_amt_usd,
       o.total_amt_usd
FROM accounts a
LEFT JOIN orders o ON a.id = o.account_id
WHERE o.total IS NULL;

-- 4

SELECT COALESCE(a.id, a.id) AS filled_id,
       a.name,
       a.website,
       a.lat,
       a.long,
       a.primary_poc,
       a.sales_rep_id,
       COALESCE(o.account_id, a.id) AS account_id,
       o.occurred_at,
       o.standard_qty,
       o.gloss_qty,
       o.poster_qty,
       o.total,
       o.standard_amt_usd,
       o.gloss_amt_usd,
       o.poster_amt_usd,
       o.total_amt_usd,
       COALESCE(o.standard_qty, 0) AS filled_standard_qty,
       COALESCE(o.standard_amt_usd, 0) AS filled_standard_usd,
       COALESCE(o.poster_qty, 0) AS filled_poster_qty,
       COALESCE(o.poster_amt_usd, 0) AS filled_poster_usd,
       COALESCE(o.gloss_qty, 0) AS filled_gloss_qty,
       COALESCE(o.gloss_amt_usd, 0) AS filled_gloss_usd
FROM accounts a
LEFT JOIN orders o ON a.id = o.account_id
WHERE o.total IS NULL;

-- 5

SELECT COUNT(*)
FROM accounts AS a
LEFT JOIN orders AS o ON a.id = o.account_id
WHERE o.total IS NULL;