create database Day2;
use Day2;

-- Step 1: Creating the Employee table
CREATE TABLE Employee (
    EmployeeId INT PRIMARY KEY,
    Name VARCHAR(50),
    DEPTID INT,
    Salary INT,
    Location VARCHAR(50)
);
 
-- Step 2: Inserting initial data into the Employee table
INSERT INTO Employee VALUES (123, 'VMNV', 10, 10000, 'Chennai');
COMMIT;
 
-- Step 3: Creating the Department table
CREATE TABLE Department (
    DEPTID INT PRIMARY KEY,
    DEPTNAME VARCHAR(50),
    COUNT_OF_EMPLOYEE INT
);
 
-- Step 4: Inserting initial data into the Department table
INSERT INTO Department VALUES (10, 'TN', 21);
COMMIT;
 
-- Step 5: Creating the Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price INT
);
 
-- Step 6: Inserting initial data into the Products table
INSERT INTO Products VALUES (1, 'Smartphone', 'Electronics', 1500);
INSERT INTO Products VALUES (2, 'TV', 'Electronics', 2000);
INSERT INTO Products VALUES (3, 'Washing Machine', 'Home Appliances', 800);
COMMIT;
 
-- Step 7: Creating a log table for triggers
CREATE TABLE TriggerLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Message VARCHAR(255),
    LogTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Step 8: Creating a Trigger to Log the Count of Rows After Inserting a New Record into the Employee Table
DELIMITER //
CREATE TRIGGER trg_after_insert_employee
AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
    DECLARE row_count INT;
    SELECT COUNT(*) INTO row_count FROM Employee;
    INSERT INTO TriggerLog (Message) VALUES (CONCAT('Total number of rows in Employee table: ', row_count));
END;
//
DELIMITER ;
 
-- Step 9: Creating a Trigger to Log the Count of Employees Whose Salary Got Updated
DELIMITER //
CREATE TRIGGER trg_after_update_salary
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    DECLARE updated_count INT;
    SELECT COUNT(*) INTO updated_count FROM Employee WHERE Salary <> OLD.Salary;
    INSERT INTO TriggerLog (Message) VALUES (CONCAT('Number of employees whose salary got updated: ', updated_count));
END;
//
DELIMITER ;
 
-- Step 10: Creating a View to Display the Details of Employees from Chennai Location and TN Team
CREATE OR REPLACE VIEW vw_chennai_tn_employees AS
SELECT *
FROM Employee
WHERE Location = 'Chennai' AND DEPTID IN (
    SELECT DEPTID FROM Department WHERE DEPTNAME = 'TN'
);
 
-- Step 11: Creating a View to Display the Details of Products from 'Electronics' with Price > 1000
CREATE OR REPLACE VIEW vw_electronics_products AS
SELECT *
FROM Products
WHERE Category = 'Electronics' AND Price > 1000;
 
-- Step 12: Testing the Triggers and Views
 
-- Insert a new employee (Triggers row count logging)
INSERT INTO Employee VALUES (124, 'John', 10, 12000, 'Bangalore');
COMMIT;
 
-- Update an employee's salary (Triggers salary update logging)
UPDATE Employee SET Salary = 15000 WHERE EmployeeId = 123;
COMMIT;
 
-- View the logged messages
SELECT * FROM TriggerLog;
 
-- View Employees from Chennai and TN Team
SELECT * FROM vw_chennai_tn_employees;
 
-- View Electronics Products with Price > 1000
SELECT * FROM vw_electronics_products;

