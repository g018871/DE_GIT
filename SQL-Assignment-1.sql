CREATE DATABASE StudentDB;

CREATE TABLE STUDENTDB.STUDENTS
(
StudentID INT PRIMARY KEY,
StudentName VARCHAR(50),
Age INT,
Gender CHAR(1),
Email VARCHAR( 50),
Phone BIGINT,
Department VARCHAR(50)
);

SELECT * FROM STUDENTDB.STUDENTS;

CREATE DATABASE EmployeeDB;

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

SELECT * FROM EmployeeDB.Employees;

CREATE DATABASE HospitalDB;

CREATE TABLE HospitalDB.Patients
(
PatientID INT PRIMARY KEY,
PatientName VARCHAR(50),
AGE INT ,
Gender CHAR(1),
BloodGroup VARCHAR(10),
Phone BIGINT,
Disease VARCHAR(50),
AdmissionDate DATE
);

SELECT * FROM HospitalDB.Patients;

CREATE DATABASE LibraryDB;

CREATE TABLE LibraryDB.Books
(
BookID INT PRIMARY KEY,
BookName VARCHAR(50),
Author VARCHAR(30) ,
Category VARCHAR(20),
Price decimal(6,2),
PublishedYear int,
Quantity INT
);

SELECT * FROM LibraryDB.Books;

CREATE DATABASE ShoppingDB;

CREATE TABLE ShoppingDB.Products
(
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(30) ,
Brand VARCHAR(30),
Price DECIMAL(8,2),
StockQuantity BIGINT,
ManufacturingDate DATE
);

SELECT * FROM ShoppingDB.Products;

CREATE DATABASE CollegeDB;

CREATE TABLE CollegeDB.Courses
(
CourseID INT PRIMARY KEY,
CourseName VARCHAR(50),
Duration VARCHAR(10) ,
Department VARCHAR(30),
Fees DECIMAL(8,2),
FacultyName VARCHAR(30)
);

SELECT * FROM CollegeDB.Courses;

CREATE DATABASE BankDB;

CREATE TABLE BankDB.Accounts
(
AccountID INT PRIMARY KEY,
CustomerName VARCHAR(50),
AccountType VARCHAR(10) ,
AccountNumber BIGINT,
Balance DECIMAL(8,2),
Branch VARCHAR(30),
OpeningDate DATE
);

SELECT * FROM BankDB.Accounts;

CREATE DATABASE HotelDB;

CREATE TABLE HotelDB.Rooms
(
RoomID INT PRIMARY KEY,
RoomNumber INT,
RoomType VARCHAR(20) ,
PricePerDay DECIMAL(8,2),
Availability CHAR(1),
FloorNumber INT
);

SELECT * FROM HotelDB.Rooms;

CREATE DATABASE MovieDB;

CREATE TABLE MovieDB.Movies
(
MovieID INT PRIMARY KEY,
MovieName VARCHAR(30),
Genre VARCHAR(20) ,
Language VARCHAR(10),
Duration VARCHAR(40),
ReleaseDate DATE,
Rating DECIMAL(2,1)
);

SELECT * FROM MovieDB.Movies;

CREATE DATABASE ECommerceDB;

CREATE TABLE ECommerceDB.Customers
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(30),
Email VARCHAR(80) ,
Phone VARCHAR(15),
City VARCHAR(40),
State VARCHAR(20),
Country VARCHAR(20),
RegistrationDate DATE
);

SELECT * FROM ECommerceDB.Customers;