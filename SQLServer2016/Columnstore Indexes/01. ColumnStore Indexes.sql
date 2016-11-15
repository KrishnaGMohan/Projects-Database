--------------------------------------------------------------------------------
-- 
-- ColumnStore Indexes - Enforce Primary Key
--
--------------------------------------------------------------------------------
-- DROP TABLE Supplier

-- Create a rowstore table
CREATE TABLE [dbo].[Supplier](
	[Supplier Key] [int] NOT NULL,
	[WWI Supplier ID] [int] NOT NULL,
	[Supplier] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Supplier Reference] [nvarchar](20) NULL,
	[Payment Days] [int] NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,

	CONSTRAINT uniq_Supplier UNIQUE ([Supplier Key])
) ON [PRIMARY]

--Store the table as a columnstore.  
CREATE CLUSTERED COLUMNSTORE INDEX Supplier_cci ON Supplier;  
GO  

-- Create a nonclustered index on the columnstore index
CREATE INDEX ix_Supplier_WWI_Supplier_ID ON Supplier([WWI Supplier ID]);
GO

/*
INSERT INTO dbo.Supplier 
SELECT * FROM [SQLServer2016].[dbo].[Supplier]
*/
SELECT * FROM Supplier;

--------------------------------------------------------------------------------
-- 
-- Real-Time Operational Analytics - Disk Based
--
--------------------------------------------------------------------------------
-- DROP TABLE Supplier;
-- Create a rowstore table
CREATE TABLE [dbo].[Supplier](
	[Supplier Key] [int] NOT NULL,
	[WWI Supplier ID] [int] NOT NULL,
	[Supplier] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Supplier Reference] [nvarchar](20) NULL,
	[Payment Days] [int] NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,

	CONSTRAINT uniq_Supplier UNIQUE ([Supplier Key])
) ON [PRIMARY]

--Create the columnstore index  
CREATE NONCLUSTERED COLUMNSTORE INDEX Supplier_ncci   
ON [dbo].[Supplier](
	[Supplier Key],	[WWI Supplier ID], 	[Supplier], [Category],
	[Primary Contact], [Supplier Reference], [Payment Days], 
	[Postal Code], [Valid From], [Valid To], [Lineage Key]
)
;  
/*
INSERT INTO dbo.Supplier 
SELECT * FROM [SQLServer2016].[dbo].[Supplier]
*/

SELECT * FROM Supplier;
--------------------------------------------------------------------------------
-- 
-- Real-Time Operational Analytics - In-Memory
--
--------------------------------------------------------------------------------
-- DROP TABLE Supplier;
-- Create a rowstore table
CREATE TABLE [dbo].[Supplier](
	[Supplier Key] [int] NOT NULL PRIMARY KEY NONCLUSTERED,
	[WWI Supplier ID] [int] NOT NULL,
	[Supplier] [nvarchar](100) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Primary Contact] [nvarchar](50) NOT NULL,
	[Supplier Reference] [nvarchar](20) NULL,
	[Payment Days] [int] NOT NULL,
	[Postal Code] [nvarchar](10) NOT NULL,
	[Valid From] [datetime2](7) NOT NULL,
	[Valid To] [datetime2](7) NOT NULL,
	[Lineage Key] [int] NOT NULL,

	CONSTRAINT uniq_Supplier UNIQUE ([Supplier Key]),
	INDEX Supplier_cci CLUSTERED COLUMNSTORE

) 	
WITH (MEMORY_OPTIMIZED = ON );  

/*
SELECT *  INTO dbo.SupplierData
FROM [SQLServer2016].[dbo].[Supplier]

INSERT INTO dbo.Supplier 
SELECT * FROM [dbo].[SupplierData]
*/
SELECT COUNT(*) FROM Supplier
WHERE [Payment Days] > 20


---------------------------------------------------------
-- Session 1
BEGIN TRAN 
UPDATE Supplier
SET [Payment Days] = [Payment Days] + 5
WHERE [Payment Days] > 15
ROLLBACK

BEGIN TRAN
SELECT * FROM Supplier
WHERE [Payment Days] > 15
---------------------------------------------------------
-- Session 2
BEGIN TRAN
SELECT * FROM Supplier
WHERE [Payment Days] > 15

SELECT * FROM Supplier

UPDATE Supplier
SET [Payment Days] = [Payment Days] + 5
WHERE [Payment Days] > 15

ROLLBACK