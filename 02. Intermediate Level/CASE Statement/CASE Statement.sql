
--CASE STATEMENT
/*Syntax: CASE 
              WHEN condition1 THEN Result1
			  WHEN condition2 THEN Result2
			  ....
			  ELSE result
          END
*/

/*Create report showing total sales for each of the following categories:
High(sales over 50),Medium(sales 21-50), and Low(sales 20 or less)
Sort the categories from highest sales to lowest*/

SELECT Category, 
SUM(Sales) AS TotalSales
FROM (
SELECT OrderID , Sales,
CASE 
    WHEN Sales>50 THEN 'High'
	WHEN Sales BETWEEN 21 AND 50 THEN 'Medium'
	ELSE 'Low'
END Category
FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC



--Retrieve employee details with Gender displayed as full text
SELECT EmployeeID,FirstName,LastName,Gender,
CASE 
    WHEN Gender = 'M' THEN 'Male'
	WHEN Gender = 'F' THEN 'Female'
	ELSE 'Not Available'
END GenderFullText
FROM Sales.Employees

--Retrieve customer details with abbreviated country code
SELECT CustomerID,FirstName,LastName,Country,
CASE 
    WHEN Country = 'Germany' THEN 'DE'
	WHEN Country = 'USA' THEN 'US'
	ELSE 'Not Available'
END AbbreviatedCountry
FROM Sales.Customers



/*Find the average scores of customers and treat NULLa AS 0,
Additionally provide details such as CustomerID and Lastname*/
SELECT CustomerID,LastName,Score,
CASE 
    WHEN Score IS NULL THEN 0
	ELSE Score	
END ScoreClean ,
AVG(CASE 
    WHEN Score IS NULL THEN 0
	ELSE Score	
END) OVER() AvgCustScore
FROM Sales.Customers

/*Count how many times each customer has made an order with sales greater than 30*/
SELECT CustomerID,
SUM(CASE 
    WHEN Sales > 30 THEN 1
	ELSE 0	
END) TotalOrdersHighSales,
COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID