
--4X RULES 
--        1) Window Function can be used only in SELECT and ORDER BY clauses. Can't be used to filter data like WHERE or GROUP BY

SELECT OrderID, OrderDate,Sales,OrderStatus,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
ORDER BY SUM(Sales) OVER(PARTITION BY OrderStatus) DESC


--		2) Nesting Window Function is not allowed

SELECT OrderID, OrderDate,Sales,OrderStatus,
SUM(SUM(Sales) OVER(PARTITION BY OrderStatus)) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders

--Above query will give an error as Nesting Window Function is not allowed


--		3) SQL execute WINDOW function after WHERE clause

--Find the total sales for each order status only for two products 101 and 102

SELECT OrderID, OrderDate,Sales,OrderStatus,
SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN (101,102)

--		4)  Window Function can be used together with GROUP BY in the same query, ONLY if same columns are used

--Rank the customers based on their total sales	

SELECT CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) RankCustomers
FROM Sales.Orders
GROUP BY CustomerID 





