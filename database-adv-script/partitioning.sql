-- Step 1: Create a new partitioned table based on start_date
CREATE TABLE bookings_partitioned (
    booking_id SERIAL PRIMARY KEY,
    user_id INT,
    property_id INT,
    start_date DATE NOT NULL,
    end_date DATE,
    amount DECIMAL(10,2),
    status VARCHAR(50)
)
PARTITION BY RANGE (start_date);

-- Step 2: Create partitions by year (you can adjust based on data distribution)
CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Copy data from the old bookings table to the new partitioned one
INSERT INTO bookings_partitioned (booking_id, user_id, property_id, start_date, end_date, amount, status)
SELECT booking_id, user_id, property_id, start_date, end_date, amount, status FROM bookings;

-- Step 4: Test query performance before partitioning
EXPLAIN ANALYZE
SELECT * FROM bookings
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';

-- Step 5: Test query performance after partitioning
EXPLAIN ANALYZE
SELECT * FROM bookings_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-06-30';
