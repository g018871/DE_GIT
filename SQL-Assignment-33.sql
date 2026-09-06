-- TEMPORARY TABLE
CREATE TEMPORARY TABLE Temp_Employees (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Temp_Employees VALUES
(1, 'Arun', 'IT', 60000),
(2, 'Priya', 'HR', 45000),
(3, 'Ravi', 'IT', 70000),
(4, 'Anu', 'Finance', 55000),
(5, 'Kumar', 'Sales', 40000);

SELECT * FROM Temp_Employees;

DESC Temp_Employees;

CREATE TEMPORARY TABLE High_Salary_Employees AS
SELECT *
FROM Temp_Employees
WHERE Salary > 50000;

CREATE TEMPORARY TABLE Employee_Details AS
SELECT EmployeeID, EmployeeName, Department
FROM Temp_Employees;

UPDATE Temp_Employees
SET Salary = 65000
WHERE EmployeeID = 1;

DROP TEMPORARY TABLE Temp_Employees;

-- TRUNCATE
CREATE TABLE Student_Test (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentName VARCHAR(50),
    Marks INT
);

INSERT INTO Student_Test (StudentName, Marks) VALUES
('Arun', 85),
('Priya', 90),
('Ravi', 75),
('Anu', 88),
('Kumar', 65),
('Divya', 92),
('Rahul', 70),
('Sneha', 80),
('Vijay', 95),
('Meena', 78);

SELECT * FROM Student_Test;
TRUNCATE TABLE Student_Test;
SELECT * FROM Student_Test;
-- ------------------------------------------------
DELETE FROM Student_Test;
-- REMOVES ROWS FROM THE TABLE
-- TABLE STRUCTURE REMAINS
-- CAN USE WHERE CONDITION
TRUNCATE TABLE Student_Test;
-- REMOVE ALL ROWS
-- TABLE STRUCTURE REMAINS
-- CANNOT USE WHERE CLAUSE
-- RESET AN AUTO INCREAMENT 
-- ---------------------------------------------------
INSERT INTO Student_Test (StudentName, Marks)
VALUES ('Arjun', 85), ('Neha', 90);
SELECT * FROM Student_Test;
TRUNCATE TABLE Student_Test;
DESC Student_Test;
-- -----------------------------------------------------
TRUNCATE TABLE Employees;
SELECT * FROM Employees;
-- ----------------------------------------------------
CREATE TABLE Test_Employee (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50)
);
INSERT INTO Test_Employee (Name)
VALUES ('Arun'), ('Ravi'), ('Priya');
SELECT * FROM Test_Employee;
TRUNCATE TABLE Test_Employee;
INSERT INTO Test_Employee (Name)
VALUES ('Kumar'), ('Anu');
SELECT * FROM Test_Employee;
-- ---------------------------------------------
/* DELETE -- REMOVES ALL TEH RECORDS BUT KEEPS THE TABLE WHERE CONDITION CAN BE USED
TRUNCATE -- REMOVES ALL TEH RECORDS BUT KEEPS THE TABLE
DROP - REMOVES BOTH TABLE AND DATA */

-- --------------------------------------------
-- SEQUENCE
/*-- MYSQL DOES NOT SUPPORT SEQUENCE DIRECTLY INSTEAD WE CAN GO WITH AUTO INCREMENT
CREATE SEQUENCE employee_seq
START WITH 1001
INCREMENT BY 1;
-- -------------------------------
SELECT employee_seq.NEXTVAL FROM dual;
-- ---------------------------
SELECT employee_seq.NEXTVAL FROM dual;
SELECT employee_seq.NEXTVAL FROM dual;
SELECT employee_seq.NEXTVAL FROM dual;
SELECT employee_seq.NEXTVAL FROM dual;
SELECT employee_seq.NEXTVAL FROM dual;
-- ------------------------------
CREATE SEQUENCE seq1
START WITH 1
INCREMENT BY 1;
-- -------------------------------
CREATE SEQUENCE seq2
START WITH 100
INCREMENT BY 10;
-- ---------------------------
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees
VALUES (employee_seq.NEXTVAL, 'Arun', 'IT', 50000);

-- -------------------------------
INSERT INTO Employees
VALUES (employee_seq.NEXTVAL, 'Arun', 'IT', 50000);
INSERT INTO Employees
VALUES (employee_seq.NEXTVAL, 'Ravi', 'HR', 45000);
INSERT INTO Employees
VALUES (employee_seq.NEXTVAL, 'Priya', 'IT', 60000);
INSERT INTO Employees
VALUES (employee_seq.NEXTVAL, 'Anu', 'Finance', 55000);
INSERT INTO Employees
VALUES (employee_seq.NEXTVAL, 'Kumar', 'Sales', 40000);
-- ------------------------------------
ALTER SEQUENCE employee_seq
RESTART START WITH 5001;
SELECT employee_seq.NEXTVAL FROM dual; */

