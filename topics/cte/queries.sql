/* Retrieve the film_id, title, length for each film that is in the
category 'Long', i.e., whose length is greater than or equal to 90. */
WITH cte_film AS (
    SELECT
        film_id,
        title,
        length,
        (CASE
            WHEN length < 30 THEN 'Short'
            WHEN length < 90 THEN 'Medium'
            ELSE 'Long'
        END) AS "length_label"
    FROM
        film
)
SELECT
    film_id,
    title,
    length
FROM
    cte_film
WHERE
    length_label = 'Long'
ORDER BY
    title;


/* Retrieve the staff_id, staff's last name and number of rentals
made by each staff. */
WITH cte_rental AS (
    SELECT
        staff_id,
        COUNT(rental_id) AS rental_count
    FROM
        rental
    GROUP BY
        staff_id
)
SELECT
    staff.staff_id,
    staff.last_name,
    cte_rental.rental_count
FROM
    staff
INNER JOIN cte_rental
    ON staff.staff_id = cte_rental.staff_id;


/* Retrive the country_id, country's name and number of cities
registered for the top 10 countries with most cities registered. */
WITH cte_city AS (
    SELECT
        country_id,
        COUNT(city_id) AS city_count
    FROM
        city
    GROUP BY
        country_id
)
SELECT
    country.country_id,
    country.country,
    cte_city.city_count
FROM
    country
INNER JOIN cte_city
    ON country.country_id = cte_city.country_id
ORDER BY
    cte_city.city_count DESC
LIMIT 10;


