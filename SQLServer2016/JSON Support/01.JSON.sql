--------------------------------------------------------------------------------
-- 
-- Querying and Analyzing JSON data
--
--------------------------------------------------------------------------------
DECLARE @json NVARCHAR(4000)
SET @json = N'
{
    "ID": {
        "SupplierKey": 2,
        "SupplierID": 13
    },
    "Info": {
        "Supplier": "Woodgrove Bank",
        "Category": "Financial Services Supplier",
        "PrimaryContact": "Hubert Helms",
        "SupplierReference": "028034202"
    }
}
'

SELECT
  JSON_VALUE(@json, '$.ID.SupplierKey') as SupplierKey,
  JSON_VALUE(@json, '$.Info.Category') as Category
  
--------------------------------------------------------------------------------
DECLARE @json NVARCHAR(4000)
SET @json = N'
{
    "ID": {
        "SupplierKey": 2,
        "SupplierID": 13
    },
    "Info": {
        "Supplier": "Woodgrove Bank",
        "Category": "Financial Services Supplier",
        "PrimaryContact": "Hubert Helms",
        "SupplierReference": "028034202"
    }
}
'
SELECT 
  JSON_QUERY(@json, '$.Info') as Info

--------------------------------------------------------------------------------

DECLARE @json NVARCHAR(4000)
SET @json = N'
{
    "ID": {
        "SupplierKey": 2,
        "SupplierID": 13
    },
    "Info": {
        "Supplier": "Woodgrove Bank",
        "Category": "Financial Services Supplier",
        "PrimaryContact": "Hubert Helms",
        "SupplierReference": "028034202"
    }
}
'
SELECT 
	ISJSON(@json)

--------------------------------------------------------------------------------
-- 
-- Storing JSON data
--
--------------------------------------------------------------------------------

--DROP TABLE SupplierJSON
--GO

CREATE TABLE SupplierJSON
(
	[Supplier Key] INT,
	[WWI Supplier ID] INT,
	[Info] nvarchar(max) CHECK (ISJSON(Info) = 1)
);
GO

INSERT INTO SupplierJSON
SELECT a.[Supplier Key], a.[WWI Supplier ID],
	( SELECT [Supplier], [Category], [Primary Contact], [Supplier Reference]
		FROM [Dimension].[Supplier] b
		WHERE a.[Supplier Key] = b.[Supplier Key]
		FOR JSON PATH, WITHOUT_ARRAY_WRAPPER 
	) AS Info
FROM [Dimension].[Supplier]  a
GO

SELECT *, ISJSON(Info) AS [IsJSON?]
FROM SupplierJSON
GO
----------------------------------------------------------------------
-- Compressed JSON Storage

DROP TABLE SupplierJSON
GO

CREATE TABLE SupplierJSON
(
	[Supplier Key] INT,
	[WWI Supplier ID] INT,
	[Info] varbinary(max)
);
GO

INSERT INTO SupplierJSON
SELECT a.[Supplier Key], a.[WWI Supplier ID],
	COMPRESS (
		( SELECT [Supplier], [Category], [Primary Contact], [Supplier Reference]
			FROM [Dimension].[Supplier] b
			WHERE a.[Supplier Key] = b.[Supplier Key]
			FOR JSON PATH, WITHOUT_ARRAY_WRAPPER 
		) 
	) AS Info
FROM [Dimension].[Supplier] a
GO

SELECT  CAST(DECOMPRESS(info) AS NVARCHAR(MAX)) AS info  
FROM SupplierJSON
GO
----------------------------------------------------------------------



--------------------------------------------------------------------------------
-- 
-- Transform JSON data to Table data
--
--------------------------------------------------------------------------------
DECLARE @json NVARCHAR(4000)
SET @json = N'{  
  "StringValue":"John",  
  "IntValue":45,  
  "TrueValue":true,  
  "FalseValue":false,  
  "NullValue":null,  
  "ArrayValue":["a","r","r","a","y"],  
  "ObjectValue":{"obj":"ect"}  
}'  
  
SELECT *   
FROM OPENJSON(@json)  

--------------------------------------------------------------------------------
DECLARE @json NVARCHAR(4000)
SET @json = N'{  
  "StringValue":"John",  
  "IntValue":45,  
  "TrueValue":true,  
  "FalseValue":false,  
  "NullValue":null,  
  "ArrayValue":["a","r","r","a","y"],  
  "ObjectValue":{"obj":"ect"}  
}'  

SELECT *   
FROM OPENJSON(@json, '$.ObjectValue') 
--------------------------------------------------------------------------------
DECLARE @json NVARCHAR(4000)
SET @json = N'{  
  "StringValue":"John",  
  "IntValue":45,  
  "TrueValue":true,  
  "FalseValue":false,  
  "NullValue":null,  
  "ArrayValue":["a","r","r","a","y"],  
  "ObjectValue":{"obj":"ect"}  
}'  
SELECT *   
FROM OPENJSON(@json, '$.ArrayValue')  
--------------------------------------------------------------------------------
-- Prepare table 

