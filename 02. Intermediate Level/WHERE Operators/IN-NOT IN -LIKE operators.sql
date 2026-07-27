
--Retrieve all the customers from either Germany or USA (IN operator)
SELECT *
FROM Customers
WHERE country IN ('Germany','USA')


--Retrieve all the customers who are not from Germany and USA (NOT IN operator)
SELECT *
FROM Customers
WHERE country NOT IN ('Germany','USA')


--Find all the customers whose first name starts with 'M' (% and _ LIKE operator)
SELECT *
FROM Customers
WHERE first_name LIKE 'M%'

--Find all the customers whose first name ends with 'n' (% and _ LIKE operator)
SELECT *
FROM Customers
WHERE first_name LIKE '%n'

--Find all the customers whose first name contains 'r' (% and _ LIKE operator)
SELECT *
FROM Customers
WHERE first_name LIKE '%r%'

--Find all the customers whose first name has 'r' at the 3rd position (% and _ LIKE operator)
SELECT *
FROM Customers
WHERE first_name LIKE '__r%'