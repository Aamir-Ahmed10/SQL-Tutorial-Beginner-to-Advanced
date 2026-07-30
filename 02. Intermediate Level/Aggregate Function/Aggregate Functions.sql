

--Find the total numbers of orders. Then total sales, average sales, highest sales,lowest sales of all orders.
SELECT customer_id,
COUNT(*) AS Total_nr_orders,
SUM(sales) AS Total_Sales,
AVG(sales) AS Avg_Sales,
MAX(sales) AS Highest_Sales,
MIN(sales) AS Lowest_Sales
FROM orders
GROUP BY customer_id


--Find the total numbers of score. Then total score, average score, highest score,lowest score of all customers by country.
SELECT country,
COUNT(*) AS Total_nr_score,
SUM(score) AS Total_Score,
AVG(score) AS Avg_Score,
MAX(score) AS Highest_Score,
MIN(score) AS Lowest_Score
FROM customers
GROUP BY country













