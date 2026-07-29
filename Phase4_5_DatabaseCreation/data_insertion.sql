-- =========================================================================
-- Phase V: Initial Core Data Population Script
-- Project Name: 32217_2025_EVENT_MANAGEMENT_DB
-- =========================================================================

-- 1. Insert Core Users (Organizers and Attendees)
INSERT INTO Users (name, email, role) VALUES ('Alice Smith', 'alice.smith@email.com', 'Organizer');
INSERT INTO Users (name, email, role) VALUES ('Bob Gakuba', 'bob.gakuba@email.com', 'Organizer');
INSERT INTO Users (name, email, role) VALUES ('Charlie Nshuti', 'charlie.n@email.com', 'Attendee');

-- 2. Insert Core Venues
INSERT INTO Venues (name, address, capacity) VALUES ('Main Auditorium', 'Kigali Campus Hall A', 500);
INSERT INTO Venues (name, address, capacity) VALUES ('Conference Room 1', 'Gasabo Tech Center', 50);

-- 3. Insert Core Scheduled Events
-- Binds events directly to the assigned venues and organizers above
INSERT INTO Events (title, event_date, venue_id, organizer_id) 
VALUES ('Tech Innovation Summit 2026', TO_DATE('2026-08-15', 'YYYY-MM-DD'), 1, 1);

INSERT INTO Events (title, event_date, venue_id, organizer_id) 
VALUES ('Database Masterclass', TO_DATE('2026-09-01', 'YYYY-MM-DD'), 2, 2);

-- 4. Insert Attendee Seat Bookings
INSERT INTO Bookings (event_id, attendee_id, status) VALUES (1, 3, 'Confirmed');
INSERT INTO Bookings (event_id, attendee_id, status) VALUES (2, 3, 'Confirmed');

-- Commit transaction changes permanently to the database
COMMIT;
