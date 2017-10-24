/*
Exercise 1
The following query attempts to filter orders that were not placed on the last day of the year. 
It’s supposed to return the order ID, order date, customer ID, employee ID, and respective 
end-of-year date for each order:

SELECT orderid, orderdate, custid, empid,
DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders
WHERE orderdate <> endofyear;
*/
--SOLUTION 1
WITH EOF as(
SELECT orderid, orderdate, custid, empid,
DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders)

SELECT *
FROM EOF
WHERE orderdate NOT IN (endofyear);--WHERE orderdate <> (endofyear), WHERE orderdate != (endofyear);


--SOLUTION 2
SELECT orderid, orderdate, custid, empid,
DATEFROMPARTS(YEAR(orderdate), 12, 31) AS endofyear
FROM Sales.Orders
WHERE orderdate <> DATEFROMPARTS(YEAR(orderdate), 12, 31);


/*
Exercise 2-1
Write a query that returns the maximum value in the orderdate column for each employee:
Table involved: TSQLV4 database, Sales.Orders table
*/

--Solution 1

SELECT empid, MAX(orderdate)
FROM Sales.Orders 
GROUP BY empid;

--Solution 2 

SELECT M.empid, M.maxdate
FROM (SELECT empid, MAX(orderdate) as maxdate
	FROM Sales.Orders 
	GROUP BY empid) as M

/*
Exercise 2-2
Encapsulate the query from Exercise 2-1 in a derived table. Write a join query between the derived
table and the Orders table to return the orders with the maximum order date for each employee:
 Table involved: Sales.Orders
*/


SELECT O.empid, M.maxdate, O.orderid, O.custid
FROM (SELECT empid, MAX(orderdate) as maxdate
	FROM Sales.Orders 
	GROUP BY empid) as M
	INNER JOIN
	(SELECT *
	FROM Sales.Orders) as O
	on M.empid = O.empid and M.maxdate = O.orderdate

/*
Exercise 3-1
Write a query that calculates a row number for each order based on orderdate, orderid ordering:
 Table involved: Sales.Orders
*/


/*
Exercise 4 (optional, advanced)
Write a solution using a recursive CTE that returns the management chain leading to Patricia Doyle
(employee ID 9):
*/



/*
Exercise 5-1
Create a view that returns the total quantity for each employee and year:
 Tables involved: Sales.Orders and Sales.OrderDetails
 When running the following code:
SELECT * FROM Sales.VEmpOrders ORDER BY empid, orderyear;
*/
DROP VIEW IF EXISTS Sales.VEmpOrder;
GO
CREATE VIEW Sales.VEmpOrder
AS
SELECT O.empid, YEAR(O.orderdate) as OrderYear, SUM(OD.qty) as totalQTY
FROM (Sales.Orders as O 
	INNER JOIN 
	Sales.OrderDetails as OD
	ON OD.orderid = O.orderid)
GROUP BY O.empid, YEAR(O.orderdate);
GO

SELECT empid, OrderYear, totalQTY
FROM Sales.VEmpOrder
ORDER BY empid, Orderyear

/*
Exercise 5-2 (optional, advanced)
Write a query against Sales.VEmpOrders that returns the running total quantity for each employee and year:
Table involved: Sales.VEmpOrders view
*/

--ATTEMPT 1: INCORRECT
SELECT empid, OrderYear, totalQTY,
(SELECT SUM(V2.totalQTY)
	FROM Sales.VEmpOrder AS V2
	WHERE V2.OrderYear<=V1.OrderYear)  
FROM Sales.VEmpOrder V1
ORDER BY empid, Orderyear

--ATTEMPT 2: CORRECT!
SELECT empid, OrderYear, totalQTY,
(SELECT SUM(V2.totalQTY)
	FROM Sales.VEmpOrder AS V2
	WHERE V2.OrderYear<=V1.OrderYear AND V2.empid = V1.empid)  
FROM Sales.VEmpOrder V1
ORDER BY empid, Orderyear


/*
Exercise 6-1
Create an inline TVF that accepts as inputs a supplier ID (@supid AS INT) and a requested number of
products (@n AS INT). The function should return @n products with the highest unit prices that are
supplied by the specified supplier ID:
 Table involved: Production.Products
*/
---------------------------------
USE TSQLV4;
DROP FUNCTION IF EXISTS dbo.GetCustOrders;
GO
AlTER FUNCTION dbo.GetTop
(@supid AS INT, @n AS INT) RETURNS TABLE
AS
RETURN

SELECT TOP (@n) productid, productname, unitprice, supplierid
FROM Production.Products
WHERE supplierid = @supid
ORDER BY unitprice DESC;

SELECT *
FROM dbo.GetTop(5,2)

/*
Exercise 6-2
Using the CROSS APPLY operator and the function you created in Exercise 6-1, return the two most
expensive products for each supplier:
Table involved: Production.Suppliers
*/


--ATTEMPT 1: INCORRECT 
SELECT *
FROM Production.Suppliers AS PS
	INNER JOIN 
	Production.Products AS PP
	on PS.supplierid = PP.supplierid





