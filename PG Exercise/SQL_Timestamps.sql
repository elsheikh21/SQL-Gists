-- 1. Produce a timestamp for 1 a.m. on the 31st of August 2012

SELECT TIMESTAMP '2012-08-31 01:00:00';

-- 2. Subtract timestamps from each other

SELECT TIMESTAMP '2012-08-31 01:00:00' - TIMESTAMP '2012-07-30 01:00:00' AS interval;

-- 3. Generate a list of all the dates in October 2012

SELECT generate_series(TIMESTAMP '2012-10-01', TIMESTAMP '2012-10-31', interval '1 day') AS ts;

-- 4. Get the day of the month from a timestampGet the day of the month from a timestamp

SELECT DATE_PART('day', CAST('2012-08-31' AS TIMESTAMP));

-- 5. Work out the number of seconds between timestamps

SELECT extract(epoch
               FROM (CAST('2012-09-02 00:00:00' AS TIMESTAMP) - CAST('2012-08-31 01:00:00' AS TIMESTAMP))) AS date_part;

-- 6. Work out the number of days in each month of 2012

SELECT extract(MONTH
               FROM cal.month) AS MONTH,
       (cal.month + interval '1 month') - cal.month AS LENGTH
FROM
    (SELECT generate_series(TIMESTAMP '2012-01-01', TIMESTAMP '2012-12-01', interval '1 month') AS MONTH) cal
ORDER BY MONTH;

-- 7. Work out the number of days remaining in the month

SELECT (date_trunc('month',ts.testts) + interval '1 month') - date_trunc('day', ts.testts) AS remaining
FROM
    (SELECT TIMESTAMP '2012-02-11 01:00:00' AS testts) AS ts;

-- 8. Work out the end time of bookings

SELECT b.starttime,
       b.starttime + (b.slots * interval '30 minutes') AS endtime
FROM cd.bookings AS b
ORDER BY 1
LIMIT 10;

-- 9. Return a count of bookings for each month

SELECT DATE_TRUNC('month', b.starttime),
       COUNT(b.slots)
FROM cd.bookings AS b
GROUP BY 1
ORDER BY 1;

-- 10. Work out the utilisation percentage for each facility by month

SELECT name,
       MONTH,
       round((100*slots)/ cast( 25*(cast((MONTH + interval '1 month') AS date) - CAST (MONTH AS date)) AS numeric),1) AS utilisation
FROM
    ( SELECT facs.name AS name,
             date_trunc('month', starttime) AS MONTH,
             sum(slots) AS slots
     FROM cd.bookings bks
     INNER JOIN cd.facilities facs ON bks.facid = facs.facid
     GROUP BY facs.facid,
              MONTH ) AS inn
ORDER BY name,
         MONTH;