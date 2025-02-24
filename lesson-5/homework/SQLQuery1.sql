USE class5;
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    HireDate DATE NOT NULL
);

INSERT INTO Employees (Name, Department, Salary, HireDate) VALUES
    ('Alice', 'HR', 50000, '2020-06-15'),
    ('Bob', 'HR', 60000, '2018-09-10'),
    ('Charlie', 'IT', 70000, '2019-03-05'),
    ('David', 'IT', 70000, '2021-07-22'),
    ('Eve', 'Finance', 90000, '2017-11-30'),
    ('Frank', 'Finance', 75000, '2019-12-25'),
    ('Grace', 'Marketing', 65000, '2016-05-14'),
    ('Hank', 'Marketing', 72000, '2019-10-08'),
    ('Ivy', 'IT', 67000, '2022-01-12'),
    ('Jack', 'HR', 52000, '2021-03-29');

SELECT *, DENSE_RANK() OVER(ORDER BY Salary) as Salary_rank
FROM Employees;


WITH RankedEmployees AS (
    SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Salary, 
        RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
)
SELECT * 
FROM RankedEmployees 
WHERE SalaryRank IN (
    SELECT SalaryRank 
    FROM RankedEmployees 
    GROUP BY SalaryRank 
    HAVING COUNT(*) > 1
);
WITH RankedEmployees AS (SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Salary, 
        RANK() OVER (Partition BY Department ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
	)
SELECT * 
FROM RankedEmployees
WHERE SalaryRank=1 OR SalaryRank=2;

WITH RankedEmployees AS (SELECT 
        EmployeeID, 
        Name, 
        Department, 
        Salary, 
        RANK() OVER (Partition BY Department ORDER BY Salary) AS SalaryRank
    FROM Employees
	)
SELECT * 
FROM RankedEmployees
WHERE SalaryRank=1;

SELECT *, sum(salary) over(Partition by Department ORDER by EmployeeID rows between unbounded preceding and current row)
FROM Employees;

SELECT DISTINCT Department, sum(salary) over(Partition by Department) as DeptSum
FROM Employees;
SELECT DISTINCT Department, avg(salary) over(Partition by Department) as DeptSum
FROM Employees;
SELECT *, Salary-avg(salary) over(Partition by Department) as SalaryDiff
FROM Employees;
--Calculate the Moving Average Salary Over 3 Employees (Including Current, Previous, and Next)
SELECT *, avg(salary) over(ORDER by HireDate rows between 2 preceding and current row)
FROM Employees;
--Find the Sum of Salaries for the Last 3 Hired Employees
SELECT *,sum(salary) over(ORDER by HireDate DESC rows between 2 preceding and current row)
FROM Employees
ORDER BY HireDate DESC;
--Calculate the Running Average of Salaries Over All Previous Employees
SELECT *, avg(salary) over(ORDER by HireDate DESC rows between unbounded preceding and current row)
FROM Employees;
--Find the Maximum Salary Over a Sliding Window of 2 Employees Before and After
SELECT 
    EmployeeID, 
    Name, 
    Salary, 
    MAX(Salary) OVER (
        ORDER BY EmployeeID 
        ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
    )
FROM Employees;

--Determine the Percentage Contribution of Each Employee’s Salary to Their Department’s Total Salary
SELECT *, salary/sum(salary) over(Partition by Department)*100
FROM Employees
