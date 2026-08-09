
--SUBQUERY: A query inside another query.

--A) RESULT TYPES

      --1) Scalar Subquery: Returns on only one single value
SELECT
AVG(Sales) AvgSales
FROM Sales.Orders

      --2)Row Subquery : Returns multiple rows and single column
SELECT CustomerID
FROM Sales.Orders

      --3)Table Subquery : Returns multiple rows and multiple columns
SELECT OrderID, OrderDate
FROM Sales.Orders


--B) LOCATION | CLAUSES

       --1) FROM Clause: Used as temporary table for the main query.

/*Find the products that have a price higher than the average price of all products*/

--Main Query
SELECT *
FROM
    --SubQuery
	(SELECT ProductID, Price,
	AVG(Price) OVER () AvgPrice
	FROM Sales.Products)t
WHERE Price > AvgPrice

/*Rank customers based on their total amount of sales*/

SELECT *, RANK() OVER (ORDER BY TotalSales DESC) CustRank
FROM
    --SubQuery
	(SELECT CustomerID,
	SUM(Sales) TotalSales
	FROM Sales.Orders
	GROUP BY CustomerID)t



        --2) SELECT Clause: Used to aggregate data side by side with the main query's data allowing for direct comparison

/*Show the product IDs, product names, prices, and the total number of orders*/
--Main Query
SELECT 
	ProductID, 
	Product, 
	Price ,
	--SubQuery
	(SELECT COUNT(*) FROM Sales.Orders) AS TotalOrders
FROM Sales.Products

       --3) JOIN Clause: Used to prepare the data(filtering or aggregation) before joining it with other tables.

/* Show all the customer details and find the total orders of each customer*/
--Main Query
SELECT c.*,o.TotalOrders
FROM Sales.Customers c
LEFT JOIN
    --Subquery
	(SELECT CustomerID, COUNT(*) TotalOrders
	FROM Sales.Orders
	GROUP BY CustomerID) o
ON c.CustomerID = o.CustomerID



       --4) WHERE Clause: Used for complex filtering logic and makes query more flexible and dynamic

            --a) Comparison Operators: Used to filter data by comparing two values

/*Find the products that have a price higher than the average price of all products*/
--Main Query
SELECT 
	ProductID, 
	Price, 
	(SELECT AVG(Price) FROM Sales.Products) AvgPrice
FROM Sales.Products
WHERE Price > (SELECT AVG(Price) FROM Sales.Products)  

          --b) Logical Operators: 

	            -- IN Operators: Checks whether a value matches any value from a list

/* Show the details of orders made by customers in Germany*/
SELECT * 
FROM Sales.Orders
WHERE CustomerID IN  
            --Subquery        
            (SELECT CustomerID 
			FROM Sales.Customers
			WHERE Country = 'Germany')

   
 
                -- ANY Operator: Used to check if a value is true for ATLEAST one of the values in a list

/* Find female employees whose salaries are greater than the salaries of any male employess */
--Main Query 
SELECT EmployeeID, FirstName,Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ANY 
            --Subquery        
            (SELECT Salary
			FROM Sales.Employees
			WHERE Gender = 'M')


               -- ALL Operator: Checks if a value matches ALL values within a list

	 /* Find female employees whose salaries are greater than the salaries of all male employess */
--Main Query 
SELECT EmployeeID, FirstName,Salary
FROM Sales.Employees
WHERE Gender = 'F'
AND Salary > ALL 
            --Subquery        
            (SELECT Salary
			FROM Sales.Employees
			WHERE Gender = 'M')


			-- EXIST Operator: Check if the subquery returns any rows

/* Show the details of orders made by customers in Germany*/
--Main Query
SELECT * 
FROM Sales.Orders o
WHERE EXISTS  
            --Subquery        
            (SELECT 1
			FROM Sales.Customers c
			WHERE Country = 'Germany' AND o.CustomerID = c.CustomerID )


--C) DEPENDENCY

    --1) Non-Correlated Subquery: that can run independently from the Main Query
	--2) Correlated Subquery: that relies on values from the Main Query

/*Show all customer details and find the total number of orders of each customer (Example of Correlated Subquery) */

SELECT * , 
(SELECT COUNT(*) FROM Sales.Orders o WHERE o.CustomerID = c.CustomerID) TotalOrders
FROM Sales.Customers c














