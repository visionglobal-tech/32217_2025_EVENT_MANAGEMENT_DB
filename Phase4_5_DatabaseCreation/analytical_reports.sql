-- =========================================================================
-- Phase VI: Analytical Reports using Window Functions
-- Project Name: 32217_2025_EVENT_MANAGEMENT_DB
-- Description: Measures attendee densities and ranks events by total signups.
-- =========================================================================

-- Report 1: Event Popularity Rank (Dense Rank Window Function)
-- Ranks events based on the total number of confirmed bookings, highest to lowest.
SELECT 
    e.event_id,
    e.title AS event_title,
    v.venue_name,
    COUNT(b.booking_id) AS total_bookings,
    DENSE_RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS popularity_rank
FROM Events e
LEFT JOIN Venues v ON e.venue_id = v.venue_id
LEFT JOIN Bookings b ON e.event_id = b.event_id AND b.status = 'Confirmed'
GROUP BY e.event_id, e.title, v.venue_name;


-- Report 2: Booking Running Totals over Time (Partitioned Running Sum)
-- Tracks registration velocity by calculating cumulative bookings for each event chronologically.
SELECT 
    b.booking_id,
    e.title AS event_title,
    b.booking_date,
    COUNT(b.booking_id) OVER (
        PARTITION BY b.event_id 
        ORDER BY b.booking_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_bookings_to_date
FROM Bookings b
JOIN Events e ON b.event_id = e.event_id
WHERE b.status = 'Confirmed';