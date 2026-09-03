-- BEFORE INSERT
DELIMITER $$
CREATE TRIGGER employeedb.before_employee_insert_date
BEFORE INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    SET NEW.CreatedDate = CURDATE();
END $$
DELIMITER ;

-- -------------------------------------------------------
DELIMITER $$
CREATE TRIGGER employeedb.before_employee_insert_salary
BEFORE INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 10000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be less than 10000';
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------
DELIMITER $$
CREATE TRIGGER employeedb.before_employee_insert_name
BEFORE INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    SET NEW.employeename = UPPER(NEW.employeename);
END $$
DELIMITER ;

-- ------------------------------------------------------
DELIMITER $$
CREATE TRIGGER employeedb.before_employee_insert_department
BEFORE INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    IF NEW.department IS NULL OR NEW.department = '' THEN
        SET NEW.department = 'General';
    END IF;
END $$
DELIMITER ;

-- ----------------------------------------------------
DELIMITER $$
CREATE TRIGGER shoppingdb.before_product_insert_price
BEFORE INSERT ON shoppingdb.products
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product price cannot be negative';
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------
-- AFTER INSERT

CREATE TABLE employeedb.Employee_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    employee_name VARCHAR(100),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    inserted_at DATETIME
);

DELIMITER $$
CREATE TRIGGER employeedb.after_employee_insert
AFTER INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    INSERT INTO employeedb.Employee_Audit
    (employee_id, employee_name, salary, department, inserted_at)
    VALUES
    (NEW.employeeid, NEW.employeename, NEW.salary,
     NEW.department, NOW());
END $$
DELIMITER ;
-- ---------------------------------------------------------------
CREATE TABLE employeedb.Employee_Insert_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    insertion_time DATETIME
);

DELIMITER $$
CREATE TRIGGER employeedb.employee_insert_time
AFTER INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    INSERT INTO employeedb.Employee_Insert_Audit
    (employee_id, insertion_time)
    VALUES
    (NEW.employeeid, NOW());
END $$
DELIMITER ;
-- -------------------------------------------------------------
CREATE TABLE SHOPPINGDB.Order_Audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    customer_id INT,
    order_amount DECIMAL(10,2),
    order_time DATETIME
);

DELIMITER $$
CREATE TRIGGER SHOPPINGDB.after_order_insert
AFTER INSERT ON SHOPPINGDB.orders
FOR EACH ROW
BEGIN
    INSERT INTO SHOPPINGDB.Order_Audit
    (order_id, customer_id, order_amount, order_time)
    VALUES
    (NEW.order_id, NEW.customer_id, NEW.order_amount, NOW());
END $$
DELIMITER ;
-- -----------------------------------------------------
CREATE TABLE employeedb.departments1 (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    employee_count INT DEFAULT 0
);

DELIMITER $$
CREATE TRIGGER employeedb.update_department_count
AFTER INSERT ON employeedb.employees
FOR EACH ROW
BEGIN
    UPDATE employeedb.departments1
    SET employee_count = employee_count + 1
    WHERE department_name = NEW.department;
END $$
DELIMITER ;

-- ---------------------------------------------------------
INSERT INTO employeedb.employees
(EMPLOYEEID,employeename, salary, department)
VALUES
(1001,'Rahul', 25000, 'IT'),
(1002,'Priya', 30000, 'HR'),
(1003,'Arun', 28000, 'IT');

SELECT * FROM employeedb.employees;
SELECT * FROM employeedb.departments1;

-- --------------------------------------------------------------
-- BEFORE UPDATE
DELIMITER $$
CREATE TRIGGER employeedb.prevent_salary_reduction
BEFORE UPDATE ON employeedb.employees
FOR EACH ROW
BEGIN
IF NEW.Salary < OLD.Salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee salary cannot be reduced';
    END IF;
END
$$ DELIMITER ;
-- --------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER employeedb.prevent_low_salary
BEFORE UPDATE ON employeedb.employees
FOR EACH ROW
BEGIN
IF NEW.Salary < 15000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee salary cannot be reduced';
    END IF;
END
$$ DELIMITER ;
-- --------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER update_modified_date
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    SET NEW.ModifiedDate = CURRENT_TIMESTAMP;
END $$
DELIMITER ;

-- -------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER uppercase_employee_name
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    SET NEW.EmployeeName = UPPER(NEW.EmployeeName);
END $$
DELIMITER ;
-- ---------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_employee_id_change
BEFORE UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF NEW.EmployeeID <> OLD.EmployeeID THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'EmployeeID cannot be changed';
    END IF;
END $$
DELIMITER ;
-- ----------------------------------------------------------------
-- AFTER UPDATE
CREATE TABLE Employee_Salary_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldSalary DECIMAL(10,2),
    NewSalary DECIMAL(10,2),
    ChangedDate DATETIME
);

