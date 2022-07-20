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


--- Produce a list of all members, along with their recommender
SELECT cd.members.firstname, cd.members.surname, members_who_recommended.firstname, members_who_recommended.surname
FROM cd.members
LEFT JOIN cd.members as members_who_recommended
    ON cd.members.recommendedby = members_who_recommended.memid
ORDER BY cd.members.surname, cd.members.firstname
--- It has a left join (outer) because it is required that all members must be showed, even those not recommended by anyone.


--- Produce a list of all members who have used a tennis court
SELECT DISTINCT cd.members.firstname || ' ' || cd.members.surname AS member, cd.facilities.name AS facility
FROM cd.members
INNER JOIN cd.bookings
    ON cd.members.memid = cd.bookings.memid
INNER JOIN cd.facilities
    ON cd.bookings.facid = cd.facilities.facid
WHERE name LIKE 'Tennis Court %'
ORDER BY member ASC, facility ASC


--- Produce a list of costly bookings
SELECT cd.members.firstname || ' ' || cd.members.surname AS member, cd.facilities.name AS facility,
    CASE
        WHEN cd.members.memid = 0 THEN
            cd.bookings.slots * cd.facilities.guestcost
        ELSE
            cd.bookings.slots * cd.facilities.membercost
    END AS cost
FROM cd.members
INNER JOIN cd.bookings
    ON cd.members.memid = cd.bookings.memid
INNER JOIN cd.facilities
    ON cd.bookings.facid = cd.facilities.facid
WHERE cd.bookings.starttime BETWEEN '2012-09-14 00:00:00.000000'
                            AND '2012-09-14 23:59:59.999999'
    AND (cd.members.memid = 0 AND cd.bookings.slots * cd.facilities.guestcost > 30
         OR cd.members.memid != 0 AND cd.bookings.slots * cd.facilities.membercost > 30)
ORDER BY cost DESC;

--- Produce a list of all members, along with their recommender, using no joins.
SELECT DISTINCT cd.members.firstname || ' ' || cd.members.surname AS member,
    (SELECT recommenders.firstname || ' ' || recommenders.surname AS recommender
        FROM cd.members AS recommenders
        WHERE cd.members.recommendedby = recommenders.memid
    )
FROM cd.members
ORDER BY member;

