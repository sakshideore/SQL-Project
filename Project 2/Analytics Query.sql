USE MYSELF;

#1. Find each sale’s contribution % to total revenue.

SELECT 
s.sale_id,
(s.quantity * p.unit_price * (1 - s.discount/100)) AS sale_revenue,

100.0 *
(s.quantity * p.unit_price * (1 - s.discount/100))
/
SUM(s.quantity * p.unit_price * (1 - s.discount/100)) 
OVER () AS contribution_percent
FROM sales s
JOIN products p
ON s.product_id = p.product_id;

#2. Identify customers who purchased Electronics more than once.

SELECT 
c.first_name,
c.last_name,
COUNT(*) AS purchase_count
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN products p 
ON s.product_id = p.product_id
WHERE p.category = 'Electronics'
GROUP BY c.first_name, c.last_name
HAVING COUNT(*) > 1;


#3. Calculate month-over-month revenue growth using LAG().

WITH monthly_sales AS (
SELECT 
YEAR(s.sale_date) AS yr,
MONTH(s.sale_date) AS mn,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS revenue
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
GROUP BY YEAR(s.sale_date), MONTH(s.sale_date)
)
SELECT 
yr,
mn,
revenue,
revenue - LAG(revenue) OVER (ORDER BY yr, mn) AS growth
FROM monthly_sales;


#4. Find top-selling product per month.

WITH product_month AS (
SELECT 
YEAR(s.sale_date) AS yr,
MONTH(s.sale_date) AS mn,
p.product_name,
SUM(s.quantity) AS total_qty,
RANK() OVER(
PARTITION BY YEAR(s.sale_date), MONTH(s.sale_date)
ORDER BY SUM(s.quantity) DESC
) AS rnk
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
GROUP BY YEAR(s.sale_date), MONTH(s.sale_date), p.product_name
)
SELECT *FROM product_month
WHERE rnk = 1;

#5. List repeat customers (purchased in multiple months).

SELECT 
c.first_name,
c.last_name,
COUNT(DISTINCT FORMAT(s.sale_date,'yyyy-MM')) AS months_purchased
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(DISTINCT FORMAT(s.sale_date,'yyyy-MM')) > 1;


#6. Analyze customer retention (first vs last purchase date).

SELECT 
c.first_name,
c.last_name,
MIN(s.sale_date) AS first_purchase,
MAX(s.sale_date) AS last_purchase
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name;

#7. Find most popular category by gender.

SELECT 
c.gender,
p.category,
COUNT(*) AS total_orders
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN products p 
ON s.product_id = p.product_id
GROUP BY c.gender, p.category
ORDER BY c.gender, total_orders DESC;

#8. Show top 3 customers in each region by revenue.

WITH region_revenue AS (
SELECT 
r.region_name,
c.first_name,
c.last_name,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS revenue,
RANK() OVER (
PARTITION BY r.region_name
ORDER BY SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) DESC
) AS rnk
FROM sales s
JOIN customers c 
ON s.customer_id = c.customer_id
JOIN products p 
ON s.product_id = p.product_id
JOIN regions r 
ON c.city = r.city
GROUP BY r.region_name, c.first_name, c.last_name
)

SELECT *
FROM region_revenue
WHERE rnk <= 3;

#9. Identify slow-moving products with low total sales.

SELECT 
p.product_name,
SUM(s.quantity) AS total_quantity
FROM sales s
JOIN products p 
ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity) < 5;

#10. Calculate category revenue share percentage.

SELECT 
p.category,
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0)) AS category_revenue,

100.0 *
SUM(s.quantity * p.unit_price * (1 - s.discount/100.0))
/
SUM(SUM(s.quantity * p.unit_price * (1 - s.discount/100.0))) 
OVER () AS revenue_percent

FROM sales s
JOIN products p 
ON s.product_id = p.product_id
GROUP BY p.category;


