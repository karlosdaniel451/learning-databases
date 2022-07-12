/*
SELECT SUM(city.population)
FROM city, country
WHERE city.countrycode = country.code
        AND country.continent = 'Asia'
*/

SELECT SUM(city.population)
FROM city
INNER JOIN country
    ON city.countrycode = country.code
WHERE country.continent = 'Asia'

