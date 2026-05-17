# OnlineRetailDB

## Project Overview
OnlineRetailDB is a SQL Server database project that simulates an online retail management system. The project demonstrates database design, relational modeling, query optimization, and reporting concepts using SQL Server.

It includes database creation, table relationships, sample data insertion, joins, aggregations, subqueries, views, indexes, triggers, and analytical queries for managing customers, products, categories, orders, and sales data.

This project was created for learning and practice purposes while exploring real-world SQL Server database development concepts.

---

# Database Name
`OnlineRetailDB`

---

# Tables Included
- Customers
- Products
- Categories
- Orders
- OrderItems

---

# Features
- Database creation using SQL Server
- Primary Key & Foreign Key relationships
- Sample data insertion
- Joins and aggregations
- Subqueries and reporting queries
- Views for simplified data access
- Clustered and Non-Clustered Indexes
- Basic Triggers implementation
- Sales and customer analysis
- Query optimization concepts
- Performance testing using indexes

---

# SQL Concepts Used

## Database Design
- DDL Commands
- Constraints
- Identity Columns
- Primary Keys
- Foreign Keys

## Querying & Data Manipulation
- DML Commands
- Joins
- Aggregate Functions
- GROUP BY & HAVING
- ORDER BY
- TOP Clause
- Subqueries
- Common Reporting Queries

## Advanced SQL Concepts
- Views
- Clustered Indexes
- Non-Clustered Indexes
- Triggers
- Query Optimization
- Performance Analysis

---

# Sample Queries Included
- Retrieve customer orders
- Calculate total sales per product
- Find top spending customers
- Retrieve popular product categories
- Find out-of-stock products
- Monthly order analysis
- Revenue by category
- Highest priced products
- Frequently ordered products
- Retrieve recent customer orders using Views
- Performance comparison before and after Indexing
- Trigger-based automatic operations

---

# Views Implemented
- `vw_RecentOrders`
  - Displays recent customer orders with total order amount.

---

# Indexes Implemented
## Clustered Indexes
- Customers(CustomerID)
- Products(ProductID)
- Orders(OrderID)
- OrderItems(OrderItemID)
- Categories(CategoryID)

## Non-Clustered Indexes
- Orders(CustomerID)
- Orders(OrderDate)
- Products(CategoryID)
- Products(Price)
- Customers(Email)
- Customers(Country)
- OrderItems(OrderID)
- OrderItems(ProductID)

---

# Trigger Implementations
- Basic triggers for automated database actions and data integrity handling.

---

# Tools Used
- SQL Server
- SQL Server Management Studio (SSMS)

---

# How to Run

1. Open SQL Server Management Studio (SSMS)
2. Run the SQL script file
3. Database and tables will be created automatically
4. Insert sample data
5. Execute the sample queries
6. Test views, indexes, and triggers

---

# Learning Outcomes
This project helped in understanding:
- Relational database design
- SQL query writing
- Data analysis queries
- Indexing and performance optimization
- Views and reusable query structures
- Trigger implementation
- Real-world database development practices

---
