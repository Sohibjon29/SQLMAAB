use class12;
DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql = @sql + 
'SELECT ''' + name + ''' AS DatabaseName, s.name AS SchemaName, t.name AS TableName 
 FROM ' + name + '.sys.tables t 
 JOIN ' + name + '.sys.schemas s ON t.schema_id = s.schema_id 
 UNION ALL '
FROM sys.databases 
WHERE state_desc = 'ONLINE' AND database_id > 4; -- Excluding system databases

SET @sql = LEFT(@sql, LEN(@sql) - 10);
SELECT @sql
EXEC sp_executesql @sql;




