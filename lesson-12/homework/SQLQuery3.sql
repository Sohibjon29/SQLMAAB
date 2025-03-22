CREATE PROCEDURE GetProceduresAndFunctions
    @DatabaseName NVARCHAR(128) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = '';

    
    BEGIN
        SELECT @sql = @sql + 'SELECT 
            ''' + name + ''' AS DatabaseName,
            s.name AS SchemaName, 
            o.name AS ObjectName,
            o.type_desc AS ObjectType,
            p.name AS ParameterName,
            TYPE_NAME(p.user_type_id) AS DataType,
            p.max_length AS MaxLength
        FROM ' + QUOTENAME(name) + '.sys.objects o
        JOIN ' + QUOTENAME(name) + '.sys.schemas s ON o.schema_id = s.schema_id
        LEFT JOIN ' + QUOTENAME(name) + '.sys.parameters p ON o.object_id = p.object_id
        WHERE o.type IN (''P'', ''FN'', ''IF'', ''TF'')
        UNION ALL ' 
        FROM sys.databases 
        WHERE state_desc = 'ONLINE' AND database_id > 4; -- Exclude system databases

        IF LEN(@sql) > 10
            SET @sql = LEFT(@sql, LEN(@sql) - 10);
    END

    EXEC sp_executesql @sql;
END
