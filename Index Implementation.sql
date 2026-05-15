/*
========================================================
SQL Server Indexing & Query Optimization
========================================================

Indexes are crucial for optimizing the performance of you SQL Server database, 
especially for read - heavy operations like SELECT queries.

Description:
This script demonstrates the implementation of
Clustered and Non-Clustered Indexes in SQL Server
to improve query performance for read-heavy operations.

Concepts Covered:
1. Clustered Indexes
2. Non-Clustered Indexes
3. Foreign Key Constraint Handling
4. Query Optimization
5. Performance Testing using STATISTICS IO/TIME
6. Execution Plan Analysis
*/

/*
NOTE:
Primary Keys in SQL Server usually create Clustered Indexes automatically.

These indexes are created explicitly here for learning and demonstration purposes.
*/


/*
Clustered Index: Stores data physically in sorted order.

Non-Clustered Index: Stores index separately and improves filter/search query performance.
*/



-- A. Indexes on Categories Table
	-- 1. Cluseterd Index on CategoryID: Usually created with Primary Key

	CREATE CLUSTERED INDEX IDX_CategoriesCategoryID
	ON Categories(CategoryID);
	GO

-- B. Indexes on Products Table

-- Drop Foreign Key Constraints from OrderItems Table - ProductID
ALTER TABLE OrderItems DROP CONSTRAINT FK_OrderItems_Products;

	-- 1. Clustered Index on ProductID : This is usually created automatically when the Primary Key is defined
	CREATE CLUSTERED INDEX IDX_Product_ProductID
	ON Products(ProductID);
	GO

	-- 2. Non - Clustered Index on CategoryID : TO speed up queries filtering by CategoryID
	CREATE NONCLUSTERED INDEX IDX_Product_CategoryID
	ON Products(CategoryID);
	GO

    -- 3. Non - Clustered Index on Price : TO speed up queries filtering by CategoryID
	CREATE NONCLUSTERED INDEX IDX_Product_Price
	ON Products(Price);
	GO

	-- Recreate Foreign Key Constarint on OrderItems Table(ProductID)
	ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_ProductID
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID);



	
-- B. Indexes on Orders Table

	-- Drop Foreign Key Constraints from OrderItems Table - OrderID
	ALTER TABLE OrderItems DROP CONSTRAINT FK__OrderItem__Order__440B1D61;

	-- 1. Clustered Index on OrderID : This is usually created automatically when the Primary Key is defined
	CREATE CLUSTERED INDEX IDX_Orders_OrderID
	ON Orders(OrderID);
	GO

	-- 2. Non - Clustered Index on CustomerID : TO speed up queries filtering by CustomerID
	CREATE NONCLUSTERED INDEX IDX_Ordres_CustomerID
	ON Orders(CustomerID);
	GO

    -- 3. Non - Clustered Index on OrderDate : TO speed up queries filtering by OrderDate
	CREATE NONCLUSTERED INDEX IDX_Orders_OrderDate
	ON Orders(OrderDate);
	GO

	-- Recreate Foreign Key Constarint on OrderItems Table(OrderID)
	ALTER TABLE OrderItems ADD CONSTRAINT FK_OrderItems_OrderID
	FOREIGN KEY (OrderID) REFERENCES Orders(OrderID);


	
-- C. Indexes on OrderItems Table

	-- 1. Clustered Index on OrderItemID : This is usually created automatically when the Primary Key is defined
	CREATE CLUSTERED INDEX IDX_OrderItems_OrderItemID
	ON OrderItems(OrderItemID);
	GO

	-- 2. Non - Clustered Index on OrderID : TO speed up queries filtering by OrderID
	CREATE NONCLUSTERED INDEX IDX_OrdreItems_OrderID
	ON OrderItems(OrderID);
	GO

    -- 3. Non - Clustered Index on ProductID : TO speed up queries filtering by ProductID
	CREATE NONCLUSTERED INDEX IDX_OrderItems_ProductID
	ON OrderItems(ProductID);
	GO




-- D. Indexes on Customers Table

-- Drop Foreign Key Constraints from Orders Table - CustomerID
	ALTER TABLE Orders DROP CONSTRAINT FK__Orders__Customer__403A8C7D;


	-- 1. Clustered Index on CustomerID : This is usually created automatically when the Primary Key is defined
	CREATE CLUSTERED INDEX IDX_Customers_CustomerID
	ON Customers(CustomerID);
	GO

	-- 2. Non - Clustered Index on Email : TO speed up queries filtering by Email
	CREATE NONCLUSTERED INDEX IDX_Customers_Email
	ON Customers(Email);
	GO

    -- 3. Non - Clustered Index on Country : TO speed up queries filtering by Country
	CREATE NONCLUSTERED INDEX IDX_Customers_Country
	ON Customers(Country);
	GO

	-- Recreate Foreign Key Constarint on Orders Table(CustomerID)
	ALTER TABLE Orders ADD CONSTRAINT FK_Orders_CustomerID
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID);


/*
========================================================
Performance Testing Before & After Indexing
========================================================
*/

SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- Query using CustomerID
SELECT *
FROM Orders
WHERE CustomerID = 1;
GO


-- Query using ProductID
SELECT *
FROM OrderItems
WHERE ProductID = 1;
GO

/*
Expected Results:
1. Reduced Logical Reads
2. Faster Query Execution
3. Index Seek instead of Table Scan
4. Lower CPU Time
*/

