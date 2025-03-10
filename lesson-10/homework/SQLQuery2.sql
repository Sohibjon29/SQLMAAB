WITH AllDays AS (
    -- Generate a table with 40 days, assuming at least one record per day
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS DayNumber
    FROM master.dbo.spt_values
    WHERE type = 'P' AND number < 40
),
ShipmentsWithZeros AS (
    -- Join with recorded shipment data, filling missing days with zero
    SELECT a.DayNumber, COALESCE(s.Num, 0) AS TractorsShipped
    FROM AllDays a
    LEFT JOIN Shipments s ON a.DayNumber = s.N
),
RankedShipments AS (
    -- Rank the rows to help find the median
    SELECT TractorsShipped, 
           ROW_NUMBER() OVER (ORDER BY TractorsShipped) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY TractorsShipped DESC) AS RowDesc
    FROM ShipmentsWithZeros
)
-- Compute the median based on even number of total days
SELECT AVG(TractorsShipped * 1.0) AS Median
FROM RankedShipments
WHERE RowAsc IN (20, 21);
