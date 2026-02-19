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

- Find total sales amount per product.
- Calculate average discount per product category.
- Display monthly sales trend (quantity sold per month).
- Show top 3 cities by total revenue.
- Display customer name, product, and sales amount using JOINs.
- Identify customers who never made a purchase (LEFT JOIN).
- Combine region and sales data to show total sales per region.
- Rank customers by total revenue using RANK() function.
- Calculate cumulative sales month-over-month using SUM() OVER.
- Compare category average vs overall average order size.

---

## Sales Analytics System Database

```sql
CREATE DATABASE myself;
USE myself;
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  gender CHAR(1),
  city VARCHAR(50),
  join_date DATE
);

CREATE TABLE products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  category VARCHAR(50),
  unit_price DECIMAL(10,2)
);

CREATE TABLE sales (
  sale_id INT PRIMARY KEY,
  sale_date DATE,
  customer_id INT,
  product_id INT,
  quantity INT,
  discount DECIMAL(5,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_name VARCHAR(50),
  city VARCHAR(50)
);

INSERT INTO customers VALUES
(1,'Arjun','Rao','M','Bangalore','2020-02-15'),
(2,'Sneha','Patil','F','Mumbai','2021-05-10'),
(3,'Kiran','Shah','M','Delhi','2019-08-25'),
(4,'Meena','Kumar','F','Chennai','2022-01-05'),
(5,'Rahul','Das','M','Kolkata','2020-11-22');
SELECT *FROM customers;

INSERT INTO products VALUES
(101,'Laptop','Electronics',55000),
(102,'Headphones','Electronics',3000),
(103,'Office Chair','Furniture',7000),
(104,'Notebook','Stationery',80),
(105,'Water Bottle','Accessories',250);
SELECT *FROM products;

INSERT INTO sales VALUES
(1,'2024-01-12',1,101,2,10),
(2,'2024-02-05',2,103,1,0),
(3,'2024-02-10',3,102,3,5),
(4,'2024-03-15',1,104,10,0),
(5,'2024-03-28',4,105,5,8),
(6,'2024-04-02',2,101,1,15),
(7,'2024-04-15',5,104,20,0),
(8,'2024-05-10',3,105,2,10),
(9,'2024-06-01',1,103,1,0),
(10,'2024-07-18',4,101,1,5);
SELECT *FROM sales;

INSERT INTO regions VALUES
(1,'South','Bangalore'),
(2,'West','Mumbai'),
(3,'North','Delhi'),
(4,'South','Chennai'),
(5,'East','Kolkata');
SELECT *FROM regions;

