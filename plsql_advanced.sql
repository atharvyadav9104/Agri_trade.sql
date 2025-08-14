
-- Exception Handling | Cursors | Advanced Blocks

-- 1️⃣ EXCEPTION HANDLING
-------------------------------------------------

-- Q1: Handle NO_DATA_FOUND when fetching buyer name
DECLARE
    v_buyer_name VARCHAR2(100);
BEGIN
    SELECT buyer_name
    INTO v_buyer_name
    FROM buyer
    WHERE buyer_id = 999;  -- ID that does not exist

    DBMS_OUTPUT.PUT_LINE('Buyer Name: ' || v_buyer_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No buyer found for given ID.');
END;
/

-- Q2: Handle DUP_VAL_ON_INDEX for unique constraint on crop_name
BEGIN
    INSERT INTO crop (crop_id, crop_name, price_per_kg)
    VALUES (999, 'Tomato', 25);

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Duplicate crop name or ID not allowed.');
END;
/

-------------------------------------------------
-- 2️⃣ CURSORS
-------------------------------------------------

-- Q1: Explicit cursor to display all shipments
DECLARE
    CURSOR cur_shipments IS
        SELECT shipment_id, status
        FROM shipment;
    v_shipment_id shipment.shipment_id%TYPE;
    v_status shipment.status%TYPE;
BEGIN
    OPEN cur_shipments;
    LOOP
        FETCH cur_shipments INTO v_shipment_id, v_status;
        EXIT WHEN cur_shipments%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Shipment ID: ' || v_shipment_id || ', Status: ' || v_status);
    END LOOP;
    CLOSE cur_shipments;
END;
/

-- Q2: Parameterized cursor to display orders of a buyer
DECLARE
    CURSOR cur_orders(p_buyer_id NUMBER) IS
        SELECT order_id, total_amount
        FROM order_master
        WHERE buyer_id = p_buyer_id;
BEGIN
    FOR rec IN cur_orders(101)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Order ID: ' || rec.order_id || ', Total: ' || rec.total_amount);
    END LOOP;
END;
/

-------------------------------------------------
-- 3️⃣ ADVANCED PLSQL BLOCKS
-------------------------------------------------

-- Q1: Bulk Collect to fetch all crop names into a collection
DECLARE
    TYPE crop_table IS TABLE OF crop.crop_name%TYPE;
    v_crops crop_table;
BEGIN
    SELECT crop_name
    BULK COLLECT INTO v_crops
    FROM crop;

    FOR i IN 1 .. v_crops.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Crop: ' || v_crops(i));
    END LOOP;
END;
/

-- Q2: FORALL to update shipment statuses in bulk
DECLARE
    TYPE id_table IS TABLE OF shipment.shipment_id%TYPE;
    v_ids id_table := id_table(1001, 1002, 1003);
BEGIN
    FORALL i IN 1 .. v_ids.COUNT
        UPDATE shipment
        SET status = 'Processed'
        WHERE shipment_id = v_ids(i);

    DBMS_OUTPUT.PUT_LINE('Bulk update completed.');
END;
/
