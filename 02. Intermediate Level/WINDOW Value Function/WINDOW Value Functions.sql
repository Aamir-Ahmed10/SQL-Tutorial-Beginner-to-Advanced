
--LEAD(): Access a value from the next row within a window
--LAG(): Access a value from the previous row within a window


/*TIME SERIES ANALYSIS is the process of analyzing the data to understand patterns, trends and behaviors overtime.
         Year-over-Year(YoY) - Analyze the overall growth or decline of the business's performance overtime
		 Month-over-Month(MoM) - Analyze short-term trends and discover patterns in seasonability  */

--Analyze Month-over-Month performance by finding the percentage change in sales between the current and previous month
SELECT * ,
CurrentMonthSales - PreviousMonthSales AS MoM_Change,
ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT)/PreviousMonthSales * 100 , 1) AS MoM_Perc
FROM (
SELECT  
MONTH(OrderDate) OrderMonth, 
SUM(Sales) CurrentMonthSales,
LAG(SUM(Sales)) OVER(ORDER BY MONTH(OrderDate)) PreviousMonthSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate))t


--Customer Retention Analysis - Measures customer's behavior and loyalty to help businesses build strong relationship with customers.

--In order to analyze customer loyalty, rank customers based on the average days between their orders
SELECT CustomerID, AVG(DaysUntilNextOrder) AvgDays,
RANK() OVER(ORDER BY COALESCE(AVG(DaysUntilNextOrder),999999)) RankAvg  
FROM(
SELECT OrderID,  CustomerID, 
OrderDate AS CurrentOrder,
LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
DATEDIFF(DAY,OrderDate, LEAD(OrderDate) OVER (PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
FROM Sales.Orders)t
GROUP BY CustomerID


--FIRST_VALUE(): Access a value from the first row within a window
--LAST_VALUE: Access a value from the last row within a window

--Find the lowest and highest sales for each product
SELECT OrderID, ProductID, Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales) LowestSales,
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales 
ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSales2
FROM Sales.Orders

/*NOTE
LAST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales

We can achieve the same result that we got with above query, by quering it with 2 different ways

1) FIRST_VALUE(Sales) OVER(PARTITION BY ProductID ORDER BY Sales DESC) HighestSales2

2) MAX(Sales) OVER(PARTITION BY ProductID) HighestSales3    */










