USE class3;
SELECT Category, MAX(Price) AS MostExpensive
FROM Products
GROUP BY Category;
SELECT *,
IIF (Stock=0, 'Out of Stock',
	IIF (Stock<11, 'Low Stock', 'In Stock')) AS Status
FROM Products
ORDER BY  Price DESC
OFFSET 5 ROWS;

