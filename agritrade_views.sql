
-- 1. Farmers with Crops
-- ===========================
CREATE OR REPLACE VIEW vw_farmer_crops AS
SELECT f.farmer_id,
       f.farmer_name,
       c.crop_name,
       fc.quantity_kg,
       fc.price_per_kg
FROM   farmer f
JOIN   farmer_crop fc ON f.farmer_id = fc.farmer_id
JOIN   crop c         ON fc.crop_id = c.crop_id;

-- ===========================
-- 2. Buyers with Orders
-- ===========================
CREATE OR REPLACE VIEW vw_buyer_orders AS
SELECT b.buyer_id,
       b.buyer_name,
       om.order_id,
       om.order_date,
       om.total_amount
FROM   buyer b
JOIN   order_master om ON b.buyer_id = om.buyer_id;

-- ===========================
-- 3. Orders with Shipments
-- ===========================
CREATE OR REPLACE VIEW vw_order_shipments AS
SELECT s.shipment_id,
       s.order_id,
       om.buyer_id,
       om.order_date,
       s.ship_date,
       s.destination_port,
       s.status
FROM   shipment s
JOIN   order_master om ON s.order_id = om.order_id;

-- ===========================
-- 4. Farmer Sales Summary (Extra Useful View)
-- ===========================
CREATE OR REPLACE VIEW vw_farmer_sales_summary AS
SELECT f.farmer_id,
       f.farmer_name,
       SUM(fc.quantity_kg)       AS total_quantity_kg,
       SUM(fc.quantity_kg * fc.price_per_kg) AS total_sales_value
FROM   farmer f
JOIN   farmer_crop fc ON f.farmer_id = fc.farmer_id
GROUP BY f.farmer_id, f.farmer_name;

-- ===========================
-- 5. Buyer Purchase Summary (Extra Useful View)
-- ===========================
CREATE OR REPLACE VIEW vw_buyer_purchase_summary AS
SELECT b.buyer_id,
       b.buyer_name,
       COUNT(om.order_id)        AS total_orders,
       SUM(om.total_amount)      AS total_purchase_value
FROM   buyer b
JOIN   order_master om ON b.buyer_id = om.buyer_id
GROUP BY b.buyer_id, b.buyer_name;

--------------------------------------------------------------------------------
-- TESTING VIEWS
--------------------------------------------------------------------------------
SELECT * FROM vw_farmer_crops;
SELECT * FROM vw_buyer_orders;
SELECT * FROM vw_order_shipments;
SELECT * FROM vw_farmer_sales_summary;
SELECT * FROM vw_buyer_purchase_summary;

--------------------------------------------------------------------------------
-- END OF FILE
--------------------------------------------------------------------------------
