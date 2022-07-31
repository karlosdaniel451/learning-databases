/*
Suppose you want to label the films by their length based on the following logic:
    - If the lengh is less than 50 minutes, the film is short.
    - If the length is greater than 50 minutes and less than or equal to 120 minutes, the film is medium.
    - If the length is greater than 120 minutes, the film is long.
*/

SELECT
    film_id, title, length, release_year,
    CASE
        WHEN length <= 50 THEN 'short'
        WHEN length > 50 AND length <= 120 THEN 'medium'
        ELSE 'long'
    END duration_label
FROM
    film;
ORDER BY
    title;

/*
Suppose that you want to assign price segments to films with the following logic:

    If the rental rate is 0.99, the film is economic.
    If the rental rate is 1.99, the film is mass.
    If the rental rate is 4.99, the film is premium.

And you want to know the number of films that belong to economy, mass, and premium.
*/
--  SELECT
--      film_id, title, rental_rate,
--      CASE
--          WHEN rental_rate = 0.99 THEN 'economic'
--          WHEN rental_rate = 1.99 THEN 'mass'
--          WHEN rental_rate = 4.99 THEN 'premium'
--      END AS price_segment,
--      (
--          SELECT
--              COUNT(*)
--          FROM
--              film
--          WHERE price_segment = 'economic'
--      ),
--      (
--          SELECT
--              COUNT(*)
--          FROM
--              film
--          WHERE price_segment = 'mass'
--      ),
--      (
--          SELECT
--              COUNT(*)
--          FROM
--              film
--          WHERE price_segment = 'premium'
--      )
--  FROM
--      film
--  ORDER BY
--      title;

/*
--- If we know that the values for each price segments wont' change:
SELECT
    DISTINCT
    (SELECT
        COUNT(*)
    FROM
        film
    WHERE
        film.rental_rate = 0.99
    ),
    (SELECT
        COUNT(*)
    FROM
        film
    WHERE
        film.rental_rate = 2.99
    ),
    (SELECT
        COUNT(*)
    FROM
        film
    WHERE
        film.rental_rate = 4.99
    )
FROM film;
 */

SELECT
    SUM(
        CASE rental_rate
            WHEN 0.99 THEN 1
            ELSE 0
        END
    ) AS "economy_counter",
    SUM(
        CASE rental_rate
            WHEN 2.99 THEN 1
            ELSE 0
        END
    ) AS "mass_counter",
    SUM(
        CASE rental_rate
            WHEN 4.99 THEN 1
            ELSE 0
        END
    ) AS "premium_counter"
FROM
    film;


/*
In this example, we used a simple CASE expression to compare the
rating from the film table with some literal values like G, PG, NC17,
PG-13 and return the corresponding rating description.
*/

SELECT
    title, release_year, rating,
    CASE rating
        WHEN 'G' THEN 'General Audiences'
        WHEN 'PG' THEN 'Parental Guidance Suggested'
        WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
        WHEN 'R' THEN 'Restricted'
        WHEN 'NC-17' THEN 'Adults Only'
    END rating_description
FROM
    film;


/*
The following statement uses CASE expression with the SUM function to
calculate the number of films in each rating:
 */
SELECT
    SUM
    (
        CASE film.rating
            WHEN 'G' THEN 1
            ELSE 0
        END
    ) AS "General audiences count",
    SUM
    (
        CASE film.rating
            WHEN 'PG' THEN 1
            ELSE 0
        END
    ) AS "Parental Guidance count",
    SUM
    (
        CASE film.rating
            WHEN 'PG-13' THEN 1
            ELSE 0
        END
    ) AS "Parents Strongly Cautioned count",
    SUM
    (
        CASE film.rating
            WHEN 'R' THEN 1
            ELSE 0
        END
    ) AS "Restricted count",
    SUM
    (
        CASE film.rating
            WHEN 'NC-17' THEN 1
            ELSE 0
        END
    ) AS "Adults Only count"
FROM
    film;


