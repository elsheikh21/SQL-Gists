-- 1. Count the number of facilities

SELECT COUNT(*)
FROM cd.facilities;

-- 2. Count the number of expensive facilities

SELECT COUNT(*)
FROM
    (SELECT f.guestcost
     FROM cd.facilities AS f
     WHERE f.guestcost >= 10) AS tbl1;

-- better

SELECT count(*)
FROM cd.facilities
WHERE guestcost >= 10;

-- 3. Count the number of recommendations each member makes.

SELECT m.recommendedby,
       COUNT(m.recommendedby)
FROM cd.members AS m
WHERE m.recommendedby IS NOT NULL
GROUP BY 1
ORDER BY 1;

-- 4. List the total slots booked per facility

SELECT b.facid,
       SUM(b.slots)
FROM cd.bookings AS b
GROUP BY 1
ORDER BY 1;

-- 5. List the total slots booked per facility in a given month

SELECT b.facid,
       SUM(b.slots)
FROM cd.bookings AS b
WHERE b.starttime BETWEEN '2012-09-01' AND '2012-10-01'
GROUP BY 1
ORDER BY 2;

-- 6. List the total slots booked per facility per month

SELECT b.facid,
       DATE_PART('month', b.starttime),
       SUM(b.slots)
FROM cd.bookings AS b
WHERE DATE_PART('year', b.starttime) = 2012
GROUP BY 1,
         2
ORDER BY 1,
         2;

-- or

