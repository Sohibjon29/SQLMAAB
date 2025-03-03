USE Class8;
DROP TABLE IF EXISTS Groupings;

CREATE TABLE Groupings
(
StepNumber  INTEGER PRIMARY KEY,
TestCase    VARCHAR(100) NOT NULL,
[Status]    VARCHAR(100) NOT NULL
);
INSERT INTO Groupings (StepNumber, TestCase, [Status]) 
VALUES
(1,'Test Case 1','Passed'),
(2,'Test Case 2','Passed'),
(3,'Test Case 3','Passed'),
(4,'Test Case 4','Passed'),
(5,'Test Case 5','Failed'),
(6,'Test Case 6','Failed'),
(7,'Test Case 7','Failed'),
(8,'Test Case 8','Failed'),
(9,'Test Case 9','Failed'),
(10,'Test Case 10','Passed'),
(11,'Test Case 11','Passed'),
(12,'Test Case 12','Passed');

-----------------------------------------

DROP TABLE IF EXISTS [dbo].[EMPLOYEES_N];

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
)
 
INSERT INTO [dbo].[EMPLOYEES_N]
VALUES
	(1001,'Pawan','1975-02-21'),
	(1002,'Ramesh','1976-02-21'),
	(1003,'Avtaar','1977-02-21'),
	(1004,'Marank','1979-02-21'),
	(1008,'Ganesh','1979-02-21'),
	(1007,'Prem','1980-02-21'),
	(1016,'Qaue','1975-02-21'),
	(1155,'Rahil','1975-02-21'),
	(1102,'Suresh','1975-02-21'),
	(1103,'Tisha','1975-02-21'),
	(1104,'Umesh','1972-02-21'),
	(1024,'Veeru','1975-02-21'),
	(1207,'Wahim','1974-02-21'),
	(1046,'Xhera','1980-02-21'),
	(1025,'Wasil','1975-02-21'),
	(1052,'Xerra','1982-02-21'),
	(1073,'Yash','1983-02-21'),
	(1084,'Zahar','1984-02-21'),
	(1094,'Queen','1985-02-21'),
	(1027,'Ernst','1980-02-21'),
	(1116,'Ashish','1990-02-21'),
	(1225,'Bushan','1997-02-21');

SELECT MIN(StepNumber) as MinStepNumber, Status, MAX(StepNumber) as MaxStepNumber, COUNT(SumCol) as ConsequtiveCount
FROM
(SELECT *, SUM(prod) OVER (ORDER BY StepNumber) as SumCol
FROM
(SELECT *, CASE 
WHEN num*num1=1 THEN 0
ELSE 1
END as prod
FROM
(SELECT *, LAG(num, 1) OVER(ORDER BY StepNumber) as num1
FROM 
(SELECT *, CASE
WHEN Status='Passed' THEN 1
ELSE -1
END as num
FROM Groupings) as t1) as t2) as t3) as t4
GROUP BY SumCol, Status
ORDER BY MinStepNumber;

SELECT *
FROM EMPLOYEES_N
ORDER BY HIRE_DATE

SELECT all_years 
FROM 
(SELECT *, ROW_NUMBER() OVER(ORDER BY all_years) row_num
FROM
(SELECT CONCAT(MIN(years), '-', MAX(years)) as all_years
FROM
(SELECT *, SUM(prod) OVER(ORDER BY years) as sum
FROM 
(SELECT *,
CASE WHEN num*num1=1 THEN 0
ELSE 1
END as prod
FROM
(SELECT *, LEAD(num) OVER(ORDER BY years) as num1
FROM
(SELECT ordinal+1971 as years, CASE 
WHEN ordinal+1971 IN (
SELECT YEAR(HIRE_DATE)
FROM EMPLOYEES_N) THEN 1
ELSE -1
END as num
FROM string_split(REPLICATE('.',25),'.',1)) as t1) as t2) as t3) as t4
GROUP BY sum) as t5) as t6
WHERE row_num%2=0
