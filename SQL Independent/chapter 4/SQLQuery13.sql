SELECT orderid, orderdate, custid, empid 
FROM Sales.Orders
WHERE orderdate=
(SELECT MAX(orderdate)
FROM Sales.Orders);



SELECT *
FROM Sales.Orders as o
WHERE o.custid IN (SELECT custid
FROM Sales.Orders as o
GROUP BY custid
HAVING COUNT(o.orderid)=
(SELECT TOP 1 COUNT(o.orderid) num
FROM Sales.Orders as o
GROUP BY custid
ORDER BY num DESC))

SELECT TOP (1) WITH TIES O.custid
FROM Sales.Orders AS O
GROUP BY O.custid
ORDER BY COUNT(*) DESC;

SELECT e.empid, e.firstname, e.lastname
FROM HR.Employees as e
LEFT JOIN 
(SELECT *
FROM Sales.Orders as o
WHERE orderdate>='2022-05-01') t1
ON e.empid=t1.empid
WHERE custid IS NULL;

SELECT o.custid, o.orderid, o.orderdate, o.empid
FROM Sales.Orders as o
CROSS JOIN
(SELECT MAX(orderdate) as last, custid
FROM Sales.Orders as o1
GROUP BY custid) as t1
 WHERE o.custid=t1.custid AND o.orderdate=t1.last
 ORDER BY custid;

 
 SELECT * 
 FROM Sales.Customers 
 WHERE custid IN (SELECT custid
 FROM (SELECT t1.custid
 FROM
 (SELECT custid
 FROM Sales.Orders
 WHERE YEAR(orderdate)=2021) as t1
 INNER JOIN
 (SELECT custid
 FROM Sales.Orders
 WHERE YEAR(orderdate)<>2021) as t2
 ON t1.custid=t2.custid) as t3) 


SELECT custid, companyname
FROM Sales.Customers AS C
WHERE EXISTS
(SELECT *
FROM Sales.Orders AS O
WHERE O.custid = C.custid
AND O.orderdate >= '20210101'
AND O.orderdate < '20220101')
AND NOT EXISTS
(SELECT *
FROM Sales.Orders AS O
WHERE O.custid = C.custid
AND O.orderdate >= '20220101'
AND O.orderdate < '20230101');

SELECT c.custid, c.companyname
FROM Sales.Customers as c
WHERE EXISTS
(SELECT o.orderid, custid
FROM Sales.Orders as o
WHERE c.custid=o.custid AND EXISTS (SELECT *
FROM Sales.OrderDetails od
WHERE o.orderid=od.orderid AND od.productid=12)
);



SELECT custid, orderdate, orderid,
(SELECT TOP (1) O2.orderdate
FROM Sales.Orders AS O2
WHERE O2.custid = O1.custid
AND ( O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid
OR O2.orderdate < O1.orderdate)
ORDER BY O2.orderdate DESC, O2.orderid DESC) AS prevdate, DATEDIFF(DAY, (SELECT TOP (1) O2.orderdate
FROM Sales.Orders AS O2
WHERE O2.custid = O1.custid
AND ( O2.orderdate = O1.orderdate AND O2.orderid < O1.orderid
OR O2.orderdate < O1.orderdate)
ORDER BY O2.orderdate DESC, O2.orderid DESC), orderdate) as days
FROM Sales.Orders AS O1
ORDER BY custid, orderdate, orderid
