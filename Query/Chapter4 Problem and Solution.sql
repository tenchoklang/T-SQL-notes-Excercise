/*
Exercise 1
Write a query that returns all orders placed on the last day of activity that can be found in the Orders
table:
Table involved: Sales.Orders
*/
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders as O1
WHERE orderdate = (SELECT MAX(orderdate)
FROM Sales.Orders as O2)

/*
Exercise 2 (optional, advanced)
Write a query that returns all orders placed by the customer(s) who placed the highest number of or-
ders. Note that more than one customer might have the same number of orders:
Table involved: Sales.Orders
*/

--ATTEMPT 1: incorrect 
SELECT *
FROM Sales.Orders
WHERE custid in
(
    SELECT MAX(total) as O1total
    FROM
    (
        SELECT COUNT(O2.orderid) AS total, custid
        FROM Sales.Orders AS O2
        GROUP BY custid

    ) AS O1
   
);

--ATTEMPT 2: CORRECT!
SELECT *
FROM Sales.Orders
WHERE custid in
(
    SELECT TOP (1) O1.custid
    FROM
    (
        SELECT COUNT(O2.orderid) AS total, custid
        FROM Sales.Orders AS O2
        GROUP BY custid

    ) AS O1
    ORDER BY total desc
);








--QUESTION 5
--Write a query that returns for each customer all orders placed on the customer’s last day of activity:
--Table involved: Sales.Orders
USE TSQLV4

SELECT custid, orderid, orderdate, empid
FROM Sales.Orders AS O1
WHERE orderdate in (SELECT max(orderdate)
FROM Sales.Orders AS O2
WHERE O2.custid = O1.custid)

--QUESTION 6
--Write a query that returns customers who placed orders in 2015 but not in 2016:
--Tables involved: Sales.Customers and Sales.Orders

SELECT custid, companyname
FROM Sales.Customers AS C
WHERE custid not in(SELECT custid
FROM Sales.Orders AS O
WHERE YEAR(orderdate) = 2016 
) and 
(custid in(SELECT custid
FROM Sales.Orders AS O
WHERE YEAR(orderdate) = 2015))
 
 --QUESTION 7
--Write a query that returns customers who ordered product 12:
--Tables involved: Sales.Customers, Sales.Orders, and Sales.OrderDetails

--SOLUTION 1
SELECT custid, companyname
FROM Sales.Customers AS C
WHERE custid in (SELECT custid
FROM Sales.Orders AS O
WHERE O.orderid in (SELECT OD.orderid
FROM Sales.OrderDetails AS OD
WHERE OD.productid =12))



SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
(SELECT *
FROM Sales.Orders AS O
WHERE O.custid = C.custid
AND EXISTS
(SELECT *
FROM Sales.OrderDetails AS OD
WHERE OD.orderid = O.orderid
AND OD.ProductID = 12));





--QUESTION 8
--Write a query that calculates a running-total quantity for each customer and month:
--Table involved: Sales.CustOrders





