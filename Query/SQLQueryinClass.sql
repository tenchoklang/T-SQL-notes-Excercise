USE [TSQLV4]
DECLARE @OFFSET int =14, @FETCHNEXT int = 5;
--OFFSET FETCH
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
ORDER BY orderdate, orderid

-------------------------

SELECT distinct custid
FROM Sales.OrderValues order by custid

------------------------

SELECT title, empid
FROM HR.Employees
WHERE title = 'CEO'

-----------

SELECT firstname, lastname
FROM HR.Employees
WHERE lastname like '%P'