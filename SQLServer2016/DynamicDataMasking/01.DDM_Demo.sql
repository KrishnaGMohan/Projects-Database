--DROP USER DDMUser;

CREATE USER DDMUser WITHOUT LOGIN;  
GRANT SELECT ON dbo.Supplier TO DDMUser;  
  
EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 

------------------------------------------------
ALTER TABLE dbo.Supplier  
ALTER COLUMN [Postal Code] 
ADD MASKED WITH (FUNCTION = 'default()')

EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 

GRANT UNMASK TO DDMUser;
EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 
REVOKE UNMASK FROM DDMUser;

------------------------------------------------
ALTER TABLE dbo.Supplier  
ALTER COLUMN [Postal Code] 
ADD MASKED WITH (FUNCTION = 'email()')

EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 
------------------------------------------------

ALTER TABLE dbo.Supplier  
ALTER COLUMN [Payment Days] 
ADD MASKED WITH (FUNCTION = 'random(1800, 3650)')

EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 

------------------------------------------------
ALTER TABLE dbo.Supplier  
ALTER COLUMN [Category] 
ADD MASKED WITH (FUNCTION = 'partial(3,"***",3)');

EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 

------------------------------------------------

SELECT	c.name as column_name, 
		tbl.name as table_name, 
		c.is_masked, c.masking_function  
FROM sys.masked_columns AS c  
JOIN sys.tables AS tbl   
    ON c.[object_id] = tbl.[object_id]  
WHERE is_masked = 1; 


------------------------------------------------

ALTER TABLE dbo.Supplier 
ALTER COLUMN [Category] DROP MASKED;

ALTER TABLE dbo.Supplier 
ALTER COLUMN [Payment Days] DROP MASKED;

ALTER TABLE dbo.Supplier 
ALTER COLUMN [Postal Code] DROP MASKED;

EXECUTE AS USER = 'DDMUser';  
SELECT * FROM dbo.Supplier;  
REVERT; 
------------------------------------------------
DROP USER DDMUser;


