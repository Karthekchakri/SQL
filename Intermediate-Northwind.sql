/*20 Categories, and the total products in
each category
For this problem, we’d like to see the total number of
products in each category. Sort the results by the total
number of products, in descending order.
*/

SELECT CategoryName,Count(*) AS 'Total Products'  FROM Products p Inner join Categories c on
p.CategoryID = c.CategoryID Group by c.CategoryName Order by Count(*) Desc

/* 21. Total customers per country/city
In the Customers table, show the total number of
customers per Country and City.
*/

Select Country, City, Count(*) as TotalCustomers From customers Group by Country, City
Order by TotalCustomers desc

/*
22. Products that need reordering What products do we have in our inventory that
should be reordered? For now, just use the fields UnitsInStock and ReorderLevel, where UnitsInStock
is less than the ReorderLevel, ignoring the fields UnitsOnOrder and Discontinued.
Order the results by ProductID.
*/

Select ProductId,ProductName , UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
from Products Where UnitsInStock <= ReorderLevel 
Order by ProductID
/*
23.	Now we need to incorporate these fields—
UnitsInStock, UnitsOnOrder, ReorderLevel,
Discontinued—into our calculation. We’ll define
“products that need reordering” with the following:
UnitsInStock plus UnitsOnOrder are less than
or equal to ReorderLevel
The Discontinued flag is false (0)
*/
Select ProductId,ProductName , UnitsInStock,UnitsOnOrder,ReorderLevel,Discontinued
from Products Where UnitsInStock + UnitsOnOrder <= ReorderLevel AND Discontinued =0
Order by ProductID

/*
24.Customer list by region
A salesperson for Northwind is going on a business
trip to visit customers, and would like to see a list of
all customers, sorted by region, alphabetically.
However, he wants the customers with no region
(null in the Region field) to be at the end, instead of
at the top, where you’d normally find the null values.
Within the same region, companies should be sorted
by CustomerID
*/
Select * from customers order by case when region is null then 1 else 0 END ,customerid

/*
25. High freight charges
Some of the countries we ship to have very high
freight charges. We'd like to investigate some more
shipping options for our customers, to be able to
offer them lower freight charges. Return the three
ship countries with the highest average freight
overall, in descending order by average freight
*/

SELECT ShipCountry,AVG(Freight) from Orders Group by shipCountry Order by AVG(Freight) DESC OFFSET 0 ROWS
FETCH FIRST 3 ROWS Only

/*
26. High freight charges - 2015
We're continuing on the question above on high
freight charges. Now, instead of using all the orders
we have, we only want to see orders from the year
1996
*/
select * from orders
SELECT ShipCountry,AVG(Freight) from Orders WHERE YEAR(OrderDate) = 1996 Group by shipCountry Order by AVG(Freight) DESC OFFSET 0 ROWS
FETCH FIRST 3 ROWS Only

/*
28. High freight charges - last year
We're continuing to work on high freight charges.
We now want to get the three ship countries with the
highest average freight charges. But instead of
filtering for a particular year, we want to use the last
12 months of order data, using as the end date the last
OrderDate in Orders.*/
  
Select ShipCountry,AVG(Freight) from orders where OrderDate > Dateadd(yy, -1, (Select Max(OrderDate) from Orders))
Group by ShipCountry
Order by AVG(Freight) Desc
OFFSET 0 ROWS
FETCH FIRST 3 ROWS ONly

/*
29.Inventory list
We're doing inventory, and need to show information
like the below, for all orders. Sort by OrderID and
Product ID
*/
SELECT  e.EmployeeID , LastName , O.OrderID , ProductName , Quantity  FROM Employees e INNER JOIN 
Orders O on O.EmployeeID = e.EmployeeID INNER JOIN [Order Details] od on O.OrderID = od.OrderID
Inner JOIN Products pro on pro.ProductID = od.ProductID

/*
30.Customers with no orders
There are some customers who have never actually
placed an order. Show these customers
*/
Select * from Customers Left Join Orders on Customers.CustomerID = Orders.CustomerID
Where Orders.CustomerID is null

/*
31.Customers with no orders for
EmployeeID 4 One employee (Margaret Peacock, EmployeeID 4)
has placed the most orders. However, there are some
customers who've never placed an order with her.
Show only those customers who have never placed
an order with her.
*/
Select * from Customers Left Join Orders on Customers.CustomerID = Orders.CustomerID
Where Orders.CustomerID is null AND   Orders.EmployeeID =4
