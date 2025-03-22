DECLARE @col_list varchar(max)
SET @col_list=(
SELECT STRING_AGG(COLUMN_NAME, ',')
FROM (
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Contacts' AND COLUMN_NAME<>'identifier_name' AND COLUMN_NAME<>'identifier_value'
) as t1
);
DECLARE @proc nvarchar(max)
SET @proc=N'
SELECT property, value
FROM (SELECT TOP 1 *
FROM contacts) as first
UNPIVOT (value FOR property IN ('+@col_list+')) as pvtd';
DECLARE @offset_count int=0;

DECLARE @id_name varchar(100)
SET @id_name=
(SELECT identifier_name
FROM Contacts
ORDER BY firstname
OFFSET @offset_count ROWS
FETCH NEXT 1 ROWS ONLY
);
DECLARE @id_value varchar(100)
SET @id_value=
(SELECT identifier_value
FROM Contacts
ORDER BY firstname
OFFSET @offset_count ROWS
FETCH NEXT 1 ROWS ONLY
);

DECLARE @inner varchar(MAX);
DROP TABLE IF EXISTS #Temp
CREATE TABLE #Temp(property varchar(max), value varchar(max))
INSERT INTO #Temp
EXEC(@proc)

SET @inner=(SELECT *
FROM #Temp
FOR JSON PATH, root('properties'));


--USE Dynamic SQL, so you can concat all the column names as variable and insert as string 

SELECT *, (SELECT *
FROM #Temp
FOR JSON PATH, root('properties')) as json 
FROM Contacts

SELECT CONCAT('[{"',@id_name,'":"',@id_value,'",',SUBSTRING(@inner, 2, LEN(@inner)-2),'}]')





