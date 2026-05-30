--------------------------------------------------------
-- 2. TABLE CREATION
--------------------------------------------------------
USE supermarkeet;
GO

CREATE TABLE dbo.Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    address VARCHAR(200)
);

CREATE TABLE dbo.Product (
    product_id INT IDENTITY(1001,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    quantity_in_stock INT NOT NULL CHECK (quantity_in_stock >= 0),
    expiry_date DATE,
    category_name VARCHAR(50)
);

CREATE TABLE dbo.Employee (
    employee_id INT IDENTITY(2001,1) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50),
    shift VARCHAR(20),
    salary DECIMAL(10,2),
    contact_number VARCHAR(15)
);

CREATE TABLE dbo.Supplier (
    supplier_id INT IDENTITY(3001,1) PRIMARY KEY,
    company_name VARCHAR(100),
    contact_person VARCHAR(100),
    contact_number VARCHAR(15),
    email VARCHAR(100),
    delivery_schedule VARCHAR(100)
);

CREATE TABLE dbo.Payment (
    payment_id INT IDENTITY(4001,1) PRIMARY KEY,
    method VARCHAR(20),
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    card_last_four VARCHAR(4)
);

CREATE TABLE dbo.Bill (
    bill_id INT IDENTITY(5001,1) PRIMARY KEY,
    customer_id INT NULL,
    employee_id INT NOT NULL,
    payment_id INT UNIQUE,
    date_time DATETIME DEFAULT GETDATE(),
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES dbo.Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES dbo.Employee(employee_id),
    FOREIGN KEY (payment_id) REFERENCES dbo.Payment(payment_id)
);

CREATE TABLE dbo.Bill_Product (
    bill_id INT,
    product_id INT,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (bill_id, product_id),
    FOREIGN KEY (bill_id) REFERENCES dbo.Bill(bill_id),
    FOREIGN KEY (product_id) REFERENCES dbo.Product(product_id)
);

CREATE TABLE dbo.Restock_Log (
    log_id INT IDENTITY(6001,1) PRIMARY KEY,
    product_id INT,
    employee_id INT,
    supplier_id INT,
    quantity_change INT,
    date_time DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (product_id) REFERENCES dbo.Product(product_id),
    FOREIGN KEY (employee_id) REFERENCES dbo.Employee(employee_id),
    FOREIGN KEY (supplier_id) REFERENCES dbo.Supplier(supplier_id)
);
GO
