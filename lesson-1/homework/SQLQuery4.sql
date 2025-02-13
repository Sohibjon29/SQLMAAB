USE class1;
CREATE TABLE category (
category_id int primary key,
category_name varchar(100)
);
CREATE TABLE item (
item_id int primary key, 
item_name varchar(100),
category_id int, 
CONSTRAINT Fk_id FOREIGN KEY (category_id) REFERENCES category(category_id)
);
ALTER TABLE item 
DROP CONSTRAINT Fk_id;
ALTER TABLE item
ADD CONSTRAINT Fk_id FOREIGN KEY (category_id) REFERENCES category(category_id);