USE Supermarkeet;
GO

-- Check Product price
SELECT product_id, name, price
FROM Product
WHERE product_id = 1001;

-- Check Employee salary
SELECT employee_id, name, salary
FROM Employee
WHERE employee_id = 2001;
GO
