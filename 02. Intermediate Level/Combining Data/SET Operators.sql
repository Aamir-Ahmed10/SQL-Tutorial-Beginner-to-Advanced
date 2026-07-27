
/*                              SET OPERATORS
Rule#1 SQL CLauses: SET Operator can be used almost in all clauses WHERE|JOIN|GROUP BY|HAVING
                    ORDER BY is allowed only once at the end of query
Rule#2 No. of Columns in each query must be the same
Rule#3 Data Types of each query must be compatible
Rule#4 Order of columns in each query must be the same
Rule#5 Column Aliases: Column names in the result set are determined by the column names specified in the 1st query
Rule#6 Correct Columns: Even if all rules are met and SQL shows no errors, the result may be incorrect
                        Incorrect column selection leads to inaccurate results*/

/*UNION   Returns all distinct rows from both queries
          Remove duplicate rows from the result*/

--Combine the data from employees and customers into one table

SELECT FirstName, LastName
FROM sales.Customers 

UNION

SELECT FirstName, LastName
FROM Sales.Employees


/* UNION ALL  Returns all rows from both queries, including duplicates */

--Combine the data from employees and customers into one table,including duplicates

SELECT FirstName, LastName
FROM sales.Employees 

UNION ALL

SELECT FirstName, LastName
FROM Sales.Customers


/* EXCEPT (MINUS)  Returns all distinct rows from the first query that are not found in the second query.
                   Its the only one where the order of queries affects the final result.*/

-- Find the employees who aren't customers at the same time

SELECT FirstName, LastName
FROM sales.Employees 

EXCEPT

SELECT FirstName, LastName
FROM Sales.Customers



/* INTERSECT Returns only the rows that are common in both queries*/

--Find the employees who are also customers

SELECT FirstName, LastName
FROM sales.Employees 

INTERSECT

SELECT FirstName, LastName
FROM Sales.Customers


/* Orders are stored in seperate tables (Orders and OrdersArchive).
Combine all orders into one report withoutt duplicates.*/

SELECT 
'Orders' AS SourceTable,[OrderID],[ProductID],[CustomerID],[SalesPersonID],[OrderDate],[ShipDate]
      ,[OrderStatus],[ShipAddress],[BillAddress],[Quantity],[Sales],[CreationTime]
FROM sales.Orders

UNION

SELECT 
'OrdersArchive' AS SourceTable,[OrderID],[ProductID],[CustomerID],[SalesPersonID],[OrderDate],[ShipDate]
      ,[OrderStatus],[ShipAddress],[BillAddress],[Quantity],[Sales],[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID

