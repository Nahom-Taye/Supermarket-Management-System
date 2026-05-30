/* =====================================================
   Supermarket Management System (Improved)
   Phase 2: Implementation (Advanced Database Systems)
   RDBMS: SQL Server
   ===================================================== */

--------------------------------------------------------
-- 1. DATABASE SETUP
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'Supermarkeet')
BEGIN
    ALTER DATABASE Supermarkeet SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Supermarkeet;
END
GO

CREATE DATABASE supermarkeet;
GO
USE supermarkeet;
GO
