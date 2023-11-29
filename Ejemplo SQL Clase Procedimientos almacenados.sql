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

