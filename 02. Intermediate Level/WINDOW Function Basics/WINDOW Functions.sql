
/*WINDOW FUNCTIONS : Perform calculations(eg. aggregation) on a speicfic subset of data,
                     without losing the level of details of rows.*/

-- Limit of  GROUP BY Function: Can't do aggregations and provide details at same time

/*GROUP BY is used for Simple Data Analysis(Aggregations) ,
 whereas WINDOW Function is used for Advanced Data Analysis (Aggregations + Details).
 Flexibilty of Window Function is that it allows aggregation of data at different granularities within the same query*/

/*Syntax:  WINDOW () OVER (Partition , Order, Frame)   : clauses in OVER are optional
       Eg: AVG (Sales) OVER (PARTITION BY Category ORDER BY OrderDate ROWS UNBOUNDED PRECEDING)

	   PARTITION BY : Divide the result into partitions (Windows). Its works same as GROUP BY but in WINDOWS Function.*/
	   

/*--Find the total sales across all orders, Additionally provide details such as OrderID, Order Date*/
SELECT OrderID, OrderDate,
SUM(Sales) OVER() TotalSales
FROM Sales.Orders

/*--Find the total sales of each product, Additionally provide details such as OrderID, Order Date*/
SELECT OrderID, OrderDate, ProductID,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesbyProducts
FROM Sales.Orders



/*LETS COMPLICATE THE ABOVE MENTIONED TASKS:
Find the total sales across all orders,
the total sales of each product, 
total sales for each combination of product and order status
Additionally provide details such as OrderID, Order Date*/
SELECT OrderID, OrderDate, ProductID,Sales,OrderStatus,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesbyProducts,
SUM(Sales) OVER(PARTITION BY ProductID,OrderStatus) SalesbyProductsandStatus,
SUM(Sales) OVER() TotalSales
FROM Sales.Orders


/*ORDER BY: Sort the data in the window fucntion*/ 

/*Rank Each order based on their sales from highest to lowest
Additionally provide details such as OrderID, Order Date*/
SELECT OrderID, OrderDate,Sales,
RANK() OVER(ORDER BY Sales DESC) SalesHightoLow
FROM Sales.Orders



/*WINDOW FRAME: Defines a subset of rows within each window that is relevant for the calculation.
                1)Can only be used together with ORDER BY clause.
				2)Lower Value must be before the higher value
				
		Window Frames can be of multiple types:
		ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
		ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
		ROWS BETWEEN 1 PRECEDING AND CURRENT ROW  
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
		ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING*/

SELECT OrderID, OrderDate,Sales,OrderStatus,
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate
ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) TotalSales
FROM Sales.Orders

/*NOTE: 
     COMPACT FRAME: Its like a short form but for only PRECEDING,the CURRENT ROW can be skipped
	 Example:  Normal Form: ROWS BETWEEN 2 PRECEDING CURRENT ROW 
	           Short Form: ROWS 2 PRECEDING or ROWS UNBOUNDED PRECEDING

     Default Frame: If we dont use any frame and just use ORDER BY there is a default frame working in the background which is :-
	                      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
	       Example: SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate) TotalSales  



				
			











