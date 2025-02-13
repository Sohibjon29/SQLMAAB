use class1;
CREATE TABLE account (
account_id int, 
balance dec, 
account_type varchar(50),
CONSTRAINT PK_id PRIMARY KEY (account_id), 
CONSTRAINT C_balance CHECK (balance>0),
CONSTRAINT C_acc_type CHECK (account_type='Checking' or account_type='Saving')
);
ALTER TABLE account
DROP CONSTRAINT Pk_id, C_balance, C_acc_type;
ALTER TABLE account
ADD CONSTRAINT PK_id PRIMARY KEY (account_id);
ALTER TABLE account
ADD CONSTRAINT C_balance CHECK (balance>0);
ALTER TABLE account
ADD CONSTRAINT C_acc_type CHECK (account_type='Checking' or account_type='Saving');