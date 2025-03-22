USE CLASS11;
CREATE VIEW Hours AS
SELECT EmployeeID, EmployeeName, Department, SUM(HoursWorked) as summa
FROM Worklog
GROUP BY EmployeeID, EmployeeName, Department;
USE CLASS11;
SELECT *
FROM Hours;

CREATE VIEW DeptHours AS
SELECT Department, SUM(HoursWorked) as summa, AVG(HoursWorked) as average
FROM Worklog
GROUP BY Department;
SELECT *
FROM DeptHours
