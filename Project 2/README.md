# SQL Sales Analytics System

## Project Overview
This project demonstrates **SQL-based data analysis** using a retail sales dataset. It includes database creation, table relationships, and analytical queries to extract business insights from sales data.

The project simulates a real-world **Sales Analytics scenario** and covers essential SQL concepts required for **Data Analyst roles**.

---

## Database Schema

The project contains four relational tables:

### Customers
Stores customer information.

- customer_id (Primary Key)
- first_name
- last_name
- gender
- city
- join_date

### Products
Stores product details.

- product_id (Primary Key)
- product_name
- category
- unit_price

### Sales
Stores transactional sales data.

- sale_id (Primary Key)
- sale_date
- customer_id (Foreign Key)
- product_id (Foreign Key)
- quantity
- discount

### Regions
Stores region mapping by city.

- region_id (Primary Key)
- region_name
- city

---

## SQL Concepts Used

- SELECT Queries  
- INNER JOIN and LEFT JOIN  
- GROUP BY and HAVING  
- Aggregate Functions (SUM, AVG, COUNT)  
- Subqueries  
- Window Functions:
  - RANK()
  - LAG()
  - SUM() OVER()

---

## Analytical Scenarios Implemented
- Find each sale’s contribution % to total revenue.
- Identify customers who purchased Electronics more than once.
- Calculate month-over-month revenue growth using LAG().
- Find top-selling product per month.
- List repeat customers (purchased in multiple months).
- Analyze customer retention (first vs last purchase date).
- Find most popular category by gender.
- Show top 3 customers in each region by revenue.
- Identify slow-moving products with low total sales.
- Calculate category revenue share percentage.

## Dataset Structure

# 1. Customers
Columns:
- customer_id (INT, Primary Key)
- first_name (VARCHAR)
- last_name (VARCHAR)
- gender (CHAR)
- city (VARCHAR)
- join_date (DATE)

# 2. Products
Columns:
- product_id (INT, Primary Key)
- product_name (VARCHAR)
- category (VARCHAR)
- unit_price (DECIMAL)

# 3. Sales
Columns:
- sale_id (INT, Primary Key)
- sale_date (DATE)
- customer_id (INT, Foreign Key → Customers)
- product_id (INT, Foreign Key → Products)
- quantity (INT)
- discount (DECIMAL)

# 4. Regions
Columns:
- region_id (INT, Primary Key)
- region_name (VARCHAR)
- city (VARCHAR)



