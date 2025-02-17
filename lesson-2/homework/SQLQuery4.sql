use class3;
create table student_tuition (
classes int, 
tuition_per_class int, 
total_tuition AS classes*tuition_per_class);
insert into student_tuition
values 
(12, 1200), 
(23, 500), 
(10, 4000);
select * from student_tuition
