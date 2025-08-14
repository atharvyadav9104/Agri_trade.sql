-- 1. List all farmers with the crops they grow, including quantity and price.
SELECT f.Farmer_Name, c.Crop_Name, fc.Quantity_kg, fc.Price_per_kg
FROM Farmer f
JOIN Farmer_Crop fc ON f.Farmer_ID = fc.Farmer_ID
JOIN Crop c ON fc.Crop_ID = c.Crop_ID;

-- 2. Show all orders with buyer name, order date, and status.
SELECT b.Buyer_Name, om.Order_ID, om.Order_Date, om.Status
FROM Buyer b
JOIN Order_Master om ON b.Buyer_ID = om.Buyer_ID;

-- 3. List all shipments with their order IDs and shipment status.
SELECT s.Shipment_ID, om.Order_ID, s.Status
FROM Shipment s
JOIN Order_Master om ON s.Order_ID = om.Order_ID;

-- 4. Find crops purchased by each buyer with quantity.
SELECT b.Buyer_Name, c.Crop_Name, od.Quantity_kg
FROM Buyer b
JOIN Order_Master om ON b.Buyer_ID = om.Buyer_ID
JOIN Order_Details od ON om.Order_ID = od.Order_ID
JOIN Crop c ON od.Crop_ID = c.Crop_ID;

-- 5. List farmers and buyers who have traded crops.
SELECT DISTINCT f.Farmer_Name, b.Buyer_Name
FROM Farmer f
JOIN Farmer_Crop fc ON f.Farmer_ID = fc.Farmer_ID
JOIN Crop c ON fc.Crop_ID = c.Crop_ID
JOIN Order_Details od ON c.Crop_ID = od.Crop_ID
JOIN Order_Master om ON od.Order_ID = om.Order_ID
JOIN Buyer b ON om.Buyer_ID = b.Buyer_ID;

-- 6. Show orders with buyer name, destination port, and order status.
SELECT om.Order_ID, b.Buyer_Name, s.Destination_Port, om.Status
FROM Order_Master om
JOIN Buyer b ON om.Buyer_ID = b.Buyer_ID
JOIN Shipment s ON om.Order_ID = s.Order_ID;

-- 7. List all farmers and the crops they grow (even if they grow none).
SELECT f.Farmer_Name, c.Crop_Name, fc.Quantity_kg
FROM Farmer f
LEFT JOIN Farmer_Crop fc ON f.Farmer_ID = fc.Farmer_ID
LEFT JOIN Crop c ON fc.Crop_ID = c.Crop_ID;

-- 8. List all buyers and their orders (even if they have no orders).
SELECT b.Buyer_Name, om.Order_ID, om.Status
FROM Buyer b
LEFT JOIN Order_Master om ON b.Buyer_ID = om.Buyer_ID;

-- 9. Show shipments where status is 'Pending' or 'In Transit' with buyer name.
SELECT s.Shipment_ID, b.Buyer_Name, s.Status
FROM Shipment s
JOIN Order_Master om ON s.Order_ID = om.Order_ID
JOIN Buyer b ON om.Buyer_ID = b.Buyer_ID
WHERE s.Status IN ('Pending', 'In Transit');

-- 10. Find crops with a price per kg greater than 50.
SELECT f.Farmer_Name, c.Crop_Name, fc.Price_per_kg
FROM Farmer f
JOIN Farmer_Crop fc ON f.Farmer_ID = fc.Farmer_ID
JOIN Crop c ON fc.Crop_ID = c.Crop_ID
WHERE fc.Price_per_kg > 50;

-- 11. Find top 3 crops by total quantity sold.
SELECT c.Crop_Name, SUM(od.Quantity_kg) AS Total_Sold
FROM Crop c
JOIN Order_Details od ON c.Crop_ID = od.Crop_ID
GROUP BY c.Crop_Name
ORDER BY Total_Sold DESC
FETCH FIRST 3 ROWS ONLY;

-- 12. Show buyers with the number of different crops they have purchased.
SELECT b.Buyer_Name, COUNT(DISTINCT c.Crop_ID) AS Crops_Purchased
FROM Buyer b
JOIN Order_Master om ON b.Buyer_ID = om.Buyer_ID
JOIN Order_Details od ON om.Order_ID = od.Order_ID
JOIN Crop c ON od.Crop_ID = c.Crop_ID
GROUP BY b.Buyer_Name;

-- 13. Show shipments with order date, buyer name, crop name, and total quantity.
SELECT s.Shipment_ID, om.Order_Date, b.Buyer_Name, c.Crop_Name, SUM(od.Quantity_kg) AS Total_Quantity
FROM Shipment s
JOIN Order_Master om ON s.Order_ID = om.Order_ID
JOIN Buyer b ON om.Buyer_ID = b.Buyer_ID
JOIN Order_Details od ON om.Order_ID = od.Order_ID
JOIN Crop c ON od.Crop_ID = c.Crop_ID
GROUP BY s.Shipment_ID, om.Order_Date, b.Buyer_Name, c.Crop_Name;
