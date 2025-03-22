SELECT *
FROM sys.indexes as i
JOIN
sys.index_columns ic
ON i.object_id=ic.object_id AND i.index_id=ic.index_id
JOIN
sys.columns as c
ON ic.index_column_id=c.column_id AND ic.object_id=c.object_id
JOIN sys.tables as t
ON i.object_id=t.object_id;

DECLARE @html nvarchar(max)=

'<table>
	<tr>
		<th>IndexName</th>
		<th>IndexType</th>
		<th>TableName</th>
		<th>ColName</th>
	</tr>'+
(SELECT '<tr>
		<td>'+i.name+'</td>
		<td>'+i.type_desc+'</td>
		<td>'+t.name+'</td>
		<td>'+c.name+'</td>
	</tr>'

FROM sys.indexes i
JOIN sys.tables t
ON i.object_id=t.object_id
JOIN sys.all_columns as c
ON t.object_id=c.object_id
FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)')+'</table>'

;
EXECUTE msdb.dbo.sysmail_add_profile_sp
@profile_name='Sohibjon';
execute msdb.dbo.sysmail_add_account_sp
@account_name='myacc',
@email_address='dilmurodovsohibjon@gmail.com',
@mailserver_name='smtp.gmail.com',
@username='AAAA',
@password='dilmurodov';
execute msdb.dbo.sysmail_add_profileaccount_sp
@profile_name='Sohibjon',
@account_name='myacc',
@sequence_number=1;
EXEC msdb.dbo.sp_send_dbmail
        @profile_name = 'Sohibjon',
        @recipients = dilmurodov.sohibjon.06@gmail.com,
        @subject = 'SQL Server Index Metadata Report',
        @body = @html,
        @body_format = 'HTML'
