# Event Management System Database Project
**Project Repository:** `32217_2025_EVENT_MANAGEMENT_DB`

## 📌 Project Overview
This repository contains the complete end-to-end relational database implementation lifecycle for a comprehensive **Event Management System**. Built on **Oracle 21c Express Edition**, the database is engineered to handle core entities including Users, Venues, Events, and Bookings. The architecture ensures strict transactional integrity, role-based security, automated capacity management, and analytical business intelligence reporting.

---

## 📂 Repository Structure & Phases

The project codebase is strictly structured into the following operational implementation phases:

### 📁 [Phase 1: Problem Statement](./Phase1_ProblemStatement/)
*   Establishes the foundational scope, functional requirements, and core business problems addressed by the system lifecycle.

### 📁 [Phase 2: Business Modeling](./Phase2_BusinessModeling/)
*   Outlines real-world structural entities, strategic constraints, data flows, and contextual operational processes.

### 📁 [Phase 3: Database Design](./Phase3_DatabaseDesign/)
*   Houses the completed Entity-Relationship (ER) Diagrams, structural mappings, and logical data definitions.

### 📁 [Phase 4 & 5: Database Creation & Data Insertion](./Phase4_5_DatabaseCreation/)
*   **`schema_setup.sql`**: Full DDL script establishing relational tables, integrity constraints, primary keys, and foreign keys.
*   **`data_insertion.sql`**: Script populating initial core datasets (Organizers, Attendees, Venues, Events, and Bookings) wrapped in explicit transaction blocks.
*   **`capacity_trigger.sql`**: PL/SQL automated trigger (`BEFORE INSERT`) validating venue seat bounds dynamically.
*   **`cancel_booking_procedure.sql`**: Stored procedure handling safe transactional status updates and verification constraints.
*   **`analytical_reports.sql`**: Advanced SQL analysis queries applying window functions (`DENSE_RANK() OVER`, `COUNT() OVER`) to extract real-time data metrics.

### 📁 [Phase 7: Database Programming](./Phase7_DatabaseProgramming/)
*   **`database_programming.sql`**: A consolidated master programming asset uniting:
    *   *Security Controls*: Role-Based Access Control configurations (`r_event_organizer`, `r_attendee_portal`) and structural execution filters.
    *   *System Test Suites*: Automated PL/SQL Anonymous Blocks validating error-trapping behaviors, procedural status updates, and capacity breach protections.

---

## 🚀 Getting Started & Execution

### Prerequisites
*   **Database Engine**: Oracle 21c Express Edition (configured pluggable database PDB environment).
*   **Interface**: Oracle SQL Developer or equivalent CLI client.

### Deployment Instructions
1. Clone the repository locally or navigate to your local tracking directory.
2. Connect to your Oracle database instance.
3. Run the schema creation file from `Phase4_5_DatabaseCreation/schema_setup.sql`.
4. Run the data population script from `Phase4_5_DatabaseCreation/data_insertion.sql`.
5. Compile the triggers and procedures, then execute the master suite in `Phase7_DatabaseProgramming/database_programming.sql` to verify environment defenses.

---
*Developed under global compliance specifications for relational database architecture metrics.*