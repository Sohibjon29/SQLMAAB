use class1;
DROP TABLE IF exists product;
CREATE TABLE product (
product_id int unique,
product_name varchar(100), 
price dec);
ALTER TABLE product
DROP UC_id;
ALTER TABLE product
ADD CONSTRAINT UC_id UNIQUE (product_id);