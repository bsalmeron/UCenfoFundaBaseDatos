select * from Customers
where CustomerID ='ANATR'

Begin transaction
update Customers
set CompanyName='PRUEBAAAAAAAA'
where CustomerID ='ANATR'


rollback 

commit 


 
 
