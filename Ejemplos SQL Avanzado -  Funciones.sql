CREATE FUNCTION dbo.IVA (@CustomerID varchar(5))
RETURNS money
AS
BEGIN
    DECLARE @TotalSales money;

    SELECT @TotalSales = SUM(OD.UnitPrice * OD.Quantity)
    FROM Orders O
    INNER JOIN [Order Details] OD ON O.OrderID = OD.OrderID
    WHERE O.CustomerID = @CustomerID;

    RETURN @TotalSales*0.13;
END;


SELECT  dbo.CalculateTotalSalesByCustomer('ALFKI') AS TotalSalesForALFKI;

select  CustomerID, CompanyName, dbo.CalculateTotalSalesByCustomer(CustomerID)'totalVentas',
dbo.IVA(CustomerID) 'IVA' from Customers



-----------------Exist 
SELECT CompanyName
FROM Customers C
WHERE EXISTS (
    SELECT 1
    FROM Orders O
    WHERE O.CustomerID = C.CustomerID
);

select distinct c.CustomerID,  c.CompanyName from Customers C
inner join Orders  o 
on c.CustomerID= o.CustomerID