⚠️ Common inefficiencies that may appear:

Full table scans on Booking, User, or Property tables.

Sorting without an index on b.created_at.

Redundant joins returning unnecessary columns.

No filtering (WHERE clause) leading to massive joins.


✅ Expected Improvements:

Query uses index scans instead of full scans.

Execution time significantly reduced.

Sorting optimized by using the idx_booking_created_at index.

Returns only necessary columns and filtered rows.