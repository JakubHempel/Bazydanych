USE AdventureWorks2019

-- 1. Wykorzystujac wyrazenie CTE zbuduj zapytanie, ktore znajdzie informacje na temat stawki 
-- pracownika oraz jego danych, a nastepnie zapisze je do tabeli tymczasowej 
-- TempEmployeeInfo. Rozwiaz w oparciu o AdventureWorks.

CREATE TABLE #TempEmployeeInfo(
	FirstName NVARCHAR(60), 
	LastName NVARCHAR(60), 
	JobTitle NVARCHAR(60),
	PhoneNumber CHAR(20), 
	Address NVARCHAR(60), 
	Salary MONEY);

-- DROP TABLE #TempEmployeeInfo

WITH EmployeeInfo (BusinessEntityID, FirstName, LastName, JobTitle, PhoneNumber, Address)
AS 
(
	SELECT p.BusinessEntityID, p.FirstName, p.LastName, e.JobTitle, pp.PhoneNumber, a.AddressLine1 AS Address
	FROM Person.Person AS p
	INNER JOIN HumanResources.Employee AS e
	ON p.BusinessEntityID = e.BusinessEntityID
	INNER JOIN Person.PersonPhone AS pp
	ON p.BusinessEntityID = pp.BusinessEntityID
	INNER JOIN Person.BusinessEntityAddress AS b
	ON pp.BusinessEntityID = b.BusinessEntityID
	INNER JOIN Person.Address AS a
	ON a.AddressID = b.AddressID
),
SalaryInfo (BusinessEntityID, Salary)
AS
(
	SELECT BusinessEntityID, Rate FROM HumanResources.EmployeePayHistory AS eph
)

INSERT INTO #TempEmployeeInfo
SELECT e.FirstName, e.LastName, e.JobTitle, e.PhoneNumber, e.Address, s.Salary 
FROM EmployeeInfo AS e
INNER JOIN SalaryInfo AS s
ON e.BusinessEntityID = s.BusinessEntityID
ORDER BY LastName;

SELECT * FROM #TempEmployeeInfo

-- 2. Uzyskaj informacje na temat przychodow ze sprzedazy wed³ug firmy i kontaktu (za pomoca 
-- CTE i bazy AdventureWorksLT).
USE AdventureWorksLT2019

WITH IncomeCTE (CompanyContact, Revenue)
AS 
(
	SELECT c.CompanyName + ' (' + c.FirstName + ' ' + c.LastName + ')' AS CompanyContact, s.TotalDue AS Revenue
	FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.SalesOrderHeader AS s
	ON c.CustomerID = s.CustomerID
)

SELECT * FROM IncomeCTE
ORDER BY CompanyContact

-- 3. Napisz zapytanie, ktore zwroci wartosc sprzedazy dla poszczegolnych kategorii produktow.
-- Wykorzystaj CTE i baze AdventureWorksLT.

WITH ProductCTE (ProductID, ProductCategoryID)
AS
(
	SELECT p.ProductID, p.ProductCategoryID 
	FROM SalesLT.Product AS p
),
ProductNameCTE (ProductCategoryID, Category)
AS
(
	SELECT pc.ProductCategoryID, pc.Name
	FROM SalesLT.ProductCategory AS pc
),
SalesCTE (ProductID, SalesValue)
AS
(
	SELECT s.ProductID, s.LineTotal
	FROM SalesLT.SalesOrderDetail AS s
)

SELECT Category, ROUND(SUM(SalesValue), 2) AS SalesValue
FROM ProductNameCTE AS pmcte
INNER JOIN ProductCTE AS pcte
ON pcte.ProductCategoryID = pmcte.ProductCategoryID
INNER JOIN SalesCTE AS scte
ON scte.ProductID = pcte.ProductID
GROUP BY Category