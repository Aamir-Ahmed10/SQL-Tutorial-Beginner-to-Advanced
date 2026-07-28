
/*WHAT IS NULL 
NULL means nothing, unknown !
NULL is not equal to anything.
NULL is not zero
NULL is not empty string
NULL is not blank space */


--ISNULL function: Replaces 'NULL' with a specified value
--Syntax: ISNULL(value, replacement_value)

--COALESCE Function: Returns the first non-null value from a list
--Syntax: COALESCE(value1, value2, value3, .....)


--Find the average scores of the customers
SELECT CustomerID, Score,
COALESCE(Score, 0) Score2,
AVG(Score) OVER () AvgScores,
AVG(COALESCE(Score, 0)) OVER() AvgScores2
FROM Sales.Customers



/* Display the full name of the customers in a single field by merging their 1st and last names,
and add 10 bonus points to each customers' score*/

SELECT CustomerID, FirstName,LastName,
FirstName + ' ' + COALESCE(LastName,'') AS FullName,
Score, 
COALESCE(Score,0) + 10 AS Score_with_Bonus
FROM Sales.Customers


/*Handling NULL with JOINS (explaining with just example)
SELECT a.year, a.type, a.orders, b.sales
FROM Table1 a
JOIN Table2 b
ON a.year = b.year
AND ISNULL (a.year, '') = (b.year, '')
*/

--Sort the customers from lowest to highest scores with nulls appearing last
SELECT CustomerID, Score,
CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score 


--NULLIF Function: Compares 2 expression returns: 1)NULL, if they are equal 2)First Value, if they are not equal
--Syntax: NULLIF(value1, value2)

--Find the sales price for each order by dividing sales by quantity
SELECT OrderID , Sales, Quantity,
Sales/NULLIF(Quantity,0) AS Price
FROM Sales.Orders

--IS NULL : Returns TRUE if the value IS NULL, Otherwise FALSE
--IS NOT NULL : Returns TRUE if the value IS NOT NULL, Otherwise FALSE
--Syntax: Value IS NULL , Value IS NOT NULL

--Identify the customers who has no scores
SELECT * 
FROM Sales.Customers
WHERE Score IS NULL

--List of all the customers who has scores
SELECT * 
FROM Sales.Customers
WHERE Score IS NOT NULL


--List all details for customers who have not placed any orders
SELECT c.*, o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL  /* Can also use o.CustomerID IS NULL*/


-- NULL vs Empty vs Space
/*NULL: means nothing, unknown  
EMPTY STRING'': String value has zero characters 
BLANK SPACE' ': String value has 1 or more space characters */

WITH Orders AS (
SELECT 1 Id, 'A' Category UNION
SELECT 2, NULL UNION
SELECT 3, '' UNION
SELECT 4 , '  ' 
)
SELECT *,
(TRIM(Category)) Policy1,   --Data Policy 1 : Only use NULL and empty strings, but avoid blank space
NULLIF(TRIM(Category),'') Policy2,  --Data Policy 2 : Only use NULLS and avoid using empty strings and blank spaces
COALESCE(NULLIF(TRIM(Category), '') , 'Unknown') Policy3  --Data Policy 3 : Use default value 'unknown' and avoid using NULLs,empty strings and blank spaces
FROM Orders



