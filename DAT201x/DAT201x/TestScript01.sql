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
