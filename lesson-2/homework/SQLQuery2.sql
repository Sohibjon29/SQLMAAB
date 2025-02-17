use class3;
create table data_types_demo (
id uniqueidentifier unique, 
name varchar(50), 
surname nvarchar(50),
place char(50), 
city nchar(50),
net_worth BIGINT, 
age tinyint, 
year_born smallint,
day_born date, 
time datetime,
);
insert into data_types_demo
values
(newid(), 'Elon', 'Musk', 'Mar-a-Lago', 'Florida', 213000000000, 55, 1970, '1970-12-12', '1970-12-12 10:10:59');
select * from data_types_demo
