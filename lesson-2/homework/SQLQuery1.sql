use class3;
create table test_identity (
id int IDENTITY(1,1), 
name varchar(50)
)
insert into test_identity 
values ( 
'John'),
('Anna'),
('Andy'),
('Tre'), 
('Vor');
DELETE from test_identity;
--every record gets deleted id continues after 5
insert into test_identity 
values ( 
'John'),
('Anna'),
('Andy'),
('Tre'), 
('Vor');
select * from test_identity;
truncate table test_identity;
select * from test_identity;
--every row gets deleted, table stays, id renews
insert into test_identity 
values ( 
'John'),
('Anna'),
('Andy'),
('Tre'), 
('Vor');
select * from test_identity;
drop table test_identity;
insert into test_identity 
values ( 
'John'),
('Anna'),
('Andy'),
('Tre'), 
('Vor');
--table fully gets deleted TT
