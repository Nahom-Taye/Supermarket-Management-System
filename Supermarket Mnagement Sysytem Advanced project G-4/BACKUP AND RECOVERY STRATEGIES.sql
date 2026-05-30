/* =====================================================
   BACKUP AND RECOVERY STRATEGY
   DATABASE: supermarkeet
   ===================================================== */

USE master;
GO

/* 1. Ensure database exists */
IF DB_ID('supermarkeet') IS NULL
BEGIN
    RAISERROR('Database "supermarkeet" does not exist.', 16, 1);
    RETURN;
END;
GO

/* 2. Set FULL recovery model */
ALTER DATABASE supermarkeet
SET RECOVERY FULL;
GO

/* 3. Build backup file paths using the instance default backup folder */
DECLARE @BackupDir NVARCHAR(260);
DECLARE @FullBackup NVARCHAR(4000);
DECLARE @DiffBackup NVARCHAR(4000);
DECLARE @LogBackup  NVARCHAR(4000);

-- Get instance default backup directory
SET @BackupDir = CAST(SERVERPROPERTY('InstanceDefaultBackupPath') AS NVARCHAR(260));

IF @BackupDir IS NULL OR @BackupDir = ''
BEGIN
    -- Fallback: set your own directory here and make sure it exists
    SET @BackupDir = 'C:\SQLBackups';
END;

-- Make sure directory path does not end with backslash twice
IF RIGHT(@BackupDir, 1) = '\'
BEGIN
    SET @FullBackup = @BackupDir + 'supermarkeet_full.bak';
    SET @DiffBackup = @BackupDir + 'supermarkeet_diff.bak';
    SET @LogBackup  = @BackupDir + 'supermarkeet_log.trn';
END
ELSE
BEGIN
    SET @FullBackup = @BackupDir + '\supermarkeet_full.bak';
    SET @DiffBackup = @BackupDir + '\supermarkeet_diff.bak';
    SET @LogBackup  = @BackupDir + '\supermarkeet_log.trn';
END;

/* 4. FULL BACKUP (starts the log chain after switching to FULL) */
BACKUP DATABASE supermarkeet
TO DISK = @FullBackup
WITH INIT,
     FORMAT,
     NAME = 'supermarkeet – Full Database Backup';
GO

/* 5. DIFFERENTIAL BACKUP (after full) */
DECLARE @BackupDir2 NVARCHAR(260) = CAST(SERVERPROPERTY('InstanceDefaultBackupPath') AS NVARCHAR(260));
DECLARE @DiffBackup2 NVARCHAR(4000);

IF @BackupDir2 IS NULL OR @BackupDir2 = ''
    SET @BackupDir2 = 'C:\SQLBackups';

IF RIGHT(@BackupDir2, 1) = '\'
    SET @DiffBackup2 = @BackupDir2 + 'supermarkeet_diff.bak';
ELSE
    SET @DiffBackup2 = @BackupDir2 + '\supermarkeet_diff.bak';

BACKUP DATABASE supermarkeet
TO DISK = @DiffBackup2
WITH DIFFERENTIAL,
     INIT,
     NAME = 'supermarkeet – Differential Backup';
GO

/* 6. LOG BACKUP */
DECLARE @BackupDir3 NVARCHAR(260) = CAST(SERVERPROPERTY('InstanceDefaultBackupPath') AS NVARCHAR(260));
DECLARE @LogBackup3 NVARCHAR(4000);

IF @BackupDir3 IS NULL OR @BackupDir3 = ''
    SET @BackupDir3 = 'C:\SQLBackups';

IF RIGHT(@BackupDir3, 1) = '\'
    SET @LogBackup3 = @BackupDir3 + 'supermarkeet_log.trn';
ELSE
    SET @LogBackup3 = @BackupDir3 + '\supermarkeet_log.trn';

BACKUP LOG supermarkeet
TO DISK = @LogBackup3
WITH INIT,
     NAME = 'supermarkeet – Log Backup';
GO