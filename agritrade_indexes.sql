
-- FARMER RELATED INDEXES
-- ===========================
-- Farmer name search fast
CREATE INDEX idx_farmer_name ON farmer(farmer_name);

-- ===========================
-- CROP RELATED INDEXES
-- ===========================
-- Crop name search fast
CREATE INDEX idx_crop_name ON crop(crop_name);

-- ===========================
-- FARMER_CROP RELATION
-- ===========================
-- For joining Farmer → Farmer_Crop
CREATE INDEX idx_fc_farmer_id ON farmer_crop(farmer_id);

-- For joining Crop → Farmer_Crop
CREATE INDEX idx_fc_crop_id ON farmer_crop(crop_id);

-- ===========================
-- BUYER RELATED INDEXES
-- ===========================
-- Buyer name search fast
CREATE INDEX idx_buyer_name ON buyer(buyer_name);

-- ===========================
-- ORDER RELATED INDEXES
-- ===========================
-- For joining Buyer → Order_Master
CREATE INDEX idx_om_buyer_id ON order_master(buyer_id);

-- For filtering orders by date
CREATE INDEX idx_om_order_date ON order_master(order_date);

-- ===========================
-- ORDER_DETAILS RELATION
-- ===========================
-- For joining Order_Master → Order_Details
CREATE INDEX idx_od_order_id ON order_details(order_id);

-- For joining Crop → Order_Details
CREAT
