use class6;
-- Create Departments Table
CREATE TABLE Departments (
    DepartmentID   INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Create Employees Table
CREATE TABLE Employees (
    EmployeeID    INT PRIMARY KEY,
    Name          VARCHAR(50) NOT NULL,
    DepartmentID  INT NULL,  -- Nullable because some employees may not have a department
    Salary        DECIMAL(10,2) NOT NULL CHECK (Salary > 0),  -- Ensures salary is positive
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) 
        ON DELETE SET NULL   -- If a department is deleted, set DepartmentID to NULL in Employees
);

-- Create Projects Table
CREATE TABLE Projects (
    ProjectID   INT PRIMARY KEY,
    ProjectName VARCHAR(50) NOT NULL,
    EmployeeID  INT NULL,  -- Nullable because some projects may not be assigned to an employee
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) 
        ON DELETE SET NULL   -- If an employee is deleted, set EmployeeID to NULL in Projects
);
-- Insert data into Departments Table
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert data into Employees Table
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000); -- DepartmentID is NULL

-- Insert data into Projects Table
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL); -- EmployeeID is NULL

SELECT Name, DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID=Departments.DepartmentID;

SELECT Name, DepartmentName
FROM Employees
LEFT JOIN Departments ON 
Employees.DepartmentID=Departments.DepartmentID;

--RIGHT JOIN

--Write a query to list all departments, including those without employees.
SELECT Name, DepartmentName
FROM Employees
RIGHT JOIN Departments ON 
Employees.DepartmentID=Departments.DepartmentID;
--FULL OUTER JOIN


--Write a query to retrieve all employees and all departments, even if there’s no match between them.
SELECT Name, DepartmentName
FROM Employees
FULL OUTER JOIN Departments ON 
Employees.DepartmentID=Departments.DepartmentID;
--JOIN with Aggregation


--Write a query to find the total salary expense for each department.
SELECT DepartmentName, sum(Salary) OVER(Partition by DepartmentName)
FROM Employees
FULL OUTER JOIN Departments ON 
Employees.DepartmentID=Departments.DepartmentID;

--CROSS JOIN

--Write a query to generate all possible combinations of departments and projects.
SELECT Departments.DepartmentName, Projects.ProjectName
FROM Departments
CROSS JOIN Projects


--MULTIPLE JOINS
SELECT Employees.EmployeeID, Employees.Name as EmployeeName, Departments.DepartmentName as DepName, Projects.ProjectName
FROM Employees
LEFT JOIN Departments 
ON Employees.DepartmentID=Departments.DepartmentID
LEFT JOIN Projects 
ON Employees.EmployeeID=Projects.EmployeeID

--Write a query to get a list of employees with their department names and assigned project names. Include employees even if they don’t have a project.
