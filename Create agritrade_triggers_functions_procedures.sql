-- ==============================
-- PLSQL OBJECTS FILE
-- Triggers | Functions | Procedures
-- ==============================

-------------------------------------------------
-- 1️⃣ TRIGGERS
-------------------------------------------------

-- Q1: Create a trigger to log changes in the shipment status table
CREATE OR REPLACE TRIGGER trg_shipment_status_log
AFTER UPDATE OF status ON shipment
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('Shipment ID ' || :OLD.shipment_id || 
                         ' status changed from ' || :OLD.status || 
                         ' to ' || :NEW.status);
END;
/

-- Q2: Create a trigger to prevent inserting farmer_crop with negative quantity
CREATE OR REPLACE TRIGGER trg_check_quantity
BEFORE INSERT OR UPDATE ON farmer_crop
FOR EACH ROW
BEGIN
    IF :NEW.area_acres < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Quantity (area_acres) cannot be negative.');
    END IF;
END;
/

-------------------------------------------------
-- 2️⃣ FUNCTIONS
-------------------------------------------------

-- Q1: Function to calculate total orders of a buyer
CREATE OR REPLACE FUNCTION fn_total_orders(p_buyer_id NUMBER)
RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_total
    FROM order_master
    WHERE buyer_id = p_buyer_id;

    RETURN v_total;
END;
/

-- Test
BEGIN
    DBMS_OUTPUT.PUT_LINE('Total Orders: ' || fn_total_orders(101));
END;
/

-- Q2: Function to get crop price by name
CREATE OR REPLACE FUNCTION fn_get_crop_price(p_crop_name VARCHAR2)
RETURN NUMBER
IS
    v_price NUMBER;
BEGIN
    SELECT price_per_kg
    INTO v_price
    FROM crop
    WHERE crop_name = p_crop_name;

    RETURN v_price;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/

-------------------------------------------------
-- 3️⃣ PROCEDURES
-------------------------------------------------

-- Q1: Procedure to update shipment status
CREATE OR REPLACE PROCEDURE pr_update_shipment_status(
    p_shipment_id NUMBER,
    p_status VARCHAR2
)
AS
BEGIN
    UPDATE shipment
    SET status = p_status
    WHERE shipment_id = p_shipment_id;

    DBMS_OUTPUT.PUT_LINE('Shipment ' || p_shipment_id || ' updated to status: ' || p_status);
END;
/

-- Test
BEGIN
    pr_update_shipment_status(1001, 'Delivered');
END;
/

-- Q2: Procedure to display farmer's crops
CREATE OR REPLACE PROCEDURE pr_show_farmer_crops(
    p_farmer_id NUMBER
)
AS
BEGIN
    FOR rec IN (
        SELECT c.crop_name, fc.area_acres, c.price_per_kg
        FROM farmer_crop fc
        JOIN crop c ON fc.crop_id = c.crop_id
        WHERE fc.farmer_id = p_farmer_id
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Crop: ' || rec.crop_name || 
                             ', Area: ' || rec.area_acres || 
                             ', Price: ' || rec.price_per_kg);
    END LOOP;
END;
/

-- Test
BEGIN
    pr_show_farmer_crops(1);
END;
/
