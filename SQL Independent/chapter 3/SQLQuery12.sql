USE TSQLV6;
SELECT empid, DATEADD(day, n-1, '2022-06-12') as dt
FROM HR.Employees
CROSS JOIN 
dbo.Nums
WHERE n<=5
ORDER BY empid, n;

SELECT c.custid, count(DISTINCT o.orderid) as numorders, SUM(od.qty) as ttlqty
FROM Sales.Customers as c
JOIN Sales.Orders as o
ON c.custid=o.custid
JOIN Sales.OrderDetails as od
ON o.orderid=od.orderid
WHERE o.shipcountry='USA'
GROUP BY c.custid;


SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers as c
LEFT JOIN 
Sales.Orders as o
ON c.custid=o.custid
ORDER BY o.orderdate;

SELECT c.custid, c.companyname, o.orderid, o.orderdate
FROM Sales.Customers as c
JOIN Sales.Orders as o
on c.custid=o.custid
where o.orderdate='2022-02-12';


SELECT c.custid, c.companyname,
	CASE 
		WHEN o.orderid IS NULL THEN 'NO'
		ELSE 'YES'
	END
FROM Sales.Customers as c
LEFT JOIN Sales.Orders as o
on c.custid=o.custid AND
o.orderdate='2022-02-12';

