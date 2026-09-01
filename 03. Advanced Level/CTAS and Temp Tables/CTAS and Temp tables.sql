
--DB TABLE: A table is a structured collection  of data, similar to a spreadsheet or grid (Excel).

--Qureying Views is slower than quering CTAS tables


--Create a table that shows total number f orders for each month
SELECT
	DATENAME(month, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)


SELECT * FROM Sales.MonthlyOrders

DROP TABLE Sales.MonthlyOrders

--To Refresh/Update CTAS , it will be same as we did with the VIEWS either dropping and recreating it or with T-SQL as follows
IF OBJECT_ID ('Sales.MonthlyOrders', 'U') IS NOT NULL
   DROP TABLE Sales.MonthlyOrders;
GO
SELECT
	DATENAME(month, OrderDate) OrderMonth,
	COUNT(OrderID) TotalOrders
INTO Sales.MonthlyOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate)


-- CTAS is also used to create data snapshot
-- Its also used for physical data marts in DWH - persisting the data marts of a DWH improves the speed of data retrieval compared to using views

--TEMPROARY TABLE: Stores intermiediate results in temproary storage within the DB during the session and DB will drop all these tables once session ends.

--SESSION: The time between connecting to and disconnecting from the database.


SELECT * 
INTO #Orders
FROM Sales.Orders


