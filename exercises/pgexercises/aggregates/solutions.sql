--- Count the number of facilities 
SELECT
	COUNT(*)
FROM
	cd.facilities;


--- Count the number of expensive facilities
SELECT
	COUNT(*)
FROM
	cd.facilities
WHERE
	cd.facilities.guestcost > 10;


