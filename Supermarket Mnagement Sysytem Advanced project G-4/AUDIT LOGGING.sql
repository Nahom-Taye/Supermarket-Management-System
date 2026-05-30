/* =====================================================
   Supermarket Management System – Part 4: AUDIT LOGGING
   ===================================================== */

CREATE TABLE Product_Audit (
    audit_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    old_price DECIMAL(10,2),
    new_price DECIMAL(10,2),
    changed_by_employee_id INT NULL,
    changed_on DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (changed_by_employee_id) REFERENCES Employee(employee_id)
);
GO

CREATE TRIGGER trg_Product_Audit
ON Product
AFTER UPDATE
AS
BEGIN
    INSERT INTO Product_Audit (product_id, old_price, new_price)
    SELECT d.product_id, d.price, i.price
    FROM deleted d
    JOIN inserted i ON d.product_id = i.product_id;
END;
GO