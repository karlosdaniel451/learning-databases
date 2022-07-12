/*
SELECT city.name
FROM city, country
WHERE city.countrycode = country.code
        AND country.continent = 'Africa'
*/

SELECT city.name
FROM city
INNER JOIN country
    ON city.countrycode = country.code
WHERE country.continent = 'Africa'

