-- Back in Window 2
ROLLBACK TRANSACTION;

BEGIN
    SELECT 'Final Price (After Rollback):' AS Message, product_id, name, price
    FROM Product
    WHERE product_id = 1001;

    PRINT 'Transaction 1 rolled back. Price is restored to 45.00.';
END;
GO
