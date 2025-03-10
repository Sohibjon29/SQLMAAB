DECLARE @MissingOrders TABLE
(
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);
INSERT INTO @MissingOrders
SELECT db1.OrderID, db1.CustomerName, db1.Product, db1.Quantity
FROM Orders_DB1 as db1
LEFT JOIN Orders_DB2 as db2
ON db1.OrderID=db2.OrderID
WHERE db2.OrderID IS NULL
