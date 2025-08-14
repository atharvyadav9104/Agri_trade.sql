
-- Q1: Find farmers who sell crops above the average price
--------------------------------------------------------------------------------
SELECT f.farmer_name
FROM farmer f
WHERE f.farmer_id IN (
    SELECT fc.farmer_id
    FROM farmer_crop fc
    WHERE fc.price_per_kg > (SELECT AVG(price_per_kg) FROM farmer_crop)
);

--------------------------------------------------------------------------------
-- Q2: List crops grown by the farmer with the maximum quantity of any crop
--------------------------------------------------------------------------------
SELECT crop_name
FROM crop
WHERE crop_id IN (
    SELECT crop_id
    FROM farmer_crop
    WHERE quantity_kg = (
        SELECT MAX(quantity_kg)
        FROM farmer_crop
    )
);

--------------------------------------------------------------------------------
-- Q3: Find buyers who have never placed an order
--------------------------------------------------------------------------------
SELECT buyer_name
FROM buyer b
WHERE b.buyer_id NOT IN (
    SELECT buyer_id
    FROM order_master
);

--------------------------------------------------------------------------------
-- Q4: Show order IDs where shipment status is 'Pending'
--------------------------------------------------------------------------------
SELECT order_id
FROM shipment
WHERE status = 'Pending.';

--------------------------------------------------------------------------------
-- Q5: Find orders whose total quantity is above the average order quantity
--------------------------------------------------------------------------------
SELECT order_id
FROM order_details
GROUP BY order_id
HAVING SUM(quantity_kg) > (
    SELECT AVG(total_qty)
    FROM (
        SELECT SUM(quantity_kg) AS total_qty
        FROM order_details
        GROUP BY order_id
    )
);

--------------------------------------------------------------------------------
-- Q6: List farmers who have supplied crops in orders shipped to 'Chennai port tamil nadu'
--------------------------------------------------------------------------------
SELECT DISTINCT f.farmer_name
FROM farmer f
WHERE f.farmer_id IN (
    SELECT fc.farmer_id
    FROM farmer_crop fc
    WHERE fc.crop_id IN (
        SELECT od.crop_id
        FROM order_details od
        WHERE od.order_id IN (
            SELECT s.order_id
            FROM shipment s
            WHERE LOWER(s.destination_port) = 'chennai port tamil nadu'
        )
    )
);

--------------------------------------------------------------------------------
-- Q7: Find the latest shipment date for each buyer
--------------------------------------------------------------------------------
SELECT b.buyer_name,
       (SELECT MAX(s.ship_date)
        FROM shipment s
        JOIN order_master om ON om.order_id = s.order_id
        WHERE om.buyer_id = b.buyer_id) AS latest_shipment_date
FROM buyer b;

--------------------------------------------------------------------------------
-- Q8: Correlated subquery - Find crops where price per kg is higher than
--      the average price of that crop across all farmers
--------------------------------------------------------------------------------
SELECT DISTINCT c.crop_name
FROM crop c
JOIN farmer_crop fc ON fc.crop_id = c.crop_id
WHERE fc.price_per_kg > (
    SELECT AVG(price_per_kg)
    FROM farmer_crop
    WHERE crop_id = c.crop_id
);

--------------------------------------------------------------------------------
-- Q9: Find farmers who grow at least one crop that is also grown by 'Farmer A'
--------------------------------------------------------------------------------
SELECT DISTINCT f.farmer_name
FROM farmer f
WHERE f.farmer_id IN (
    SELECT fc.farmer_id
    FROM farmer_crop fc
    WHERE fc.crop_id IN (
        SELECT crop_id
        FROM farmer_crop
        WHERE farmer_id = (
            SELECT farmer_id
            FROM farmer
            WHERE LOWER(farmer_name) = 'farmer a'
        )
    )
)
AND LOWER(f.farmer_name) <> 'farmer a';

--------------------------------------------------------------------------------
-- Q10: Find buyers who have ordered all crops grown by 'Farmer B'
--------------------------------------------------------------------------------
SELECT b.buyer_name
FROM buyer b
WHERE NOT EXISTS (
    SELECT crop_id_
