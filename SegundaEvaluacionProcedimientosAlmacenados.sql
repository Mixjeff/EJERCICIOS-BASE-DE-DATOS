USE master
--DROP DATABASE BD_Biblioteca
CREATE DATABASE BD_Biblioteca
GO
--creacion de tablas y restricciones
USE BD_Biblioteca
CREATE TABLE libro(
    Codigo VARCHAR (6) CONSTRAINT PK_CodigoLibro PRIMARY KEY,
    Titulo VARCHAR  (100),
    ISBN VARCHAR (25) UNIQUE,
    Descripcion VARCHAR (255),
    Resumen VARCHAR (255),
    --El año edicion tiene que ser mayor o igual a 200
    Anio_edicion INT CONSTRAINT CK_AnioEd 
    CHECK (Anio_edicion >= 2000), 
    Cod_editorial VARCHAR (5) NOT NULL,
    
)
GO
CREATE TABLE editorial(
    Codigo VARCHAR (5) CONSTRAINT PK_CodigoEditorial PRIMARY KEY,
    Nombre VARCHAR (100),
    --El campo  pais por defecto debe ser España
    Pais VARCHAR (25) CONSTRAINT DF_Pais DEFAULT 'España',
)
GO
CREATE TABLE ejemplar(
    Codigo VARCHAR(5) CONSTRAINT PK_CodigoEjemplar PRIMARY KEY,
    Cod_Libro VARCHAR (6) NOT NULL,
    Ubicacion VARCHAR (25),
    Estado VARCHAR (10) CONSTRAINT CK_Estado
    --El estado solo puede ser disponible, prestado o reservado
    CHECK (Estado='disponible' OR Estado='prestado' OR Estado = 'reservado')
)
GO
CREATE TABLE autor(
    Codigo VARCHAR (5) CONSTRAINT PK_CodigoAutor PRIMARY KEY,
    Nombres VARCHAR (50),
    Apellidos VARCHAR (50),
    Nacionalidad VARCHAR (75)
)
GO
CREATE TABLE autor_libro(
    Cod_Libro VARCHAR(6) NOT NULL ,
    Cod_Autor VARCHAR(5) NOT NULL
)
GO
CREATE TABLE prestamo(
    Cod_Ejemplar VARCHAR(5) NOT NULL,
    --Fecha prestamo por defecto debe ser la fecha actual
    Fecha_Prestamo DATE CONSTRAINT DF_Fecha DEFAULT GETDATE() ,
    Fecha_Devolucion DATE ,
    Mora money CONSTRAINT CK_Mora CHECK(Mora >=0)
)
GO
--Creacion de llaves foraneas
ALTER TABLE libro ADD CONSTRAINT FK_CodEditorial FOREIGN KEY (Cod_editorial) REFERENCES editorial(Codigo) ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE ejemplar ADD CONSTRAINT FK_CodLibro FOREIGN KEY (Cod_libro) REFERENCES libro(Codigo)  ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE autor_libro ADD CONSTRAINT FK_CodLibroAUL FOREIGN KEY (Cod_Libro) REFERENCES libro(Codigo)  ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE autor_libro ADD CONSTRAINT FK_CodAutorAUL FOREIGN KEY (Cod_Autor) REFERENCES autor(Codigo)  ON UPDATE CASCADE ON DELETE CASCADE

ALTER TABLE prestamo ADD CONSTRAINT FK_Prestamo FOREIGN KEY (Cod_Ejemplar) REFERENCES ejemplar(Codigo)  ON UPDATE CASCADE ON DELETE CASCADE
GO

--*********Creacion de restricciones****************

--la fecha de prestamo no debe ser mayor a la fecha devolucion
ALTER TABLE prestamo ADD CONSTRAINT  CK_FDev CHECK (Fecha_Prestamo< Fecha_Devolucion)
GO
--El campo ISBN de la tabla libro debe ser una serie de numeros separados por guiones
ALTER TABLE libro ADD CONSTRAINT CK_ISBNGuiones CHECK (ISBN like '[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]-[0-9]')
GO

--///////////FORMATO A LOS CODIGOS/////////////////

--Codigo de editorial dos letras, tres numeros
ALTER TABLE editorial ADD CONSTRAINT CK_CodEditoria CHECK (Codigo like 'ED[0-9][0-9][0-9]')
GO
--Codigo de libro tres letras, tres numeros 
ALTER TABLE libro ADD CONSTRAINT CK_CodLibro CHECK (Codigo LIKE 'LIB[0-9][0-9][0-9]')
GO
--Codigo de ejemplar dos letras tres numeros
ALTER TABLE ejemplar ADD CONSTRAINT CK_CodEjemplar CHECK (Codigo LIKE 'EJ[0-9][0-9][0-9]')
GO
--Codigo de autor  dos letras tres numeros 
ALTER TABLE autor ADD CONSTRAINT CK_CodAutor CHECK (Codigo LIKE 'AU[0-9][0-9][0-9]')
GO

