USE AdventureWorks2017
--Seleccionar todos los datos de la tabla HumanResources.Department
SELECT * FROM HumanResources.Department
--b)Seleccionar los campos BusinessEntityID, NationalIDNumber y JobTitle de la tabla
--HumanResources.Employee en donde en el campo JobTitle se encuentre la palabra
--Production
SELECT BusinessEntityID, NationalIDNumber,JobTitle FROM HumanResources.Employee
WHERE JobTitle LIKE '%Production%'
--c) Seleccionar los datos de la tabla Sales.Customer donde en el campo CustomerID se
--encuentren los siguientes datos: 2,4, 7 y 10
SELECT * FROM Sales.Customer WHERE CustomerID IN (2,4,7,10)
--d) Seleccionar los campos DepartmenID, Name de la tabla HumanResources.Department en
--donde los datos del DepartmenID se encuentre entre los valores 5 y 12
SELECT DepartmentID,[Name]  FROM HumanResources.Department WHERE DepartmentID BETWEEN  5 AND 12
--e) Seleccionar los campos AddressID, City y StateProvinceID de la tabla Person.Address donde
--en el campo City el dato comienza con la letra B
SELECT AddressID, City, StateProvinceID FROM Person.Address WHERE City LIKE ('B%')
--f)Seleccionar los datos de la tabla Production.Culture, donde el dato almacenado en el
--campo Name se encuentre entre los valores: English o Spanish 
SELECT * FROM Production.Culture WHERE (Name = 'English' OR Name ='Spanish')
--g)Seleccionar el 50% de los datos de la tabla Sales.CreditCard
SELECT TOP 50 PERCENT * FROM Sales.CreditCard
--h) Mostrar las 10 mejores ventas (LineTotal) de la tabla Sales.SalesOrderDetail
SELECT  TOP 10 * FROM Sales.SalesOrderDetail ORDER BY LineTotal DESC
--i)  Seleccionar el campo JobTitle de la tabla HumanResources.Employee, pero no deben
--mostrarse datos duplicados, ordenar los datos de forma descendente
SELECT DISTINCT JobTitle FROM HumanResources.Employee ORDER BY JobTitle DESC
--Mostrar los campos Name, ProductNumber y ListPrice y renombrar este campo como Price
--de la tabla Production.Product donde la línea de productos (ProductLine) sea igual a R y el
--valor correspondiente a los días para fabricar ( DaysToMafacture) sea inferior a 4
SELECT Name, ProductNumber, ListPrice AS [Price] FROM Production.Product
WHERE (ProductLine ='R' AND DaysToManufacture <4)
-- BASE DE DATOS LIBRARY
USE library
SELECT * FROM  adult WHERE expr_date BETWEEN '01-12-2006' AND '30-06-2007'
SELECT * FROM reservation
SELECT author FROM title
SELECT author, title FROM title ORDER BY author ASC
SELECT * FROM loan WHERE isbn IN (509,519,529,539)
USE pubs
SELECT * FROM employee WHERE lname LIKE '%k%'
SELECT emp_id FROM employee WHERE emp_id LIKE '[F-M]%'
SELECT * FROM sales WHERE (ord_date>='01-01-1994')
SELECT * FROM stores WHERE state ='CA'
SELECT TOP 5 * FROM titles ORDER BY price DESC