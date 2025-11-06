-- ===========================
-- Indexes for the User table
-- ===========================
CREATE INDEX idx_user_email 
ON User (email);

-- ===========================
-- Indexes for the Booking table
-- ===========================
CREATE INDEX idx_booking_user_id 
ON Booking (user_id);

CREATE INDEX idx_booking_property_id 
ON Booking (property_id);

CREATE INDEX idx_booking_status 
ON Booking (status);

-- ===========================
-- Indexes for the Property table
-- ===========================
CREATE INDEX idx_property_location 
ON Property (location);

CREATE INDEX idx_property_pricepernight 
ON Property (pricepernight);

CREATE INDEX idx_property_host_id 
ON Property (host_id);

-- ===========================
-- Indexes for the Review table
-- ===========================
CREATE INDEX idx_review_property_id 
ON Review (property_id);

CREATE INDEX idx_review_user_id 
ON Review (user_id);
