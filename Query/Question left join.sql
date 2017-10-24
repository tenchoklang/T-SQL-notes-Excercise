USE TSQLV4

SELECT O.empid, COUNT(*) AS total
FROM HR.Employees AS E RIGHT JOIN Sales.Orders AS O
	ON O.empid < E.empid--WHY is there a NULL in the output for < or >
--HAVING COUNT(*) <> null
GROUP BY O.empid
ORDER BY O.empid

SELECT O.empid AS O_empid, E.empid AS E_empid
FROM HR.Employees AS E left JOIN Sales.Orders AS O
	ON O.empid < E.empid
ORDER BY O.empid
--WHY is there a NULL in the output for < or >
--ANSWER:There are NULLS because there are no values for 
--E_empid that satisfy the condition O.empid < E.empid
-- QUESTION: how do you get rid of the null in the output

SELECT empid
FROM HR.Employees 


--WRITE A QUERY THAT RETURNS THE LAST DAY OF THE MONTH SALES.ORDERS
--ATTEMPT 1
USE TSQLV4

SELECT MONTH(orderdate), COUNT(*) as total, MAX(orderdate)
FROM Sales.Orders
GROUP BY MONTH(orderdate)
ORDER BY MONTH(orderdate)


--WRITE A QUERY THAT RETURNS THE LAST DAY OF THE MONTH SALES.ORDERS
--CORRECT WAY!! 
USE TSQLV4

SELECT orderdate
FROM Sales.Orders
WHERE orderdate = eoMONTH(orderdate)


	

