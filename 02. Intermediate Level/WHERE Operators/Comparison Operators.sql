
-- Retrieve all the customers from Germany (= equal to operator)
SELECT *
FROM Customers
WHERE country = 'Germany'


--Retrieve all the customers who are not from Germany (!= <> not equal to operator)
SELECT *
FROM Customers
WHERE country != 'Germany'

--Retrieve all the customers with score greater than 500 (> greater than operator)
SELECT *
FROM Customers
WHERE score > 500


--Retrieve all the customers with score 500 or more (>= greater than equal to operator)
SELECT *
FROM Customers
WHERE score >= 500


--Retrieve all the customers with score less than 500 (< less than operator)
SELECT *
FROM Customers
WHERE score < 500


--Retrieve all the customers with score 500 or less (<= less than equal to operator)
SELECT *
FROM Customers
WHERE score <= 500











