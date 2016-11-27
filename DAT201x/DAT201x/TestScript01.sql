USE [AdventureWorksLT2012]
GO

SELECT [ProductID],[ListPrice], [StandardCost], [ListPrice] - [StandardCost] AS Margin, Color
FROM [SalesLT].[Product]


SELECT [ProductID], Color, Size
FROM [SalesLT].[Product]


SELECT * FROM [SalesLT].[Customer]

SELECT [Title],[FirstName],[MiddleName],[LastName],[Suffix]
FROM [SalesLT].[Customer]

SELECT ISNULL([Title],'') + [LastName], [Phone]
FROM [SalesLT].[Customer]

SELECT CAST([CustomerID] AS NVARCHAR(20))+':'+[CompanyName]
FROM [SalesLT].[Customer]

---------------------------------------------

SELECT DISTINCT [StateProvince], [City]
FROM [SalesLT].[Address]


SELECT TOP 10 PERCENT [Name], [Weight]
FROM [SalesLT].[Product]
ORDER BY [Weight] DESC

SELECT [Name], [Weight] 
FROM [SalesLT].[Product]
ORDER BY [Weight] DESC
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY;


-------------------------------------------------

--Retrieve Product Details
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1;

--Retrieve Products by Color and Size
SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE Color IN ('Black','Red','White') and Size IN ('S','M');

--Retrieve Products by Product Number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'BK-%';

--Retrieve Specific Products by Product Number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';