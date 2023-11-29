USE Northwind

---SELECT 

select EmployeeID, LastName, Title,City, Country
from [dbo].[Employees]

--Mala practica 
SELECT * FROM [dbo].[Employees]

--Distinct 


select Distinct CategoryID  from Products

select  ProductName  from Products
where CategoryID is null
 
select  Distinct Country from Customers

--Where 


select * from  [dbo].[Territories]
where RegionID = 4 or RegionID =1

--order by 

select * from  [dbo].[Territories]
where RegionID = 4 or RegionID =1
order by  RegionID asc

select ContactName, Country from Customers
order by Country desc

--TOP 
select TOP 10 ContactName, Country from Customers
order by Country desc

select  top 10 ProductName, UnitPrice from Products
order by  UnitPrice desc

-- Funciones de Agregacion SUM, count, MAX, MIN, AVG

select SUM(UnitPrice)'SUMA TODAL DE VENTAS', COUNT(OrderID) 'CANTIDAD VENTAS',
MAX(UnitPrice)'PRECIO MAX', MIN(UnitPrice) 'PRECIO MIN', AVG(UnitPrice) 'PROMEDIO VENTA'
from [Order Details]


--Like 

SELECT ContactName,city FROM Customers
where City LIKE '%D.F.'


--IN 

SELECT ContactName,Country FROM Customers
where Country = 'Spain' or Country = 'Mexico' or Country='Canada'


SELECT ContactName,Country FROM Customers
where Country in ('Spain','Mexico','Canada')

-- BETWEEN 

select ProductName, UnitPrice from Products
where UnitPrice BETWEEN 50 and 200
order by  UnitPrice desc

--JOINS
 
-- LEFT 

Select A.OrderID, A.ProductID, B.ProductName, B.UnitsInStock, B.CategoryID from [Order Details] A 
LEFT JOIN Products  B
ON A.ProductID = B.ProductID
 

Select [Order Details].OrderID, Products.ProductID, 
Products.ProductName, Products.UnitsInStock, Products.CategoryID 
from [Order Details]   
inner JOIN Products   
ON [Order Details].ProductID = Products.ProductID
 

Select * from Customers  
left join Orders   
on Customers.CustomerID =  Orders.CustomerID

 

 --LEFT
 --Muetsra todo los clientes aunque no tenga ordenes, pero muestra solo las ordenes 
 --que esten relacionadas un cliente 

 --RIGTH
 --Muetsra todas las ordenes aunque no tenga clientes, pero muestra solo los clientes  
 --que esten relacionadas un orden 

 --INNER 
 --Muestra todas las ordenes que tiene un cliente, y los clientes que tiene ordenes 

 --Práctica 

 --1.  Unir Productos y Categorías para mostrar el nombre del producto y su categoría (INNER)
 --ProductName    CategoryName

 --Chai           Beverages


 --2. Mostrar el nombre del producto, el precio, el stock y 
 --el nombre de la categoría a la que pertenece.
 use [Northwind] 
 select Products.ProductName 'Nombre producto' , Products.UnitPrice 'Precio', Products.UnitsInStock, Categories.CategoryName 'Categoria'
 from Products 
 inner join Categories 
 on Products.CategoryID = Categories.CategoryID

 --3.  Mostrar el nombre del producto, el precio producto, el código del proveedor
 --y el nombre de la compañía proveedora. 
 select Productos.ProductName, Productos.UnitPrice, Proveedores.SupplierID, 
 Proveedores.CompanyName from Products Productos 
 inner join Suppliers Proveedores 
 on Productos.SupplierID = Proveedores.SupplierID
 --4. Mostrar el número de la orden, fecha, código del producto, nombre producto, precio, 
 --código del empleado y su nombre completo. 

 select ordenes.OrderID, ordenes.OrderDate, Detalles.ProductID,
 Detalles.[UnitPrice], Empleados.EmployeeID, Empleados.FirstName into #TablaTemporal
 from Orders ordenes
 inner join [dbo].[Order Details] Detalles
 on ordenes.OrderID = Detalles.OrderID
 inner join  Employees Empleados
 on ordenes.EmployeeID = Empleados.EmployeeID 

 select #TablaTemporal.OrderID, Products.ProductName from #TablaTemporal 
 inner join Products 
 on #TablaTemporal.ProductID = Products.ProductID 


 --Sin tablas temporales

 select ordenes.OrderID, ordenes.OrderDate, Detalles.ProductID, Products.ProductName,
 Detalles.[UnitPrice], Empleados.EmployeeID, Empleados.FirstName  
 from Orders ordenes
 inner join [dbo].[Order Details] Detalles
 on ordenes.OrderID = Detalles.OrderID
 inner join  Employees Empleados
 on ordenes.EmployeeID = Empleados.EmployeeID 
 inner join Products 
 on Detalles.ProductID = Products.ProductID 

 --5. Mostrar la cantidad de productos comprados por ordenes 
 select ordenes.OrderID, [Categories].CategoryName, count( Detalles.ProductID) 'Cantidad productos' from Orders ordenes
 inner join [Order Details] Detalles
 on ordenes.OrderID = Detalles.OrderID 
 inner join Products
 on  Detalles.[ProductID] = Products.[ProductID]
 inner join [dbo].[Categories] 
 on Products.[CategoryID] = [dbo].[Categories]. [CategoryID]
 group by  ordenes.OrderID, [Categories].CategoryName 
 order by  ordenes.OrderID  asc

 --6 Mostrar la Cantidad de ordenes por empleado
 select Employees.FirstName, count( Orders.OrderID) from Orders 
 inner join Employees 
 on Orders.EmployeeID = Employees.EmployeeID
 group by Employees.FirstName

--6 Mostrar la Cantidad de ordenes por empleado ordenar por cantidad de forma desc
select Employees.FirstName, count( Orders.OrderID) 'Cantidad Ordenes' from Orders 
 inner join Employees 
 on Orders.EmployeeID = Employees.EmployeeID
 group by Employees.FirstName
 order by  count( Orders.OrderID) desc

--6 Mostrar la Cantidad de ordenes por empleado ordenar por cantidad de forma desc. y mostrar
--el top 3 de empleados con mayor cantidad de ordenes 
select top 3 Employees.FirstName, count( Orders.OrderID) 'Cantidad Ordenes' from Orders 
 inner join Employees 
 on Orders.EmployeeID = Employees.EmployeeID
 group by Employees.FirstName
 order by  count( Orders.OrderID) desc

--6 Mostrar la Cantidad de ordenes por empleado ordenar por cantidad de forma desc. y mostrar
--el los empleados com mas de 100 ordenes 

 select Employees.FirstName, COUNT( Orders.OrderID) 'Cantidad Ordenes' from Orders 
 inner join Employees 
 on Orders.EmployeeID = Employees.EmployeeID  
 group by Employees.FirstName
 having  count( Orders.OrderID) >100
 order by  count( Orders.OrderID) desc


 