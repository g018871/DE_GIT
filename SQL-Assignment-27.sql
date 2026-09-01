SELECT '100' + 50 AS result;
SELECT '250' * 2 AS result;
SELECT STR_TO_DATE('2026-08-31', '%Y-%m-%d') AS converted_date;
SELECT CAST(25000 AS CHAR) AS converted_value;
SELECT CAST('1250.75' AS DECIMAL(10,2)) AS converted_value;
SELECT DATE_FORMAT('2026-08-31', '%d-%m-%Y') AS formatted_date;
SELECT STR_TO_DATE('2026-08-31 15:30:00','%Y-%m-%d %H:%i:%s') AS converted_datetime;
SELECT '100' + 25 AS result; -- IMPLICIT CONVERSION
SELECT CAST('100' AS SIGNED) + 25 AS result; -- EXPLICIT CONVERSION
