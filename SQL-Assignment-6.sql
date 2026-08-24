-- UNIQUE CONSTRAINT

CREATE TABLE StudentDB.students
(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
Age INT,
Gender CHAR(1),
Email VARCHAR(50) UNIQUE,
Phone BIGINT,
Department VARCHAR(50)
);

ALTER TABLE EmployeeDB.Employees
ADD PHONE BIGINT UNIQUE;

CREATE TABLE ShoppingDB.Products
(
ProductID INT PRIMARY KEY,
Productcode varchar(20) Unique,
ProductName VARCHAR(50),
Category VARCHAR(30) ,
Brand VARCHAR(30),
Price DECIMAL(8,2),
StockQuantity BIGINT,
ManufacturingDate DATE
);

INSERT INTO StudentDB.students
VALUES(101,'AISHU',19,'F','AISHU19@GMAIL.COM',9894354621,'ECE'),(102,'AISHU',19,'F','AISHU19@GMAIL.COM',9894354621,'ECE'); 
-- Error Code: 1062. Duplicate entry 'AISHU19@GMAIL.COM' for key 'students.Email'

-- Primary key

CREATE TABLE StudentDB.students
(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
Age INT,
Gender CHAR(1),
Email VARCHAR(50) UNIQUE,
Phone BIGINT,
Department VARCHAR(50)
);

CREATE TABLE EmployeeDB.Employees
(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
DateOfBirth DATE ,
Gender CHAR(1),
Department VARCHAR(50),
JOBROLE VARCHAR(50),
SALARY DECIMAL(8,2),
JOINING_DATE DATE
);

INSERT INTO EmployeeDB.Employees
VALUES(101,'RITHU','Finance','F','Developer',15000,'2025-08-03','rithumika.selvan@gmail.com', 9894038742),
(101,'RITHU','Finance','F','Developer',15000,'2025-08-03','rithumika.selvan@gmail.com', 9500886542)
; -- Error Code: 1062. Duplicate entry '101' for key 'employees.PRIMARY'	

INSERT INTO StudentDB.students
VALUES(null,'AISHU',19,'F','AISHU19@GMAIL.COM',9894354621,'ECE');
-- Error Code: 1048. Column 'StudentID' cannot be null	0.046 sec

-- COMPOSITE KEY

CREATE TABLE StudentDB.StudentCourses
(
StudentID INT,
CourseID VARCHAR(10),
EnrollmentDate DATE
);

CREATE TABLE StudentDB.StudentCourses
(
StudentID INT,
CourseID VARCHAR(10),
EnrollmentDate DATE,
PRIMARY KEY(StudentID,CourseID)
);

INSERT INTO StudentDB.StudentCourses
VALUES(101,501,'2026-05-05');

INSERT INTO StudentDB.StudentCourses
VALUES(101,501,'2026-05-05'); -- Error Code: 1062. Duplicate entry '101-501' for key 'studentcourses.PRIMARY'	

INSERT INTO StudentDB.StudentCourses
VALUES(101,502,'2026-05-05');

-- FOREIGN KEY

CREATE TABLE EMPLOYEEDB.Departments
(
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(50)
);

CREATE TABLE EMPLOYEEDB.Employees1
(
EmployeeID INT PRIMARY KEY,
EMPLOYEENAME VARCHAR(30),
DEPARTMENTID INT,
 FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO EMPLOYEEDB.Departments
VALUES(101,'IT'),(102,'HR'),(103,'SALES');

INSERT INTO EMPLOYEEDB.Employees1
VALUES(1001,'SANDHIYA',101),(1002,'BABY',102),(1003,'RITHU',103) ;

INSERT INTO EMPLOYEEDB.Employees1
VALUES(1004,'RAJA',104) ; -- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`employeedb`.`employees1`, CONSTRAINT `employees1_ibfk_1` FOREIGN KEY (`DEPARTMENTID`) REFERENCES `departments` (`DepartmentID`))	0.063 sec

-- NOT NULL

CREATE TABLE StudentDB.students1
(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50) NOT NULL,
Age INT,
Gender CHAR(1),
Email VARCHAR(50) NOT NULL,
Phone BIGINT,
Department VARCHAR(50)
);

INSERT INTO STUDENTDB.STUDENTS1
(StudentID,Age,Gender,Email,Phone,Department)
VALUES(101,28,'M','RAJU@GMAIL.COM',9542635144,'IT'); -- Error Code: 1364. Field 'StudentName' doesn't have a default value	0.078 sec

INSERT INTO STUDENTDB.STUDENTS1
VALUES(101,'RAJU',28,'M',NULL,9542635144,'IT'); -- Error Code: 1048. Column 'Email' cannot be null	0.000 sec

