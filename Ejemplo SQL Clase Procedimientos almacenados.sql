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

 