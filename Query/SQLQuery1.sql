USE TSQLV4

SELECT 
	empid,
	YEAR(orderdate) AS orderyear,
	COUNT(DISTINCT custid) AS total
FROM Sales.Orders
GROUP BY  empid, YEAR(orderdate)
ORDER BY empid




USE TSQLV4

SELECT 
	empid,
	COUNT(DISTINCT custid) AS total
FROM Sales.Orders
GROUP BY empid
ORDER BY empid



----------------------------

--USE TSQLV4

--SELECT discount, SUM(unitprice) AS totalprice, COUNT(*) AS qty
--FROM Sales.OrderDetails
--GROUP BY discount
--HAVING COUNT(*)>100
--ORDER BY qty
----It GROUP BY discount, shows tuples HAVING COUNT(*)>100
----it then sums the unitprice and names it totalprice and then it orders by qty
