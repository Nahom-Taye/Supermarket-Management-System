USE Supermarkeet;
GO

BEGIN TRANSACTION;

PRINT 'Transaction 1: Updating product price to 999.00 (UNCOMMITTED)...';

UPDATE Product
SET price = 999.00
WHERE product_id = 1001;

-- View the uncommitted change
SELECT 'Transaction 1 View (Uncommitted):' AS Message, product_id, name, price
FROM Product
WHERE product_id = 1001;

PRINT 'Transaction 1: Do NOT commit yet. Keep this window open for Transaction 2.';
-- DO NOT COMMIT OR ROLLBACK YET
