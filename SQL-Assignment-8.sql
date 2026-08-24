-- IN and NOT IN 

SELECT * FROM StudentDB.students WHERE DEPARTMENT IN ('IT','CSE','ECE');
SELECT * FROM EmployeeDB.Employees WHERE DEPARTMENT IN ('HR','FINANCE','IT');
SELECT * FROM HospitalDB.Patients WHERE BLOODGROUP IN ('A+VE','B+VE','O+VE');
SELECT * FROM LibraryDB.Books WHERE CATEGORY IN ('Technology','History','Science');
SELECT * FROM ShoppingDB.Products WHERE CATEGORY IN ('Electronics', 'Accessories', 'Furniture');
SELECT * FROM CollegeDB.Courses WHERE DEPARTMENT IN ('IT','CSE','ECE');
SELECT * FROM MovieDB.Movies WHERE Language IN ('Tamil', 'English','Hindi');
SELECT * FROM HotelDB.Rooms WHERE ROOMTYPE IN ('Single', 'Double','Deluxe');
SELECT * FROM ECommerceDB.Customers WHERE CITY IN ('Chennai', 'Coimbatore', 'Madurai');
SELECT * FROM EmployeeDB.Employees WHERE DESIGNATION IN ('Developer', 'Tester','Analyst');

-- NOT IN OPERATOR

SELECT * FROM StudentDB.students WHERE DEPARTMENT NOT IN ('IT','CSE','ECE');
SELECT * FROM EmployeeDB.Employees WHERE DEPARTMENT NOT IN ('HR','FINANCE');
SELECT * FROM HospitalDB.Patients WHERE BLOODGROUP NOT IN ('A+VE','B+VE','O+VE');
SELECT * FROM LibraryDB.Books WHERE CATEGORY NOT IN ('Technology','History');
SELECT * FROM ShoppingDB.Products WHERE CATEGORY NOT IN ('Electronics', 'Accessories');
SELECT * FROM CollegeDB.Courses WHERE DEPARTMENT NOT IN ('IT','CSE');
SELECT * FROM MovieDB.Movies WHERE Language NOT IN ('Tamil', 'English');
SELECT * FROM HotelDB.Rooms WHERE ROOMTYPE NOT IN ('Single', 'Double');
SELECT * FROM ECommerceDB.Customers WHERE CITY NOT IN ('Chennai', 'Coimbatore');
SELECT * FROM EmployeeDB.Employees WHERE DESIGNATION NOT IN ('Developer', 'Tester','Analyst');

-- IN WITH NUMERIC VALUES

SELECT * FROM StudentDB.students WHERE STUDENTID IN (101,105,110);
SELECT * FROM EmployeeDB.Employees WHERE EMPLOYEEID IN (201,205,210);
SELECT * FROM ShoppingDB.Products WHERE PRODUCTID IN (501,505,510);
SELECT * FROM LibraryDB.Books WHERE PRICE IN (500,750,1000);
SELECT * FROM HotelDB.Rooms WHERE ROOMNUMBER IN (101,205,301);

-- NOT IJN WITH NUMERIC VALUES

SELECT * FROM StudentDB.students WHERE STUDENTID NOT IN (101,105,110);
SELECT * FROM EmployeeDB.Employees WHERE EMPLOYEEID NOT IN (201,205,210);
SELECT * FROM ShoppingDB.Products WHERE PRODUCTID NOT IN (501,505,510);
SELECT * FROM LibraryDB.Books WHERE PRICE NOT IN (500,750,1000);
SELECT * FROM HotelDB.Rooms WHERE ROOMNUMBER NOT IN (101,205,301);

-- IN/NOT IN WITH CONDITIONS

SELECT * FROM EmployeeDB.Employees WHERE DEPARTMENT IN ('HR','FINANCE','IT') AND SALARY > 40000;
SELECT * FROM StudentDB.students WHERE DEPARTMENT IN ('IT','CSE','ECE') AND AGE > 20;
SELECT * FROM ShoppingDB.Products WHERE CATEGORY IN ('Electronics', 'Accessories') AND PRICE > 5000;
SELECT * FROM LibraryDB.Books WHERE CATEGORY IN ('Technology','SCIENCE') AND PRICE < 1000;
SELECT * FROM ECommerceDB.Customers WHERE CITY NOT IN ('Chennai', 'Bangalore', 'Hyderabad') AND REGISTEREDDATE IS NOT NULL;
SELECT * FROM EmployeeDB.Employees WHERE DEPARTMENT NOT IN ('HR','FINANCE') AND SALARY > 30000;
SELECT * FROM StudentDB.students WHERE DEPARTMENT NOT IN ('IT','CSE')AND AGE > 21;
SELECT * FROM ShoppingDB.Products WHERE CATEGORY NOT IN ('Electronics', 'Accessories') AND AVAILABLESTOCK > 10;
SELECT * FROM MovieDB.Movies WHERE Language IN ('Tamil', 'English','Hindi') AND RATING > 4;
SELECT * FROM HospitalDB.Patients WHERE BLOODGROUP IN ('A+VE','B+VE','O+VE') AND AGE >30;