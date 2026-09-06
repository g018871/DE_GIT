-- Banking System

DELIMITER //
CREATE PROCEDURE transfer_money(
    IN from_acc INT,
    IN to_acc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    UPDATE accounts
    SET balance = balance - amount
    WHERE account_no = from_acc;

    UPDATE accounts
    SET balance = balance + amount
    WHERE account_no = to_acc;
END //
DELIMITER ;
-- ----------------------------------------------------
DELIMITER //

CREATE PROCEDURE check_balance(IN acc_no INT)
BEGIN
    SELECT balance
    FROM accounts
    WHERE account_no = acc_no;
END //

DELIMITER ;
-- -----------------------------------------------------
DELIMITER //

CREATE PROCEDURE deposit_money(
    IN acc_no INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    UPDATE accounts
    SET balance = balance + amount
    WHERE account_no = acc_no;

    INSERT INTO transactions
    VALUES(acc_no, 'DEPOSIT', amount, CURDATE());
END //

DELIMITER ;
-- -------------------------------------------------
DELIMITER //

CREATE PROCEDURE withdraw_money(
    IN acc_no INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE bal DECIMAL(10,2);

    SELECT balance INTO bal
    FROM accounts
    WHERE account_no = acc_no;

    IF bal >= amount THEN

        UPDATE accounts
        SET balance = balance - amount
        WHERE account_no = acc_no;

        SELECT 'Withdrawal successful' AS message;

    ELSE

        SELECT 'Insufficient balance' AS message;

    END IF;
END //

DELIMITER ;
-- --------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE monthly_statement(
    IN acc_no INT,
    IN month_no INT
)
BEGIN
    SELECT *
    FROM transactions
    WHERE account_no = acc_no
      AND MONTH(transaction_date) = month_no;
END //

DELIMITER ;
-- -----------------------------------------------------------
-- E-Commerce System
DELIMITER //

CREATE PROCEDURE place_order(
    IN p_order_id INT,
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE p_price DECIMAL(10,2);

    SELECT price INTO p_price
    FROM products
    WHERE product_id = p_product_id;

    INSERT INTO orders
    VALUES(p_order_id, p_customer_id, CURDATE(),
           p_price * p_quantity, 'Pending');

    INSERT INTO order_items
    VALUES(p_order_id, p_product_id, p_quantity, p_price);
END //

DELIMITER ;
-- --------------------------------------------------------
DELIMITER //

CREATE PROCEDURE add_product_to_order(
    IN p_order_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE p_price DECIMAL(10,2);

    SELECT price INTO p_price
    FROM products
    WHERE product_id = p_product_id;

    INSERT INTO order_items
    VALUES(p_order_id, p_product_id, p_quantity, p_price);

    UPDATE orders
    SET total_amount = total_amount + (p_price * p_quantity)
    WHERE order_id = p_order_id;
END //

DELIMITER ;
-- ----------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE check_stock(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE p_stock INT;

    SELECT stock INTO p_stock
    FROM products
    WHERE product_id = p_product_id;

    IF p_stock >= p_quantity THEN
        SELECT 'Stock available' AS message;
    ELSE
        SELECT 'Insufficient stock' AS message;
    END IF;
END //

DELIMITER ;
-- -----------------------------------------------------------
DELIMITER //

CREATE PROCEDURE reduce_stock(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    UPDATE products
    SET stock = stock - p_quantity
    WHERE product_id = p_product_id;
END //

DELIMITER ;
-- -----------------------------------------------------------
DELIMITER //

CREATE PROCEDURE cancel_order(
    IN p_order_id INT
)
BEGIN
    UPDATE products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    SET p.stock = p.stock + oi.quantity
    WHERE oi.order_id = p_order_id;

    UPDATE orders
    SET status = 'Cancelled'
    WHERE order_id = p_order_id;
END //

DELIMITER ;
-- ----------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE customer_spending(
    IN p_customer_id INT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT
        SUM(total_amount) AS total_spent
    FROM orders
    WHERE customer_id = p_customer_id
      AND order_date BETWEEN start_date AND end_date;
END //

DELIMITER ;
-- ---------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE pending_orders(
    IN p_customer_id INT
)
BEGIN
    SELECT *
    FROM orders
    WHERE customer_id = p_customer_id
      AND status = 'Pending';
END //

DELIMITER ;
-- ----------------------------------------------------------------
-- Employee / HR System
DELIMITER //

CREATE PROCEDURE get_employees(IN dept VARCHAR(50))
BEGIN
    SELECT *
    FROM employees
    WHERE department = dept;
END //

DELIMITER ;
-- ---------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE increase_salary(
    IN eid INT,
    IN percent INT
)
BEGIN
    UPDATE employees
    SET salary = salary + (salary * percent / 100)
    WHERE employee_id = eid;
END //

DELIMITER ;
-- ---------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE annual_salary(IN eid INT)
BEGIN
    SELECT employee_name,
           salary * 12 AS annual_salary
    FROM employees
    WHERE employee_id = eid;
END //

DELIMITER ;
-- ----------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE salary_greater_than(IN amount DECIMAL(10,2))
BEGIN
    SELECT *
    FROM employees
    WHERE salary > amount;
END //

DELIMITER ;
-- -----------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE department_salary_report()
BEGIN
    SELECT department,
           employee_name,
           salary
    FROM employees
    ORDER BY department;
END //

DELIMITER ;
-- --------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE department_salary(IN dept VARCHAR(50))
BEGIN
    SELECT department,
           SUM(salary) AS total_salary
    FROM employees
    WHERE department = dept
    GROUP BY department;
END //

DELIMITER ;
-- ---------------------------------------------------------------------
-- Student Management System
DELIMITER //

CREATE PROCEDURE get_students(IN c VARCHAR(50))
BEGIN
    SELECT *
    FROM students
    WHERE course = c;
END //

DELIMITER ;
-- -------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE student_marks(IN sid INT)
BEGIN
    SELECT
        SUM(marks) AS total_marks,
        AVG(marks) AS average_marks
    FROM marks
    WHERE student_id = sid;
END //

DELIMITER ;
-- ---------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE student_result(IN sid INT)
BEGIN
    IF (SELECT MIN(marks) FROM marks WHERE student_id = sid) >= 40 THEN
        SELECT 'Passed' AS result;
    ELSE
        SELECT 'Failed' AS result;
    END IF;
END //

DELIMITER ;
-- --------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE students_above_average(IN m DECIMAL(5,2))
BEGIN
    SELECT
        s.student_name,
        AVG(mark.marks) AS average_marks
    FROM students s
    JOIN marks mark
        ON s.student_id = mark.student_id
    GROUP BY s.student_id, s.student_name
    HAVING AVG(mark.marks) > m;
END //

DELIMITER ;
-- --------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE student_result_report()
BEGIN
    SELECT
        s.student_name,
        SUM(m.marks) AS total,
        AVG(m.marks) AS average,

        CASE
            WHEN AVG(m.marks) >= 90 THEN 'A+'
            WHEN AVG(m.marks) >= 80 THEN 'A'
            WHEN AVG(m.marks) >= 70 THEN 'B'
            WHEN AVG(m.marks) >= 60 THEN 'C'
            WHEN AVG(m.marks) >= 50 THEN 'D'
            ELSE 'F'
        END AS grade,

        CASE
            WHEN MIN(m.marks) >= 40 THEN 'Passed'
            ELSE 'Failed'
        END AS result_status

    FROM students s
    JOIN marks m
        ON s.student_id = m.student_id
    GROUP BY s.student_id, s.student_name;
END //

DELIMITER ;
-- ----------------------------------------------------------------------------
-- Hospital Management System
DELIMITER //

CREATE PROCEDURE doctor_appointments(
    IN did INT,
    IN d DATE
)
BEGIN
    SELECT *
    FROM appointments
    WHERE doctor_id = did
      AND appointment_date = d;
END //

DELIMITER ;
-- --------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE patient_bill(IN pid INT)
BEGIN
    SELECT
        patient_id,
        SUM(total_bill) AS total_bill
    FROM admissions
    WHERE patient_id = pid
    GROUP BY patient_id;
END //

DELIMITER ;
-- ---------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE admitted_patients(
    IN d1 DATE,
    IN d2 DATE
)
BEGIN
    SELECT *
    FROM admissions
    WHERE admission_date BETWEEN d1 AND d2;
END //

DELIMITER ;
-- -----------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE discharge_patient(
    IN aid INT,
    IN d DATE
)
BEGIN
    UPDATE admissions
    SET status = 'Discharged',
        discharge_date = d
    WHERE admission_id = aid;
END //

DELIMITER ;
-- ------------------------------------------------------------------------
-- Inventory Management
DELIMITER //

CREATE PROCEDURE low_stock_products()
BEGIN
    SELECT *
    FROM products
    WHERE stock < reorder_level;
END //

DELIMITER ;
-- ---------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE add_stock(
    IN pid INT,
    IN qty INT
)
BEGIN
    UPDATE products
    SET stock = stock + qty
    WHERE product_id = pid;
END //

DELIMITER ;
-- ----------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE inventory_report()
BEGIN
    SELECT
        product_name,
        stock AS available_quantity,
        reorder_level,
        CASE
            WHEN stock < reorder_level THEN 'Low Stock'
            ELSE 'Available'
        END AS stock_status
    FROM products;
END //

DELIMITER ;
-- ------------------------------------------------------------------
-- Advanced Real-Time Scenarios
DELIMITER //
CREATE PROCEDURE transfer_money(
    IN from_acc INT,
    IN to_acc INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    DECLARE bal DECIMAL(10,2);
    START TRANSACTION;
    SELECT balance INTO bal
    FROM accounts
    WHERE account_id = from_acc;
    IF bal >= amount THEN
        UPDATE accounts
        SET balance = balance - amount
        WHERE account_id = from_acc;
        UPDATE accounts
        SET balance = balance + amount
        WHERE account_id = to_acc;
        COMMIT;
        SELECT 'Transfer Successful' AS message;
    ELSE
        ROLLBACK;
        SELECT 'Insufficient Balance' AS message;
    END IF;
END //
DELIMITER ;
-- ------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE place_order(
    IN oid INT,
    IN cid INT,
    IN pid INT,
    IN qty INT
)
BEGIN
    DECLARE p DECIMAL(10,2);
    START TRANSACTION;
    SELECT price INTO p
    FROM products
    WHERE product_id = pid;
    INSERT INTO orders
    VALUES(oid, cid, CURDATE(), p * qty, 'Pending');
    INSERT INTO order_items
    VALUES(oid, pid, qty, p);
    UPDATE products
    SET stock = stock - qty
    WHERE product_id = pid;
    COMMIT;
END //
DELIMITER ;
-- ------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE customer_report(
    IN cid INT,
    IN d1 DATE,
    IN d2 DATE
)
BEGIN
    SELECT
        COUNT(*) AS total_orders,
        SUM(total_amount) AS total_spending
    FROM orders
    WHERE customer_id = cid
      AND order_date BETWEEN d1 AND d2;
END //
DELIMITER ;
-- -----------------------------------------------------------
DELIMITER //
CREATE PROCEDURE update_salary(
    IN eid INT,
    IN new_salary DECIMAL(10,2)
)
BEGIN
    DECLARE old_salary DECIMAL(10,2);
    SELECT salary INTO old_salary
    FROM employees
    WHERE employee_id = eid;
    UPDATE employees
    SET salary = new_salary
    WHERE employee_id = eid;
    INSERT INTO salary_audit
    VALUES(eid, old_salary, new_salary, CURDATE());
END //
DELIMITER ;
-- ------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE delete_customer(IN cid INT)
BEGIN
    IF NOT EXISTS (
        SELECT *
        FROM orders
        WHERE customer_id = cid
          AND status = 'Active'
    ) THEN
        DELETE FROM customers
        WHERE customer_id = cid;
        SELECT 'Customer Deleted' AS message;
    ELSE
        SELECT 'Cannot Delete - Customer has active orders' AS message;
    END IF;
END //
DELIMITER ;
-- ----------------------------------------------------------
DELIMITER //
CREATE PROCEDURE employee_bonus(IN eid INT)
BEGIN
    SELECT
        employee_name,
        salary,
        performance_rating,
        CASE
            WHEN performance_rating >= 5 THEN salary * 0.20
            WHEN performance_rating >= 4 THEN salary * 0.15
            WHEN performance_rating >= 3 THEN salary * 0.10
            ELSE salary * 0.05
        END AS bonus
    FROM employees
    WHERE employee_id = eid;
END //
DELIMITER ;
-- ----------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE inactive_customers()
BEGIN
    SELECT *
    FROM customers
    WHERE customer_id NOT IN (
        SELECT customer_id
        FROM orders
        WHERE order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
    );
END //
DELIMITER ;
-- -----------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE monthly_sales()
BEGIN
    SELECT
        COUNT(DISTINCT o.order_id) AS total_orders,
        SUM(oi.quantity) AS total_quantity,
        SUM(oi.quantity * oi.price) AS total_revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE MONTH(o.order_date) = MONTH(CURDATE())
      AND YEAR(o.order_date) = YEAR(CURDATE());
END //
DELIMITER ;
-- -----------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE check_product_stock(
    IN pid INT,
    IN qty INT
)
BEGIN
    DECLARE s INT;
    SELECT stock INTO s
    FROM products
    WHERE product_id = pid;
    IF s >= qty THEN
        SELECT 'Product can be ordered' AS message;
    ELSE
        SELECT 'Insufficient stock' AS message;
    END IF;
END //
DELIMITER ;
-- -----------------------------------------------------------------------
DELIMITER //
CREATE PROCEDURE process_order(
    IN oid INT,
    IN cid INT,
    IN pid INT,
    IN qty INT
)
BEGIN
    DECLARE p DECIMAL(10,2);
    DECLARE s INT;
    START TRANSACTION;
    SELECT price, stock INTO p, s
    FROM products
    WHERE product_id = pid;
    IF NOT EXISTS (
        SELECT * FROM customers
        WHERE customer_id = cid
    ) THEN
        ROLLBACK;
        SELECT 'Customer not found' AS message;
    ELSEIF s < qty THEN
        ROLLBACK;
        SELECT 'Product not available' AS message;
    ELSE
        INSERT INTO orders
        VALUES(oid, cid, p * qty);
        INSERT INTO order_items
        VALUES(oid, pid, qty, p);
        UPDATE products
        SET stock = stock - qty
        WHERE product_id = pid;
        COMMIT;
        SELECT 'Order placed successfully' AS message;
    END IF;
END //
DELIMITER ;
-- -----------------------------------------------------------------