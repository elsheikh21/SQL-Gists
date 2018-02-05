-- Retrieve the start times of members' bookings
 
SELECT b.starttime
FROM cd.bookings AS b 
WHERE b.memid = 
        (SELECT m.memid 
         FROM cd.members AS m 
         WHERE m.firstname = 'David' 
             AND m.surname = 'Farrell');

--------------------------------------------------------------------------------------------
 -- Work out the start times of bookings for tennis courts

SELECT b.starttime,
       f.name
FROM cd.bookings AS b
JOIN cd.facilities AS f ON b.facid = f.facid
WHERE b.starttime BETWEEN '2012-09-21' AND '2012-09-22'
    AND f.facid IN
        (SELECT f.facid
         FROM cd.bookings AS b
         JOIN cd.facilities AS f ON b.memid = f.facid
         WHERE f.name LIKE 'Tennis Court%')
ORDER BY 1;

--------------------------------------------------------------------------------------------
 -- Produce a list of all members who have recommended another member
 WITH t1 AS
    (SELECT mem.firstname,
            mem.surname
     FROM cd.members AS mem
     WHERE mem.memid IN
             (SELECT m.recommendedby
              FROM cd.members AS m
              WHERE m.recommendedby IS NOT NULL)
     ORDER BY 2)
SELECT *
FROM t1;

-- Produce a list of all members, along with their recommender

SELECT m.firstname AS memfname,
       m.surname AS memsname,
       mems.firstname AS recfname,
       mems.surname AS recsname
FROM cd.members AS m
LEFT JOIN cd.members AS mems ON mems.memid = m.recommendedby
ORDER BY memsname,
         memfname;

-- Produce a list of all members who have used a tennis court

SELECT CONCAT(m.firstname, ' ', m.surname) AS member,
       tbl1.facility
FROM
    (SELECT DISTINCT f.name AS facility,
                     b.memid AS memid
     FROM cd.facilities AS f
     JOIN cd.bookings AS b ON b.facid = f.facid
     AND f.name LIKE 'Tennis Court%') AS tbl1
JOIN cd.members AS m ON tbl1.memid = m.memid
ORDER BY 1;

-- Produce a list of costly bookings

SELECT m.firstname || ' ' || m.surname AS member,
       f.name AS facility,
       b.slots * CASE
                     WHEN b.memid = 0 THEN f.guestcost
                     ELSE f.membercost
                 END AS cost
FROM cd.members AS m
JOIN cd.bookings AS b ON b.memid = m.memid
AND b.starttime BETWEEN '2012-09-14' AND '2012-09-15'
JOIN cd.facilities AS f ON b.facid = f.facid
WHERE b.slots * CASE
                    WHEN b.memid = 0 THEN f.guestcost
                    ELSE f.membercost
                END > 30
ORDER BY 3 DESC;

-- Produce a list of all members, along with their recommender, using no joins.

SELECT DISTINCT mems.firstname || ' ' || mems.surname AS member,
    (SELECT recs.firstname || ' ' || recs.surname AS recommender
     FROM cd.members recs
     WHERE recs.memid = mems.recommendedby )
FROM cd.members mems
ORDER BY member;

-- Produce a list of costly bookings, using a subquery
 WITH t1 AS
    (SELECT m.firstname || ' ' || m.surname AS member,
            f.name AS facility,
            b.slots * CASE
                          WHEN b.memid = 0 THEN f.guestcost
                          ELSE f.membercost
                      END AS cost
     FROM cd.members AS m
     JOIN cd.bookings AS b ON b.memid = m.memid
     AND b.starttime BETWEEN '2012-09-14' AND '2012-09-15'
     JOIN cd.facilities AS f ON b.facid = f.facid
     ORDER BY 3 DESC)
SELECT *
FROM t1
WHERE t1.cost > 30;