--AGREGAR 10 registros a cada una de las talas con insert into
--insercion a editorial
INSERT INTO editorial(Codigo,Nombre) VALUES('ED001','Santillana')
GO
INSERT INTO editorial(Codigo,Nombre) VALUES('ED002','Ra-Ma')
GO
INSERT INTO editorial(Codigo,Nombre) VALUES('ED003','Hewell')
GO
--insercion a autor
INSERT INTO autor(Codigo,Nombres,Apellidos,Nacionalidad) VALUES('AU001','Juan Miguel','Lopez Melendez','Ecuatoriano')
GO
INSERT INTO autor(Codigo,Nombres,Apellidos,Nacionalidad) VALUES('AU002','Daniel Miguel','Lopez Hernandez','Salvadoreño')
GO
INSERT INTO autor(Codigo,Nombres,Apellidos,Nacionalidad) VALUES('AU003','Daniel Miguel','Lopez Hernandez','Salvadoreño')
GO
select * from libro
---Insercion a libro
INSERT INTO libro (Codigo,Titulo,ISBN,Descripcion,Resumen,Anio_edicion, Cod_editorial)
VALUES ('LIB001','Ciencias Naturales','0-0-0-0-0-0-0-0-0-0-0-0-1','Ciencias para primer grado','Anatomia de los seres vivos las plantas biomas 300 paginas Cap 1: El medio ambiente',2002,'ED001')
 GO
INSERT INTO libro (Codigo,Titulo,ISBN,Descripcion,Resumen,Anio_edicion, Cod_editorial) 
VALUES ('LIB002','Ciencias Matematicas','0-0-0-0-0-0-0-0-0-0-0-0-2','Matematicas para primer grado','Anatomia de los seres vivos las plantas biomas 300 paginas Cap 1: El medio ambiente',2003,'ED002')
 GO
 INSERT INTO libro (Codigo,Titulo,ISBN,Descripcion,Resumen,Anio_edicion, Cod_editorial) 
VALUES ('LIB003','Ciencias Matematicas','0-0-0-0-0-0-0-0-0-0-0-0-3','Lenguaje para primer grado','Anatomia de los seres vivos las plantas biomas 300 paginas Cap 1: El medio ambiente',2004,'ED003')
 GO
 --Insercion autor_libro
INSERT INTO autor_libro VALUES('LIB001','AU001')
INSERT INTO autor_libro VALUES('LIB002','AU002')
INSERT INTO autor_libro VALUES('LIB003','AU003')
 --insecion a ejemplar
INSERT INTO ejemplar VALUES('EJ001','LIB001','Estante1_Puesto1','disponible')
INSERT INTO ejemplar VALUES('EJ002','LIB002','Estante1_Puesto2','prestado')
INSERT INTO ejemplar VALUES('EJ003','LIB003','Estante1_Puesto3','reservado')
 --insercion a prestamo
INSERT INTO prestamo(Cod_ejemplar,Fecha_Devolucion,Mora)
VALUES('EJ001','2020-12-21',2.50)
INSERT INTO prestamo(Cod_ejemplar,Fecha_Prestamo,Fecha_Devolucion,Mora)
VALUES('EJ002','2020-09-01','2020-12-31',3.50)
INSERT INTO prestamo(Cod_ejemplar,Fecha_Prestamo,Fecha_Devolucion,Mora)
VALUES('EJ003','2020-10-02','2020-11-30',1.50)
--CREACION DE CONSULTAS SELECT
--a) Se debe mostrar los datos de los autores junto con los titulos de los libros que han escrito (Usando inner join con tres tablas)
SELECT lib.Titulo, au.Nombres, au.Apellidos, au.Nacionalidad
FROM libro lib 
INNER JOIN autor_libro al ON lib.Codigo = al.Cod_Libro 
INNER JOIN autor au ON au.Codigo=al.Cod_Autor
--B) Mostrar cuantos libros estan prestados, cuantos estan disponibles, cuantos estan reservados
--Usando count para contar los rows resultantes
 SELECT ( select count(*) FROM ejemplar WHERE Estado='disponible') AS Disponibles, (select count(*) FROM ejemplar WHERE Estado='prestado') AS Prestado, (select count(*) FROM ejemplar WHERE Estado='reservado') AS Reservado

 --C) Mostrar los libros que estan prestados en un determinado rango de fechas de prestamo
 CREATE PROCEDURE sp_Seleccionarlibros @FechprestamoInicio DATE,
  @FechprestamoFin DATE AS
 SELECT lib.Titulo, pres.Fecha_Prestamo
 FROM libro lib 
 INNER JOIN ejemplar ejemp ON lib.Codigo = ejemp.Cod_libro
 INNER JOIN prestamo pres ON pres.Cod_Ejemplar= ejemp.Codigo
 WHERE( pres.Fecha_Prestamo > @FechprestamoInicio AND  pres.Fecha_Prestamo < @FechprestamoFin AND ejemp.Estado='prestado')
 --EJEMPLO de ejecucion, se ingresa la fecha de la primera posicion del rango, la segunda fecha es la ultima posicion de rango  
 EXEC sp_Seleccionarlibros'2020-01-01','2020-12-31'
