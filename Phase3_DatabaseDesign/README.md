# Phase III: Logical Database Design (3NF)

Our data entities are structured into Third Normal Form (3NF) to maximize data integrity:
1. **Users:** Holds profile metadata (user_id [PK], name, contact info).
2. **Venues:** Tracks logistics capabilities (venue_id [PK], name, address, capacity bounds).
3. **Events:** Binds schedules to hosts and structures (event_id [PK], title, date, venue_id [FK], organizer_id [FK]).
4. **Bookings:** Relational transaction bridge tracking event enrollment (booking_id [PK], event_id [FK], attendee_id [FK], date, confirmation status).
