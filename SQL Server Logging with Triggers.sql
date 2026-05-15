

/*
TRIGGERS - To automatically log the changes in the databse
Triggers are special types of stored procedure that automatically execute in response
to certain events on a table, such as INSERT, UPDATE or DELETE
*/

-- Step 1: Create a Log Table
CREATE TABLE ChangeLog
(
    LogID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
    TableName NVARCHAR(50),
    Opeartion NVARCHAR(10),
    RecordID INT,
    ChangeDate DATETIME DEFAULT GETDATE(),
    ChangeBy NVARCHAR(100)
);
GO

-- Step 2: Create Triggers for Each Table

-- A. Triggers for Product Table
      -- Trigger for INSERT on Products Table

      CREATE OR ALTER TRIGGER trg_Insert_Product
      ON Products
      AFTER INSERT
      AS
      BEGIN
            -- Insert a record into a ChangeLog Table
            INSERT INTO ChangeLog(TableName, Opeartion, RecordID, ChangeBy)
            SELECT 'Products', 'INSERT', inserted.ProductID, '1'
            FROM inserted;

            -- Display a message indicating that the trigger has fixed
            PRINT 'INSERT Operation logged for Products Table.';
      END

      -- Inserting records into Products Table
      INSERT INTO Products (ProductName, CategoryID, Price, Stock)
      VALUES
      ('Wireless Mouse', 1, 49.99, 20),
      ('Shirts', 2, 99.99, 150);

      -- SELECT all records from Products Table
      SELECT * FROM Products;

      -- SELECT all records from ChangeLog Table
      SELECT * FROM ChangeLog;



      -- Trigger for UPDATE on Products Table

      CREATE OR ALTER TRIGGER trg_Update_Product
      ON Products 
      AFTER UPDATE
      AS
      BEGIN

            -- Insert a table into a ChangeLog table
            INSERT INTO ChangeLog(TableName, Opeartion, RecordID, ChangeBy)
            SELECT 'Products', 'UPDATE', inserted.ProductID, '1'
            FROM inserted;

            -- Display a message indicating that the trigger has fixed
            PRINT 'UPDATE Operation logged for Products table';

      END

      -- Updating records from Products table
      UPDATE Products SET Price = 590.99 WHERE ProductID = 7

      -- SELECT all records from Products Table
      SELECT * FROM Products;

      -- SELECT all records from ChangeLog Table
      SELECT * FROM ChangeLog;




      -- Trigger for DELETE on Products Table
      CREATE OR ALTER TRIGGER trg_Delete_Product
      ON Products
      AFTER DELETE
      AS
      BEGIN

            -- Insert a record in the ChangeLog table
            INSERT INTO ChangeLog (TableName, Opeartion, RecordID, ChangeBy)
            SELECT 'Products', 'DELELTE', deleted.ProductID, '1'
            FROM deleted

            -- Display a message indicating that the trigger has fixed
            PRINT 'DELETE Operation logged for Products table';

      END

      -- Deleting records from Products table
      DELETE FROM Products WHERE ProductID = 10;

      -- SELECT all records from Products Table
      SELECT * FROM Products;

      -- SELECT all records from ChangeLog Table
      SELECT * FROM ChangeLog;





-- B. Triggers for Customers Table
      -- Trigger for INSERT on Customers Table

      CREATE OR ALTER TRIGGER trg_Insert_Customer
      ON Customers
      AFTER INSERT
      AS
      BEGIN

            -- Insert a record in the ChangeLog table
            INSERT INTO ChangeLog(TableName, Opeartion, RecordID, ChangeBy)
            SELECT 'Customers', 'INSERT', inserted.CustomerID, '1'
            FROM inserted;

            -- Display a message indicating that the trigger has fixed
            PRINT 'INSERT Operation logged for Customers table.';

      END

      -- Inserting records in the Customers table
        INSERT INTO Customers (FirstName, LastName,Email, Phone, Address, City, State, ZipCode, Country)
        VALUES
        ('Geeta', 'Patil', 'geeta@example.com', '370-2710-2813', '789 wok St.', 'Nagpur', 'Maharashtra', '678383', 'India'),
        ('Harshad', 'Khanna', 'harshad@example.com', '379-2791-1593', '123 owk St.', 'Amravati', 'Maharashtra', '782026', 'India');

      -- Select all records from Customers Table
      SELECT * FROM Customers;

      -- Select all records from ChangeLog Table
      SELECT * FROM ChangeLog;




      -- Trigger for UPDATE on Customers Table

      CREATE OR ALtER TRIGGER trg_Update_Customer
      ON Customers
      AFTER UPDATE
      AS 
      BEGIN

            -- Insert a record in the ChangeLog table
            INSERT INTO ChangeLog (TableName, Opeartion, RecordID, ChangeBy)
            SELECT 'Customers', 'UPDATE', inserted.CustomerID, '1'
            FROM inserted;
            
            -- Display a message indicating that the trigger has fixed
            PRINT 'UPDATE Operation logged for Customers table.';

      END

      -- Updating records in the Customers table
      UPDATE Customers SET FirstName = 'Harsh' WHERE CustomerID = 6;

      
      -- Select all records from Customers Table
      SELECT * FROM Customers;

      -- Select all records from ChangeLog Table
      SELECT * FROM ChangeLog;




      -- Trigger for DELETE on Customers Table

      CREATE OR ALTER TRIGGER trg_delete_Customer
      ON Customers
      AFTER DELETE
      AS
      BEGIN

            -- Insert a record in the ChangeLog table
            INSERT INTO ChangeLog (TableName, Opeartion, RecordID, ChangeBy)
            SELECT 'Customers', 'DELETE', deleted.CustomerID, '1'
            FROM deleted;

            -- Display a message indicating that the trigger has fixed
            PRINT 'DELETE Operation logged for Customers table.';

      END

      -- Delete records in the Customers table
      DELETE FROM Customers WHERE CustomerID = 6;

      -- Select all records from Customers Table
      SELECT * FROM Customers;

      -- Select all records from ChangeLog Table
      SELECT * FROM ChangeLog;