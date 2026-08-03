
--ROW_NUMBER(): Assign a unique number to each row. It doesn't handle ties i.e. if 2 rows has same value, they wont get same rank.
--RANK(): Assign a rank to each row. It handles ties. It leaves gaps in ranking.
--DENSE_RANK(): Assign a rank to each row. It handles ties. It doesn't leaves gaps in ranking.


--Rank the orders based on their sales from Highest to Lowest.
SELECT OrderID,ProductID, Sales,
ROW_NUMBER() OVER( ORDER BY Sales DESC) SalesRank_Row,
RANK() OVER( ORDER BY Sales DESC) SalesRank_Rank,
DENSE_RANK() OVER( ORDER BY Sales DESC) SalesRank_Rank
FROM Sales.Orders

--Find the top highest sales for each product.
SELECT * FROM (
SELECT OrderID,ProductID, Sales,
ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
FROM Sales.Orders)t
WHERE RankByProduct = 1

--Find the lowest 2 customers based on their sales
SELECT * FROM (
SELECT CustomerID, 
SUM(Sales) TotalSales,
ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomer
FROM Sales.Orders
GROUP BY CustomerID)t
WHERE RankCustomer <= 2


--Assign unique IDs to the rows of the 'OrderArchive' table.
SELECT
ROW_NUMBER() OVER(ORDER BY OrderID, OrderDate) UniqueID,*
FROM Sales.OrdersArchive

--Identify duplicate rows of the 'OrderArchive' table and return a clean result without any duplicates
SELECT * FROM(
SELECT
ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) rn,*
FROM Sales.OrdersArchive)t
WHERE rn = 1

--NTILE() : Divides the rows into a specified number of approx equal groups(buckets)

SELECT OrderID, Sales,
NTILE(4) OVER( ORDER BY Sales DESC) FourBucket,
NTILE(3) OVER( ORDER BY Sales DESC) ThreeBucket,
NTILE(2) OVER( ORDER BY Sales DESC) TwoBucket,
NTILE(1) OVER( ORDER BY Sales DESC) OneBucket
FROM Sales.Orders

--Data Segmentation divides a dataset into distinct subsets based on certain criteria

-- Segment all orders into 3 categories high, medium and low sales
SELECT *,
CASE WHEN Buckets = 1 THEN 'High'
     WHEN Buckets = 2 THEN 'Medium'
	 WHEN Buckets = 3 THEN 'Low'
END SalesSegementation
FROM (
SELECT OrderID, Sales,
NTILE(3) OVER(ORDER BY Sales DESC) Buckets
FROM Sales.Orders) t

--In order to export the data, divide the orders into 2 groups
SELECT NTILE(2) OVER(ORDER BY OrderID) Buckets, *
FROM Sales.Orders




--CUME_DIST : Cumulative Dsitribution calculates the distribution of data points within a window.
--PERCENT_RANK : Calculates the relative position of each row

--Find the products that fall within the highest 40% of the prices
SELECT * , CONCAT(DistRank * 100, '%') DistRankPerc, CONCAT(PercRank * 100, '%') PercRankPerc
FROM (
SELECT Product, Price,
CUME_DIST() OVER (ORDER BY Price DESC) DistRank,
PERCENT_RANK() OVER (ORDER BY Price DESC) PercRank
FROM Sales.Products) t
WHERE DistRank <= 0.4



