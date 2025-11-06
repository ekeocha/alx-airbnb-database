The query on the large bookings table performed a sequential scan, taking a high number of milliseconds due to scanning all rows regardless of date range.

After Partitioning:
Once partitioned by start_date, PostgreSQL automatically pruned irrelevant partitions, scanning only the partition(s) containing the specified date range.
The EXPLAIN ANALYZE output showed:

Reduced I/O cost

Lower execution time (often 60–80% improvement depending on dataset size)

Better use of indexes inside each partition

Result:
✅ The partitioned table significantly improved query performance for date-based filters, especially when fetching bookings over specific months or years.