/*1. Which shippers do we have?
We have a table called Shippers. Return all the fields
from all the shippers
*/
Select * from Shippers

/*
2. Certain fields from Categories
In the Categories table, selecting all the fields using
this SQL:
*/
Select CategoryName,Description from Categories

/*3.Sales Representatives
We’d like to see just the FirstName, LastName, and
HireDate of all the employees with the Title of Sales
Representative
*/
Select FirstName,LastName,HireDate from Employees where Title='Sales Representative'

/*
4. Sales Representatives in the United
States
*/

Select FirstName,LastName,HireDate from Employees where Title='Sales Representative' AND Country='USA'

/*5.
Orders placed by specific EmployeeID

Show all the orders placed by a specific employee.
The EmployeeID for this Employee (Steven
Buchanan) is 5

*/
SELECT * FROM Orders Where EmployeeID=5

/*
6. Suppliers and ContactTitles
In the Suppliers table, show the SupplierID,
ContactName, and ContactTitle for those Suppliers
whose ContactTitle is not Marketing Manager
*/

SELECT SupplierID,ContactName, ContactTitle FROM Suppliers WHERE ContactTitle <> 'Marketing Manager'

/*
7.Products with “queso” in ProductName
In the products table, we’d like to see the ProductID
and ProductName for those products where the
ProductName includes the string “queso”
*/
SELECT ProductID , ProductName from Products Where ProductName like '%queso%'

/*
8.Orders shipping to France or Belgium
Looking at the Orders table, there’s a field called
ShipCountry.Write a query that shows the OrderID,
CustomerID, and ShipCountry for the orders where
the ShipCountry is either France or Belgium
*/

SELECT OrderID,CustomerID,ShipCountry from orders where ShipCountry in ('France','Belgium')

/*
9. Brazil
Mexico
Argentina
Venezuela
*/
SELECT OrderID,CustomerID,ShipCountry FROM ORDERS WHERE SHIPCOUNTRY in('Brazil',
'Mexico','Argentina','Venezuela')/* 10.for all the employees in the Employees table, show
the FirstName, LastName, Title, and BirthDate.
Order the results by BirthDate, so we have the oldest
employees first.*/SELECT FirstName, LastName, Title, BirthDate FROM Employees Order by BirthDate/*11.Showing only the Date with a
DateTime field
In the output of the query above, showing the
Employees in order of BirthDate, we see the time of
the BirthDate field, which we don’t want. Show only
the date portion of the BirthDate field.*/SELECT FirstName, LastName, Title, CONVERT(Date,BirthDate) FROM Employees Order by BirthDate/*12.Show the FirstName and LastName columns from
the Employees table, and then create a new column
called FullName, showing FirstName and LastName
joined together in one column, with a space inbetween.
*/
SELECT FirstName , LastName,CONCAT(FirstName ,' ',LastName) AS FullName from Employees

/*
13.OrderDetails amount per line item
In the OrderDetails table, we have the fields
UnitPrice and Quantity. Create a new field,
TotalPrice, that multiplies these two together. We’ll
ignore the Discount field for now.
In addition, show the OrderID, ProductID, UnitPrice,
and Quantity. Order by OrderID and ProductID.
*/
SELECT *,UnitPrice*Quantity as TotalPrice FROM [Order Details]	

/*
14.How many customers?
How many customers do we have in the Customers
table? Show one value only, and don’t rely on getting
the recordcount at the end of a resultset.
*/
SELECT COUNT(*) FROM customers

/*
15.When was the first order?
Show the date of the first order ever made in the
Orders table
*/

SELECT Min(OrderDate)  FROM Orders 

/*
16.Countries where there are customers
Show a list of countries where the Northwind
company has customers
*/
SELECT DISTINCT COUNTRY FROM Customers
SELECT COUNTRY FROM Customers Group by Country

/*
17.
Contact titles for customers
Show a list of all the different values in the
Customers table for ContactTitles. Also include a
count for each ContactTitle.
This is similar in concept to the previous question
“Countries where there are customers”
, except we
now want a count for each ContactTitle
*/

SELECT ContactTitle,Count(*) Total FROM Customers Group by ContactTitle Order by Count(*) desc

/*
18.Products with associated supplier
names We’d like to show, for each product, the associated Supplier. Show the ProductID, ProductName, and the
CompanyName of the Supplier. Sort by ProductID.This question will introduce what may be a new
concept, the Join clause in SQL. The Join clause is used to join two or more relational database tables
together in a logical way.Here’s a data model of the relationship between Products and Suppliers
*/

SELECT ProductID,ProductName,CompanyName FROM Products Inner Join Suppliers 
on Products.SupplierID = Suppliers.SupplierID

/*
19.Orders and the Shipper that was used
We’d like to show a list of the Orders that were
made, including the Shipper that was used. Show the
OrderID, OrderDate (date only), and CompanyName
of the Shipper, and sort by OrderID.
In order to not show all the orders (there’s more than
800), show only those rows with an OrderID of less
than 10300
*/

SELECT OrderID , OrderDate , CompanyName From Shippers s INNER JOIN ORDERS o on 
s.ShipperID = o.ShipVia WHERE o.OrderID < 10300
