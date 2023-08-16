SELECT * FROM [dbo].[Data Model - Pizza Sales]

-- Total Revenue
-- (The sum of the total prize of all pizza orders )

SELECT SUM(total_price) AS Total_Revenue
FROM [dbo].[Data Model - Pizza Sales]


-- Average Order Value
-- (The average amount spent per order, calculated by dividing the total revenue by the total numbre of orders)

SELECT SUM(total_price)/ COUNT(DISTINCT(order_id)) AS Avg_Order_value
FROM [dbo].[Data Model - Pizza Sales]


-- Total Pizza Sold
-- (The sum of quantities of all pizza sold)

SELECT SUM(quantity) AS Total_pizza_sold
FROM [dbo].[Data Model - Pizza Sales]


-- Total Orders

SELECT COUNT(DISTINCT(order_id)) AS Total_orders
FROM [dbo].[Data Model - Pizza Sales]


-- Average Pizzas Per Order

SELECT (1.0 * SUM(quantity))/COUNT(DISTINCT(order_id)) AS Avg_pizzas_per_order
FROM [dbo].[Data Model - Pizza Sales]


-- Daily Trends for Total Orders

SELECT DATENAME (DW, order_date) AS Order_day ,
COUNT(DISTINCT(order_id)) AS Total_Orders
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY DATENAME (DW, order_date) 


-- Hourly Trends for Total Orders

SELECT DATEPART( HOUR, order_time) As Order_Hours,
COUNT(DISTINCT(order_id)) AS Total_Orders
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY DATEPART( HOUR, order_time)
ORDER BY DATEPART( HOUR, order_time)


-- Percentage of Sales by Pizza Category

SELECT pizza_category, SUM(total_price) As Total_Sales, SUM(total_price) * 100/ 
(SELECT SUM(total_price) FROM [dbo].[Data Model - Pizza Sales])AS Percentage_Total_Sales
FROM [dbo].[Data Model - Pizza Sales] 
-- WHERE MONTH(order_date )= 1
GROUP BY pizza_category


-- For One Month

SELECT pizza_category, SUM(total_price) As Total_Sales, SUM(total_price) * 100/ 
(SELECT SUM(total_price) FROM [dbo].[Data Model - Pizza Sales]WHERE MONTH(order_date)=1)AS Percentage_Total_Sales
FROM [dbo].[Data Model - Pizza Sales] 
WHERE MONTH(order_date )= 1
GROUP BY pizza_category


-- Percentage of Sales by pizza size

SELECT pizza_size, CAST(SUM(total_price)AS DECIMAL(10,2)) As Total_Sales,
CAST(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM [dbo].[Data Model - Pizza Sales])AS DECIMAL(10,2))
AS Percentage_Total_Sales
FROM [dbo].[Data Model - Pizza Sales] 
GROUP BY pizza_size
ORDER BY Percentage_Total_Sales DESC


-- For First Quarter

SELECT pizza_size, CAST(SUM(total_price)AS DECIMAL(10,2)) As Total_Sales,
CAST(SUM(total_price) * 100/ (SELECT SUM(total_price) FROM [dbo].[Data Model - Pizza Sales])AS DECIMAL(10,2))
AS Percentage_Total_Sales
FROM [dbo].[Data Model - Pizza Sales] 
WHERE DATEPART(QUARTER,order_date)=1
GROUP BY pizza_size
ORDER BY Percentage_Total_Sales DESC


-- Total Pizzas Sold by Pizza Category

SELECT pizza_category, SUM(quantity) AS Total_pizza_sold
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY pizza_category


-- Top 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_pizza_sold
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY pizza_name
ORDER BY Total_pizza_sold DESC


-- Bottom 5 Worst Sellers by Total Pizzas Sold

SELECT TOP 5 pizza_name, SUM(quantity) AS Total_pizza_sold
FROM [dbo].[Data Model - Pizza Sales]
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER BY Total_pizza_sold


-- Total Pizza Sold And Total Sale on '2015-12-31'

SELECT SUM (quantity) AS Total_pizza_sold, SUM(total_price) AS Total_Sales
FROM [dbo].[Data Model - Pizza Sales]
WHERE order_date  = '2015-12-31'


-- Only Sold Veggie Pizza On '2015-12-31'

SELECT SUM(quantity) As Total_Veggie_Pizza_Sold
FROM [dbo].[Data Model - Pizza Sales]
WHERE order_date = '2015-12-31' AND pizza_category = 'Veggie'


SELECT *
FROM [dbo].[Data Model - Pizza Sales]


-- Only Chicken Pizza Sales in January: All Tuesday

 SELECT DATENAME(DW, order_date) AS All_Tuesday_Jan , SUM(quantity) AS Total_Chicken_Pizza_Sold
 FROM [dbo].[Data Model - Pizza Sales]
 WHERE DATENAME(DW, order_date) = 'Tuesday' AND order_date BETWEEN'2015-01-01' AND '2015-01-31' AND pizza_category = 'Chicken'
 GROUP BY DATENAME(DW, order_date)


-- Worst Sale of the Year

SELECT Top 1 SUM(total_price) As Total_Sale, order_date, SUM(quantity) As Pizza_Sold
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY order_date
ORDER BY Total_Sale 


-- Best Sale of the Year

SELECT Top 1 SUM(total_price) As Total_Sale, order_date, SUM(quantity) As Pizza_Sold
FROM [dbo].[Data Model - Pizza Sales]
GROUP BY order_date
ORDER BY Total_Sale DESC