
--PART EXTRACTION

/* 1) DAY-MONTH-YEAR Function*/
SELECT OrderID,
       CreationTime,  
	   YEAR(CreationTime) Year,
	   MONTH(CreationTime) Month,
	   DAY(CreationTime) Day,
FROM Sales.Orders

/*DATEPART Function*/
SELECT OrderID,
       CreationTime,  	  
	   DATEPART(YEAR,CreationTime) Year_dp,
	   DATEPART(MONTH,CreationTime) Month_dp,
	   DATEPART(DAY,CreationTime) Day_dp,
	   DATEPART(HOUR,CreationTime) Hour_dp,
	   DATEPART(QUARTER,CreationTime) Quarter_dp,
	   DATEPART(WEEKDAY,CreationTime) Weekday_dp,
	   DATEPART(WEEK,CreationTime) Week_dp
FROM Sales.Orders



/* 2) DATENAME Function*/
SELECT OrderID,
       CreationTime,  	  
	   DATENAME(MONTH,CreationTime) Month_dn,
	   DATENAME(WEEKDAY,CreationTime) Weekday_dn	   
FROM Sales.Orders

/* 3) DATETRUNC Function*/
SELECT OrderID,
       CreationTime,  	  
	   DATETRUNC(MINUTE,CreationTime) Minute_dt,
	   DATETRUNC(YEAR,CreationTime) Year_dt,
	   DATETRUNC(DAY,CreationTime) Day_dt
FROM Sales.Orders

SELECT   	  
	   DATETRUNC(MONTH,CreationTime) Creation,
	   COUNT(*)  AS TotalOrders
FROM Sales.Orders
GROUP BY DATETRUNC(MONTH,CreationTime) 


/* 4) EOMONTH(End of the month) Function*/
SELECT OrderID,
       CreationTime,  	  
	   EOMONTH(CreationTime) End_of_month,
	   CAST(DATETRUNC(MONTH,CreationTime) AS date) Start_of_month
FROM Sales.Orders


/*How many orders were placed each year?*/

SELECT YEAR(OrderDate),
       COUNT(*) NoofOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate)

/*How many orders were placed each month?*/

SELECT DATENAME(MONTH,OrderDate) AS Months,
       COUNT(*) NoofOrders
FROM Sales.Orders
GROUP BY MONTH(OrderDate), DATENAME(MONTH,OrderDate)
ORDER BY MONTH(OrderDate)


/*Show all orders were placed during February*/
SELECT *
FROM Sales.Orders
WHERE MONTH(OrderDate) = 2


-- FORMAT, CONVERT, CAST Functions
--FORMAT : Changing the format of a value from one to another

SELECT OrderID,
       CreationTime,
	   FORMAT(CreationTime,'MM-dd-yyyy') USA_Format,
	   FORMAT(CreationTime,'dd-MM-yyyy') Euro_Format,
	   FORMAT(CreationTime,'dd') dd,
	   FORMAT(CreationTime,'ddd') ddd,
	   FORMAT(CreationTime,'dddd') dddd,
	   FORMAT(CreationTime,'MM') MM,
	   FORMAT(CreationTime,'MMM') MMM,
	   FORMAT(CreationTime,'MMMM') MMMM
FROM Sales.Orders

/*Show CreationTime using the following format:
DAY Wed Jan Q1 2025 12:34:56 PM */

SELECT OrderID,
CreationTime,
'Day ' + FORMAT(CreationTime,'ddd MMM') + 
' Q'+ DATENAME(quarter, CreationTime) + ' '+
FORMAT(CreationTime,'yyyy hh:mm:ss tt') AS Custom_Format	 
FROM Sales.Orders



SELECT FORMAT(OrderDate, 'MMM yy') OrderDate,
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy')


/*CONVERT : Converts a dat or time value to a different data type & Formats the value
Syntax: CONVERT(data_type, value, [style])*/

SELECT 
CONVERT(INT, '123')AS Sting_to_Int,
CONVERT(DATE, '2025-08-20')AS Sting_to_Date,
CreationTime,
CONVERT(DATE, CreationTime)AS DateTime_to_Date
FROM Sales.Orders


SELECT 
CreationTime,
CONVERT(DATE, CreationTime)AS DateTime_to_Date,
CONVERT(VARCHAR, CreationTime, 32)AS USA_Style32,
CONVERT(VARCHAR, CreationTime, 34)AS Euro_Style34
FROM Sales.Orders



--CAST : Converts a value to a specified datetype
--Syntax: CAST(value AS data_type)

SELECT CAST('123' AS INT) AS String_to_Int,
       CAST(123 AS varchar) AS Int_to_String,
	   CAST('2025-08-20' AS DATE) AS String_to_Date,
	   CAST('2025-08-20' AS datetime2) AS String_to_Datetime,
	   CreationTime,
	   CAST(CreationTime AS date) AS Datetime_to_Date
FROM Sales.Orders


--CALCULATIONS

--DATEADD Functions:  Adds or Subtracts a specific time interval to/from a date
--Syntax: DATEADD(part, interval, date)

SELECT OrderID,
       OrderDate,  
	   DATEADD(Year, 2, OrderDate) AS TwoYearLater,
	   DATEADD(MONTH, 3, OrderDate) AS TwoYearLater,
	   DATEADD(DAY, -10, OrderDate) AS TenDaysBefore
FROM Sales.Orders


--DATEDIFF Functions: Find the difference between 2 dates
--Syntax: DATEDIFF(part, start_date, end_date)

/*Calculate the age of employees*/
SELECT EmployeeID, BirthDate,  
	   DATEDIFF(Year, BirthDate, GETDATE()) AS Age	   
FROM Sales.Employees

/*Find the average shipping duration in days for each month*/
SELECT 
       DATENAME(MONTH,OrderDate) AS OrderMonth, 
	   AVG(DATEDIFF(DAY, OrderDate, ShipDate)) AS AvgShip_Duration
FROM Sales.Orders
GROUP BY DATENAME(MONTH,OrderDate),MONTH(OrderDate)
ORDER BY MONTH(OrderDate)


--TIME GAP ANALYSIS
--Find the number of days bewteen each order and previous order
SELECT OrderID, 
       OrderDate AS Current_Order_Date,
       LAG(OrderDate) OVER (ORDER BY OrderDate) AS Previous_Order_Date,
       DATEDIFF(DAY, LAG(OrderDate) OVER (ORDER BY OrderDate), OrderDate) AS NumberOfDays
FROM Sales.Orders


--VALIDATION

--ISDATE Functions: Checks if a value is a date
--Syntax: ISDATE(value)

SELECT ISDATE('123') DateCheck1,
ISDATE('2025-08-20') DateCheck2,
ISDATE('20-08-2025') DateCheck3, /*not considered as date because its not a standard format*/
ISDATE('2025') DateCheck4, /* recognises it as Year*/
ISDATE('08') DateCheck5


SELECT
     --CAST(OrderDate AS DATE) OrderDate,
	 OrderDate,
	 ISDATE(OrderDate),
	 CASE WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
	      ELSE '9999-01-01'
	 END NewOrderDate
FROM
(
     SELECT '2025-08-20' AS OrderDate UNION
	 SELECT '2025-08-21' UNION
	 SELECT '2025-08-23' UNION
	 SELECT '2025-08' 
)t
--WHERE ISDATE(OrderDate) = 0