DELIMITER $$
CREATE TRIGGER salary_audit_trigger
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO Employee_Salary_Audit
        (
            EmployeeID,
            OldSalary,
            NewSalary,
            ChangedDate
        )
        VALUES
        (
            NEW.EmployeeID,
            OLD.Salary,
            NEW.Salary,
            NOW()
        );
    END IF;
END $$
DELIMITER ;
-- -----------------------------------------------------------
CREATE TABLE Employee_Department_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldDepartmentID INT,
    NewDepartmentID INT,
    ChangedDate DATETIME
);

DELIMITER $$
CREATE TRIGGER department_change_audit
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.DepartmentID <> NEW.DepartmentID THEN
        INSERT INTO Employee_Department_Audit
        (
            EmployeeID,
            OldDepartmentID,
            NewDepartmentID,
            ChangedDate
        )
        VALUES
        (
            NEW.EmployeeID,
            OLD.DepartmentID,
            NEW.DepartmentID,
            NOW()
        );
    END IF;
END $$
DELIMITER ;
-- ---------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER salary_change_audit
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO Employee_Salary_Audit
        (
            EmployeeID,
            OldSalary,
            NewSalary,
            ChangedDate
        )
        VALUES
        (
            NEW.EmployeeID,
            OLD.Salary,
            NEW.Salary,
            NOW()
        );
    END IF;
END $$
DELIMITER ;
-- ---------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER salary_change_audit
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN
        INSERT INTO Employee_Salary_Audit
        (
            EmployeeID,
            OldSalary,
            NewSalary,
            ChangedDate
        )
        VALUES
        (
            NEW.EmployeeID,
            OLD.Salary,
            NEW.Salary,
            NOW()
        );
    END IF;
END $$
DELIMITER ;
-- ---------------------------------------------------------------
UPDATE Employee
SET Salary = Salary + 2000
WHERE EmployeeID = 101;
UPDATE Employee
SET Salary = Salary + 3000
WHERE EmployeeID = 102;
UPDATE Employee
SET Salary = Salary + 1500
WHERE EmployeeID = 103;
SELECT *
FROM Employee_Salary_Audit
ORDER BY ChangedDate DESC;

-- ---------------------------------------------------------------

CREATE TABLE Employee_Designation_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    OldDesignation VARCHAR(100),
    NewDesignation VARCHAR(100),
    ChangedDate DATETIME
);

DELIMITER $$
CREATE TRIGGER designation_change_audit
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Designation <> NEW.Designation THEN
        INSERT INTO Employee_Designation_Audit
        (
            EmployeeID,
            OldDesignation,
            NewDesignation,
            ChangedDate
        )
        VALUES
        (
            NEW.EmployeeID,
            OLD.Designation,
            NEW.Designation,
            NOW()
        );
    END IF;
END $$
DELIMITER ;
-- -------------------------------------------------------
-- BEFORE DELETE

DELIMITER $$
CREATE TRIGGER prevent_manager_delete
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Designation = 'Manager' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Manager cannot be deleted';
    END IF;
END $$
DELIMITER ;
-- ---------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_high_salary_delete
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary > 100000 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee with salary greater than 100000 cannot be deleted';
    END IF;
END $$
DELIMITER ;
-- ---------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_active_project_employee_delete
BEFORE DELETE ON Employee
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Project_Employee
        WHERE EmployeeID = OLD.EmployeeID
          AND Status = 'Active'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Employee is associated with an active project and cannot be deleted';
    END IF;
END $$
DELIMITER ;
-- ----------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_product_delete
BEFORE DELETE ON Product
FOR EACH ROW
BEGIN
    IF OLD.Stock > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product with available stock cannot be deleted';
    END IF;
END $$
DELIMITER ;
-- ----------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_customer_delete
BEFORE DELETE ON Customer
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Orders
        WHERE CustomerID = OLD.CustomerID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer with existing orders cannot be deleted';
    END IF;
END $$
DELIMITER ;

-- -----------------------------------------------------------
-- AFTER DELETE
CREATE TABLE Employee_Delete_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    Designation VARCHAR(100),
    DeletionDate DATETIME
);
DELIMITER $$
CREATE TRIGGER employee_delete_audit
AFTER DELETE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Delete_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        DeletionDate
    )
    VALUES
    (
        OLD.EmployeeID,
        OLD.EmployeeName,
        OLD.DepartmentID,
        OLD.Salary,
        OLD.Designation,
        NOW()
    );
END $$
DELIMITER ;
-- -------------------------------------------------------------
CREATE TABLE Employee_Delete_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    DeletionDate DATETIME
);
DELIMITER $$
CREATE TRIGGER employee_delete_log
AFTER DELETE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Delete_Audit
    (
        EmployeeID,
        EmployeeName,
        DeletionDate
    )
    VALUES
    (
        OLD.EmployeeID,
        OLD.EmployeeName,
        NOW()
    );
END $$
DELIMITER ;

