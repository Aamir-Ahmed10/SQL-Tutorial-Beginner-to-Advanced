
--Retrieve all the customers from USA AND have score greater than 500 (AND operator)
SELECT *
FROM Customers
WHERE country = 'USA' AND score > 500


--Retrieve all the customers who are either from USA OR have score greater than 500 (OR operator)
SELECT *
FROM Customers
WHERE country = 'USA' OR score > 500


--Retrieve all the customers with score not less than 500 (NOT operator)
SELECT *
FROM Customers
WHERE NOT score < 500



--Retrieve all the customers whose score falls between 100 and 500 (BETWEEN operator)

SELECT *
FROM Customers
WHERE score >= 100 AND score <= 500


SELECT *
FROM Customers
WHERE score BETWEEN 100 AND 500
