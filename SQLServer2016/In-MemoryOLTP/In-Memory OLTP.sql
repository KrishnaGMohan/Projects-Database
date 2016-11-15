--------------------------------------------------------------------------------
-- 
-- Creating a Database
--
--------------------------------------------------------------------------------

CREATE DATABASE [imoltp]
ON PRIMARY 
(NAME = N'imoltp_data', FILENAME = N'D:\IMOLTP\DATA\imoltp_data.mdf'),
FILEGROUP [imoltp_InMemory] CONTAINS MEMORY_OPTIMIZED_DATA
(NAME = N'imoltp_mem_1', FILENAME = N'D:\IMOLTP\MEM\LUN1')
LOG ON 
(NAME = N'imoltp_log', FILENAME = N'D:\IMOLTP\LOG\imoltp_log.ldf')


ALTER DATABASE [imoltp]
ADD FILE (NAME = N'imoltp_mem_2', 
FILENAME = N'C:\IMOLTP\MEM\LUN2')
TO FILEGROUP [imoltp_InMemory]

ALTER DATABASE imoltp SET MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT=ON 


--------------------------------------------------------------------------------
-- 
-- Creating Tables and Indexes
--
--------------------------------------------------------------------------------
-- DROP TABLE dbo.UserSession
-- DROP TABLE dbo.ShoppingCart
USE [imoltp]
GO

CREATE TABLE dbo.UserSession (
	SessionId INT IDENTITY(1,1) 
		PRIMARY KEY NONCLUSTERED 
		HASH WITH (BUCKET_COUNT=400000), 
	UserId int NOT NULL, 
	CreatedDate DATETIME2 NOT NULL, 
	ShoppingCartId INT
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY=SCHEMA_AND_DATA);
GO 

ALTER TABLE dbo.UserSession
	ADD INDEX ix_UserId NONCLUSTERED 
		HASH (UserId) WITH (BUCKET_COUNT=400000);

ALTER TABLE dbo.UserSession
	ADD INDEX ix_CreatedDate NONCLUSTERED (CreatedDate);
GO

CREATE TABLE dbo.ShoppingCart (   
    ShoppingCartId INT IDENTITY(1,1) PRIMARY KEY NONCLUSTERED,  
    UserId INT NOT NULL INDEX ix_UserId NONCLUSTERED HASH WITH (BUCKET_COUNT=400000),   
    CreatedDate DATETIME2 NOT NULL,   
    TotalPrice MONEY  
) WITH (MEMORY_OPTIMIZED=ON, DURABILITY=SCHEMA_AND_DATA)  
  GO


INSERT dbo.UserSession VALUES (342, SYSDATETIME(), 4)   
INSERT dbo.UserSession VALUES (65, SYSDATETIME(), NULL)   
INSERT dbo.UserSession VALUES (8798, SYSDATETIME(), 1)   
INSERT dbo.UserSession VALUES (80, SYSDATETIME(), NULL)   
INSERT dbo.UserSession VALUES (4321, SYSDATETIME(), NULL)   
INSERT dbo.UserSession VALUES (8578, SYSDATETIME(), NULL)   
GO
  
INSERT dbo.ShoppingCart VALUES (8798, SYSDATETIME(), NULL)   
INSERT dbo.ShoppingCart VALUES (23, SYSDATETIME(), 45.4)   
INSERT dbo.ShoppingCart VALUES (80, SYSDATETIME(), NULL)   
INSERT dbo.ShoppingCart VALUES (342, SYSDATETIME(), 65.4)   
GO  

SELECT * FROM dbo.UserSession   
SELECT * FROM dbo.ShoppingCart   
GO 

UPDATE STATISTICS dbo.UserSession WITH FULLSCAN, NORECOMPUTE   
UPDATE STATISTICS dbo.ShoppingCart WITH FULLSCAN, NORECOMPUTE   
GO  

--------------------------------------------------------------------------------
-- 
-- Natively Compiled Stored Procedures
--
--------------------------------------------------------------------------------
CREATE PROCEDURE dbo.usp_insertUserSession 
	@UserId INT NOT NULL, 
	@ShoppingCartId INT NOT NULL
WITH NATIVE_COMPILATION, SCHEMABINDING 
AS 
BEGIN ATOMIC 
WITH (TRANSACTION ISOLATION LEVEL = SNAPSHOT, LANGUAGE = N'us_english', DELAYED_DURABILITY = OFF) 
	INSERT  dbo.UserSession VALUES (@UserId , SYSDATETIME(), @ShoppingCartId)   
END; 
GO 

EXEC dbo.usp_insertUserSession 78, 45
EXEC dbo.usp_insertUserSession  677, 56

SELECT * FROM dbo.UserSession 