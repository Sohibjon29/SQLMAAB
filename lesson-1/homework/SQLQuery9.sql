use class1;
CREATE TABLE Book (
book_id int primary key, 
title varchar(100),
author varchar(100), 
published_year int
);
CREATE TABLE Member (
member_id int primary key,
name varchar (100),
email varchar (100),
phone_number varchar(20)
);
CREATE TABLE Loan (
loan_id int primary key,
book_id int foreign key REFERENCES Book(book_id),
member_id int foreign key REFERENCES Member(member_id), 
loan_date date, 
return_date date NULL
);
INSERT INTO Book
VALUES 
(1, 'Al Muqaddimah', 'ibn Khaldun', 1377),
(2, 'War and Peace', 'Leo Tolstoy', 1898), 
(3, 'Chameleon', 'Anton Chekhov', 1900);
INSERT INTO Member
VALUES
(1, 'Sohibjon', 'dilmurodov@gmail.com', '+998998294210'), 
(2, 'Mom', 'my_mom@gmail.com', '+998901234567');
INSERT INTO Loan
VALUES 
(1, 3, 2, '2024-02-02', '2026-03-04'),
(2, 2, 2, '2022-03-02', '2025-06-02');