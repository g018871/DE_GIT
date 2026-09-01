-- NUMERIC FUNCTION
SELECT ROUND (SALARY,2) FROM  EmployeeDB.Employees;
SELECT EMPLOYEENAME,SALARY, ABS(SALARY - 50000) FROM EmployeeDB.Employees;
SELECT productname, price, CEIL(price) AS ceiling_price FROM ShoppingDB.Products;
SELECT productname, price, FLOOR(price) AS floor_price FROM ShoppingDB.Products;
SELECT EMPLOYEENAME,SALARY, MOD(SALARY, 10000) AS remainder FROM EmployeeDB.Employees;
SELECT studentname, marks, POWER(MARKS, 2)  FROM StudentDB.students;
SELECT PRODUCTNAME, PRICE, SQRT(PRICE)  FROM ShoppingDB.Products;
SELECT PRODUCTNAME, PRICE, ROUND(PRICE, 2) FROM ShoppingDB.Products;