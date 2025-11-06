
**1. Identify High-Usage Columns**

| Table        | Column          | Usage       | Reason for Index                        |
| ------------ | --------------- | ----------- | --------------------------------------- |
| **User**     | `email`         | WHERE, JOIN | Common lookup for login/authentication  |
| **Booking**  | `user_id`       | JOIN        | Used to join users and bookings         |
| **Booking**  | `property_id`   | JOIN        | Used to join properties and bookings    |
| **Property** | `location`      | WHERE       | Used to filter searches by location     |
| **Property** | `pricepernight` | ORDER BY    | Used for sorting search results         |
| **Review**   | `property_id`   | JOIN        | Used to fetch reviews for each property |


**2. SQL — CREATE INDEX Commands**

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


**3. Measuring Performance with EXPLAIN or ANALYZE**

EXPLAIN 
SELECT * 
FROM Booking 
WHERE user_id = 'a1b2c3d4';

- ⏱ Without index → Full table scan, slower performance on large datasets.
- ✅ With index → Uses idx_booking_user_id (index scan), much faster performance.

