USE MYSELF;

#1. Find total sales amount per product.

SELECT p.product_name,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS total_revenue
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
GROUP BY p.product_name;


#2. Calculate average discount per product category.

SELECT p.category,
AVG(s.discount) AS avg_discount
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
GROUP BY p.category;


#3. Display monthly sales trend (quantity sold per month).

SELECT FORMAT(sale_date,'yyyy-MM') AS month,
SUM(quantity) AS total_quantity
FROM sales
GROUP BY FORMAT(sale_date,'yyyy-MM');


#4. Show top 3 cities by total revenue.

SELECT TOP 3 c.city,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS revenue
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.city
ORDER BY revenue DESC;


#5. Display customer name, product, and sales amount using JOINs.

SELECT c.first_name + ' ' + c.last_name AS customer_name,
p.product_name,
(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS sales_amount
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN products p 
ON s.product_id = p.product_id;


#6. Identify customers who never made a purchase (LEFT JOIN).
INSERT INTO customers VALUES
(6,'Riya','Sharma','F','Pune','2024-01-01');

SELECT c.customer_id,
c.first_name,
c.last_name
FROM customers c
LEFT JOIN sales s
ON c.customer_id = s.customer_id
WHERE s.sale_id IS NULL;


#7. Combine region and sales data to show total sales per region.

SELECT r.region_name,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS total_sales
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN regions r 
ON c.city = r.city
JOIN products p 
ON s.product_id = p.product_id
GROUP BY r.region_name
ORDER BY total_sales DESC;


#8. Rank customers by total revenue using RANK() function.

SELECT c.first_name + ' ' + c.last_name AS customer_name,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS total_revenue,
RANK() OVER (
ORDER BY SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) DESC
) AS ranking
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN products p 
ON s.product_id = p.product_id
GROUP BY c.first_name, c.last_name;


#9. Calculate cumulative sales month-over-month using SUM() OVER.

SELECT year_month,
SUM(monthly_sales) OVER (ORDER BY year_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales
FROM (
SELECT 
CAST(YEAR(sale_date) AS VARCHAR(4)) + '-' +
RIGHT('0' + CAST(MONTH(sale_date) AS VARCHAR(2)),2) AS year_month,
SUM(quantity) AS monthly_sales
FROM sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
) t
ORDER BY year_month;


#10. Compare category average vs overall average order size.

SELECT p.category,
AVG(s.quantity) AS category_avg_order,
(SELECT AVG(quantity) FROM sales) AS overall_avg_order
FROM sales s
JOIN products p
ON s.product_id = p.product_id
GROUP BY p.category;


