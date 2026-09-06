-- Banking
CREATE VIEW bankdb.customer_account_details AS
SELECT
    c.customername,
    a.accountnumber,
    a.accounttype,
    a.balance
FROM bankdb.customers c
JOIN bankdb.accounts a
    ON c.customerid = a.customerid;
    
CREATE VIEW bankdb.high_balance_customers 
AS SELECT c.customerid,    
	c.customername,
    a.accountnumber,
    a.accounttype,
    a.balance
FROM bankdb.customers c
JOIN bankdb.accounts a
    ON c.customerid = a.customerid
    WHERE A.BALANCE > 50000;
    
CREATE VIEW bankdb.active_bank_accounts AS
SELECT *
FROM bankdb.accounts
WHERE status = 'Active';

CREATE VIEW bankdb.customer_transaction_details AS
SELECT
    c.customer_name,
    t.transaction_type,
    t.amount,
    t.transaction_date
FROM bankdb.customers c
JOIN bankdb.accounts a
    ON c.customer_id = a.customer_id
JOIN bankdb.transactions t
    ON a.account_id = t.account_id;

CREATE VIEW bankdb.current_month_customers AS
SELECT DISTINCT
    c.customer_id,
    c.customer_name
FROM bankdb.customers c
JOIN bankdb.accounts a
    ON c.customer_id = a.customer_id
JOIN bankdb.transactions t
    ON a.account_id = t.account_id
WHERE YEAR(t.transaction_date) = YEAR(CURRENT_DATE())
  AND MONTH(t.transaction_date) = MONTH(CURRENT_DATE());

-- E-Commerce
CREATE VIEW shoppingdb.product_stock_details AS
SELECT
    productname,
    category,
    price,
    availablestock
FROM shoppingdb.products;

CREATE VIEW shoppingdb.low_stock_products AS
SELECT
    product_name,
    category,
    stock,
    reorder_level
FROM shoppingdb.products
WHERE stock < reorder_level;

CREATE VIEW shoppingdb.customer_order_details AS
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    o.order_amount
FROM shoppingdb.customers c
JOIN shoppingdb.orders o
    ON c.customer_id = o.customer_id;

CREATE VIEW shoppingdb.pending_orders AS
SELECT *
FROM shoppingdb.orders
WHERE status = 'Pending';

CREATE VIEW shoppingdb.complete_order_details AS
SELECT
    o.order_id,
    o.order_date,
    c.customer_name,
    p.product_name,
    od.quantity,
    od.price,
    (od.quantity * od.price) AS total
FROM shoppingdb.orders o
JOIN shoppingdb.customers c
    ON o.customer_id = c.customer_id
JOIN shoppingdb.order_details od
    ON o.order_id = od.order_id
JOIN shoppingdb.products p
    ON od.product_id = p.product_id;

CREATE VIEW shoppingdb.customer_total_spending AS
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_amount_spent
FROM shoppingdb.customers c
JOIN shoppingdb.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

CREATE VIEW shoppingdb.category_wise_sales AS
SELECT
    p.category,
    SUM(od.quantity * od.price) AS total_sales
FROM shoppingdb.products p
JOIN shoppingdb.order_details od
    ON p.product_id = od.product_id
GROUP BY p.category;

CREATE VIEW shoppingdb.top_selling_products AS
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS quantity_sold
FROM shoppingdb.products p
JOIN shoppingdb.order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY quantity_sold DESC;

-- Employee / HR

CREATE VIEW employeedb.employee_details AS
SELECT
    employee_name,
    department,
    designation,
    salary
FROM employeedb.employees;

CREATE VIEW employeedb.high_salary_employees AS
SELECT
    employee_name,
    department,
    designation,
    salary
FROM employeedb.employees
WHERE salary > 50000;

CREATE VIEW employeedb.it_employees AS
SELECT
    employee_name,
    designation,
    salary
FROM employeedb.employees
WHERE department = 'IT';

CREATE VIEW employeedb.department_employee_count AS
SELECT
    department,
    COUNT(*) AS employee_count
FROM employeedb.employees
GROUP BY department;

CREATE VIEW employeedb.department_average_salary AS
SELECT
    department,
    AVG(salary) AS average_salary
FROM employeedb.employees
GROUP BY department;

CREATE VIEW employeedb.employee_manager_details AS
SELECT
    e.employee_name AS employee_name,
    e.department,
    e.designation,
    m.employee_name AS manager_name
FROM employeedb.employees e
LEFT JOIN employeedb.employees m
    ON e.manager_id = m.employee_id;

CREATE VIEW employeedb.recent_employees AS
SELECT
    employee_name,
    department,
    designation,
    salary,
    joining_date
FROM employeedb.employees
WHERE joining_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- Student Management

