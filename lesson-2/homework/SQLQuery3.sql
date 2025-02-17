create table photo (
id int, 
photo varbinary(max)
);
INSERT INTO photo (id, photo)
select 1, * from openrowset(BULK 'C:\Users\User\Downloads\birds.jpg', SINGLE_BLOB) as image_file;
