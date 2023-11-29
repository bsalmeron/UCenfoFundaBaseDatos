--Procedimientos almacenados 
-- 1. Logica de negocio o reglas de negocio, unicas 
-- 2. Seguridad 
-- 3. Cuando se necesita consumir del exterior mi bd (app, web app, o ETL etc)

--consulta cliente por cedula 

--1- Nombre: Tabla - proceso + verbo 
--Ejemplo: clienteAgregar , clienteConsultar, clienteEliminar 
--clienteReporteConsultar

--2- Parametros: (@ParamCedula varchar(9))

--3- Crear la consulta 
-- select nombre from clientes 
-- where cedula = @ParamCedula

--4- Retornamos 


--Ejemplos 
--1-  Obtener Productos(nombre, precio) por Categoría (nombre)
 use Northwind
create procedure obtenerProductosCategoria
	@CategoryName varchar(50)
AS
Begin 
select ProductName, UnitPrice 
 From Products INNER JOIN 
 Categories on Products.CategoryID = Categories.CategoryID
 where Categories.CategoryName =  @CategoryName
end
Exec obtenerProductosCategoria 'Beverages'

--2. Crear SP, para actualizar por medio del Id del producto,
--la cantidad de STOCK
select * from Products

CREATE PROCEDURE actualizarStock 
	@ID int,
	@Stock int
as
begin 
	Update Products
	set UnitsInStock=@Stock
	where ProductID = @ID
end


select * from Products

Exec actualizarStock 6 , 1

---Manejo Fechas

SELECT CONVERT(DATE, OrderDate), OrderDate
FROM Orders
WHERE CONVERT(DATE, OrderDate) = '1996-07-04';


SELECT *
FROM Orders
WHERE CONVERT(DATE, OrderDate) BETWEEN '1996-07-01' AND '1996-07-31';


SELECT EmployeeID, LastName, BirthDate,
    DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM Employees;


SELECT P.ProductID, ProductName, O.OrderID, OrderDate
FROM [Order Details] OD
INNER JOIN Orders O ON OD.OrderID = O.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID
WHERE DATEPART(MONTH, O.OrderDate) = 5;


SELECT DATEPART(YEAR, OrderDate) AS Year,
    DATEPART(MONTH, OrderDate) AS Month,
    SUM(Quantity) AS TotalQuantity
FROM [Order Details] OD
INNER JOIN Orders O ON OD.OrderID = O.OrderID
GROUP BY DATEPART(YEAR, OrderDate), DATEPART(MONTH, OrderDate)
ORDER BY Year, Month;