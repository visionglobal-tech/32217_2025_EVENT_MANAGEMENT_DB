-- =========================================================================
-- Phase V/VI: PL/SQL Automated Triggers
-- Project Name: 32217_2025_EVENT_MANAGEMENT_DB
-- Description: Automates venue capacity validation prior to finalizing a booking.
-- =========================================================================

CREATE OR REPLACE TRIGGER trg_check_venue_capacity
BEFORE INSERT ON Bookings
FOR EACH ROW
DECLARE
    v_current_bookings NUMBER;
    v_max_capacity     NUMBER;
    v_event_title      VARCHAR2(150);
BEGIN
    -- 1. Get the current number of confirmed bookings for this specific event
    SELECT COUNT(*)
    INTO v_current_bookings
    FROM Bookings
    WHERE event_id = :NEW.event_id
      AND status = 'Confirmed';

    -- 2. Get the maximum capacity allowed by the venue assigned to this event
    SELECT v.capacity, e.title
    INTO v_max_capacity, v_event_title
    FROM Events e
    JOIN Venues v ON e.venue_id = v.venue_id
    WHERE e.event_id = :NEW.event_id;

    -- 3. Business Logic: If current bookings equal or exceed capacity, throw an exception
    IF v_current_bookings >= v_max_capacity THEN
        RAISE_APPLICATION_ERROR(-20001, 
            'Booking Denied: The event "' || v_event_title || '" has already reached its maximum capacity of ' || v_max_capacity || ' seats.');
    END IF;
END;
/
