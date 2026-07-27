
--Retrieve all data from customers and orders in 2 different results (NO JOIN)
SELECT * FROM Customers;
SELECT * FROM Orders;


/*Get all customers along with their orders,but only for customers
who have placed an order(INNER JOIN)*/
SELECT c.id, c.first_name,o.order_id,o.sales
FROM Customers c
INNER JOIN orders o
ON c.id = o.customer_id


/*Get all customers along with their orders,including those without orders (LEFT JOIN)*/
SELECT c.id, c.first_name,o.order_id,o.sales
FROM Customers c
LEFT JOIN orders o
ON c.id = o.customer_id


/*Get all customers along with their orders,including orders without matching customers (RIGHT JOIN)*/
SELECT c.id, c.first_name,o.order_id,o.sales
FROM Customers c
RIGHT JOIN orders o
ON c.id = o.customer_id


/*Get all customers and all orders,even if there is no match (FULL JOIN)*/
SELECT c.id, c.first_name,o.order_id,o.sales
FROM Customers c
FULL JOIN orders o
ON c.id = o.customer_id


/*Get all customers who haven't placed any order (LEFT ANTI JOIN)*/
SELECT *
FROM customers c 
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL


/*Get all orders without matching customers (RIGHT ANTI JOIN)*/
SELECT *
FROM Customers c
RIGHT JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL


/*Get customers without orders and orders without customers (FULL ANTI JOIN)*/
SELECT *
FROM Customers c
FULL JOIN orders o
ON c.id = o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL


/*Get all customers along with their orders,but only for customers who have placed orders.
Without using INNER JOIN*/
SELECT *
FROM Customers c
LEFT JOIN orders o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL


/*Generate all combinations of customers and orders (CROSS or CARTESIAN JOIN)*/
SELECT *
FROM Customers c
CROSS JOIN orders o

/*Using SalesDB, Retrieve a list of all orders, along with the related customer, product and employee details.
For each order, display:
Order ID, Cutosmer's name,Product name, Product price, Salesperson's name
MULTIPLE JOINS*/

USE SalesDB

SELECT o.OrderID,
       o.Sales,
       CONCAT(c.FirstName,' ',c.LastName) AS Customer_Name, 
	   p.Product AS ProductName, 
	   p.Price AS Product_price,
	   CONCAT(e.FirstName,' ',e.LastName) AS SalespersonName

FROM Sales.Orders o 
LEFT JOIN Sales.Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN Sales.Products p ON o.ProductID = p.ProductID
LEFT JOIN Sales.Employees e ON o.SalesPersonID = e.EmployeeID












