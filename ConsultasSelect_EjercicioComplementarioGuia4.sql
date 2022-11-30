USE AdventureWorks2017
--seleccionar todos los datos de la tabla Sales.Person
SELECT * FROM Sales.SalesPerson
--Seleccionar todos los registros de los primeros 4 campos de la tabla Production.Product
SELECT TOP 4  ProductID,[Name],ProductNumber,MakeFlag  FROM Production.Product
--seleccionar los 10 productos con el costo mas alto almacenados en la tabla 
SELECT TOP 10 * FROM Production.ProductCostHistory
ORDER BY [StandardCost]DESC
--seleccionar campos... de la tabla Production.Product y renombrar cada campo
SELECT [Name] AS [Nombre de Producto],
ProductNumber AS [Numero de Producto],
ListPrice AS [Precio] FROM Production.Product ORDER BY Precio ASC
--seleccionar los primeros de 3 campos de la tabla Purchasing.Vendor donde el campo AccountNumber
--Comience con cualquier letra del rando G a T
SELECT BusinessEntityID, AccountNumber, [Name], CreditRating  from Purchasing.Vendor
WHERE AccountNumber LIKE '[G-T]%' Order by AccountNumber
--Mostrar los datos de la tabla Person.CountryRegion donde el campo ContryRegionCode
--Contenga cualquiera de los siguientes datos: AR,BO,CO ES,SV y VN
SELECT * FROM Person.CountryRegion WHERE CountryRegionCode IN ('AR','BO','CO','ES','SV','VN')
--Seleccionar el campo CountryRegionCode de la tabla Person.StateProvince, pero en el
--resultado los datos no tienen que repetirse
SELECT DISTINCT CountryRegionCode FROM Person.StateProvince
--Seleccionar los campos SalesOrderID, OrderQty de la tabla Sales.SalesOrderDetail en
--donde los datos del campo UnitPrice se encuentre entre los valores de 200 y 1000
SELECT SalesOrderID, OrderQty FROM Sales.SalesOrderDetail WHERE UnitPrice BETWEEN 200 AND 1000
--Mostrar los campos ProductID, ListPrice de la tabla Production.Product y una columna más
--que muestre un aumento del 15% del dato almacenado en ListPrice renombrar esta nueva
--columna con el nombre Aumento de Precio
SELECT ProductID, ListPrice, (ListPrice*0.15+ListPrice) AS [Aumento de precio] FROM Production.Product
ORDER BY ListPrice
-- Seleccionar el 20% de los registros almacenados en la tabla Sales.SalesOrderDetail
SELECT TOP 20 PERCENT * FROM Sales.SalesOrderDetail