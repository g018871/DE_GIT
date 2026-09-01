SELECT UPPER(EMPLOYEENAME) AS uppercase_name FROM EmployeeDB.Employees ;
SELECT LOWER(EMPLOYEENAME) AS lowercase_name FROM EmployeeDB.Employees ;
SELECT EMPLOYEENAME, LENGTH(EMPLOYEENAME) AS name_length FROM EmployeeDB.Employees ;
SELECT EMPLOYEENAME, LEFT(EMPLOYEENAME, 3) AS first_3_characters FROM EmployeeDB.Employees ;
SELECT EMPLOYEENAME, RIGHT(EMPLOYEENAME, 3) AS last_3_characters FROM EmployeeDB.Employees ;
SELECT CONCAT(first_name, ' ', last_name) AS Full_Name FROM EmployeeDB.Employees ;
SELECT TRIM(CUSTOMERNAME) AS trimmed_name FROM ECommerceDB.Customers;
SELECT REPLACE(city, 'Chennai', 'Madras') AS city FROM ECommerceDB.Customers;
