/* =====================================================
   QUERY PROCESSING - COMPLEX JOIN AND OPTIMIZATION
   Supermarket Management System
   ===================================================== */

USE Supermarkeet;
GO

/* =====================================================
   1. COMPLEX JOIN QUERY (LAST 30 DAYS BILLS)
   ===================================================== */
SELECT 
    b.bill_id,
    c.name AS CustomerName,
    e.name AS EmployeeName,
    p.name AS ProductName,
    bp.quantity,
    (bp.quantity * p.price) AS TotalProductPrice,
    b.total_amount
FROM Bill b
JOIN Customer c ON b.customer_id = c.customer_id
JOIN Employee e ON b.employee_id = e.employee_id
JOIN Bill_Product bp ON b.bill_id = bp.bill_id
JOIN Product p ON bp.product_id = p.product_id
WHERE b.date_time >= DATEADD(DAY, -30, GETDATE())
ORDER BY b.date_time DESC;
GO

/* =====================================================
   2. INDEXING FOR OPTIMIZATION
   ===================================================== */
CREATE INDEX idx_BillProduct_BillID ON Bill_Product(bill_id);
CREATE INDEX idx_BillProduct_ProductID ON Bill_Product(product_id);
CREATE INDEX idx_Bill_DateTime ON Bill(date_time);
CREATE INDEX idx_Bill_CustomerID ON Bill(customer_id);
CREATE INDEX idx_Bill_EmployeeID ON Bill(employee_id);
GO

/* =====================================================
   3. RESTRUCTURED/OPTIMIZED QUERY USING CTE
   ===================================================== */
WITH RecentBills AS (
    SELECT *
    FROM Bill
    WHERE date_time >= DATEADD(DAY, -30, GETDATE())
)
SELECT 
    rb.bill_id,
    c.name AS CustomerName,
    e.name AS EmployeeName,
    p.name AS ProductName,
    bp.quantity,
    (bp.quantity * p.price) AS TotalProductPrice,
    rb.total_amount
FROM RecentBills rb
JOIN Customer c ON rb.customer_id = c.customer_id
JOIN Employee e ON rb.employee_id = e.employee_id
JOIN Bill_Product bp ON rb.bill_id = bp.bill_id
JOIN Product p ON bp.product_id = p.product_id
ORDER BY rb.date_time DESC;
GO

/* =====================================================
   4. NOTES:
   - Check execution plan in SSMS (Ctrl+M) before and after indexing.
   - The optimized query filters first (CTE) and uses indexes to reduce row scanning.
   ===================================================== */