CREATE VIEW studentdb.student_marks_summary AS
SELECT
    s.student_name,
    s.course,
    SUM(m.marks) AS total_marks,
    AVG(m.marks) AS average_marks
FROM studentdb.students s
JOIN studentdb.marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name, s.course;

CREATE VIEW studentdb.students_passed_all_subjects AS
SELECT
    s.student_id,
    s.student_name,
    s.course
FROM studentdb.students s
JOIN studentdb.marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name, s.course
HAVING MIN(m.marks) >= 40;

CREATE VIEW studentdb.high_average_students AS
SELECT
    s.student_id,
    s.student_name,
    s.course,
    AVG(m.marks) AS average_marks
FROM studentdb.students s
JOIN studentdb.marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name, s.course
HAVING AVG(m.marks) > 80;

CREATE VIEW studentdb.course_student_count AS
SELECT
    course,
    COUNT(*) AS student_count
FROM studentdb.students
GROUP BY course;

CREATE VIEW studentdb.course_average_marks AS
SELECT
    s.course,
    AVG(m.marks) AS average_marks
FROM studentdb.students s
JOIN studentdb.marks m
    ON s.student_id = m.student_id
GROUP BY s.course;

CREATE VIEW studentdb.student_grades AS
SELECT
    s.student_id,
    s.student_name,
    s.course,
    AVG(m.marks) AS average_marks,
    CASE
        WHEN AVG(m.marks) >= 90 THEN 'A+'
        WHEN AVG(m.marks) >= 80 THEN 'A'
        WHEN AVG(m.marks) >= 70 THEN 'B'
        WHEN AVG(m.marks) >= 60 THEN 'C'
        WHEN AVG(m.marks) >= 50 THEN 'D'
        ELSE 'F'
    END AS grade
FROM studentdb.students s
JOIN studentdb.marks m
    ON s.student_id = m.student_id
GROUP BY s.student_id, s.student_name, s.course;
 
 -- Hospital
 
 CREATE VIEW hospitaldb.patient_appointment_details AS
SELECT
    p.patient_name,
    d.doctor_name,
    a.appointment_date,
    a.status AS appointment_status
FROM hospitaldb.appointments a
JOIN hospitaldb.patients p
    ON a.patient_id = p.patient_id
JOIN hospitaldb.doctors d
    ON a.doctor_id = d.doctor_id;

CREATE VIEW hospitaldb.currently_admitted_patients AS
SELECT
    p.patient_id,
    p.patient_name,
    a.admission_date
FROM hospitaldb.admissions a
JOIN hospitaldb.patients p
    ON a.patient_id = p.patient_id
WHERE a.discharge_date IS NULL;

CREATE VIEW hospitaldb.patient_admission_bill AS
SELECT
    p.patient_name,
    a.admission_date,
    a.discharge_date,
    a.total_bill
FROM hospitaldb.admissions a
JOIN hospitaldb.patients p
    ON a.patient_id = p.patient_id;

CREATE VIEW hospitaldb.doctor_patient_count AS
SELECT
    d.doctor_id,
    d.doctor_name,
    COUNT(DISTINCT a.patient_id) AS patient_count
FROM hospitaldb.doctors d
JOIN hospitaldb.appointments a
    ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.doctor_name;

CREATE VIEW hospitaldb.high_bill_patients AS
SELECT
    p.patient_name,
    a.admission_date,
    a.discharge_date,
    a.total_bill
FROM hospitaldb.admissions a
JOIN hospitaldb.patients p
    ON a.patient_id = p.patient_id
WHERE a.total_bill > 25000;

-- Advanced View Scenarios
CREATE VIEW customer_order_report AS
SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    oi.product_id,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS item_total
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id;

CREATE VIEW monthly_sales_summary AS
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS month,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    SUM(oi.quantity) AS quantity_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m');

CREATE VIEW customers_without_orders AS
SELECT
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

CREATE VIEW unsold_products AS
SELECT
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi
    ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

CREATE VIEW highest_paid_employee AS
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);

CREATE VIEW second_highest_salary AS
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.salary
FROM employees e
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
      AND e2.salary < (
          SELECT MAX(e3.salary)
          FROM employees e3
          WHERE e3.department = e.department
      )
);

CREATE VIEW employees_above_department_average AS
SELECT
    e.employee_id,
    e.employee_name,
    e.department,
    e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department = e.department
);

CREATE VIEW employee_salary_rank AS
SELECT
    employee_id,
    employee_name,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;

CREATE VIEW management_sales_report AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity) AS total_quantity,
    SUM(oi.quantity * oi.price) AS total_revenue,
    AVG(oi.quantity * oi.price) AS average_order_item_value
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.price) > 50000;

