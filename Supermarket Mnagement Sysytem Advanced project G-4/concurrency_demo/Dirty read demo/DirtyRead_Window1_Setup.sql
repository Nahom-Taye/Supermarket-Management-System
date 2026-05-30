USE Supermarkeet;
GO

-- Reset product price for the demo
UPDATE Product
SET price = 45.00
WHERE product_id = 1001;

SELECT 'Initial Price:' AS Message, product_id, name, price
FROM Product
WHERE product_id = 1001;
GO
