--------------------------------------------------------------------------------
-- 
-- Creating a System-Versioned Temporal Table
--
--------------------------------------------------------------------------------
-- ALTER TABLE dbo.Department SET (SYSTEM_VERSIONING = OFF);   
-- DROP TABLE dbo.[Department]
-- DROP TABLE dbo.[DepartmentHistory]
-- GO

CREATE TABLE dbo.[Department](
	[DepartmentID] [smallint] IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	[Name] NVARCHAR(50) NOT NULL,
	[GroupName] NVARCHAR(50) NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL,
	SysEndTime datetime2 GENERATED ALWAYS AS ROW END  NOT NULL,
	PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)     
)
WITH (   
      SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DepartmentHistory)   
	 )   
GO

INSERT INTO dbo.[Department] ( [Name], [GroupName], [ModifiedDate])
SELECT [Name]
      ,[GroupName]
      ,[ModifiedDate]
  FROM [AdventureWorks2016CTP3].[HumanResources].[Department]
GO

SELECT * FROM dbo.[Department] 
GO


UPDATE dbo.[Department] 
SET Name = 'Sales2'
WHERE DepartmentID = 3;
GO

WAITFOR DELAY '00:01'

UPDATE dbo.[Department] 
SET Name = 'Sales'
WHERE DepartmentID = 3;
GO

WAITFOR DELAY '00:01'

--------------------------------------------------------------------------------
-- 
-- Querying Data in a Temporal Table
--
--------------------------------------------------------------------------------

SELECT * from dbo.Department
FOR SYSTEM_TIME ALL


SELECT * from dbo.Department
FOR SYSTEM_TIME BETWEEN '2016-10-03 20:35:00.0000000' AND '2016-10-03 20:40:00.0000000'
WHERE DepartmentID = 3

SELECT * from dbo.Department
FOR SYSTEM_TIME BETWEEN '2016-10-03 20:35:00.0000000' AND '2016-10-03 20:40:00.0000000'
WHERE DepartmentID = 3

SELECT * from dbo.Department
FOR SYSTEM_TIME AS OF '2016-10-03 20:35:00.0000000' 
WHERE DepartmentID = 3

SELECT * from dbo.Department
FOR SYSTEM_TIME AS OF '2016-10-03 20:40:00.0000000' 
WHERE DepartmentID = 3


SELECT * from dbo.Department
FOR SYSTEM_TIME BETWEEN '2016-10-03 20:20:00.0000000' AND '2016-10-03 20:50:00.0000000'
WHERE DepartmentID = 3
ORDER BY SysStartTime DESC 


--------------------------------------------------------------------------------
-- 
-- Managing a Temporal Table
--
--------------------------------------------------------------------------------

BEGIN TRAN
ALTER TABLE dbo.Department
	ADD  CostCenter INT;
ALTER TABLE dbo.Department   
   ALTER COLUMN SysStartTime ADD HIDDEN;   
ALTER TABLE dbo.Department   
   ALTER COLUMN SysEndTime ADD HIDDEN;  
COMMIT;

UPDATE  dbo.Department
SET CostCenter = 10000+ DepartmentID

SELECT * from dbo.Department;
GO


BEGIN TRAN
ALTER TABLE dbo.Department
	DROP COLUMN  CostCenter;
ALTER TABLE dbo.Department   
   ALTER COLUMN SysStartTime DROP HIDDEN;   
ALTER TABLE dbo.Department   
   ALTER COLUMN SysEndTime DROP HIDDEN;  
COMMIT;

SELECT * from dbo.Department;
GO


ALTER TABLE dbo.Department SET (SYSTEM_VERSIONING = OFF); 
GO

ALTER TABLE dbo.Department SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DepartmentHistory)) ;
GO

--------------------------------------------------------------------------------
-- 
-- Temporal Tables Metadata
--
--------------------------------------------------------------------------------


SELECT	a.object_id AS [TemporalTableID],
		a.name AS [TemporalTable],
		a.temporal_type AS [TemporalTableType],
		a.temporal_type_desc AS [TemporalTableTypeDesc],
		b.object_id AS [HistoryObjectID],
		b.name AS [HistoryTable],
		b.temporal_type AS [HistoryTableType],
		b.temporal_type_desc AS [HistoryTableTypeDesc]
FROM sys.tables a JOIN sys.tables b ON a.history_table_id = b.object_id

SELECT * FROM sys.periods

SELECT	name AS [TemporalTable], 
		OBJECTPROPERTY(object_id, 'TableTemporalType') AS [TemporalTableType]
FROM sys.tables
WHERE OBJECTPROPERTY(object_id, 'TableTemporalType') ! = 0

SELECT	name AS [TemporalTable], 
		OBJECTPROPERTYEX(object_id, 'TableTemporalType') AS [TemporalTableType]
FROM sys.tables
WHERE OBJECTPROPERTYEX(object_id, 'TableTemporalType') ! = 0

