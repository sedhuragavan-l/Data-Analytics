create database db_emp;
use db_emp;


-- Step 1: Create the Employee Table
CREATE TABLE Employees(
    EmployeeId INT PRIMARY KEY,
    Name VARCHAR(50),
    DEPTID INT,
    Salary INT,
    Location VARCHAR(50)
);
 
-- Step 2: Insert Sample Data
INSERT INTO Employees VALUES
(101, 'John', 1, 20000, 'Chennai'),
(102, 'Jane', 2, 25000, 'Bangalore'),
(103, 'Doe', 1, 22000, 'Chennai'),
(104, 'Smith', 2, 30000, 'Hyderabad');
COMMIT;
 
-- Step 3: Create a Log Table for Employee Counts
CREATE TABLE Employee_Log (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    Count_Chennai INT,
    Total_Employees INT,
    Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
 
-- Step 4: Drop Function If It Already Exists
DROP FUNCTION IF EXISTS update_employee_salary;
 
-- Step 5: Create the Function to Update Employee Salary
DELIMITER //
CREATE FUNCTION update_employee_salary(emp_id INT, increment INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    -- Update the Salary
    UPDATE Employee
    SET Salary = Salary + increment
    WHERE EmployeeId = emp_id;
 
    -- Return Success Message
    RETURN CONCAT('Salary updated successfully for Employee ID: ', emp_id);
END;
//
DELIMITER ;
 
-- Step 6: Drop Trigger If It Already Exists
DROP TRIGGER IF EXISTS trg_employee_count_update;
 
-- Step 7: Create a Trigger to Log Chennai and Total Employee Counts After Salary Update
DELIMITER //
CREATE TRIGGER trg_employee_count_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    DECLARE chennai_count INT;
    DECLARE total_count INT;
 
    -- Count Employees in Chennai
    SELECT COUNT(*) INTO chennai_count
    FROM Employee
    WHERE Location = 'Chennai';
 
    -- Count Total Employees
    SELECT COUNT(*) INTO total_count
    FROM Employee;
 
    -- Log the counts into the Employee_Log table
    INSERT INTO Employee_Log (Count_Chennai, Total_Employees)
    VALUES (chennai_count, total_count);
END;
//
DELIMITER ;
 
-- Step 8: Testing the Function and Trigger
 
-- Test the Function by Updating an Employee's Salary
SELECT update_employee_salary(101, 5000);
 
-- Verify Chennai and Total Employee Counts in the Log Table
SELECT * FROM Employee_Log;
 
-- Additional Salary Updates
UPDATE Employee SET Salary = Salary + 1000 WHERE EmployeeId = 103;
 
-- Check the Updated Log
SELECT * FROM Employee_Log;