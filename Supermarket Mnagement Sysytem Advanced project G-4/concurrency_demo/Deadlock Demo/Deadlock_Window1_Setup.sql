USE Supermarkeet;
GO

-- Reset product price and employee salary
UPDATE Product
SET price = 45.00
WHERE product_id = 1001;

UPDATE Employee
SET salary = 5000
WHERE employee_id = 2001;

PRINT 'Setup Complete: Product price and Employee salary reset.';
GO
