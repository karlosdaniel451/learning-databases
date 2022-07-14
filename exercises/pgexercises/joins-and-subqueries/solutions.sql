--- Retrieve the start times of members' bookings
SELECT starttime
FROM cd.bookings
INNER JOIN cd.members
    ON bookings.memid = members.memid
WHERE members.firstname = 'David'
    AND members.surname = 'Farrell';


--- Work out the start times of bookings for tennis courts
SELECT cd.bookings.starttime, cd.facilities.name
FROM cd.bookings
INNER JOIN cd.facilities
    ON cd.bookings.facid = cd.facilities.facid
WHERE cd.facilities.name LIKE 'Tennis Court%'
    AND cd.bookings.starttime BETWEEN '2012-09-21 00:00:00' 
                                  AND '2012-09-21 23:59:59.999999'
ORDER BY cd.bookings.starttime


--- Produce a list of all members who have recommended another member
SELECT DISTINCT cd.members.firstname, cd.members.surname
FROM cd.members
INNER JOIN cd.members as members_2
    ON cd.members.memid = members_2.recommendedby
ORDER BY cd.members.surname, cd.members.firstname;


