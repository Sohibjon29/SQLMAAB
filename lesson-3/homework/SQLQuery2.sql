USE class3;
SELECT
	CASE 
		WHEN Status='Shipped' OR Status='Delivered' THEN 'Completed'
		WHEN Status='Pending' THEN 'Pending'
		WHEN Status='Cancelled' THEN 'Cancelled'
	END
	AS OrderStatus, 
	Count(OrderID) AS TotalOrders,
	SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31' AND TotalAmount>5000
GROUP BY CASE 
		WHEN Status='Shipped' OR Status='Delivered' THEN 'Completed'
		WHEN Status='Pending' THEN 'Pending'
		WHEN Status='Cancelled' THEN 'Cancelled'
	END
ORDER BY TotalRevenue;