SELECT facid,
       extract(MONTH
               FROM starttime) AS MONTH,
       sum(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-01-01'
    AND starttime < '2013-01-01'
GROUP BY facid,
         MONTH
ORDER BY facid,
         MONTH;

-- 7. Find the count of members who have made at least one booking

SELECT COUNT(DISTINCT m.memid)
FROM cd.bookings AS b
JOIN cd.members AS m ON m.memid = b.memid
WHERE b.slots >= 1;

-- 8. List facilities with more than 1000 slots booked

SELECT b.facid,
       SUM(b.slots)
FROM cd.bookings AS b
GROUP BY b.facid
HAVING SUM(b.slots) > 1000
ORDER BY b.facid;

-- 9. Find the total revenue of each facility

SELECT f.name AS name,
       SUM(b.slots * CASE
                         WHEN b.memid = 0 THEN f.guestcost
                         ELSE f.membercost
                     END) AS revenue
FROM cd.facilities AS f
JOIN cd.bookings AS b ON f.facid = b.facid
GROUP BY f.name
ORDER BY 2;

-- 10. Find facilities with a total revenue less than 1000

SELECT f.name AS name,
       SUM(b.slots * CASE
                         WHEN b.memid = 0 THEN f.guestcost
                         ELSE f.membercost
                     END) AS revenue
FROM cd.facilities AS f
JOIN cd.bookings AS b ON f.facid = b.facid
GROUP BY f.name
HAVING SUM(b.slots * CASE
                         WHEN b.memid = 0 THEN f.guestcost
                         ELSE f.membercost
                     END) < 1000
ORDER BY 2;

-- 11. Output the facility id that has the highest number of slots booked
 WITH t1 AS
    (SELECT f.facid AS name,
            SUM(b.slots) AS total_slots
     FROM cd.facilities AS f
     JOIN cd.bookings AS b ON b.facid = f.facid
     GROUP BY f.facid),
      t2 AS
    (SELECT MAX(t1.total_slots) AS MAX
     FROM t1)
SELECT t1.name,
       t2.max
FROM t1,
     t2
WHERE t1.total_slots = t2.max;

-- 12. List the total slots booked per facility per month, part 2
WITH t1 AS
    (SELECT f.facid AS facid,
            DATE_PART('month', b.starttime) AS MONTH,
            SUM(b.slots) AS slots
     FROM cd.bookings AS b
     JOIN cd.facilities AS f ON f.facid = b.facid
     WHERE DATE_PART('year', b.starttime) = '2012'
     GROUP BY 1,
              2),
     t2 AS
    (SELECT f.facid AS facid,
            SUM(b.slots) AS slots
     FROM cd.bookings AS b
     JOIN cd.facilities AS f ON f.facid = b.facid
     WHERE DATE_PART('year', b.starttime) = '2012'
     GROUP BY 1),
     t3 AS
    (SELECT t1.facid,
            t1.month,
            t1.slots
     FROM t1
     UNION ALL SELECT t2.facid,
                      NULL AS MONTH,
                      t2.slots
     FROM t2),
     t4 AS
    (SELECT *
     FROM t3
     ORDER BY t3.facid,
              t3.month),
     t5 AS
    (SELECT NULL AS facid,
            NULL AS MONTH,
            SUM(t2.slots) AS slots
     FROM t2),
     t6 AS
    (SELECT t3.*
     FROM t3
     UNION ALL SELECT CAST(t5.facid AS INTEGER),
                      CAST(t5.month AS INTEGER),
                      CAST(t5.slots AS INTEGER)
     FROM t5)
SELECT t6.*
FROM t6
ORDER BY t6.facid,
         t6.month;

-- 13. List the total hours booked per named facility

SELECT f.facid,
       f.name,
       CAST(ROUND(SUM(b.slots * 0.5), 2) AS varchar(50)) AS "Total Hours"
FROM cd.facilities AS f
JOIN cd.bookings AS b ON f.facid = b.facid
GROUP BY f.facid,
         f.name
ORDER BY f.facid;

-- 14. List each member's first booking after September 1st 2012
 
SELECT m.surname, 
       m.firstname, 
       m.memid, 
       MIN(b.starttime)
FROM cd.members AS m
JOIN cd.bookings AS b ON b.memid = m.memid 
WHERE b.starttime >= '2012-09-01'
GROUP BY 1,
         2,
         3
ORDER BY 3;

-- 15. Produce a list of member names, with each row containing the total member count
 WITH t1 AS
    (SELECT m.firstname,
            m.surname
     FROM cd.members AS m
     ORDER BY m.joindate),
      t2 AS
    (SELECT COUNT(*)
     FROM cd.members)
SELECT t2.*,
       t1.*
FROM t2,
     t1;

-- 16. Produce a numbered list of members

SELECT row_number()over(
                        ORDER BY joindate),
                   m.firstname,
                   m.surname
FROM cd.members AS m
ORDER BY m.joindate;

-- 17. Output the facility id that has the highest number of slots booked, again
 WITH t1 AS
    (SELECT SUM(b.slots) AS slots,
            b.facid AS facid
     FROM cd.bookings AS b
     GROUP BY b.facid),
      t2 AS
    (SELECT MAX(t1.slots)
     FROM t1)
SELECT t1.facid,
       t2.max AS total
FROM t1,
     t2
WHERE t1.slots = t2.max;

-- 18. Rank members by (rounded) hours used

SELECT m.firstname,
       m.surname,
       ROUND(SUM(b.slots * 0.5), -1) AS hours,
       rank() over(
                   ORDER BY ROUND(SUM(b.slots * 0.5), -1) DESC) AS rank
FROM cd.members AS m
JOIN cd.bookings AS b ON b.memid = m.memid
GROUP BY 1,
         2
ORDER BY rank,
         2,
         1;

-- 19. Find the top three revenue generating facilities

SELECT f.name,
       rank() over(
                   ORDER BY SUM(b.slots * CASE
                                              WHEN b.memid = 0 THEN f.guestcost
                                              ELSE f.membercost
                                          END) DESC)
FROM cd.facilities AS f
JOIN cd.bookings AS b ON b.facid = f.facid
GROUP BY 1
ORDER BY rank
LIMIT 3;

-- 20. Classify facilities by value
 WITH t1 AS
    (SELECT f.name,
            ntile(3) over(
                          ORDER BY SUM(b.slots * CASE
                                                     WHEN b.memid = 0 THEN f.guestcost
                                                     ELSE f.membercost
                                                 END) DESC) AS rank
     FROM cd.facilities AS f
     JOIN cd.bookings AS b ON b.facid = f.facid
     GROUP BY 1
     ORDER BY 2,
              1)
SELECT t1.name,
       CASE
           WHEN t1.rank = 1 THEN 'high'
           WHEN t1.rank = 2 THEN 'average'
           ELSE 'low'
       END AS revenue
FROM t1;

-- 21. Calculate the payback time for each facility

SELECT f.name,
       (f.initialoutlay / (SUM(b.slots * CASE
                                             WHEN b.memid = 0 THEN f.guestcost
                                             ELSE f.membercost
                                         END) / 3 - f.monthlymaintenance)) AS revenue
FROM cd.facilities AS f
JOIN cd.bookings AS b ON f.facid = b.facid
GROUP BY 1,
         f.monthlymaintenance,
         f.initialoutlay
ORDER BY 1;

-- 22. Calculate a rolling average of total revenue

SELECT date, avgrev
FROM
    ( -- AVG over this row and the 14 rows before it.
 SELECT dategen.date AS date,
        avg(revdata.rev) over(
                              ORDER BY dategen.date ROWS 14 preceding) AS avgrev
     FROM -- generate a list of days.  This ensures that a row gets generated
 -- even if the day has 0 revenue.  Note that we generate days before
 -- the start of october - this is because our window function needs
 -- to know the revenue for those days for its calculations.

         (SELECT cast(generate_series(TIMESTAMP '2012-07-10', '2012-08-31','1 day') AS date) AS date ) AS dategen
     LEFT OUTER JOIN -- left join to a table of per-day revenue

         (SELECT cast(bks.starttime AS date) AS date,
                 sum(CASE
                         WHEN memid = 0 THEN slots * facs.guestcost
                         ELSE slots * membercost
                     END) AS rev
          FROM cd.bookings bks
          INNER JOIN cd.facilities facs ON bks.facid = facs.facid
          GROUP BY cast(bks.starttime AS date) ) AS revdata ON dategen.date = revdata.date ) AS subq
WHERE date >= '2012-08-01'
ORDER BY date;