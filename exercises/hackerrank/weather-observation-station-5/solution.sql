SELECT station.city, LENGTH(city) as city_name_length
FROM station
ORDER BY city_name_length DESC, station.city ASC
LIMIT 1;

SELECT station.city, LENGTH(city) as city_name_length
FROM station
ORDER BY city_name_length ASC, station.city ASC
LIMIT 1;

