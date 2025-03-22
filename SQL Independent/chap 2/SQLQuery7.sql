USE TSQLV6;
SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE MONTH(orderdate)=06 AND YEAR(orderdate)=2021;

SELECT orderid, orderdate, custid, empid
FROM Sales.Orders
WHERE orderdate = DATEADD(day, -1, EOMONTH(orderdate));

SELECT empid, firstname, lastname
FROM HR.Employees
WHERE lastname LIKE '%e%e%';

SELECT orderid, qty*unitprice as totalvalue
FROM Sales.OrderDetails
WHERE qty*unitprice>10000
ORDER BY qty*unitprice DESC;

SELECT firstname
FROM HR.Employees
WHERE firstname COLLATE Latin1_General_CS_AS LIKE 'N[%a-z]%';

SELECT TOP 3 shipcountry, AVG(freight) as avgfreight
FROM Sales.Orders
WHERE YEAR(orderdate)=2021
GROUP BY shipcountry
ORDER BY AVG(freight) DESC;

SELECT custid, orderdate, orderid, RANK() OVER(Partition BY custid ORDER BY orderdate, orderid DESC) as rownum
FROM Sales.Orders;
SELECT custid, orderdate, orderid, ROW_NUMBER() OVER(Partition BY custid ORDER BY orderdate, orderid DESC) as rownum
FROM Sales.Orders;

SELECT empid, firstname, lastname, titleofcourtesy, 
CASE 
	WHEN titleofcourtesy='Ms.' or titleofcourtesy='Mrs.'  THEN 'Female'
	WHEN titleofcourtesy='Mr.' THEN 'Male'
	ELSE 'Unknown'
END as gender
FROM HR.Employees;

SELECT custid, region
FROM Sales.Customers
ORDER BY
	CASE 
		WHEN region IS NULL THEN 1
		ELSE 0
	END, region