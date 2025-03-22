drop table if exists items;
go

create table items
(
	ID						varchar(10),
	CurrentQuantity			int,
	QuantityChange   		int,
	ChangeType				varchar(10),
	Change_datetime			datetime
);
go

insert into items values
('A0013', 278,   99 ,   'out', '2020-05-25 0:25'), 
('A0012', 377,   31 ,   'in',  '2020-05-24 22:00'),
('A0011', 346,   1  ,   'out', '2020-05-24 15:01'),
('A0010', 347,   1  ,   'out', '2020-05-23 5:00'),
('A009',  348,   102,   'in',  '2020-04-25 18:00'),
('A008',  246,   43 ,   'in',  '2020-04-25 2:00'),
('A007',  203,   2  ,   'out', '2020-02-25 9:00'),
('A006',  205,   129,   'out', '2020-02-18 7:00'),
('A005',  334,   1  ,   'out', '2020-02-18 6:00'),
('A004',  335,   27 ,   'out', '2020-01-29 5:00'),
('A003',  362,   120,   'in',  '2019-12-31 2:00'),
('A002',  242,   8  ,   'out', '2019-05-22 0:50'),
('A001',  250,   250,   'in',  '2019-05-20 0:45');







SELECT *
FROM 
(SELECT *, SUM(CASE WHEN ChangeType='in' THEN QuantityChange END) OVER(ORDER BY Change_datetime) sum_in, SUM(CASE WHEN ChangeType='out' THEN QuantityChange END) OVER(ORDER BY Change_datetime) sum_out
FROM items) as t1
CROSS JOIN 
(SELECT QuantityChange as InitIn, Change_datetime as InitDate
FROM items
WHERE ChangeType='in') as t2
ORDER BY InitDate



;

CREATE TABLE Final (
Quantity INT, 
Interval Varchar(max))

INSERT INTO FINAL 
SELECT Sum(QuantityRemoved) qty, Interval
FROM
(SELECT MIN(Change_datetime) as InDate, MIN(sum_in) sum_in, RemoveID, QuantityRemoved, RemovedDate, max(sum_out) as sum_out, DATEDIFF(Day, MIN(Change_datetime), RemovedDate) as DayDiff, CONCAT(FLOOR(DATEDIFF(Day, MIN(Change_datetime), RemovedDate)/90)*90, '-', FLOOR(DATEDIFF(Day, MIN(Change_datetime), RemovedDate)/90+1)*90) as Interval
FROM(
SELECT *
FROM 
(SELECT *, SUM(CASE WHEN ChangeType='in' THEN QuantityChange END) OVER(ORDER BY Change_datetime) sum_in
FROM items
WHERE ChangeType='in') as t1
CROSS JOIN
(SELECT ID as RemoveID, QuantityChange as QuantityRemoved, Change_datetime as RemovedDate, SUM(CASE WHEN ChangeType='out' THEN QuantityChange END) OVER(ORDER BY Change_datetime) sum_out
FROM items
WHERE ChangeType='out') as t2
WHERE sum_in>=sum_out) as t3
GROUP BY RemoveID, QuantityRemoved, RemovedDate) as t4
GROUP BY Interval;

DECLARE @columns NVARCHAR(MAX);
DECLARE @proc NVARCHAR(MAX);


SELECT @columns = STRING_AGG(QUOTENAME(Interval), ',')
FROM (SELECT DISTINCT Interval FROM Final) AS Intervals;


SET @proc = '
SELECT * FROM 
(SELECT Interval, Quantity FROM Final) AS src
PIVOT (MAX(Quantity) FOR Interval IN (' + @columns + ')) AS pvtd;';

EXEC sp_executesql @proc;


