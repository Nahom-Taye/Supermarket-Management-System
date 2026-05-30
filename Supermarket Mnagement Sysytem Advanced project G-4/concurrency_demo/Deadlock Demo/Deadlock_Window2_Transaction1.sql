USE Supermarkeet;
GO

BEGIN TRANSACTION;

PRINT 'T1: Locking Product first, then Employee...';

-- Lock Product row first
UPDATE Product
SET price = price + 1
WHERE product_id = 1001;

WAITFOR DELAY '00:00:05'; -- Simulate processing

-- Lock Employee row next (same order as T2)
UPDATE Employee
SET salary = salary + 100
WHERE employee_id = 2001;

COMMIT TRANSACTION;

PRINT 'T1: Transaction committed successfully.';
GO
