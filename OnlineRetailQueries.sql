/*
FICTIONAL ONLINE RETAIL COMPANY PROJECT

Project Overview : 

A. Database Design
-- Database Name : OnlineRetailDB

B. Tables
-- Customers : Stores Customer details
-- Products : Stores Product details
-- Orders : Stores Order details
-- OrderItems : Stores details of each item in an order
-- Categories : Stores Product Categories

C. Insert Sample Data
-- Populate each table with sample data

D. Write Queries
-- Retrieve Data (e.g. Customers, Orders, Popular Products)
-- Perform Aggregations (e.g. Total Sales, Average Order Value
-- Join tables for comprehensive reports
-- Use subqueries and common table expressions (CTEs)

*/


-- Let's Start

-- Create the database
CREATE DATABASE OnlineRetailDB
GO

-- Use the database
USE OnlineRetailDB
GO

-- Create Customers Table
CREATE TABLE Customers
(
	CustomerID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Email NVARCHAR(100),
	Phone NVARCHAR(50),
	Address NVARCHAR(255),
	City NVARCHAR(50),
	State NVARCHAR(50),
	ZipCode NVARCHAR(50),
	Country NVARCHAR(50),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Products Table
CREATE TABLE Products
(
	ProductID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	ProductName NVARCHAR(100),
	CategoryID INT,
	Price DECIMAL(10, 2),
	Stock INT, 
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create Categories Table
CREATE TABLE Categories
(
	CategoryID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	CategoryName NVARCHAR(100),
	Description NVARCHAR(255)
);

-- Create Orders Table
CREATE TABLE Orders
(
	OrderID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	CustomerID INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderItems Table
CREATE TABLE OrderItems
(
	OrderItemID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	OrderID INT,
	ProductID INT, 
	Quantity INT,
	Price DECIMAL(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID), 
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert sample data in the Categories Table
INSERT INTO Categories (CategoryName, Description)
VALUES
('Eelectronics', 'Devices and Gadgets'),
('Clothing', 'Apparel and Accessories'),
('Books', 'Printed and Electronic Books');

-- Insert sample data in the Products Table
INSERT INTO Products (ProductName, CategoryID, Price, Stock)
VALUES
('SmartPhone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-Shirts', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

-- Insert sample data into Customers Table
INSERT INTO Customers (FirstName, LastName,Email, Phone, Address, City, State, ZipCode, Country)
VALUES
('Jay', 'Khanna', 'jay@example.com', '167-789-7380', '123 Ema St.', 'Nagpur', 'Maharashtra', '678383', 'India'),
('Sameer', 'Patel', 'sameer@example.com', '623-237-7382', '456 hsk St.', 'Amravati', 'Maharashtra', '782026', 'India'),
('Swati', 'Deboray', 'swati@example.com', '217-739-7302', '789 jkl St.', 'Nagpur', 'Maharashtra', '678383', 'India'),
('Shree', 'Dubey', 'shree@example.com', '156-483-2681', '179 syh St.', 'Nagpur', 'Maharashtra', '678383', 'India')

--Insert sample data into Orders Table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, GETDATE(), 719.98),
(2, GETDATE(), 49.99),
(3, GETDATE(), 44.98)

-- Insert sample data into OrderItems Table
INSERT INTO OrderItems (OrderID, ProductID, Quantity, Price)
VALUES
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1, 49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99)

-- Query 1 : Retrieve all orders for a specific customer
SELECT o.OrderID, o.OrderDate, o.TotalAmount, p.ProductID, p.ProductName, oi.Quantity, oi.Price
FROM Orders o INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE o.CustomerID = 1

-- Query 2 : Find the total sales for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity * oi.Price) AS TotalSales
FROM Products p INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC

-- Query 3 : Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders

-- Query 4 : List the top 5 customers by total spending
SELECT TOP 5 c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpending DESC

-- Query 5 : Retrieve the most popular product category
SELECT TOP 1 c.CategoryID, c.CategoryName, SUM(oi.Quantity * oi.Price)
FROM OrderItems oi INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName

-- To insert a product with zero stock
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES('Keyboard',1, 39.99, 0)

-- Query 6 : List all products that are out of stock, i.e. stock = 0
SELECT ProductID, ProductName, Stock FROM Products WHERE Stock = 0

-- With Category Name
SELECT p.ProductID, p.ProductName, p.Price, c.CategoryID, c.CategoryName, p.Stock
FROM Products p INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE Stock = 0;

-- Query 7 : Find Customers who placed orders in the last 30 days
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= DATEADD(DAY, -30, GETDATE());

-- Query 8 : Calculate the total number of orders placed each month
SELECT YEAR(OrderDate) AS OrderYear, MONTH(OrderDate) as OrderMonth, Count(OrderID) AS TotalOrders
FROM Orders 
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;

-- Query 9 : Retrieve the details of the most recent order
SELECT TOP 1 o.OrderID, o.OrderDate, o.TotalAmount, c.FirstName, c.LastName
FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC

-- Query 10 : Find the average price of products in each category
SELECT c.CategoryID, c.CategoryName, AVG(p.Price) AS AveragePrice
FROM Products p INNER JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName

-- Query 11: List customers who have never placed an order
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, o.OrderID, o.TotalAmount
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL

-- Query 12: Retrieve the total quantity sold for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalquantitySold
FROM Products p INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName;

-- Query 13: Calculate the total revenue generated from each category
SELECT c.CategoryID, c.CategoryName, SUM(oi.Quantity * oi.Price) AS TotalRevenue
FROM OrderItems oi INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN Categories c ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;

-- Query 14: Find the highest-priced product in each category
SELECT c.CategoryID, c.CategoryName, p1.ProductID, p1.ProductName, p1.Price
FROM Categories c INNER JOIN Products p1 ON c.CategoryID = p1.CategoryID
WHERE p1.Price = (SELECT MAX(Price) FROM Products p2 WHERE p2.CategoryID = p1.CategoryID)
ORDER BY p1.Price DESC;

-- Query 15: Retrieve orders with a total amount greater than or equal to a specific value (e.g., $49.99)
SELECT o.OrderID, o.TotalAmount, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o INneR JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount >= 49.99
ORDER BY o.TotalAmount DESC;

-- Query 16: List products along with the number of orders they appear
SELECT p.ProductID, p.ProductName, COUNT(oi.OrderID) as OrderCount
FROM Products p INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY OrderCount DESC;

-- Query 17: Find the top 3 most frequently ordered products
SELECT TOP 3 p.ProductID, p.ProductName, COUNT(oi.OrderID) AS OrderCount
FROM Products p INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY OrderCount DESC;

-- Query 18: Calculate the total number of customers from each country
SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY Country
ORDER BY TotalCustomers DESC;

-- Query 19: Retrieve the list of customers along with their total spending
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpending DESC;

-- Query 20: List orders with more than a specified number of items (e.g., 1 items)
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName, COUNT(oi.OrderItemID) AS NumberOfItems
FROM Orders o INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Customers c ON c.CustomerID = o.CustomerID
GROUP BY o.OrderID, c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(oi.OrderItemID) > 1
ORDER BY NumberOfItems DESC;