-- Insert into select 

--Copias de tablas 
select  * into Customers_Copy 
from Customers

--inserts masivos 
INSERT INTO Customers_Copy (CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax)
SELECT CustomerID, CompanyName, ContactName, ContactTitle, Address, City, Region, PostalCode, Country, Phone, Fax
FROM Customers;

--Procedimeintos almacenados 
--Reutilizacion codigo 
--Seguridad y control: consumidores externos (insertar, actualizar, eliminar y seleccionar)
--CRUD 

CREATE PROCEDURE GetEmployeeInfo2
    @EmployeeID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE EmployeeID = @EmployeeID;
END;


EXEC GetEmployeeInfo2   @EmployeeID = 5;




CREATE PROCEDURE GetOrdersByParameters
    @CustomerID varchar(5) = NULL,
    @EmployeeID int = NULL,
    @StartDate datetime = NULL,
    @EndDate datetime = NULL
AS
BEGIN
    SELECT 
        O.OrderID,
        O.OrderDate,
        C.CompanyName  'CustomerName',
        E.FirstName + ' ' + E.LastName  'EmployeeName',
        P.ProductName,
        OD.Quantity,
        OD.UnitPrice * OD.Quantity  'TotalPrice'
    FROM Orders O
    INNER JOIN Customers C ON O.CustomerID = C.CustomerID
    INNER JOIN Employees E ON O.EmployeeID = E.EmployeeID
    INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    INNER JOIN Products P ON OD.ProductID = P.ProductID
    WHERE (@CustomerID IS NULL OR O.CustomerID = @CustomerID)
      AND (@EmployeeID IS NULL OR O.EmployeeID = @EmployeeID)
      AND (@StartDate IS NULL OR O.OrderDate >= @StartDate)
      AND (@EndDate IS NULL OR O.OrderDate <= @EndDate);
END;

EXEC GetOrdersByParameters @CustomerID = 'ALFKI', @EmployeeID = 5, @StartDate = '1997-01-01', @EndDate = '1997-01-01';