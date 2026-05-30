USE Supermarkeet;
GO

BEGIN TRANSACTION;

PRINT 'T2: Locking Product first, then Employee...';

-- Lock Product row first (same as T1)
UPDATE Product
SET price = price + 2
WHERE product_id = 1001;

WAITFOR DELAY '00:00:05'; -- Simulate processing

-- Lock Employee row next
UPDATE Employee
SET salary = salary + 50
WHERE employee_id = 2001;

COMMIT TRANSACTION;

PRINT 'T2: Transaction committed successfully.';
GO
