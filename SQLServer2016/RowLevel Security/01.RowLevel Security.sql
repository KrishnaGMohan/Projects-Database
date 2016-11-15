--------------------------------------------------------------------------------
-- 
-- Rowl Level Security
--
--------------------------------------------------------------------------------
/*
DROP SECURITY POLICY rls.accessSecurityPolicy
DROP FUNCTION rls.accessPredicate
DROP SCHEMA rls

SELECT 
  AdventureWorks2016CTP3.HumanResources.Employee.LoginID AS LoginID
  ,AdventureWorks2016CTP3.Person.Person.FirstName AS FirstName
  ,AdventureWorks2016CTP3.Person.Person.LastName AS LastName
  ,AdventureWorks2016CTP3.HumanResources.Employee.JobTitle AS JobTitle
  ,AdventureWorks2016CTP3.HumanResources.Department.Name AS DeptName
  ,AdventureWorks2016CTP3.HumanResources.EmployeeDepartmentHistory.DepartmentID AS DepartmentID
INTO dbo.EmpDept
FROM
  AdventureWorks2016CTP3.HumanResources.Employee
  INNER JOIN AdventureWorks2016CTP3.Person.Person
    ON AdventureWorks2016CTP3.HumanResources.Employee.BusinessEntityID = AdventureWorks2016CTP3.Person.Person.BusinessEntityID
  INNER JOIN AdventureWorks2016CTP3.HumanResources.EmployeeDepartmentHistory
    ON AdventureWorks2016CTP3.HumanResources.Employee.BusinessEntityID = AdventureWorks2016CTP3.HumanResources.EmployeeDepartmentHistory.BusinessEntityID
  INNER JOIN AdventureWorks2016CTP3.HumanResources.Department
    ON AdventureWorks2016CTP3.HumanResources.EmployeeDepartmentHistory.DepartmentID = AdventureWorks2016CTP3.HumanResources.Department.DepartmentID;

GO

DROP USER diane1
DROP USER janice0
DROP USER mary2

CREATE USER diane1 WITHOUT LOGIN;
CREATE USER janice0 WITHOUT LOGIN;
CREATE USER mary2 WITHOUT LOGIN;


GRANT SELECT, INSERT, UPDATE, DELETE  ON dbo.Department TO diane1, janice0, mary2
GRANT SELECT, INSERT, UPDATE, DELETE  ON dbo.EmpDept TO diane1, janice0, mary2


--Tool Design
--Research and Development

*/

CREATE SCHEMA rls
GO

CREATE FUNCTION rls.accessPredicate(@deptName sysname)
	RETURNS table
	WITH SchemaBinding
AS
RETURN 	SELECT 1 AS [accessPredicateResult]
	FROM dbo.EmpDept
	WHERE 
	(
		LoginId = 'adventure-works\' + USER_NAME()
		AND DeptName = @deptName
	)
	OR
	SUSER_NAME() = 'NORTHAMERICA\krgandhi'
GO

CREATE SECURITY POLICY rls.accessSecurityPolicy
	ADD FILTER PREDICATE rls.accessPredicate(Name) ON dbo.Department,
	ADD BLOCK  PREDICATE rls.accessPredicate(Name) ON dbo.Department AFTER INSERT
GO


SELECT * from dbo.Department


EXECUTE AS USER = 'diane1';
SELECT * from dbo.Department
REVERT

EXECUTE AS USER = 'janice0';
SELECT * from dbo.Department
REVERT

EXECUTE AS USER = 'mary2';
SELECT * from dbo.Department
REVERT


EXECUTE AS USER = 'diane1';
UPDATE dbo.Department
SET GroupName = 'R&D'
WHERE DepartmentID = 6
SELECT * from dbo.Department
REVERT

/*
-- Cleanup
EXECUTE AS USER = 'diane1';
UPDATE dbo.Department
SET GroupName = 'Research and Development'
WHERE DepartmentID = 6
SELECT * from dbo.Department
REVERT
*/