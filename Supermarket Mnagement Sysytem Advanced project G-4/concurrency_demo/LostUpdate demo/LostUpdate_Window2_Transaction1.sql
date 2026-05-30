USE Supermarkeet;
GO

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;  -- Prevent lost updates
BEGIN TRANSACTION;

PRINT 'Transaction 1: Reading product stock...';

SELECT quantity_in_stock
FROM Product
WHERE product_id = 1001;

PRINT 'Transaction 1: Simulating delay...';
WAITFOR DELAY '00:00:10';  -- Simulate processing time

PRINT 'Transaction 1: Selling 1 item...';

UPDATE Product
SET quantity_in_stock = quantity_in_stock - 1
WHERE product_id = 1001;

COMMIT TRANSACTION;

PRINT 'Transaction 1 committed.';
GO
