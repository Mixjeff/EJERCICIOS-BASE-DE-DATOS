Use NORTHWND
--ejercicio 1
select * from Categories
Select CategoryName, CategoryID from Categories
--Ejercicio 2
--1
select OrderID, ProductID, UnitPrice from [Order Details]
where OrderId=10251
--2
select CompanyName from Customers
Where CompanyName = 'Alfreds Futtekiste'
--3
select OrderID, ProductID, UnitPrice
from [Order Details]
Where OrderID= 10251 and ProductID =57
--4
select OrderId, ProductId, UnitPrice from [Order Details]
Where OrderID =10251 or ProductID=57
--5 
SELECT OrderId,ProductID, UnitPrice
FROM [Order Details]
WHERE OrderID>=11000
--6
SELECT OrderID, ProductID,UnitPrice
FROM [Order Details]
WHERE OrderId>=11000 AND OrderID<=11003
--7
SELECT  OrderID, ProductID,UnitPrice
FROM[Order Details]
WHERE OrderID BETWEEN 11000 AND 11003
--8
SELECT CompanyName FROM Customers
WHERE CompanyName Like 'A%'
--9
SELECT CompanyName FROM Customers
WHERE CompanyName Like 'MA%'
--10 
SELECT RegionDescription FROM Region 
WHERE RegionDescription LIKE '%TERN%'
--11
SELECT  OrderID FROM[Order Details]
WHERE OrderID LIKE '_0285'
--12
SELECT CompanyName FROM Customers
WHERE CompanyName Like '[a-c]'
--13
SELECT * FROM [Order Details]
WHERE OrderID IN (10248,10255,10270)
--14 
SELECT * FROM [Order Details]
WHERE OrderID = 10248 OR OrderID= 10255 OR OrderID= 10270
--EJERCICIO 3 USO DE LA CLAUSA ORDER BY
SELECT CategoryName,CategoryID FROM Categories
ORDER BY CategoryName ASC
--2
SELECT CategoryName,CategoryID FROM Categories
ORDER BY CategoryName
--3
SELECT CategoryName,CategoryID FROM Categories
ORDER BY CategoryName DESC
--EJERCICIO 4 USO DE LA INSTRUCCION DISTINCT
--1
SELECT SupplierID,CategoryID FROM Products
--3 Con la sieguiente consulta se obtendran los mismos resultados pero no repetios 
SELECT DISTINCT SupplierID,CategoryID FROM Products
--EJERCICIO 5 RENOMBRAR COLUMNAS DE UNA CONSULTA
--1
SELECT CategoryID AS [Codigo de la Categoria],
CategoryName AS [Nombre de la Categoria]
FROM Categories
--2
SELECT ProductID, ProductName, UnitPrice, UnitPrice*1.10 AS Aumento
from Products
--EJERCICIO 6 USO DE LA INSTRUCCION TOP N
USE NORTHWND
SELECT TOP 3 OrderID, (UnitPrice*Quantity) AS [Venta Total]
FROM [Order Details]
ORDER BY [Venta Total] DESC
--2 
SELECT TOP 3 WITH TIES OrderID, (UnitPrice*Quantity) AS [Venta Total]
FROM[Order Details] ORDER BY [Venta Total] DESC
--3
SELECT TOP 25 PERCENT OrderID, (UnitPrice*Quantity) AS [Venta Total]
FROM [Order Details] ORDER BY [Venta Total] DESC