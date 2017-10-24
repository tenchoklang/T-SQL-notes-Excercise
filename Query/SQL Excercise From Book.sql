USE TSQLV4

--EXCERCISE 4
--Write a query against the Sales.OrderDetails table that
--returns orders with a total value (quantity *
--unitprice) greater than 10,000, sorted by total value
SELECT orderid, (unitprice * qty) AS totalprice
FROM Sales.OrderDetails
WHERE (unitprice * qty) > 10000
ORDER BY totalprice


SELECT orderid, unitprice, qty
FROM Sales.OrderDetails
ORDER BY orderid
-------------------------------------------

-------------------------------------------
--EXCERCISE 6
-- Query 1
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
WHERE orderdate < '20160501'
GROUP BY empid;
-- Query 2
SELECT empid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY empid
HAVING MAX(orderdate) < '20160501';

SELECT empid, COUNT(*) AS total, MAX(orderdate)
FROM Sales.Orders
GROUP BY empid
--------------------

--------------------
--EXCERCISE 7

SELECT TOP(3) shipcountry, COUNT(*) AS CountryTotal, AVG(freight) as total
FROM Sales.Orders
WHERE YEAR(orderdate) = '2015' 
GROUP BY shipcountry
ORDER BY total DESC

------------------------
--EXCERCISE

USE TSQLV4

DECLARE @string varchar(30) = 'database@@start@yahoo.com'
print @string

--|||||||||||||||||||||||||||||||||
--FIRST METHOD: DOES NOT WORK FOR '@' in USER NAME
--SELECT LEN(@string)
--SELECT CHARINDEX('@', @string) as Startingindex --->first index of @
--SELECT LEN(@string) - CHARINDEX('@', REVERSE(@string)) + 1 ---> length of the domain

SELECT SUBSTRING(@string, CHARINDEX('@', @string), LEN(@string) - CHARINDEX('@', @string) + 1) AS DomainName

--|||||||||||||||||||||||||||||||||||||||||||||
--SECOND METHOD: WORKS FOR ALL CASES WITH '@' in user name
--SELECT LEN(@string) --length of string
--SELECT CHARINDEX('@', REVERSE(@string))  --->last index of @
--SELECT LEN(@string) - CHARINDEX('@', REVERSE(@string)) ---> length of the domain
SELECT SUBSTRING(@string, LEN(@string) - CHARINDEX('@', REVERSE(@string))+1, LEN(@string) - CHARINDEX('@', REVERSE(@string))) AS DomainName

-----------------------------------------------------------------