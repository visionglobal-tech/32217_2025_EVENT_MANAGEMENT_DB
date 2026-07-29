-- =========================================================================
-- Phase V/VI: PL/SQL Stored Procedures
-- Project Name: 32217_2025_EVENT_MANAGEMENT_DB
-- Description: Safely handles booking cancellations with data validation.
-- =========================================================================

CREATE OR REPLACE PROCEDURE prc_cancel_booking (
    p_booking_id IN NUMBER
) IS
    v_exists       NUMBER;
    v_current_stat VARCHAR2(20);
BEGIN
    -- 1. Validation: Verify if the booking record actually exists
    SELECT COUNT(*), MAX(status)
    INTO v_exists, v_current_stat
    FROM Bookings
    WHERE booking_id = p_booking_id
    GROUP BY booking_id;

    IF v_exists = 0 OR v_exists IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Cancellation Error: Booking ID ' || p_booking_id || ' does not exist.');
    END IF;

    -- 2. Validation: Check if the booking is already cancelled
    IF v_current_stat = 'Cancelled' THEN
        RAISE_APPLICATION_ERROR(-20003, 'Cancellation Error: Booking ID ' || p_booking_id || ' is already cancelled.');
    END IF;

    -- 3. Execution: Update the booking status safely
    UPDATE Bookings
    SET status = 'Cancelled'
    WHERE booking_id = p_booking_id;

    -- 4. Save Transaction
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Success: Booking ID ' || p_booking_id || ' has been successfully cancelled.');

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback any partial transaction updates if an unexpected failure occurs
        ROLLBACK;
        RAISE;
END prc_cancel_booking;
/
