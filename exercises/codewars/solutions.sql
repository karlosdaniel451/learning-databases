--- SQL Basics: Top 10 customers by total payments amount
SELECT
  customer.customer_id,
  customer.email,
  COUNT(payment.payment_id) as payments_count,
  CAST(SUM(payment.amount) AS FLOAT) as total_amount
FROM
  customer
INNER JOIN payment
  ON customer.customer_id = payment.customer_id
GROUP BY
  customer.customer_id
ORDER BY
  total_amount DESC
LIMIT 10


--- SQL with Sailor Moon: Thinking about JOINs...
SELECT
  sailorsenshi.senshi_name AS sailor_senshi,
  sailorsenshi.real_name_jpn AS real_name,
  cats.name AS cat,
  schools.school
FROM
  sailorsenshi
LEFT JOIN schools 
  ON sailorsenshi.school_id = schools.id
LEFT JOIN cats
  ON sailorsenshi.cat_id = cats.id
