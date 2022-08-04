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


/* Retrieve the name and e-mail of the 30 customers who did most
rentals. */
WITH cte_rental_count_by_customer AS (
    SELECT
        customer_id,
        COUNT(*) AS rental_count
    FROM
        rental
    GROUP BY
        customer_id
)
SELECT
    customer.customer_id,
    customer.first_name || ' ' || customer.last_name AS customer_name,
    cte_rental_count_by_customer.rental_count
FROM
    customer
INNER JOIN cte_rental_count_by_customer
    ON customer.customer_id = cte_rental_count_by_customer.customer_id
ORDER BY
    cte_rental_count_by_customer.rental_count DESC
LIMIT 30;


/* Retrieve the 30 countries with more rentals. */
WITH cte_rental_count_by_country AS (
    SELECT
        country.country_id,
        COUNT(*) rental_count
    FROM
        rental
    INNER JOIN customer
        ON rental.customer_id = customer.customer_id
    INNER JOIN address
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id
    GROUP BY
        country.country_id
)
SELECT
    country.country_id,
    country.country,
    cte_rental_count_by_country.rental_count
FROM
    country
INNER JOIN cte_rental_count_by_country
    ON country.country_id = cte_rental_count_by_country.country_id
ORDER BY
    cte_rental_count_by_country.rental_count DESC
LIMIT 30;


/* Retrieve the sum of the rents of the 10 countries with the most rents. */
WITH cte_rental_count_by_country AS (
    SELECT
        country.country_id,
        COUNT(*) rental_count
    FROM
        rental
    INNER JOIN customer
        ON rental.customer_id = customer.customer_id
    INNER JOIN address
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id
    GROUP BY
        country.country_id
)
SELECT
    SUM(cte_rental_count_by_country.rental_count)
FROM
    cte_rental_count_by_country
WHERE
    cte_rental_count_by_country.country_id IN (
        SELECT
            country.country_id
        FROM
            country
        INNER JOIN cte_rental_count_by_country
            ON country.country_id = cte_rental_count_by_country.country_id
        ORDER BY
            cte_rental_count_by_country.rental_count DESC
        LIMIT 10
);
