USE Supermarkeet;
GO

PRINT 'Final verification of product stock...';

SELECT 
    product_id,
    name,
    quantity_in_stock AS Final_Stock,
    'Expected stock = 8 (10 - 1 - 1) and got '
        + CAST(quantity_in_stock AS VARCHAR) AS Observation
FROM Product
WHERE product_id = 1001;
GO
