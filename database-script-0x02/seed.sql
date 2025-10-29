-- ============================================================
-- 🏠 AirBnB Sample Data Insertion Script
-- ============================================================

-- NOTE: This assumes the airbnb_schema.sql has already been executed.
--       Each table uses UUID primary keys with DEFAULT uuid_generate_v4().

-- ============================================================
-- 1. USERS
-- ============================================================

INSERT INTO users (first_name, last_name, email, password_hash, phone_number, role)
VALUES
('John', 'Doe', 'john.doe@example.com', 'hashedpassword123', '+2348012345678', 'guest'),
('Mary', 'Johnson', 'mary.johnson@example.com', 'hashedpassword234', '+2348023456789', 'host'),
('Michael', 'Smith', 'michael.smith@example.com', 'hashedpassword345', '+2348034567890', 'host'),
('Admin', 'User', 'admin@airbnb.com', 'adminhash456', NULL, 'admin');

-- ============================================================
-- 2. PROPERTIES
-- ============================================================

-- Let's assume Mary Johnson (host_id = 2nd user) and Michael Smith (3rd user) are hosts.

-- We can use subqueries to fetch host_id from users by email for clarity.

INSERT INTO properties (host_id, name, description, location, pricepernight)
VALUES
((SELECT user_id FROM users WHERE email = 'mary.johnson@example.com'),
 'Ocean View Apartment',
 'A cozy apartment overlooking the ocean, perfect for vacation stays.',
 'Lagos, Nigeria',
 25000.00),

((SELECT user_id FROM users WHERE email = 'michael.smith@example.com'),
 'Downtown Studio Flat',
 'A minimalist studio apartment located in the heart of Port Harcourt.',
 'Port Harcourt, Nigeria',
 18000.00),

((SELECT user_id FROM users WHERE email = 'michael.smith@example.com'),
 'Mountain Lodge Retreat',
 'Rustic cabin surrounded by nature, ideal for weekend getaways.',
 'Jos, Nigeria',
 20000.00);

-- ============================================================
-- 3. BOOKINGS
-- ============================================================

-- Guest: John Doe makes bookings for properties hosted by Mary and Michael.

INSERT INTO bookings (property_id, user_id, start_date, end_date, total_price, status)
VALUES
((SELECT property_id FROM properties WHERE name = 'Ocean View Apartment'),
 (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
 '2025-10-01', '2025-10-05', 100000.00, 'confirmed'),

((SELECT property_id FROM properties WHERE name = 'Downtown Studio Flat'),
 (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
 '2025-11-10', '2025-11-12', 36000.00, 'pending');

-- ============================================================
-- 4. PAYMENTS
-- ============================================================

-- Payment for the confirmed booking (Ocean View Apartment)

INSERT INTO payments (booking_id, amount, payment_method)
VALUES
((SELECT booking_id FROM bookings WHERE status = 'confirmed' LIMIT 1),
 100000.00, 'credit_card');

-- ============================================================
-- 5. REVIEWS
-- ============================================================

-- John leaves reviews for the properties he booked.

INSERT INTO reviews (property_id, user_id, rating, comment)
VALUES
((SELECT property_id FROM properties WHERE name = 'Ocean View Apartment'),
 (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
 5,
 'Amazing stay! The view was breathtaking and the host was very accommodating.'),

((SELECT property_id FROM properties WHERE name = 'Downtown Studio Flat'),
 (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
 4,
 'Nice location, but the WiFi was a bit slow.');

-- ============================================================
-- 6. MESSAGES
-- ============================================================

-- John (guest) messages Mary (host), and Mary replies.

INSERT INTO messages (sender_id, recipient_id, message_body)
VALUES
((SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
 (SELECT user_id FROM users WHERE email = 'mary.johnson@example.com'),
 'Hi Mary, I just booked your Ocean View Apartment for next week!'),

((SELECT user_id FROM users WHERE email = 'mary.johnson@example.com'),
 (SELECT user_id FROM users WHERE email = 'john.doe@example.com'),
 'Hi John! Great to hear from you. Looking forward to hosting you.');

-- ============================================================

