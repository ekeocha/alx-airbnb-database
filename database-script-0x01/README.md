✅ **Key Design Features**

- UUID primary keys ensure global uniqueness across distributed systems.

- Foreign key constraints maintain referential integrity (e.g., bookings tied to properties and users).

- CHECK constraints enforce valid ENUM-like values for role, status, and payment_method.

- ON DELETE CASCADE ensures related records are automatically removed when parent entities are deleted.

- Indexes on critical lookup fields (email, property_id, booking_id, etc.) improve query performance.

- All data types and relationships align with 3NF principles.