-- MYSQL STRUCTURE
CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employees(EmployeeName, Department, Salary)
VALUES
('Arun', 'IT', 50000),
('Ravi', 'HR', 45000),
('Priya', 'IT', 60000),
('Anu', 'Finance', 55000),
('Kumar', 'Sales', 40000);

-- -------------------------------------------------------
-- COPY
-- COPY IS NOT DIRECTLY USED IN MYSQL
CREATE TABLE Students (
    StudentID INT,
    StudentName VARCHAR(50),
    Course VARCHAR(50),
    Marks INT
);
COPY Students
TO '/tmp/students.csv'
DELIMITER ','
CSV HEADER;
-- ------------------------
COPY Students
FROM '/tmp/students.csv'
DELIMITER ','
CSV HEADER;
-- --------------------------
COPY (
    SELECT StudentID, StudentName, Marks
    FROM Students
)
TO '/tmp/student_marks.csv'
DELIMITER ','
CSV HEADER;
-- ---------------------------
CREATE TABLE Employees (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
COPY Employees
FROM '/tmp/employees.csv'
DELIMITER ','
CSV HEADER;
-- --------------------------
COPY (
    SELECT *
    FROM Employees
    WHERE Salary > 50000
)
TO '/tmp/high_salary_employees.csv'
DELIMITER ','
CSV HEADER;
-- -----------------------------
COPY Employees
FROM '/tmp/employees.csv'
DELIMITER ','
CSV HEADER
NULL '';
-- ------------------------------
COPY Students
TO '/tmp/students.csv'
DELIMITER ','
CSV HEADER;

-- ------------------------------
-- Challenge Questions
CREATE TEMPORARY TABLE Temp_Average_Salary AS
SELECT
    Department,
    AVG(Salary) AS Average_Salary
FROM Employees
GROUP BY Department;
-- --------------------------------
CREATE SEQUENCE employee_seq
START WITH 1001
INCREMENT BY 1;
CREATE TABLE Employee_Test (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Employee_Test VALUES
(employee_seq.NEXTVAL, 'Arun', 50000),
(employee_seq.NEXTVAL, 'Ravi', 55000),
(employee_seq.NEXTVAL, 'Priya', 60000),
(employee_seq.NEXTVAL, 'Anu', 45000),
(employee_seq.NEXTVAL, 'Kumar', 70000),
(employee_seq.NEXTVAL, 'Meena', 48000),
(employee_seq.NEXTVAL, 'Rahul', 65000),
(employee_seq.NEXTVAL, 'Divya', 52000),
(employee_seq.NEXTVAL, 'Vijay', 58000),
(employee_seq.NEXTVAL, 'Sneha', 62000);
-- ------------------------------------
CREATE TABLE Employee_CSV (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
COPY Employee_CSV
FROM '/tmp/employees.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM Employee_CSV;
TRUNCATE TABLE Employee_CSV;
SELECT * FROM Employee_CSV;
-- -------------------------------------
CREATE SEQUENCE temp_emp_seq
START WITH 1
INCREMENT BY 1;

CREATE TEMPORARY TABLE Temp_Employees (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Salary DECIMAL(10,2)
);
INSERT INTO Temp_Employees VALUES
(temp_emp_seq.NEXTVAL, 'Arun', 50000),
(temp_emp_seq.NEXTVAL, 'Ravi', 55000),
(temp_emp_seq.NEXTVAL, 'Priya', 60000),
(temp_emp_seq.NEXTVAL, 'Kumar', 45000),
(temp_emp_seq.NEXTVAL, 'Anu', 70000);
SELECT * FROM Temp_Employees;
UPDATE Temp_Employees
SET Salary = 65000
WHERE EmployeeID = 1;
SELECT * FROM Temp_Employees
WHERE EmployeeID = 1;
TRUNCATE TABLE Temp_Employees;
-- ----------------------------------------
CREATE TABLE Employees (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);
COPY Employees
FROM '/tmp/employees.csv'
DELIMITER ','
CSV HEADER;
SELECT * FROM Employees;
CREATE TEMPORARY TABLE Temp_Employees AS
SELECT * FROM Employees;
SELECT * FROM Temp_Employees;
UPDATE Temp_Employees
SET Salary = 60000
WHERE EmployeeID = 1;
SELECT * FROM Temp_Employees
WHERE EmployeeID = 1;
TRUNCATE TABLE Temp_Employees;
SELECT * FROM Temp_Employees;
-- --------------------------------------
