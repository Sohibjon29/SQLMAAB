USE class1;
CREATE TABLE invoice (
invoice_id int IDENTITY (1, 1),
amount dec
);
INSERT INTO invoice (amount)
VALUES
(3.5),
(4.6), 
(21.20),
(23.40),
(34.43);
SET IDENTITY_INSERT invoice ON;
INSERT INTO invoice (invoice_id, amount)
VALUES (100, 45.30);
SET IDENTITY_INSERT invoice OFF;

