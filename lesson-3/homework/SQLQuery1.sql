use class3;
SELECT TOP 10 percent *
FROM Employees;
SELECT Department, AVG(Salary) AS AverageSalary,
	CASE
		WHEN AVG(Salary)>80000 THEN 'High'
		WHEN AVG(Salary)>5000 THEN 'Medium'
		ELSE 'Low'
	END
	AS SalaryCategory
FROM Employees
GROUP BY Department
ORDER BY AverageSalary
OFFSET 2 ROWS
FETCH NEXT 5 ROWS ONLY;
