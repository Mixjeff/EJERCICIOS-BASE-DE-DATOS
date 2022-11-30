--PARTE 2 Ejemplos de vistas
--EJERCICIO 1
CREATE VIEW dbo.productos_proveedor_HS202152
AS
    SELECT ProductID,ProductName,SupplierID,CategoryID,QuantityPerUnit,UnitPrice,Discontinued
    FROM Products
    WHERE SupplierID = 14
GO
SELECT * FROM productos_proveedor_HS202152


--EJERCICIO 2
CREATE VIEW dbo.PedidosProductos1997_HS202152
AS
    SELECT od.ProductName,o.OrderDate,o.ShippedDate,   od.UnitPrice*Quantity as Subtotal FROM Orders o
    INNER JOIN [Order Details Extended]  od ON o.OrderID = od.OrderID 
GO
SELECT * FROM PedidosProductos1997_HS202152 ORDER BY ProductName ASC
DROP VIEW dbo.PedidosProductos1997_HS202152

--EJERCICIO 3
CREATE VIEW dbo.TotalProductos_HS202152
AS
    SELECT od.ProductName, SUM(od.UnitPrice*od.Quantity) as Subtotal, SUM (od.UnitPrice*od.Quantity-( od.UnitPrice*od.Quantity*od.Discount)) as total
    FROM [Order Details Extended] od GROUP BY od.ProductName, od.UnitPrice, od.Quantity,od.Discount
GO
SELECT * FROM TotalProductos_HS202152 ORDER BY ProductName

---PARTE 3  PROCEDIMIENTOS ALMACENADOS

--EJERCICIO 1
CREATE PROCEDURE dbo.sp_Insertar_CategoriasHS202152
    @ID int,
    @NombreCategoria VARCHAR(15) 
AS 
IF (SELECT COUNT(*) FROM Categories 
    WHERE CategoryID=@ID OR CategoryName= @NombreCategoria)=0
    INSERT INTO Categories(CategoryName)
    VALUES(@NombreCategoria)
ELSE
PRINT 'Error la categoria ya existe '
GO
--Ejecutar primero
EXECUTE dbo.sp_Insertar_CategoriasHS202152 1,'Alimentos'
GO
--Segundo
EXECUTE dbo.sp_Insertar_CategoriasHS202152 9,'Alimentos'
GO
--Tercero
EXECUTE dbo.sp_Insertar_CategoriasHS202152 10,'Alimentos'
GO
--hacer un select y verificar los ingresos
SELECT * FROM Categories

--EJERICIO 2 USO DE LA SENTENCIA CASE
CREATE PROCEDURE sp_Hay_ClientesHS202152
@ciudad VARCHAR(15)
AS SELECT
CASE (SELECT COUNT(*) FROM Customers WHERE City=@Ciudad)WHEN 0 THEN 'No hay clientes en la ciudad de '+@ciudad ELSE ' Hay clientes en la ciudad de '+@ciudad END
--Ejecutar el procedimiento
EXEC sp_Hay_ClientesHS202152 'Barcelona'
EXEC sp_Hay_ClientesHS202152 'New York'


--EJERCICIO 3
CREATE PROCEDURE PROCE_TotalHS202152
AS 
    SELECT OrderID,
    SUM(CONVERT(money,(UnitPrice*Quantity*(1-Discount)/100))*100)
    AS Total
    FROM [Order Details]
    GROUP BY OrderID
GO

--ejecutar el proceso
EXEC PROCE_TotalHS202152
--Alterar un procedimiento 
ALTER PROCEDURE PROCE_TotalHS202152
@Cod_orden int 
AS 
    SELECT OrderID,
    SUM(CONVERT(money,(UnitPrice*Quantity*(1-Discount)/100))*100)
AS Total 
FROM [Order Details]
WHERE OrderID = @Cod_orden
GROUP BY OrderID
GO
--Ejecutar el procedimiento
EXEC PROCE_TotalHS202152 10248
--Ejecutar el procedimiento con otro codigo qde pedido
EXEC PROCE_TotalHS202152 10242
--SE PUEDE MODIFICAR DE NUEVO, y muestra un mensaje indicancdo que no existe esa orden
ALTER PROCEDURE PROCE_TotalHS202152
@Cod_orden int 
AS 
DECLARE @total INT --declaracion de variables locales
SELECT @total=COUNT (orderid) FROM [Order Details] WHERE OrderID=@Cod_orden
IF (@total>01)--Evalua la condicion
    BEGIN 
        SELECT OD.OrderID,
        SUM(CONVERT(money,(OD.  UnitPrice*Quantity*(1-Discount)/100))*100) AS Total
        FROM [Order Details] OD
        WHERE OrderID=@Cod_orden
        GROUP BY OD.OrderID
        END
ELSE
    BEGIN 
        PRINT 'La orden no existe y el codigo es: '+CONVERT(VARCHAR(10),@Cod_orden)
    END
GO
--Ejecutar el procedimiento
--Codigo de pedido que si existe en la tabla order details
EXEC PROCE_TotalHS202152 10248
--Cpdigo de pedido que no existe en la tabla order details
EXEC PROCE_TotalHS202152 10242
