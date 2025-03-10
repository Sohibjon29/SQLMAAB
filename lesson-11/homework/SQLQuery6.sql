CREATE VIEW Hours AS
SELECT EmployeeID, EmployeeName, Department, SUM(HoursWorked) as summa
FROM Worklog
GROUP BY EmployeeID, EmployeeName, Department;
