# course-registration-db
University Course Registration &amp; Seat Allocation Engine This project models a real university course registration system. It includes prerequisite enforcement, seat limits, and waitlisting. The focus is on database design and logic driven by constraints.

## ER Diagram
![ER Diagram](https://github.com/nonsensicalraven/course-registration-db/blob/main/design/ER_diagram.png?raw=true)

## Features
- Normalized MySQL schema (3NF+)
- Prerequisite enforcement
- Seat allocation & waitlisting
- Database-level constraints
- Analytical SQL queries

## Enrollment Logic

- Seat allocation and waitlisting are enforced using database triggers.
- Prerequisite eligibility is checked before enrollment.
- Due to MySQL trigger limitations, dropping a course and promoting the next waitlisted student is handled via a stored procedure (`drop_enrollment_and_promote`).
- This ensures transactional safety and avoids recursive trigger updates.


## Tech Stack
- Database: MySQL
- Backend: Java (JDBC)
- Frontend: HTML, CSS, JavaScript
- Design: dbdiagram.io (ER modeling)
- Tools: MySQL Workbench, GitHub

