use class13;

SELECT ROW_NUMBER() OVER(ORDER BY value) as nums
FROM string_split(replicate(',', 30), ',')

DECLARE @givendate date
SET @givendate=GETDATE()
;with cte as (
SELECT 1 as number, 
DATEFROMPARTS(YEAR(@givendate),MONTH(@givendate),1) as day, DATENAME(DW, DATEFROMPARTS(YEAR(@givendate),MONTH(@givendate),1)) as dw, 1 as nweek
UNION ALL
SELECT cte.number+1 as number, DATEFROMPARTS(YEAR(@givendate),MONTH(@givendate),DAY(cte.day)+1) as day, DATENAME(DW, DATEFROMPARTS(YEAR(@givendate),MONTH(@givendate),DAY(cte.day)+1)) as dw, CASE WHEN cte.dw='Saturday' THEN cte.nweek+1 ELSE cte.nweek END as nweek
FROM cte
WHERE day(cte.day)<day(EOMONTH(@givendate)))
SELECT Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
FROM (SELECT day(day) as day, dw, nweek
FROM cte) as D
PIVOT (MAX(day) FOR dw in(Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday)) as P