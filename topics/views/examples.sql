CREATE VIEW film_category_info
AS
SELECT
    film.film_id,
    film.title,
    film.release_year,
    category.category_id,
    category.name AS category_name
FROM film
INNER JOIN film_category
    ON film.film_id = film_category.film_id
INNER JOIN category
    ON film_category.category_id = category.category_id;



CREATE VIEW customer_info AS
    SELECT
        customer.customer_id,
        customer.first_name,
        customer.last_name,
        customer.email,
        customer.store_id,
        --  customer.activebool,
        (
            CASE
                WHEN customer.activebool THEN 'active'
                ELSE ''
            END
        ) AS notes,
        address.address,
        address.phone,
        address.postal_code,
        city.city,
        country.country
    FROM
        customer
    INNER JOIN address  
        ON customer.address_id = address.address_id
    INNER JOIN city
        ON address.city_id = city.city_id
    INNER JOIN country
        ON city.country_id = country.country_id;



CREATE VIEW total_length_by_category
AS
SELECT
    category.category_id,
    category.name,
    SUM(film.length) total_length_in_minutes
FROM
    category
INNER JOIN film_category
    ON category.category_id = film_category.category_id
INNER JOIN film
    ON film_category.film_id = film.film_id
GROUP BY
    category.category_id
ORDER BY
    total_length_in_minutes DESC


