-- CREATE DATABASE TRIGGERS;
USE TRIGGERS;
DELIMITER //
CREATE FUNCTION add_numbers(a DECIMAL(10,2), b DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN a + b;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION subtract_numbers(a DECIMAL(10,2), b DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN a - b;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION square_number(n DECIMAL(10,2))
RETURNS DECIMAL(20,2)
DETERMINISTIC
BEGIN
    RETURN n * n;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION cube_number(n DECIMAL(10,2))
RETURNS DECIMAL(30,2)
DETERMINISTIC
BEGIN
    RETURN n * n * n;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION greater_number(a DECIMAL(10,2), b DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    IF a > b THEN
        RETURN a;
    ELSE
        RETURN b;
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION even_odd(n INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF MOD(n, 2) = 0 THEN
        RETURN 'Even';
    ELSE
        RETURN 'Odd';
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION annual_salary(monthly_salary DECIMAL(10,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN monthly_salary * 12;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION calculate_age(dob DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, dob, CURDATE());
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION name_upper(name VARCHAR(100))
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    RETURN UPPER(name);
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION string_length(str VARCHAR(255))
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN LENGTH(str);
END //
DELIMITER ;

-- -------------------------------------------------
DELIMITER //
CREATE FUNCTION calculate_discount(amount DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    IF amount >= 50000 THEN
        RETURN amount * 0.20;
    ELSEIF amount >= 20000 THEN
        RETURN amount * 0.10;
    ELSE
        RETURN amount * 0.05;
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------
DELIMITER //
CREATE FUNCTION pass_fail(marks INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    IF marks >= 40 THEN
        RETURN 'Pass';
    ELSE
        RETURN 'Fail';
    END IF;
END //
DELIMITER ;

-- -------------------------------------------------
DELIMITER //
CREATE FUNCTION total_price(quantity INT, unit_price DECIMAL(10,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN quantity * unit_price;
END //
DELIMITER ;

-- --------------------------------------------------
DELIMITER //
CREATE FUNCTION calculate_gst(amount DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN amount * 0.18;
END //
DELIMITER ;

-- ---------------------------------------------------
DELIMITER //
CREATE FUNCTION employee_experience(joining_date DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(YEAR, joining_date, CURDATE());
END //
DELIMITER ;

-- ---------------------------------------------------
DELIMITER //
CREATE FUNCTION check_eligibility(age INT)
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
    IF age >= 18 THEN
        RETURN 'Eligible';
    ELSE
        RETURN 'Not Eligible';
    END IF;
END //
DELIMITER ;

-- -------------------------------------------------
DELIMITER //
CREATE FUNCTION calculate_bmi(
    weight DECIMAL(10,2),
    height DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN weight / (height * height);
END //
DELIMITER ;

-- --------------------------------------------------
DELIMITER //
CREATE FUNCTION last_four_chars(str VARCHAR(255))
RETURNS VARCHAR(4)
DETERMINISTIC
BEGIN
    RETURN RIGHT(str, 4);
END //
DELIMITER ;

-- --------------------------------------------------
DELIMITER //
CREATE FUNCTION calculate_commission(sales DECIMAL(12,2))
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    IF sales >= 100000 THEN
        RETURN sales * 0.10;
    ELSEIF sales >= 50000 THEN
        RETURN sales * 0.05;
    ELSE
        RETURN sales * 0.02;
    END IF;
END //
DELIMITER ;

-- ---------------------------------------------------
DELIMITER //
CREATE FUNCTION get_grade(marks INT)
RETURNS CHAR(1)
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN marks >= 90 THEN 'A'
        WHEN marks >= 80 THEN 'B'
        WHEN marks >= 70 THEN 'C'
        WHEN marks >= 60 THEN 'D'
        ELSE 'F'
    END;
END //
DELIMITER ;

-- ---------------------------------------------