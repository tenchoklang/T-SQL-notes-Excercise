
SELECT empid, YEAR(orderdate) AS orderyear --distinct eliminates the duplicates 
	
	FROM Sales.Orders
	WHERE custid = 71
	ORDER BY 2,1 desc;
