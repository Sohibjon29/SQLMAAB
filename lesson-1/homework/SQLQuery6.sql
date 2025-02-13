USE class1;
CREATE TABLE customer(
customer_id int CONSTRAINT Pk_cust_id PRIMARY KEY , 
name varchar(50),
city varchar(50) CONSTRAINT DEf_city DEFAULT 'Unknown'
);
ALTER TABLE customer
DROP CONSTRAINT DEf_city;
ALTER TABLE customer
ADD CONSTRAINT Def_city DEFAULT 'Unknown' FOR city;