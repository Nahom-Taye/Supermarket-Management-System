USE supermarkeet;
GO

-- CUSTOMER
INSERT INTO dbo.Customer (name, contact_number, email, address)
VALUES ('Alice Johnson', '0912345678', 'alice@example.com', 'Addis Ababa');

-- EMPLOYEE
INSERT INTO dbo.Employee (name, role, shift, salary, contact_number)
VALUES ('Daniel Mekonnen', 'Cashier', 'Morning', 5000, '0934567890');

-- PRODUCT
INSERT INTO dbo.Product (name, brand, price, quantity_in_stock, expiry_date, category_name)
VALUES ('Milk', 'DairyPure', 45, 50, '2025-01-10', 'Dairy');

-- PAYMENT + BILL + BILL_PRODUCT (ONE BATCH)
DECLARE @PaymentID INT;
DECLARE @BillID INT;

INSERT INTO dbo.Payment (method, amount, card_last_four)
VALUES ('Card', 75, '1234');



INSERT INTO dbo.Bill (customer_id, employee_id, payment_id, total_amount)
VALUES (1, 2001,4001, 75);


INSERT INTO dbo.Bill_Product (bill_id, product_id, quantity)
VALUES (5001, 1001, 1);
GO
