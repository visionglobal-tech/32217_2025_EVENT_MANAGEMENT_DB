# Phase VII: Advanced Database Programming & Security Control

This directory contains the consolidated security architecture and system verification test suites for the **32217_2025_EVENT_MANAGEMENT_DB** project.

## 1. Security Architecture & Role-Based Access Control (RBAC)
To protect data integrity, direct table access is restricted. The database implements two distinct roles:
*   **`r_event_organizer`**: Granted full operational privileges (`INSERT`, `UPDATE`, `DELETE`) over events and venues.
*   **`r_attendee_portal`**: Restricted to read-only access (`SELECT`) for discovery, and `INSERT` privileges exclusively for the bookings ledger.
*   **Stored Procedure Enforcer**: Direct booking status tampering is completely blocked; cancellations are strictly routed through the `prc_cancel_booking` procedure via explicit `GRANT EXECUTE` rights.

## 2. Automated System Verification (Test Suites)
The included anonymous PL/SQL blocks provide programmatic evaluation of the system's business rules:
1.  **Procedure Verification**: Executes `prc_cancel_booking` against an active target booking ID, ensuring data states transition to 'Cancelled' smoothly.
2.  **Trigger Stress Test**: Dynamically spins up a temporary venue with a hard capacity limit of 1 seat, logs a valid booking, and attempts a secondary overflow booking. It successfully asserts that `trg_check_venue_capacity` intercepts the breach and throws a custom application error (`-20001`).

## How to Execute the Scripts
1. Connect to your pluggable database (PDB) instance via Oracle SQL Developer.
2. Open and execute `database_programming.sql`.
3. Ensure `SERVEROUTPUT` is enabled (`SET SERVEROUTPUT ON;`) to view the real-time test execution logs and validation traces.