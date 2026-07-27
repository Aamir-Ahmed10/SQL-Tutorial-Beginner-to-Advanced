
--ROUND Function
SELECT 3.516, 
       ROUND(3.516,2) AS round_2, 
	   ROUND(3.516,1) AS round_1,
	   ROUND(3.516,0) AS round_0 

--ABSOLUTE Function
SELECT -10 , ABS(-10),ABS(10)


--DATE and TIME Functions

SELECT OrderID,
       CreationTime,  /* already in the column*/
	   '2025-08-20' Hardcoded,  /*fixed date that we enter for all rows*/
	   GETDATE() Today   /*Gives the current/todays' datetime*/
FROM Sales.Orders
