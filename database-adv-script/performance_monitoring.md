1. We used the EXPLAIN ANALYZE command to profile frequently executed queries in the system.

EXPLAIN ANALYZE
SELECT b.booking_id, b.start_date, b.end_date, u.user_id, u.full_name
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.start_date BETWEEN '2024-01-01' AND '2024-06-30';

Observation:

- The query performed a sequential scan on both tables.

- Cost: High (due to scanning entire bookings and users tables).

- Execution Time: ~180ms on test data (expected to grow exponentially with real data).


2. Step 2 — Identify Bottlenecks

Detected issues:

- Lack of indexes on foreign keys (user_id, property_id).

- Sequential scans for date range filters on bookings.

- Heavy aggregation on unindexed columns in reviews.

3. Step 3 — Implement Schema & Index Adjustments

-- Improve JOIN and filter performance
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
CREATE INDEX idx_properties_location ON properties(location);