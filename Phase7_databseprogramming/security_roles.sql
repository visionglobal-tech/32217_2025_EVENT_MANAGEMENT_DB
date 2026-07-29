-- =========================================================================
-- Phase VII: Security, User Access Control, and Roles
-- Project Name: 32217_2025_EVENT_MANAGEMENT_DB
-- Description: Establishes role-based privileges for application components.
-- =========================================================================

-- 1. Create Roles for Different Access Profiles
CREATE ROLE r_event_organizer;
CREATE ROLE r_attendee_portal;

-- 2. Grant Permissions to the Organizer Role
-- Organizers need to manage events and venues, and view incoming bookings
GRANT SELECT, INSERT, UPDATE, DELETE ON Events TO r_event_organizer;
GRANT SELECT, INSERT, UPDATE ON Venues TO r_event_organizer;
GRANT SELECT ON Bookings TO r_event_organizer;

-- 3. Grant Permissions to the Attendee Role
-- Attendees should only be able to browse events/venues and create their own bookings
GRANT SELECT ON Events TO r_attendee_portal;
GRANT SELECT ON Venues TO r_attendee_portal;
GRANT SELECT, INSERT ON Bookings TO r_attendee_portal;

-- 4. Restrict direct modification of Bookings status to enforce execution 
-- only via your safe Stored Procedure (prc_cancel_booking)
GRANT EXECUTE ON prc_cancel_booking TO r_attendee_portal;
GRANT EXECUTE ON prc_cancel_booking TO r_event_organizer;