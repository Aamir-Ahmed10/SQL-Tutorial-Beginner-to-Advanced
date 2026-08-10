
                                           --CTE (COMMON TABLE EXPRESSION)
-- Temporary , named result set (virtual table) that can be used multiple times within your query to simplify and organize complex query 

                               /*NON RECURSIVE CTE: is executed only once without any repetition*/

--1) STANDALONE CTE : Defined and Used independently. Runs independently as it's self contained and doesn't rely on other CTEs or queries.
--2) NESTED CTE: CTE inside another CTE. A Nested CTE uses the result of another CTE, so it can't run independently.

--Step 1 : Find the total sales per customer (If we execute just step 1 with main query , its an example of standalone CTE)
WITH CTE_Total_Sales AS
(SELECT CustomerID, SUM(Sales) AS TotalSales
FROM Sales.Orders
GROUP BY CustomerID)

--Step 2: Find the last order date for each customer (If we execute step 1,2 with main query , its an example of multiple standalone CTE)
, CTE_Last_Order AS
(SELECT CustomerID, MAX(OrderDate) Last_Order
FROM Sales.Orders
GROUP BY CustomerID)

--Step 3: Rank customers based on total sales per customer (If we execute step 1,3 with main query , its an example of Nested CTE)
, CTE_Customer_Rank AS
(SELECT CustomerID, TotalSales, RANK() OVER (ORDER BY TotalSales DESC) AS CustomerRank
FROM CTE_Total_Sales)

--Step 4: Segment Customers based on their total sales (If we execute step 1,4 with main query , its an example of Nested CTE)
, CTE_Customer_Segment AS
(SELECT CustomerID, 
CASE WHEN TotalSales > 100 THEN 'High'
     WHEN TotalSales > 80 THEN 'Mid'
	 ELSE 'Low'
END CustomerSegments
FROM CTE_Total_Sales)

--Main Query
SELECT c.CustomerID , C.FirstName, c.LastName, cts.TotalSales, clo.Last_Order, ccr.CustomerRank, ccs.CustomerSegments
FROM Sales.Customers c
LEFT JOIN CTE_Total_Sales cts
ON cts.CustomerID = c.CustomerID
LEFT JOIN CTE_Last_Order clo
ON clo.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Rank ccr
ON ccr.CustomerID = c.CustomerID
LEFT JOIN CTE_Customer_Segment ccs
ON ccs.CustomerID = c.CustomerID



                  /*RECURSIVE CTE: self referencing query that repeatedly processes data until a specific condition is met*/

--Generate a sequence of numbers from 1 to 20

WITH Series AS (
	--Anchor query
	SELECT 
	1 AS MyNumber

	UNION ALL
	--Recursive Query
	SELECT MyNumber + 1 
    FROM Series
	WHERE MyNumber < 20	
)
--Main Query
SELECT * 
FROM Series
OPTION (MAXRECURSION 5000)  -- with this we can control how many iterations are allowed in the query , as default is 100. 


-- Show the employee hierarchy by displaying each employee's level within the organisation

WITH CTE_Emp_Hierarchy AS 
(
        --Anchor query
		SELECT EmployeeID, FirstName, ManagerID, 1 AS Level
		FROM Sales.Employees
		WHERE ManagerID IS NULL

		UNION ALL

		--Recursive query
		SELECT e.EmployeeID, e.FirstName, e.ManagerID, Level +1
		FROM Sales.Employees AS e
		INNER JOIN CTE_Emp_Hierarchy ceh
		ON e.ManagerID = ceh.EmployeeID
)
--Main Query
SELECT *
FROM CTE_Emp_Hierarchy






























