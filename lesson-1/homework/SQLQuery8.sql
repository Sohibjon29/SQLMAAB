USE class1;
CREATE TABLE books (
book_id int PRIMARY KEY IDENTITY(1, 1),
title varchar(100) not null, 
price decimal(10, 2) check(price>0),
genre varchar(100) DEFAULT 'Unknown'
)
INSERT INTO books
VALUES
('War and Peace', 3.55, 'Long Boring Drama'),
('1984', 3.55, 'Dystopian'),
('Harry Potter and the Prisoner of Azkaban', 9.54, 'Fantasy');
SELECT * from books;