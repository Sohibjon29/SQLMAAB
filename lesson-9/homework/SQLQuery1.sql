USE class9;
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');
SELECT * 
FROM Employees;
DECLARE @depth int =0

;with cte
AS (
select EmployeeID, ManagerID, Jobtitle, 0 AS Depth
FROM Employees
WHERE ManagerID IS NULL
UNION ALL
SELECT e.EmployeeID, e.ManagerID, e.Jobtitle, cte.Depth+1
FROM Employees as e
JOIN cte on e.ManagerID=cte.EmployeeID
)
SELECT * FROM cte;

;
WITH cte 
AS (
SELECT
1 as Num, 1 as Factorial
UNION ALL
SELECT Num+1, Factorial*Num
from cte
where Num<10
)
select * from cte;



;WITH cte
AS (
SELECT 
1 as n, 1 as FN, 0 as PN
UNION ALL
SELECT
n+1, FN+PN, FN
FROM cte
WHERE n<10
)
SELECT n, FN as Fibonacci_Number FROM cte