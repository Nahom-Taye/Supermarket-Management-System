/* =====================================================
   Supermarket Management System – Part 3
   ROLE-BASED ACCESS CONTROL & USERS
   Database: supermarkeet
   ===================================================== */

-- Use correct database
USE supermarkeet;
GO

------------------------------------------------
-- 1. CREATE ROLES
------------------------------------------------
CREATE ROLE AdminRole;
CREATE ROLE ManagerRole;
CREATE ROLE CashierRole;
GO

------------------------------------------------
-- 2. GRANT PERMISSIONS
------------------------------------------------

-- ADMIN: Full access
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Product TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Bill TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Bill_Product TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Employee TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Customer TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Supplier TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Payment TO AdminRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Restock_Log TO AdminRole;

-- MANAGER: Manage products and employees
GRANT SELECT, UPDATE ON dbo.Product TO ManagerRole;
GRANT SELECT, UPDATE ON dbo.Employee TO ManagerRole;
GRANT SELECT ON dbo.Bill TO ManagerRole;

-- CASHIER: Sales only
GRANT SELECT ON dbo.Product TO CashierRole;
GRANT INSERT ON dbo.Bill TO CashierRole;
GRANT INSERT ON dbo.Bill_Product TO CashierRole;
GO

------------------------------------------------
-- 3. CREATE LOGINS (SERVER LEVEL)
------------------------------------------------
CREATE LOGIN admin_userr WITH PASSWORD = 'Admiin@123';
CREATE LOGIN manager_userr WITH PASSWORD = 'Managier@123';
CREATE LOGIN cashier_userr WITH PASSWORD = 'Cashiier@123';
GO

------------------------------------------------
-- 4. CREATE USERS (DATABASE LEVEL)
------------------------------------------------
CREATE USER admin_user FOR LOGIN admin_user;
CREATE USER manager_user FOR LOGIN manager_user;
CREATE USER cashier_user FOR LOGIN cashier_user;
GO

------------------------------------------------
-- 5. ASSIGN USERS TO ROLES
------------------------------------------------
ALTER ROLE AdminRole ADD MEMBER admin_user;
ALTER ROLE ManagerRole ADD MEMBER manager_user;
ALTER ROLE CashierRole ADD MEMBER cashier_user;
GO
