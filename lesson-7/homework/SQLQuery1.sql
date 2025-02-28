use class7;
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);
-- Insert values into Customers table
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown');
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(4, 'Celine Jackson');

-- Insert values into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(101, 1, '2024-02-01'),
(102, 2, '2024-02-05'),
(103, 3, '2024-02-10');

-- Insert values into Products table
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(201, 'Laptop', 'Electronics'),
(202, 'Phone', 'Electronics'),
(203, 'Desk Chair', 'Furniture');

-- Insert values into OrderDetails table
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(301, 101, 201, 1, 1200.00),
(302, 102, 202, 2, 800.00),
(303, 103, 203, 1, 150.00);
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(304, 101, 203, 1, 150.00),
(305, 102, 201, 1, 1200.00),
(306, 103, 202, 2, 1850.00);

--1️ Retrieve All Customers With Their Orders (Include Customers Without Orders)
--Use an appropriate JOIN to list all customers, their order IDs, and order dates.
--Ensure that customers with no orders still appear.
SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
--2️ Find Customers Who Have Never Placed an Order
--Return customers who have no orders.
SELECT Customers.CustomerName, Orders.OrderID, Orders.OrderDate
FROM Customers
LEFT JOIN Orders
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.OrderID IS NULL;
--3️ List All Orders With Their Products
--Show each order with its product names and quantity.
SELECT OrderDetails.Quantity, Products.ProductName
FROM OrderDetails
LEFT JOIN Products
ON OrderDetails.ProductID=Products.ProductID

--4️ Find Customers With More Than One Order
--List customers who have placed more than one order.
SELECT Customers.CustomerName
FROM Orders
INNER JOIN Customers
ON Customers.CustomerID=Orders.CustomerID
INNER JOIN OrderDetails
ON Orders.OrderID=OrderDetails.OrderID
WHERE OrderDetails.Quantity>1

--5️ Find the Most Expensive Product in Each Order
SELECT od.OrderID, p.ProductName, od.Price 
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
WHERE od.Price = (SELECT MAX(Price) FROM OrderDetails WHERE OrderID = OrderDetails.OrderID);
--6️ Find the Latest Order for Each Customer
SELECT Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers
ON Customers.CustomerID=Orders.CustomerID
WHERE Orders.OrderDate=(SELECT MAX(OrderDate) FROM Orders WHERE CustomerID=Customers.CustomerID)
--7️ Find Customers Who Ordered Only 'Electronics' Products
--List customers who only purchased items from the 'Electronics' category.
SELECT Orders.OrderID, Customers.CustomerName, Products.Category
FROM Orders
INNER JOIN Customers 
ON Orders.CustomerID=Customers.CustomerID
INNER JOIN OrderDetails
ON Orders.OrderID=OrderDetails.OrderID
INNER JOIN Products 
ON OrderDetails.ProductID=Products.ProductID
WHERE Category='Electronics'


--8️ Find Customers Who Ordered at Least One 'Stationery' Product
--List customers who have purchased at least one product from the 'Stationery' category.
SELECT DISTINCT c.CustomerID, c.CustomerName 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';

--9️ Find Total Amount Spent by Each Customer
--Show CustomerID, CustomerName, and TotalSpent.
SELECT c.CustomerName, SUM(od.Price)
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerName