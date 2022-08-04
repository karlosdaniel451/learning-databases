--- Find all students that have above-average GPAs
SELECT *
FROM students
WHERE students.GPA > (
    SELECT AVG(students.GPA)
    FROM students
);

--- Calculate the average number of students in classes where the teacher
--- teaches History or English
SELECT AVG(classes.number_of_students)
FROM classes
WHERE classes.teacher_id IN (
    SELECT teachers.id
    FROM teachers
    WHERE teachers.subject IN ('History', 'English')
);

--- Show all information about the students in the class with the highest 
--- number of students
SELECT *
FROM students
WHERE students.class_id IN (
    SELECT classes.id
    FROM classes
    WHERE classes.number_of_students = (
        SELECT MAX(classes.number_of_students)
        FROM classes
    )
);


--- Retrieve the films that have a greater length than the average
--- length of their category.
--  WITH cte_average_length_of_film_by_category AS (
--      SELECT
--          film_category_id,
--          AVG(film.length) AS average_length
--      FROM
--          film
--      INNER JOIN film_category
--          ON film.film_id = film_category.film_id
--      GROUP BY
--          film.category_id
--  )
--  SELECT
--      film.film_id,
--      film.title,
--      film.release_year,
--      film.length
--  FROM
--      film
--  WHERE
--      film.length > (
--          SELECT
--              cte_average_length_of_film_by_category.average_length
--          FROM
--              cte_average_length_of_film_by_category
--          WHERE
--              film.c
--      )
--  ;


--- The following example returns the maximum length of film grouped by
--- film category.
SELECT
    MAX(film.length)
FROM
    film
INNER JOIN film_category
    ON film.film_id = film_category.film_id
GROUP BY
    category_id;


--- Following statement finds the films whose lengths are greater than
--- or equal to the maximum length of any film category.
SELECT
    film.film_id,
    film.title,
    film.release_year,
    film.length
FROM
    film
WHERE
    film.length >= ANY (
        SELECT
            MAX(film.length)
        FROM
            film
        INNER JOIN film_category
            ON film.film_id = film_category.film_id
        GROUP BY
            category_id
    )
;


--- To find all films whose lengths are greater than the list of the
--- average lengths grouped by rating, you use the ALL and greater than
--- operator --- (>) as follows:
SELECT
    film.film_id,
    film.title,
    film.release_year,
    film.length
FROM film
WHERE
    film.length > ALL (
        SELECT
            ROUND(AVG(film.length), 2)
        FROM
            film
        GROUP BY
            film.rating
    )
ORDER BY
    film.length;


--- Find customers who have at least one payment whose amount is greater
--- than 11.
SELECT
    customer.customer_id,
    customer.first_name || ' ' || customer.last_name AS customer_name,
    customer.email
FROM
    customer
WHERE
    EXISTS (
        SELECT
            1
        FROM
            payment
        WHERE
            payment.customer_id = customer.customer_id AND
            payment.amount > 11
    )
ORDER BY
    customer_name;



