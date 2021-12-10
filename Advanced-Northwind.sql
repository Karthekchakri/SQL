/* 32. High-value customers
We want to send all of our high-value customers a
special VIP gift. We're defining high-value
customers as those who've made at least 1 order with
a total value (not including the discount) equal to
$10,000 or more. We only want to consider orders
made in the year 1996
*/
Select
Customers.CustomerID
,Customers.CompanyName
,Orders.OrderID
,Amount = Quantity * UnitPrice
From Customers
join Orders
on Orders.CustomerID = Customers.CustomerID
join [Order Details]
on Orders.OrderID = [Order Details].OrderID
Where
OrderDate >= '19960101'
and OrderDate < '19970101'
AND Quantity * UnitPrice > 10000
Group By
Customers.CustomerID
,Customers.CompanyName
,Orders.OrderID,Quantity * UnitPrice
/*
33.High-value customers - total orders
The manager has changed his mind. Instead of
requiring that customers have at least one individual
orders totaling $10,000 or more, he wants to define
high-value customers as those who have orders
totaling $15,000 or more in 1996. How would you
change the answer to the problem above
*/
SELECT c.customerid,SUM(UnitPrice*Quantity) AS Total FROM [Order Details]od Inner Join Orders o on od.OrderID = o.OrderID
Inner Join Customers c on o.CustomerID = c.CustomerID 
WHERE YEAR(OrderDate) ='1996'
Group by c.CustomerID 
having SUM(UnitPrice*Quantity) >15000
order by SUM(UnitPrice*Quantity) desc

/*
34.High-value customers - with discount
Change the above query to use the discount when
calculating high-value customers. Order by the total
amount which includes the discount.
*/

SELECT c.customerid,SUM(UnitPrice*Quantity*(1-Discount)) AS Total FROM [Order Details]od Inner Join Orders o on od.OrderID = o.OrderID
Inner Join Customers c on o.CustomerID = c.CustomerID 
WHERE YEAR(OrderDate) ='1996'
Group by c.CustomerID 
--having SUM((UnitPrice*Quantity)*(1-Discount)) >15000
order by SUM((UnitPrice*Quantity)*(1-Discount)) desc

/*
35.Month-end orders
At the end of the month, salespeople are likely to try
much harder to get orders, to meet their month-end
quotas. Show all orders made on the last day of the
month. Order by EmployeeID and OrderID
*/
SELECT * FROM ORDERS Where OrderDate = EOMONTH(OrderDate)

/*36. Orders with many line items
The Northwind mobile app developers are testing an
app that customers will use to show orders. In order
to make sure that even the largest orders will show
up correctly on the app, they'd like some samples of
orders that have lots of individual line items. Show
the 10 orders with the most line items, in order of
total line items
*/
SELECT O.OrderID,Count(*) AS Total FROM ORDERS O INNER JOIN [ORDER DETAILS] OD on O.OrderID = OD.OrderID
Group by O.OrderID Order by Count(*) Desc OFFSET 0 ROWS Fetch FIRST 10 ROWS ONLY

/*
37.Orders - random assortment
The Northwind mobile app developers would now
like to just get a random assortment of orders for beta
testing on their app. Show a random set of 2% of all
orders.
*/

/*
38. Orders - accidental double-entry
Janet Leverling, one of the salespeople, has come to
you with a request. She thinks that she accidentally
double-entered a line item on an order, with a
different ProductID, but the same quantity. She
remembers that the quantity was 60 or more. Show
all the OrderIDs with line items that match this, in
order of OrderID
*/

select * , Row_number() over(partition by Orderid,quantity order by quantity )from [Order Details]where Quantity > 60order by orderidSelect OrderID,quantity,Count(*) from [Order Details]Where Quantity > 60group by OrderID,Quantityhaving Count(OrderID) >1Select OrderID,quantity from [Order Details]Where Quantity > 60group by OrderID,Quantityhaving Count(*) >1/*39.Orders - accidental double-entry details
Based on the previous question, we now want to
show details of the order, for orders that match the
above criteria*/
select * , Row_number() over(partition by quantity,Orders.Orderid order by quantity )from [Order Details] Inner join Orderson [Order Details].OrderID = orders.OrderIDwhere Quantity > 60order by orders.orderid/*40.Orders - accidental double-entry
details, derived table
Here's another way of getting the same results as in
the previous problem, using a derived table instead of
a CTE. However, there's a bug in this SQL. It returns
20 rows instead of 16. Correct the SQL.*/Select DISTINCT
[Order Details].OrderID
,ProductID
,UnitPrice
,Quantity
,Discount
From [Order Details]
Join (
Select
OrderID
From [Order Details]
Where Quantity >= 60
Group By OrderID, Quantity
Having Count(*) > 1
) PotentialProblemOrders
on PotentialProblemOrders.OrderID = [Order Details].OrderID
Order by [Order Details].OrderID, ProductID

/*
41. Late orders
Some customers are complaining about their orders
arriving late. Which orders are late?
*/

Select * from orders Where RequiredDate < ShippedDate


/*
42. Late orders - which employees?
Some salespeople have more orders arriving late than
others. Maybe they're not following up on the order
process, and need more training. Which salespeople
have the most orders arriving late
*/
Select O.EmployeeID,E.LastName,Count(*) from orders O
INNER JOIN Employees E on O.EmployeeID = E.EmployeeID
Where RequiredDate < ShippedDate Group By O.EmployeeID,E.LastName Order by count(*) desc

/*
43. Late orders vs. total orders
Andrew, the VP of sales, has been doing some more
thinking some more about the problem of late orders.
He realizes that just looking at the number of orders
arriving late for each salesperson isn't a good idea. It
needs to be compared against the total number of
orders per salesperson. Return results like the
following
*/
with test as(
Select O.EmployeeID,E.LastName,Count(*) total from orders O
INNER JOIN Employees E on O.EmployeeID = E.EmployeeID
Where RequiredDate < ShippedDate Group By O.EmployeeID,E.LastName) 
Select * from test

Select * from Employees


