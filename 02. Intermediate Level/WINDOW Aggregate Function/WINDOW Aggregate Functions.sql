

--COUNT() : Returns the number of rows within a window

/*Find the total number of Orders, total number of Orders for each Customer. Additionally give OrderID, Order Date*/
SELECT OrderID, OrderDate, CustomerID,
COUNT(*) OVER() TotalOrders,
COUNT(*) OVER (PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders

/*Find the total number of Customers, total number of scores for Customers. Additionally provide all customers details*/
SELECT *,
COUNT(*) OVER() TotalCustomers,
COUNT(Score) OVER () TotalScores
FROM Sales.Customers

/*Check whether the table 'Orders' contains any duplicate rows*/
SELECT *
FROM(SELECT OrderID, 
COUNT(*) OVER (PARTITION BY OrderID) CheckPK
FROM Sales.OrdersArchive)t
WHERE CheckPK > 1



--SUM(): Returns the sum of values within a window

/*Find the total sales across all Orders, total sales for each product. Additionally give OrderID, Order Date*/
SELECT OrderID, OrderDate,Sales,ProductID,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER (PARTITION BY ProductID) TotalSalesbyProduct
FROM Sales.Orders



/*Find percentage contribution of each product's sales to the total sales*/
SELECT OrderID,Sales,ProductID,
SUM(Sales) OVER() TotalSales,
ROUND(CAST(Sales AS float)/SUM(Sales) OVER() * 100 , 2) PercentageofTotal
FROM Sales.Orders

--AVG(): Returns the average of values within a window

/*Find the average sales across all Orders, average sales for each product. Additionally give OrderID, Order Date*/
SELECT OrderID,OrderDate, Sales,ProductID,
AVG(COALESCE (Sales,0)) OVER() Average_Sales,
AVG(COALESCE (Sales,0)) OVER(PARTITION BY ProductID) Average_Sales_by_Product
FROM Sales.Orders

/*Find the average scores of customers. Additionally provide details such as CustomerID and LastName*/
SELECT CustomerID,LastName,Score,
AVG(COALESCE (Score,0)) OVER() Average_Score
FROM Sales.Customers

/*Find all Orders where sales are higher than the average sales across all Orders*/
SELECT *
FROM
(SELECT OrderID,ProductID, Sales,
AVG(COALESCE (Sales,0)) OVER() Avg_Sales
FROM Sales.Orders)t
WHERE Sales > Avg_Sales




/*        MIN():Returns the lowest value within a window.                         MAX():Returns the highest value within a window          */

/*Find the highest and lowest sales across all Orders, highest and lowest sales for each product. Additionally give OrderID, Order Date*/
SELECT OrderID, Sales,ProductID,
MAX(COALESCE (Sales,0)) OVER() Highest_Sales,
MIN(COALESCE (Sales,0)) OVER() Lowest_Sales,
MAX(COALESCE (Sales,0)) OVER(PARTITION BY ProductID) Highest_Sales_by_Product,
MIN(COALESCE (Sales,0)) OVER(PARTITION BY ProductID) Lowest_Sales_by_Product
FROM Sales.Orders

/*Show the employee who have the highest salary*/
SELECT *
FROM (
SELECT *,
MAX(COALESCE (Salary,0)) OVER() HighestSalary
FROM Sales.Employees
)t 
WHERE Salary = HighestSalary

--Find the deviation of each sales from the minimum and maximum sales amounts
SELECT OrderID, OrderDate, ProductID, Sales,
MAX(COALESCE (Sales,0)) OVER() Highest_Sales,
MIN(COALESCE (Sales,0)) OVER() Lowest_Sales,
Sales - MIN(COALESCE (Sales,0)) OVER() DeviationFromMin,
Max(COALESCE (Sales,0)) OVER() - Sales DeviationFromMax
FROM Sales.Orders




/*RUNNING TOTAL: Aggregate all the values from start upto current point without dropping off older date.
        Syntax with Example: SUM(Sales) OVER (ORDER BY Month)   
		               {here window from will be default i.e. ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW}   */


/*ROLLING TOTAL: Aggregate all the values within a fixed time window. As new data is added, the oldest data point will be dropped.
       Syntax with Example: SUM(Sales) OVER (ORDER BY Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) */

/*Calculate moving (running) average of sales for each product overtime.
Calculate moving average of sales for each product overtime, including only the next order (rolling total)*/

SELECT OrderID, ProductID, OrderDate, Sales,
AVG(Sales) OVER(PARTITION BY ProductID) Avg_Sales_by_Product,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate) Moving_Avg,
AVG(Sales) OVER(PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) Rolling_Avg
FROM Sales.Orders












