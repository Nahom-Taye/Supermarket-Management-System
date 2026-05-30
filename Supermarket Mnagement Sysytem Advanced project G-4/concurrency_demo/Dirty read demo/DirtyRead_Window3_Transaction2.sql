USE Supermarkeet;
GO

-- Allow dirty reads
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

PRINT 'Transaction 2: Reading product data (Dirty Read allowed)...';

SELECT 'Transaction 2 View (Dirty Read):' AS Message, product_id, name, price
FROM Product
WHERE product_id = 1001;

PRINT 'Notice: Transaction 2 sees price = 999.00 even though it is uncommitted.';
