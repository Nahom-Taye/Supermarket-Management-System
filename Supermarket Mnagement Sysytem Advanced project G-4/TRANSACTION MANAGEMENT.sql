/* =====================================================
   TRANSACTION MANAGEMENT
   Supermarket Management System
   Database: supermarkeet
   ===================================================== */

USE supermarkeet;
GO

/* =====================================================
   1. SERIALIZABLE TRANSACTION SCHEDULE
   ===================================================== */
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @productID INT = 1001;
    DECLARE @quantity INT = 5;
    DECLARE @stock INT;
    DECLARE @StockTable TABLE (quantity_in_stock INT);

    -- Safely reduce stock with row locks and capture old stock
    UPDATE dbo.Product WITH (ROWLOCK, UPDLOCK, HOLDLOCK)
    SET quantity_in_stock = quantity_in_stock - @quantity
    OUTPUT DELETED.quantity_in_stock INTO @StockTable
    WHERE product_id = @productID
      AND quantity_in_stock >= @quantity;

    SELECT @stock = quantity_in_stock FROM @StockTable;

    IF @@ROWCOUNT > 0
        PRINT 'Serializable Transaction committed: Stock updated';
    ELSE
        PRINT 'Serializable Transaction rolled back: Not enough stock';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

/* =====================================================
   2. NON-SERIALIZABLE TRANSACTION SCHEDULE (READ COMMITTED)
   ===================================================== */
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @productID2 INT = 1001;
    DECLARE @quantity2 INT = 5;
    DECLARE @stock2 INT;
    DECLARE @StockTable2 TABLE (quantity_in_stock INT);

    UPDATE dbo.Product WITH (ROWLOCK, UPDLOCK)
    SET quantity_in_stock = quantity_in_stock - @quantity2
    OUTPUT DELETED.quantity_in_stock INTO @StockTable2
    WHERE product_id = @productID2
      AND quantity_in_stock >= @quantity2;

    SELECT @stock2 = quantity_in_stock FROM @StockTable2;

    IF @@ROWCOUNT > 0
        PRINT 'Read Committed Transaction committed: Stock updated';
    ELSE
        PRINT 'Read Committed Transaction rolled back: Not enough stock';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO

/* =====================================================
   3. HIGH-CONFLICT OPERATION WITH EXPLICIT LOCKING
   ===================================================== */
BEGIN TRY
    BEGIN TRANSACTION;

    DECLARE @productID3 INT = 1001;
    DECLARE @quantity3 INT = 3;
    DECLARE @stock3 INT;
    DECLARE @StockTable3 TABLE (quantity_in_stock INT);

    UPDATE dbo.Product WITH (XLOCK, ROWLOCK)
    SET quantity_in_stock = quantity_in_stock - @quantity3
    OUTPUT DELETED.quantity_in_stock INTO @StockTable3
    WHERE product_id = @productID3
      AND quantity_in_stock >= @quantity3;

    SELECT @stock3 = quantity_in_stock FROM @StockTable3;

    IF @@ROWCOUNT > 0
        PRINT 'High-conflict operation committed safely';
    ELSE
        PRINT 'High-conflict operation rolled back: Not enough stock';

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    THROW;
END CATCH;
GO