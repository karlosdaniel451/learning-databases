--- Retrive the country with most cities registered in the database.

-- Retrive the country id with most cities registered.

SELECT
    ocurrencies,
    country.country_id
FROM
    country
WHERE
    country.country_id = (
        SELECT
            count(*) AS ocurrencies,
            city.country_id
        FROM
            city
        GROUP BY
            city.country_id
        ORDER BY 
            count DESC
            LIMIT 10
    );


