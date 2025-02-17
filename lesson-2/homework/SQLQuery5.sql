use class3;
create table worker (
id int, 
name varchar(50)
);
BULK INSERT worker
FROM 'C:\Users\User\Desktop\MAAB\SQLMAAB\lesson-2\homework\something.csv'
WITH (
firstrow=2, 
FIELDTERMINATOR=',',
ROWTERMINATOR='\n');
select * from worker