-- check constarint

CREATE TABLE EmployeeDB.Employees2
(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
DateOfBirth DATE ,
Gender CHAR(1),
Department VARCHAR(50),
JOBROLE VARCHAR(50),
SALARY DECIMAL(8,2) check (salary > 10000),
JOINING_DATE DATE
);

INSERT INTO EmployeeDB.Employees2
VALUES(101,'RITHU','1998-08-03','F','Finance','DEVELOPER',8000,'2025-05-04'); 
-- Error Code: 3819. Check constraint 'employees2_chk_1' is violated.	0.047 sec

CREATE TABLE StudentDB.students1
(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50) NOT NULL,
Age INT CHECK (AGE BETWEEN 18 AND 60),
Gender CHAR(1),
Email VARCHAR(50) NOT NULL,
Phone BIGINT,
Department VARCHAR(50)
);

INSERT INTO STUDENTDB.STUDENTS1
(StudentID,STUDENTNAME,Age,Gender,Email,Phone,Department)
VALUES(101,'RAJU',15,'M','RAJU@GMAIL.COM',9542635144,'IT'); -- Error Code: 3819. Check constraint 'students1_chk_1' is violated.	0.000 sec

CREATE TABLE ShoppingDB.Products
(
ProductID INT PRIMARY KEY,
Productcode varchar(20) Unique,
ProductName VARCHAR(50),
Category VARCHAR(30) ,
Brand VARCHAR(30),
Price DECIMAL(8,2) CHECK(PRICE> 0),
StockQuantity BIGINT,
ManufacturingDate DATE
);

CREATE TABLE HospitalDB.Patients
(
PatientID INT PRIMARY KEY,
PatientName VARCHAR(50),
AGE INT CHECK(AGE>=0),
Gender CHAR(1),
BloodGroup VARCHAR(10),
Phone BIGINT,
Disease VARCHAR(50),
AdmissionDate DATE
);

-- DEFAULT CONSTRAINT

DROP TABLE EMPLOYEEDB.EMPLOYEES3;
CREATE TABLE EmployeeDB.Employees3
(
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50),
DateOfBirth DATE ,
Gender CHAR(1),
Department VARCHAR(50) DEFAULT 'IT',
JOBROLE VARCHAR(50),
SALARY DECIMAL(8,2) ,
JOINING_DATE DATE
);

INSERT INTO EmployeeDB.Employees3
(EMPLOYEEID,EMPLOYEENAME,DATEOFBIRTH,GENDER,JOBROLE,SALARY,JOINING_DATE)
VALUES(101,'RITHU','1998-08-03','F','DEVELOPER',8000,'2025-05-04'); 

SELECT * FROM EmployeeDB.Employees3;

CREATE TABLE ShoppingDB.Products1
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(30) ,
Brand VARCHAR(30),
Price DECIMAL(8,2),
StockQuantity INT DEFAULT 0,
ManufacturingDate DATE
);

INSERT INTO SHOPPINGDB.Products1 
(PRODUCTID,PRODUCTNAME,CATEGORY,BRAND,PRICE,MANUFACTURINGDATE) 
VALUES(101,'PEN','STATIONARY','CELLO',5,'2026-06-07');

SELECT * FROM SHOPPINGDB.Products1;

-- COMBINATION PRACTICE

CREATE TABLE StudentDB.students
(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50) NOT NULL,
Email VARCHAR(50) UNIQUE,
Age INT CHECK(AGE BETWEEN 18 AND 60),
CITY VARCHAR(30) DEFAULT 'CHENNAI'
);

CREATE TABLE EMPLOYEEDB.DEPARTMENTS
(
DEPARTMENTID INT PRIMARY KEY,
DEPARTMENTNAME VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE EMPLOYEEDB.EMPLOYEES
(
EMPLOYEEID INT PRIMARY KEY,
EMPLOYEENAME VARCHAR(30) NOT NULL,
EMAIL VARCHAR(50) UNIQUE,
SALARY DECIMAL(5,2) CHECK(SALARY > 10000),
DEPARTMENTID INT ,
FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

CREATE TABLE STUDENTDB.StudentCourses
(
StudentID INT,
CourseID INT,
EnrollmentDate date,
PRIMARY KEY (StudentID , CourseID)
);

CREATE TABLE ShoppingDB.Products
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50) UNIQUE,
Category VARCHAR(30) NOT NULL,
Brand VARCHAR(30),
Price DECIMAL(8,2) CHECK(PRICE >0),
StockQuantity BIGINT DEFAULT 0,
ManufacturingDate DATE
);