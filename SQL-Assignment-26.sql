-- AUTOCOMMIT
CREATE TABLE EmployeeDB.Employees2  (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO EmployeeDB.Employees2 VALUES (1, 'Arun', 'IT', 50000);
SELECT * FROM EmployeeDB.Employees2;

SELECT @@AUTOCOMMIT; -- CHECKED IN GOOGLE

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2 VALUES (2, 'Priya', 'HR', 45000);
SELECT * FROM EmployeeDB.Employees2;
COMMIT;
ROLLBACK;

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2
VALUES (3, 'Ravi', 'Sales', 40000),(4, 'Meena', 'Finance', 55000),(5, 'Kiran', 'IT', 60000);
SELECT * FROM EmployeeDB.Employees2;
COMMIT;
ROLLBACK;

SET AUTOCOMMIT = 1;
INSERT INTO EmployeeDB.Employees2 VALUES (6, 'Suresh', 'Marketing', 48000);
SELECT * FROM EmployeeDB.Employees2;

-- COMMIT

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2 VALUES (7, 'Anil', 'IT', 52000),(8, 'Divya', 'HR', 47000),(9, 'Rahul', 'Sales', 43000),(10, 'Sneha', 'Finance', 58000),(11, 'Vijay', 'Marketing', 49000);
SELECT * FROM EmployeeDB.Employees2;
COMMIT;

SET AUTOCOMMIT = 0;
UPDATE EmployeeDB.Employees2 SET Salary = 65000 WHERE EmployeeID = 1;
SELECT * FROM EmployeeDB.Employees2 WHERE EmployeeID = 1;
COMMIT;

SET AUTOCOMMIT = 0;
DELETE FROM EmployeeDB.Employees2 WHERE EmployeeID = 11;
SELECT * FROM EmployeeDB.Employees2 WHERE EmployeeID = 11;
COMMIT;

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2 VALUES (12, 'Karthik', 'IT', 55000);
UPDATE EmployeeDB.Employees2 SET Salary = 70000 WHERE EmployeeID = 2;
DELETE FROM EmployeeDB.Employees2 WHERE EmployeeID = 10;
SELECT * FROM EmployeeDB.Employees2;
COMMIT;

SET AUTOCOMMIT = 0;
INSERT INTO ShoppingDB.Products VALUES (101, 'Laptop','HP','ELECTRONICS', 55000, 10,'2025-06-01','20%'), (102, 'Keyboard','HP','ELECTRONICS', 1500, 10,'2025-06-01','20%');
UPDATE ShoppingDB.Products SET Price = 60000 WHERE ProductID = 1;
SELECT * FROM ShoppingDB.Products;
COMMIT;

-- ROLLBACK

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2 VALUES (13, 'Asha', 'IT', 50000),(14, 'Mohan', 'HR', 45000),(15, 'Deepa', 'Sales', 42000);
SELECT * FROM EmployeeDB.Employees2 WHERE EmployeeID IN (13, 14, 15);
ROLLBACK;
SELECT * FROM EmployeeDB.Employees2 WHERE EmployeeID IN (13, 14, 15);

SET AUTOCOMMIT = 0;
SELECT EmployeeID, EmployeeName, Salary FROM EmployeeDB.Employees2 WHERE EmployeeID = 1;
UPDATE EmployeeDB.Employees2 SET Salary = 80000 WHERE EmployeeID = 1;
SELECT EmployeeID, EmployeeName, Salary FROM EmployeeDB.Employees2 WHERE EmployeeID = 1;
ROLLBACK;
SELECT EmployeeID, EmployeeName, Salary FROM EmployeeDB.Employees2 WHERE EmployeeID = 1;

SET AUTOCOMMIT = 0;
DELETE FROM EmployeeDB.Employees2 WHERE EmployeeID IN (8, 9);
SELECT * FROM EmployeeDB.Employees2 WHERE EmployeeID IN (8, 9);
ROLLBACK;
SELECT * FROM EmployeeDB.Employees2 WHERE EmployeeID IN (8, 9);

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2 VALUES (16, 'Nisha', 'IT', 52000);
UPDATE EmployeeDB.Employees2 SET Salary = 75000 WHERE EmployeeID = 2;
DELETE FROM EmployeeDB.Employees2 WHERE EmployeeID = 7;
SELECT * FROM EmployeeDB.Employees2;
ROLLBACK;
SELECT * FROM EmployeeDB.Employees2;

SET AUTOCOMMIT = 0;
INSERT INTO EmployeeDB.Employees2 VALUES (17, 'Pooja', 'HR', 46000),(18, 'Sanjay', 'Finance', 59000);
UPDATE EmployeeDB.Employees2 SET Salary = 68000 WHERE EmployeeID = 1;
DELETE FROM EmployeeDB.Employees2 WHERE EmployeeID = 7;
SELECT * FROM EmployeeDB.Employees2;
ROLLBACK;
SELECT * FROM EmployeeDB.Employees2;
INSERT INTO EmployeeDB.Employees2 VALUES (17, 'Pooja', 'HR', 46000),(18, 'Sanjay', 'Finance', 59000);
UPDATE EmployeeDB.Employees2 SET Salary = 68000 WHERE EmployeeID = 1;
DELETE FROM EmployeeDB.Employees2 WHERE EmployeeID = 7;
COMMIT;
SELECT * FROM EmployeeDB.Employees2;
