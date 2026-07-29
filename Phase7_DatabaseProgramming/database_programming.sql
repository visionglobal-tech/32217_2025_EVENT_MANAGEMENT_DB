-- =========================================================================
-- Phase VII: Advanced Database Programming & Security Control
-- Project Name: 32217_2025_EVENT_MANAGEMENT_DB
-- =========================================================================

-- =========================================================================
-- SECTION 1: Security, User Access Control, and Roles
-- =========================================================================

-- 1. Create Roles for Different Access Profiles
CREATE ROLE r_event_organizer;
CREATE ROLE r_attendee_portal;

-- 2. Grant Permissions to the Organizer Role
GRANT SELECT, INSERT, UPDATE, DELETE ON Events TO r_event_organizer;
GRANT SELECT, INSERT, UPDATE ON Venues TO r_event_organizer;
GRANT SELECT ON Bookings TO r_event_organizer;

-- 3. Grant Permissions to the Attendee Role
GRANT SELECT ON Events TO r_attendee_portal;
GRANT SELECT ON Venues TO r_attendee_portal;
GRANT SELECT, INSERT ON Bookings TO r_attendee_portal;

-- 4. Restrict direct booking tampering by forcing execution via Stored Procedure
GRANT EXECUTE ON prc_cancel_booking TO r_attendee_portal;
GRANT EXECUTE ON prc_cancel_booking TO r_event_organizer;


-- =========================================================================
-- SECTION 2: System Verification Test Suite (Anonymous PL/SQL Blocks)
-- =========================================================================
SET SERVEROUTPUT ON;

-- TEST CASE 1: Verifying the Stored Procedure (prc_cancel_booking)
DECLARE
    v_target_booking NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- START TEST 1: Booking Cancellation ---');
    
    SELECT MIN(booking_id) INTO v_target_booking FROM Bookings WHERE status = 'Confirmed';
    
    IF v_target_booking IS NOT NULL THEN
        prc_cancel_booking(p_booking_id => v_target_booking);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Test Skipped: No confirmed bookings found to test cancellation.');
    END IF;
END;
/

-- TEST CASE 2: Verifying the Capacity Violation Trigger (trg_check_venue_capacity)
DECLARE
    v_small_venue_id NUMBER;
    v_test_event_id  NUMBER;
    v_attendee_id    NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- START TEST 2: Capacity Limit Violations ---');
    
    -- Provision a small venue with a limitation of 1 seat
    INSERT INTO Venues (name, address, capacity) 
    VALUES ('Micro Test Lab', 'Testing Suite X', 1)
    RETURNING venue_id INTO v_small_venue_id;

    -- Create a dummy event linked to this venue
    INSERT INTO Events (title, event_date, venue_id, organizer_id) 
    VALUES ('Capacity Failure Test Run', SYSDATE + 5, v_small_venue_id, 1)
    RETURNING event_id INTO v_test_event_id;

    SELECT MIN(user_id) INTO v_attendee_id FROM Users WHERE role = 'Attendee';

    -- First booking execution (Consumes the 1 available seat)
    INSERT INTO Bookings (event_id, attendee_id, status) VALUES (v_test_event_id, v_attendee_id, 'Confirmed');
    DBMS_OUTPUT.PUT_LINE('Seat 1 reserved successfully.');

    -- Second booking execution (Should intentionally breach capacity bounds and trigger exception)
    BEGIN
        INSERT INTO Bookings (event_id, attendee_id, status) VALUES (v_test_event_id, v_attendee_id, 'Confirmed');
        DBMS_OUTPUT.PUT_LINE('CRITICAL ERROR: System failed to block the overbooking!');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('SUCCESS: Trigger blocked the overflow booking.');
            DBMS_OUTPUT.PUT_LINE('Oracle Error Trace: ' || SQLERRM);
    END;
    
    -- Clean up test structure environment data
    ROLLBACK;
END;
/