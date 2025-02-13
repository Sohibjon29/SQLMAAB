use class1;
CREATE TABLE orders (
order_id int CONSTRAINT pk_odrder_id primary key, 
customer_name varchar, 
order_date date);
ALTER TABLE orders 
DROP pk_odrder_id;
ALTER TABLE orders
ADD CONSTRAINT pk_order_id PRIMARY KEY (order_id);


