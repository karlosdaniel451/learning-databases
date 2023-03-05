--- Empty Neighborhoods
SELECT
    neighborhoods.name
FROM
    neighborhoods
WHERE
    neighborhoods.id NOT IN
        (SELECT neighborhood_id
         FROM users)

--- Alternative solution:
SELECT
    neighborhoods.name
FROM
    neighborhoods
LEFT JOIN users
    ON neighborhoods.id = users.neighborhood_id
WHERE
    users.id IS NULL

--- Alternative solution
SELECT
    neighborhoods.name
FROM
    neighborhoods
WHERE
    NOT EXISTS
        (SELECT 1
         FROM users
         WHERE neighborhoods.id = users.neighborhood_id)


--- Manager Team Sizes
SELECT
    managers.name AS manager,
    COUNT(employees.id) as team_size
FROM
    managers
INNER JOIN employees
    ON managers.id = employees.manager_id
GROUP BY
    managers.id
ORDER BY
    team_size DESC
LIMIT 1

--- Alternative solution:
WITH team_size_by_manager AS (
    SELECT managers.*, COUNT(employees.id) AS team_size
    FROM managers
    INNER JOIN employees
        ON managers.id = employees.manager_id
    GROUP BY managers.id
)
SELECT
    managers.name AS manager,
    team_size_by_manager.team_size
FROM
    managers
INNER JOIN team_size_by_manager
    ON managers.id = team_size_by_manager.id
WHERE
    team_size_by_manager.team_size = 
        (SELECT MAX(team_size_by_manager.team_size)
         FROM team_size_by_manager)


--- Employee Salaries
SELECT
    SUM(
        CASE
            WHEN employees.salary > 100000 THEN 1
            ELSE 0
        END
    ) / COUNT(employees.id) AS percentage_over_100k,
    departments.name AS department_name,
    COUNT(employees.id) AS number_of_employees
FROM
    departments
INNER JOIN employees
    ON departments.id = employees.department_id
GROUP BY
    departments.id
HAVING
    COUNT(employees.id) >= 10
ORDER BY
    percentage_over_100k DESC
LIMIT 3 


SELECT d.name AS department_name,
           COUNT(DISTINCT e.id) AS number_of_employees,
           COUNT(DISTINCT CASE WHEN salary > 100000 THEN e.id ELSE NULL END)/COUNT(DISTINCT e.id) AS percentage_over_100k
FROM employees e 
JOIN departments d 
    ON e.department_id = d.id 
GROUP BY
    percentage_over_100k
HAVING
    COUNT(DISTINCT e.id) >= 10
ORDER BY 3 DESC 
LIMIT 3

SELECT CAST(SUM(
        CASE WHEN 
            salary > 100000 THEN 1 ELSE 0 
        END) AS DECIMAL
      )/COUNT(*) AS percentage_over_100k
      , d.name as department_name
      , COUNT(*) AS number_of_employees
FROM departments AS d
LEFT JOIN employees AS e
    ON d.id = e.department_id
GROUP BY d.name
HAVING COUNT(*) >= 10
ORDER BY 1 DESC
LIMIT 3

