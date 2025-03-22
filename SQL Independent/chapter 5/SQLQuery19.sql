SELECT * FROM dbo.Orders;

SELECT empid,
SUM(CASE WHEN custid = 'A' THEN qty END) AS A,
SUM(CASE WHEN custid = 'B' THEN qty END) AS B,
SUM(CASE WHEN custid = 'C' THEN qty END) AS C,
SUM(CASE WHEN custid = 'D' THEN qty END) AS D
FROM dbo.Orders
GROUP BY empid;

SELECT empid, A, B, C, D, E
FROM (SELECT empid, custid, qty
		FROM dbo.Orders) as D
	PIVOT(SUM(qty) FOR custid IN (A, B, C, D, E)) as pvtd;




USE TSQLV6;
DROP TABLE IF EXISTS dbo.EmpCustOrders;
CREATE TABLE dbo.EmpCustOrders
(
empid INT NOT NULL
CONSTRAINT PK_EmpCustOrders PRIMARY KEY,
A VARCHAR(5) NULL,
B VARCHAR(5) NULL,
C VARCHAR(5) NULL,
D VARCHAR(5) NULL
);
INSERT INTO dbo.EmpCustOrders(empid, A, B, C, D)
SELECT empid, A, B, C, D
FROM (SELECT empid, custid, qty
FROM dbo.Orders) AS D
PIVOT(SUM(qty) FOR custid IN(A, B, C, D)) AS P;
SELECT * FROM dbo.EmpCustOrders;

SELECT empid, custid, qnt
FROM dbo.EmpCustOrders
CROSS APPLY(
VALUES ('A', A), ('B', B), ('C', C), ('D', D)) AS C(custid, qnt)
WHERE qnt IS NOT NULL;