DROP TABLE SupplierJSON
GO

CREATE TABLE SupplierJSON
(
	[Supplier Key] INT,
	[WWI Supplier ID] INT,
	[Info] nvarchar(max) CHECK (ISJSON(Info) = 1)
);
GO

INSERT INTO SupplierJSON
SELECT a.[Supplier Key], a.[WWI Supplier ID],
	( SELECT [Supplier], [Category], [Primary Contact], [Supplier Reference]
		FROM Dimension.Supplier b
		WHERE a.[Supplier Key] = b.[Supplier Key]
		FOR JSON PATH, WITHOUT_ARRAY_WRAPPER 
	) AS Info
FROM Dimension.Supplier a
GO

SELECT *, ISJSON(Info) AS [IsJSON?]
FROM SupplierJSON
GO

SELECT [Supplier Key], [WWI Supplier ID], 
		Info.[Supplier], Info.[Category],
		Info.[Primary Contact],  Info.[Supplier Reference]
FROM SupplierJSON 
CROSS APPLY OPENJSON(SupplierJSON.Info)
WITH (
	[Supplier] nvarchar(100) '$.Supplier',
	[Category] nvarchar(50) '$.Category',
	[Primary Contact] nvarchar(50) '$."Primary Contact"',
	[Supplier Reference] nvarchar(20) '$."Supplier Reference"'
) AS Info

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- 
-- Transform Table data to JSON data
--
--------------------------------------------------------------------------------

SELECT TOP 2 [Supplier Key], Supplier, Category
FROM [Dimension].[Supplier]
WHERE [Supplier Key] != 0
FOR JSON AUTO

/*
[{
    "Supplier Key": 1,
    "Supplier": "A Datum Corporation",
    "Category": "Novelty Goods Supplier"
}, {
    "Supplier Key": 2,
    "Supplier": "Woodgrove Bank",
    "Category": "Financial Services Supplier"
}]
*/

SELECT TOP 2 [Supplier Key], Supplier, Category
FROM [Dimension].[Supplier]
WHERE [Supplier Key] != 0
FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER

SELECT TOP 2 [Supplier Key], Supplier, Category
FROM [Dimension].[Supplier]
WHERE [Supplier Key] != 0
FOR JSON AUTO, WITHOUT_ARRAY_WRAPPER, INCLUDE_NULL_VALUES 
/*

{
    "Supplier Key": 1,
    "Supplier": "A Datum Corporation",
    "Category": "Novelty Goods Supplier"
}, {
    "Supplier Key": 2,
    "Supplier": "Woodgrove Bank",
    "Category": "Financial Services Supplier"
}
*/


---------------------------------------------------------

SELECT TOP 2 
 [Supplier Key] AS [ID.SupplierKey],
 [WWI Supplier ID] AS [ID.SupplierID],
 [Supplier] AS [Info.Supplier],
 [Category] AS [Info.Category],
 [Primary Contact] AS [Info.PrimaryContact],
 [Supplier Reference] AS [Info.SupplierReference]
FROM [Dimension].[Supplier]
WHERE [Supplier Key] != 0
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER 

/*
{
    "ID": {
        "SupplierKey": 1,
        "SupplierID": 1
    },
    "Info": {
        "Supplier": "A Datum Corporation",
        "Category": "Novelty Goods Supplier",
        "PrimaryContact": "Reio Kabin",
        "SupplierReference": "AA20384"
    }
}, {
    "ID": {
        "SupplierKey": 2,
        "SupplierID": 13
    },
    "Info": {
        "Supplier": "Woodgrove Bank",
        "Category": "Financial Services Supplier",
        "PrimaryContact": "Hubert Helms",
        "SupplierReference": "028034202"
    }
}
*/
----------------------------------------------------------

SELECT TOP 2 
 [Supplier Key] AS [ID.SupplierKey],
 [WWI Supplier ID] AS [ID.SupplierID],
 [Supplier] AS [Info.Supplier],
 [Category] AS [Info.Category],
 [Primary Contact] AS [Info.PrimaryContact],
 [Supplier Reference] AS [Info.SupplierReference]
FROM [Dimension].[Supplier]
WHERE [Supplier Key] != 0
FOR JSON PATH, ROOT('Suppliers'), INCLUDE_NULL_VALUES;


/*
{
    "Suppliers": [{
        "ID": {
            "SupplierKey": 1,
            "SupplierID": 1
        },
        "Info": {
            "Supplier": "A Datum Corporation",
            "Category": "Novelty Goods Supplier",
            "PrimaryContact": "Reio Kabin",
            "SupplierReference": "AA20384"
        }
    }, {
        "ID": {
            "SupplierKey": 2,
            "SupplierID": 13
        },
        "Info": {
            "Supplier": "Woodgrove Bank",
            "Category": "Financial Services Supplier",
            "PrimaryContact": "Hubert Helms",
            "SupplierReference": "028034202"
        }
    }]
}
*/
------------------------------------------------------