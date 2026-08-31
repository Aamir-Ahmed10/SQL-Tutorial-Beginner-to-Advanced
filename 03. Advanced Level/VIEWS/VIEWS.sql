
-- SQL SERVER : stores, manages, and provides access to databases for users or applications.

--DATABASE: Collection of information that is stored in a structured way.

--SCHEMA: Logical layer that  groups related objects together.

--TABLE: a place where data is stored and organized into rows and columns.

/*VIEW: virtual table based on the result set of a query, without storing the data in database.
        Views are persisted SQL queries in the database.*/

/* USE CASE #1 - Central Complex Query Logic : 
                Store central, complex query logic in the database for access by multiple queries, reducing project complexity.*/

-- Find the running total of sales for each month
WITH CTE_Monthly_Summary AS (
	SELECT 
	DATETRUNC(month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQunatities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)
SELECT OrderMonth, TotalSales,
SUM(TotalSales) OVER (ORDER BY OrderMonth) AS RunningTotal
FROM CTE_Monthly_Summary



CREATE VIEW V_Monthly_Summary AS
(
SELECT 
	DATETRUNC(month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQunatities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)



SELECT * 
FROM V_Monthly_Summary

--Querying the same running total task with VIEW instead of CTE


SELECT OrderMonth, TotalSales,
SUM(TotalSales) OVER (ORDER BY OrderMonth) AS RunningTotal
FROM V_Monthly_Summary


/*NOTE: If a TABLE or VIEW is created without specifying a schema, it deafults to the DBO.
        while creating VIEW specify the schema as shown below: */


CREATE VIEW Sales.V_Monthly_Summary AS
(
SELECT 
	DATETRUNC(month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders,
	SUM(Quantity) TotalQunatities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)


DROP VIEW V_Monthly_Summary



-- If you want to make changes in the VIEW , you can use CREATE OR REPLACE (as shown below) in PostGreSQL but SQL Server doesn't support it.
CREATE OR REPLACE VIEW Sales.V_Monthly_Summary AS
(
/*QUERY*/
)

/*In SQL Server, you'll have to DROP the VIEW first and then Recreate it with changes or 
use T-SQL : Transact-SQL is an extension of SQL that adds programming features. (as shown below)*/

IF OBJECT_ID ('Sales.V_Monthly_Summary', 'V') IS NOT NULL
   DROP VIEW Sales.V_Monthly_Summary;
GO
CREATE VIEW Sales.V_Monthly_Summary AS
(
SELECT 
	DATETRUNC(month, OrderDate) OrderMonth,
	SUM(Sales) TotalSales,
	COUNT(OrderID) TotalOrders  -- we made change to the VIEW and removed the line: SUM(Quantity) TotalQunatities
	FROM Sales.Orders
	GROUP BY DATETRUNC(month, OrderDate)
)



--Provide a view that combines details from ordes, products, customers, and employees.
CREATE VIEW Sales.V_Order_Details AS (
	SELECT o.OrderID, o.OrderDate, 
	--ProductID, CustomerID, SalesPersonID, 
	o.Sales, o.Quantity, p.Product, p.Category,
	COALESCE(c.FirstName,'')+ ' ' +COALESCE(c.LastName,'') AS CustomerName, c.Country AS CustomerCountry,
	COALESCE(e.FirstName,'')+ ' ' +COALESCE(e.LastName,'') AS SalesPersonName, e.Department
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
	ON p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID = o.SalesPersonID
)



SELECT * FROM Sales.V_Order_Details



--VIEWS USE CASE : USe views to enforce security and protect sensitive data, by hiding columns and/or rows from tables.

/* Provide a view for EU Sales Team that combines details from All tables and excludes data related to the USA*/

CREATE VIEW Sales.V_Order_Details_EU AS (
	SELECT o.OrderID, o.OrderDate, 
	--ProductID, CustomerID, SalesPersonID, 
	o.Sales, o.Quantity, p.Product, p.Category,
	COALESCE(c.FirstName,'')+ ' ' +COALESCE(c.LastName,'') AS CustomerName, c.Country AS CustomerCountry,
	COALESCE(e.FirstName,'')+ ' ' +COALESCE(e.LastName,'') AS SalesPersonName, e.Department
	FROM Sales.Orders o
	LEFT JOIN Sales.Products p
	ON p.ProductID = o.ProductID
	LEFT JOIN Sales.Customers c
	ON c.CustomerID = o.CustomerID
	LEFT JOIN Sales.Employees e
	ON e.EmployeeID = o.SalesPersonID
    WHERE c.Country != 'USA'
)


--VIEWS USE CASE : Views can be used as Data Marts in Data Warehouse System because they provide a flexible and efficient way to present data.
