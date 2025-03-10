CREATE TABLE #EmployeeTransfers (
EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

SELECT *, CASE
	WHEN Department='HR' THEN 'IT'
	WHEN Department='IT' THEN 'Sales'
	WHEN Department='Sales' THEN 'HR'
	END as swapped_dept
FROM Employees

INSERT INTO #EmployeeTransfers
SELECT EmployeeID, Name, swapped_dept as Department, Salary
FROM (
SELECT *, CASE
	WHEN Department='HR' THEN 'IT'
	WHEN Department='IT' THEN 'Sales'
	WHEN Department='Sales' THEN 'HR'
	END as swapped_dept
FROM Employees
) as t1;
SELECT * FROM #EmployeeTransfers;