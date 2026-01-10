SHOW TABLES;

DESCRIBE enrollment;

ALTER TABLE enrollment
ADD CONSTRAINT unique_student_course
UNIQUE (student_id, course_id);

CREATE VIEW course_waitlist_count AS
SELECT course_id, COUNT(*) AS waitlisted_students
FROM enrollment
WHERE status = 'WAITLISTED'
GROUP BY course_id;

