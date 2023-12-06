--Vistas 
	--Simplificación
	--Seguridad
	--abstraccion 
CREATE VIEW miPrimeraVista AS
SELECT 
    O.OrderID,
    O.OrderDate,
    C.CustomerID,
    C.CompanyName,
    OD.ProductID,
    P.ProductName,
    OD.Quantity,
    OD.UnitPrice,
    OD.Quantity * OD.UnitPrice AS TotalPrice
FROM Orders O
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
INNER JOIN Products P ON OD.ProductID = P.ProductID;


select * from [dbo].[miPrimeraVista]