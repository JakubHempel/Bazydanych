-- 1. Napisz procedurę wypisującą do konsoli ciąg Fibonacciego. Procedura musi przyjmować jako 
-- argument wejściowy liczbę n. Generowanie ciągu Fibonacciego musi zostać 
-- zaimplementowane jako osobna funkcja, wywoływana przez procedurę.

CREATE OR ALTER FUNCTION Fib(@n INT)
RETURNS @CiagFibonacciego TABLE(CiagFibonacciego INT)
AS
BEGIN
	DECLARE @F1 INT = 0
	DECLARE @F2 INT = 1
	DECLARE @NumerCiagu INT = 0

	INSERT INTO @CiagFibonacciego VALUES (@F1), (@F2)

	WHILE (@NumerCiagu <= @n - 2)
	BEGIN
		INSERT INTO @CiagFibonacciego VALUES (@F1 + @F2)
		SET @F2 += @F1
		SET @F1 = @F2 - @F1
		SET @NumerCiagu += 1
	END

	RETURN
END;

-- procedura wykonujaca funkcje Fib
 CREATE OR ALTER PROCEDURE Fibonacci(@n INT)
 AS
 BEGIN
	SELECT * FROM master.dbo.Fib(@n)
 END;

EXEC master.dbo.Fibonacci 10;

-- 2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko 
--    tak, aby było napisane dużymi literami. 

USE AdventureWorks2019;

CREATE OR ALTER TRIGGER LastNameUpperCase
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE Person.Person 
	SET LastName = UPPER(LastName)
	WHERE LastName IN (SELECT LastName FROM inserted)
END;

--DROP TRIGGER Person.LastNameUpperCase

-- test triggera LastNameUpperCase
UPDATE Person.Person
SET FirstName = 'Ken' 
WHERE BusinessEntityID = 1;

SELECT * FROM Person.Person;

-- 3. Przygotuj trigger ‘taxRateMonitoring’, który wyświetli komunikat o błędzie, jeżeli nastąpi 
-- zmiana wartości w polu ‘TaxRate’ o więcej niż 30%.

CREATE OR ALTER TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
	DECLARE @OldTaxRate SMALLMONEY
	DECLARE @NewTaxRate SMALLMONEY

	SELECT @OldTaxRate = deleted.TaxRate FROM deleted
	SELECT @NewTaxRate = inserted.TaxRate FROM inserted

	IF (@NewTaxRate > 1.3*@OldTaxRate) OR (@NewTaxRate < 0.7*@OldTaxRate)
	BEGIN
		UPDATE Sales.SalesTaxRate
		SET TaxRate = @OldTaxRate
		WHERE SalesTaxRateID IN (SELECT SalesTaxRateID FROM inserted)

		RAISERROR ('You cannot change the TaxRate value in the Sales.SalesTaxRate table by more than 30 percent', 16, 1)
	END
END;

--DROP TRIGGER Sales.taxRateMonitoring
	
-- test triggera taxRateMonitoring
UPDATE Sales.SalesTaxRate
SET TaxRate = 30
WHERE SalesTaxRateID = 1;

SELECT * FROM Sales.SalesTaxRate;




