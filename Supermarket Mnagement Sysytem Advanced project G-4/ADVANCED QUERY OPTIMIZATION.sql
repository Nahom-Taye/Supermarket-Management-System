/* =====================================================
   ADVANCED QUERY OPTIMIZATION
   Supermarket Management System
   ===================================================== */

USE Supermarkeet;
GO

/* =====================================================
   QUERY 1: Total Revenue per Product
   ===================================================== */

-- 1(a) UNOPTIMIZED
SELECT 
    p.name AS ProductName,
    (SELECT SUM(bp.quantity * p.price)
     FROM Bill_Product bp
     WHERE bp.product_id = p.product_id) AS TotalRevenue
FROM Product p;
GO

-- 1(b) OPTIMIZED
CREATE INDEX idx_BillProduct_ProductID
ON Bill_Product(product_id);
GO

SELECT 
    p.name AS ProductName,
    SUM(bp.quantity * p.price) AS TotalRevenue
FROM Product p
JOIN Bill_Product bp
ON p.product_id = bp.product_id
GROUP BY p.name;
GO

/* =====================================================
   QUERY 2: Customer Total Spending
   ===================================================== */

-- 2(a) UNOPTIMIZED
SELECT 
    c.name AS CustomerName,
    (SELECT SUM(total_amount)
     FROM Bill b
     WHERE b.customer_id = c.customer_id) AS TotalSpent
FROM Customer c;
GO

-- 2(b) OPTIMIZED
CREATE INDEX idx_Bill_CustomerID
ON Bill(customer_id);
GO

SELECT 
    c.name AS CustomerName,
    SUM(b.total_amount) AS TotalSpent
FROM Customer c
JOIN Bill b
ON c.customer_id = b.customer_id
GROUP BY c.name;
GO

/* =====================================================
   QUERY 3: Products Near Expiry
   ===================================================== */

-- 3(a) UNOPTIMIZED
SELECT name AS ProductName, expiry_date
FROM Product
WHERE DATEDIFF(DAY, GETDATE(), expiry_date) <= 30;
GO

-- 3(b) OPTIMIZED
CREATE INDEX idx_Product_ExpiryDate
ON Product(expiry_date);
GO

SELECT name AS ProductName, expiry_date
FROM Product
WHERE expiry_date <= DATEADD(DAY, 30, GETDATE());
GO

/* =====================================================
   QUERY 4: Employee Sales Count
   ===================================================== */

-- 4(a) UNOPTIMIZED
SELECT 
    e.name AS EmployeeName,
    (SELECT COUNT(*)
     FROM Bill b
     WHERE b.employee_id = e.employee_id) AS NumberOfSales
FROM Employee e;
GO

-- 4(b) OPTIMIZED
CREATE INDEX idx_Bill_EmployeeID
ON Bill(employee_id);
GO

SELECT 
    e.name AS EmployeeName,
    COUNT(b.bill_id) AS NumberOfSales
FROM Employee e
LEFT JOIN Bill b
ON e.employee_id = b.employee_id
GROUP BY e.name;
GO

/* =====================================================
   QUERY 5: Low Stock Products That Have Been Sold
   ===================================================== */

-- 5(a) UNOPTIMIZED
SELECT DISTINCT name AS ProductName
FROM Product
WHERE quantity_in_stock < 50
AND product_id IN (
    SELECT product_id
    FROM Bill_Product
);
GO

-- 5(b) OPTIMIZED
CREATE INDEX idx_Product_Quantity
ON Product(quantity_in_stock);
GO

SELECT DISTINCT p.name AS ProductName
FROM Product p
JOIN Bill_Product bp
ON p.product_id = bp.product_id
WHERE p.quantity_in_stock < 50;
GO
