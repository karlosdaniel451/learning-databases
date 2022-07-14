--- Retrieve everything from a table
SELECT *
FROM cd.facilities;

--- Retrieve specific columns from a table
SELECT name, membercost
FROM cd.facilities

--- Control which rows are retrieved
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0

--- Control which rows are retrieved - part 2
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0
    AND membercost < (monthlymaintenance) / 50

--- Basic string searches
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE name LIKE '%Tennis%'

--- Matching against multiple possible values
SELECT facid, name, membercost, guestcost, initialoutlay, monthlymaintenance
FROM cd.facilities
WHERE facid IN (1, 5)

--- Working with dates
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE joindate >= TIMESTAMP'2012-09-01 00:00:00'
/*
Alternative to the WHERE clause:
where joindate >= '2012-09-01';
*/

--- Removing duplicates, and ordering results
SELECT DISTINCT surname
FROM cd.members
ORDER BY surname ASC
LIMIT 10

--- Combining results from multiple queries
SELECT surname
FROM cd.members

UNION
SELECT name
FROM cd.facilities


--- Simple aggregation
SELECT MAX(joindate) AS latest
FROM cd.members


--- More aggregation
SELECT firstname, surname, joindate
FROM cd.members
WHERE joindate = (
    SELECT MAX(joindate)
    FROM cd.members
);