-- -------------------------------------------------
DELETE FROM Employee
WHERE EmployeeID IN (101, 102, 103);
SELECT *
FROM Employee_Delete_Audit
ORDER BY DeletionDate DESC;
-- --------------------------------------------------
CREATE TABLE Order_Delete_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    Amount DECIMAL(10,2),
    DeletionDate DATETIME
);
DELIMITER $$
CREATE TRIGGER order_delete_audit
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_Delete_Audit
    (
        OrderID,
        CustomerID,
        OrderDate,
        Amount,
        DeletionDate
    )
    VALUES
    (
        OLD.OrderID,
        OLD.CustomerID,
        OLD.OrderDate,
        OLD.Amount,
        NOW()
    );
END $$
DELIMITER ;
DELETE FROM Orders WHERE OrderID = 5001;
SELECT * FROM Order_Delete_Audit;
-- ----------------------------------------------------
CREATE TABLE Employee_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    Designation VARCHAR(100),
    ActionType VARCHAR(10),
    ActionDate DATETIME
);

DELIMITER $$
CREATE TRIGGER employee_after_insert
AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        ActionType,
        ActionDate
    )
    VALUES
    (
        NEW.EmployeeID,
        NEW.EmployeeName,
        NEW.DepartmentID,
        NEW.Salary,
        NEW.Designation,
        'INSERT',
        NOW()
    );
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER employee_after_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        ActionType,
        ActionDate
    )
    VALUES
    (
        NEW.EmployeeID,
        NEW.EmployeeName,
        NEW.DepartmentID,
        NEW.Salary,
        NEW.Designation,
        'UPDATE',
        NOW()
    );
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER employee_after_delete
AFTER DELETE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        ActionType,
        ActionDate
    )
    VALUES
    (
        OLD.EmployeeID,
        OLD.EmployeeName,
        OLD.DepartmentID,
        OLD.Salary,
        OLD.Designation,
        'DELETE',
        NOW()
    );
END $$
DELIMITER ;
-- -------------------------------------------------------------
-- Challenge Questions
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    CreatedDate DATETIME
);
DELIMITER $$
CREATE TRIGGER prevent_negative_price
BEFORE INSERT ON Products
FOR EACH ROW
BEGIN
    IF NEW.Price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product price cannot be negative';
    END IF;
END $$
DELIMITER ;
INSERT INTO Products
VALUES (101, 'Laptop', -50000, NOW());
-- -------------------------------------------------------------------
DELIMITER $$
CREATE TRIGGER prevent_large_price_reduction
BEFORE UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.Price < OLD.Price * 0.80 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product price cannot be reduced by more than 20%';
    END IF;
END $$
DELIMITER ;
-- ------------------------------------------------------------------
CREATE TABLE Product_Price_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT,
    OldPrice DECIMAL(10,2),
    NewPrice DECIMAL(10,2),
    ChangedDate DATETIME
);
DELIMITER $$
CREATE TRIGGER product_price_audit
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF OLD.Price <> NEW.Price THEN
        INSERT INTO Product_Price_Audit
        (
            ProductID,
            OldPrice,
            NewPrice,
            ChangedDate
        )
        VALUES
        (
            OLD.ProductID,
            OLD.Price,
            NEW.Price,
            NOW()
        );
    END IF;
END $$
DELIMITER ;
UPDATE Products SET Price = 45000 WHERE ProductID = 101;
SELECT * FROM Product_Price_Audit;
-- ----------------------------------------------------------------------
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10,2),
    Stock INT,
    CreatedDate DATETIME
);
DELIMITER $$
CREATE TRIGGER prevent_product_deletion
BEFORE DELETE ON Products
FOR EACH ROW
BEGIN
    IF OLD.Stock > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product with stock greater than 0 cannot be deleted';
    END IF;
END $$
DELIMITER ;
-- -------------------------------------------------------------------------------------
CREATE TABLE Employee_Audit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    Designation VARCHAR(100),
    ActionType VARCHAR(10),
    ActionDate DATETIME
);
DELIMITER $$
CREATE TRIGGER employee_audit_insert
AFTER INSERT ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        ActionType,
        ActionDate
    )
    VALUES
    (
        NEW.EmployeeID,
        NEW.EmployeeName,
        NEW.DepartmentID,
        NEW.Salary,
        NEW.Designation,
        'INSERT',
        NOW()
    );
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER employee_audit_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        ActionType,
        ActionDate
    )
    VALUES
    (
        NEW.EmployeeID,
        NEW.EmployeeName,
        NEW.DepartmentID,
        NEW.Salary,
        NEW.Designation,
        'UPDATE',
        NOW()
    );
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER employee_audit_delete
AFTER DELETE ON Employee
FOR EACH ROW
BEGIN
    INSERT INTO Employee_Audit
    (
        EmployeeID,
        EmployeeName,
        DepartmentID,
        Salary,
        Designation,
        ActionType,
        ActionDate
    )
    VALUES
    (
        OLD.EmployeeID,
        OLD.EmployeeName,
        OLD.DepartmentID,
        OLD.Salary,
        OLD.Designation,
        'DELETE',
        NOW()
    );
END $$
DELIMITER ;
-- ---------------------------------------------------------------------