USE Supermarkeet;
GO

UPDATE Product
SET quantity_in_stock = 10
WHERE product_id = 1001;

PRINT 'Setup Complete: Product 1001 stock reset to 10';

SELECT product_id, name, quantity_in_stock
FROM Product
WHERE product_id = 1001;
GO
