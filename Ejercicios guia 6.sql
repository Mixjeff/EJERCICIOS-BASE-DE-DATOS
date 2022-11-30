USE NORTHWND
--Por medio de la instruccion insert agregar datos a cada una de las bases
INSERT INTO Customers(CustomerID,CompanyName) 
VALUES ('TIPLE', 'Típicos Regionales'),('FLOSU','Flores del Sur')
INSERT INTO Orders(CustomerID)
VALUES(NULL)

---EJERCICIO 1 uso de INNER JOIN
SELECT OrderID, Customers.CustomerID 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID
--Cosntruir de nuevo la consulta, implementado ALIAS
SELECT OrderID, Cus.CustomerID 
FROM Customers Cus
INNER JOIN Orders Od ON Cus.CustomerID = Od.CustomerID

---EJERCICIO 2 Uso de RIGHT JOIN
SELECT OrderId, Customers.CustomerID
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID= Orders.CustomerID
--IMPLEMENTADO ALIAS
SELECT OrderID, cus.CustomerID
FROM Customers cus 
RIGHT JOIN Orders od
ON cus.CustomerID = od.CustomerID

--EJERCICIO 3 Uso de right join Is Null
SELECT OrderId, Customers.CustomerID
FROM Customers
RIGHT JOIN Orders
ON Customers.CustomerID= Orders.CustomerID
WHERE Customers.CustomerID IS NULL
--IMPLEMENTANDO ALIAS
SELECT OrderID, cus.CustomerID
FROM Customers cus 
RIGHT JOIN Orders od
ON cus.CustomerID = od.CustomerID
WHERE cus.CustomerID  IS NULL

--EJERCICIO LEFT JOIN
SELECT OrderId, Customers.CustomerID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID= Orders.CustomerID
--IMPLEMENTANDO ALIAS 
SELECT OrderID, cus.CustomerID
FROM Customers cus 
LEFT JOIN Orders od
ON cus.CustomerID = od.CustomerID

--EJERCICIO 5 LEFT JOIN IS NULL
SELECT OrderId, Customers.CustomerID
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID= Orders.CustomerID
WHERE Orders.CustomerID IS NULL
--IMPLEMENTANDO ALIAS
SELECT OrderID, cus.CustomerID
FROM Customers cus 
LEFT JOIN Orders od
ON cus.CustomerID = od.CustomerID
WHERE cus.CustomerID  IS NULL

--EJERCICIO 6 USO DEL FULL JOIN 
SELECT OrderId, Customers.CustomerID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID= Orders.CustomerID
--IMPLEMENTANDO ALIAS 
SELECT OrderID, cus.CustomerID
FROM Customers cus 
FULL JOIN Orders od
ON cus.CustomerID = od.CustomerID

--EJERCICIO 7 FULL JOIN IS NULL
SELECT OrderId, Customers.CustomerID
FROM Customers
FULL JOIN Orders
ON Customers.CustomerID= Orders.CustomerID
WHERE Customers.CustomerID is NULL OR  Orders.CustomerID IS NULL
--IMPLEMENTANDO ALIAS 
SELECT OrderID, cus.CustomerID
FROM Customers cus 
FULL JOIN Orders od
ON cus.CustomerID = od.CustomerID
WHERE cus.CustomerID IS NULL OR od.CustomerID IS NULL

--EJERCICIO 8 CROSS JOIN
SELECT OrderID, Customers.CustomerID
FROM Customers
CROSS JOIN  Orders
--IMPLEMENTAR LA CLAUSA WHERE 
SELECT OrderID, C.CustomerID
FROM Customers C
CROSS JOIN  Orders O
WHERE C.CustomerID = O.CustomerID

--ELIMINAR DE LAS TABLAS LOS DATOS AGREGADOS 
DELETE FROM Customers WHERE CustomerID = 'TIPLE'
DELETE FROM Customers WHERE CustomerID = 'FLOSU'
