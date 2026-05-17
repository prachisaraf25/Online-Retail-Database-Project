/*
========================================================
SQL Server - Implementing Views
========================================================

Views - Views are Vritual Tables that represent the result of a query.
They can simplify complex queries and enhance security by restricting access to specific data.

*/

-- View for Product Details : A view combining product details with category names.
CREATE OR ALTER VIEW vw_ProductDetails AS
SELECT p.ProductID, p.ProductName, p.Price, p.Stock, c.CategoryName
FROM Products p INNER JOIN Categories c
ON p.CategoryID = c.CategoryID;
GO

-- View for Customer Orders : A view to get a summary of orders placed by each customer
CREATE OR ALTER VIEW vw_CustomerOrders AS
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders, SUM(oi.Quantity * p.Price) AS TotalAmount
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON p.ProductID = oi.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
GO

-- View for Recent Orders : A view to display orders placed in the last 30 days
CREATE OR ALTER VIEW vw_RecentOrders AS
SELECT o.OrderID, o.OrderDate, c.CustomerID, c.FirstName, c.LastName, SUM(oi.Quantity * p.Price) AS OrderAmount
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON oi.OrderID = o.OrderID
INNER JOIN Products p ON p.ProductID = oi.ProductID
WHERE o.OrderDate >= DATEADD(DAY, -30, GETDATE())
GROUP BY o.OrderID, o.OrderDate, c.CustomerID, c.FirstName, c.LastName;
GO




-- Use Case 1: Retireve all products with category names
-- Using the vw_ProductDetails view to get a list of all products along with their category names.
SELECT * FROM vw_ProductDetails;

-- Use Case 2: Retieve Products within a specific Price Range
-- Using the vw_ProductDetails view to find products priced between $10 and $500.
SELECT * FROM vw_ProductDetails
WHERE Price BETWEEN 10 AND 500;

-- Use Case 3: Count the Number of Products in each Category
-- Using the vw_ProductDetails view to count the number of products in each category.
SELECT CategoryName, COUNT(ProductID) AS ProductCount FROM vw_ProductDetails
GROUP BY CategoryName;

-- Use Case 4: Retrieve Customers with more than 1 orders
-- Using the vw_CustomerOrders view to find customers who have placed more than 1 orders.
SELECT * FROM vw_CustomerOrders 
WHERE TotalOrders > 1;

-- Use Case 5: Retrieve the total amount spent by each customer
-- Using the vw_CustomerOrders view to get the total amount spent by each customer.
SELECT CustomerID, FirstName, LastName, TotalAmount FROM vw_CustomerOrders

-- Use Case 6: Retrieve Recent Orders above a certain amount
-- Using the vw_RecentOrders view to find the recent orders where the total amount is greater than $500.
SELECT * FROM vw_RecentOrders
WHERE OrderAmount > 500;

-- Use Case 7: Retrieve the latest order for each customer
-- Using the vw_RecentOrders view to find the latest order for each customer.
SELECT * FROM vw_RecentOrders ro
WHERE OrderDate = 
(SELECT MAX(OrderDate) FROM vw_RecentOrders
WHERE CustomerID = ro.CustomerID);

-- Use Case 8: Retrieve products in a specific category
-- Using the vw_ProductDetails view to get all products in a specific category, such as 'Electronics'.
SELECT * FROM vw_ProductDetails
WHERE CategoryName = 'Eelectronics';

-- Use Case 9: Retrieve Total Sales foreach category
-- Using the vw_ProductDetails and vw_CustomerOrders views to calculate the total sales for each category.
SELECT pd.CategoryName, SUM(oi.Quantity * p.Price) AS TotalSales
FROM OrderItems oi INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN vw_ProductDetails pd ON pd.ProductID = p.ProductID
GROUP BY pd.CategoryName
ORDER BY TotalSales DESC;

-- Use Case 10: Retrieve Customers Orders with Product Details
-- Using the vw_ProductDetails and vw_CustomerOrders views to get customer orders along with the details of the product.
SELECT co.CustomerID, co.FirstName, co.LastName, o.OrderID, o.OrderDate, pd.ProductName, oi.Quantity, pd.Price
FROM Orders o INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN vw_ProductDetails pd ON pd.ProductID = oi.ProductID
INNER JOIN vw_CustomerOrders co ON co.CustomerID = o.CustomerID
ORDER BY pd.Price DESC;

-- Use Case 11: Retrieve Top 5 Customers by Total Spending
-- Using the vw_CustomerOrders view to find the top 5 customers based on their total spending.
SELECT TOP 5 CustomerID, FirstName, LastName, TotalAmount
FROM vw_CustomerOrders
ORDER BY TotalAmount DESC;

-- Use Case 12: Retrieve Products with low stock
-- Using the vw_ProductDetails view to find products with stock below a certain threshold, such as 10 units.
SELECT * FROM vw_ProductDetails 
WHERE Stock < 10;

-- Use Case 13: Retrieve Orders Placed in the last 7 days
-- Using the vw_RecentOrders view to find orders placed in the last 7 days.
SELECT * FROM vw_RecentOrders
WHERE OrderDate >= DATEADD(DAY, -7, GETDATE());

-- Use Case 14: Retrieve Products sold in the last month
-- Using the vw_RecentOrders view to find products sold in the last month.
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM vw_RecentOrders ro INNER JOIN OrderItems oi ON ro.OrderID = oi.OrderID
INNER JOIN Products p ON p.ProductID = oi.ProductID
WHERE ro.OrderDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC;