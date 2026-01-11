USE university_registration;

-- Trigger 1:
-- Automatically enroll or waitlist a student based on seat availability
DELIMITER $$

CREATE TRIGGER before_enrollment_insert
BEFORE INSERT ON enrollment
FOR EACH ROW
BEGIN
    DECLARE seats_filled INT;
    DECLARE seat_limit INT;

    SELECT enrolled_count, max_seats
    INTO seats_filled, seat_limit
    FROM course
    WHERE course_id = NEW.course_id;

    IF seats_filled < seat_limit THEN
        SET NEW.status = 'ENROLLED';
        UPDATE course
        SET enrolled_count = enrolled_count + 1
        WHERE course_id = NEW.course_id;
    ELSE
        SET NEW.status = 'WAITLISTED';
    END IF;
END$$

DELIMITER ;


-- Trigger 3:
-- Prevent enrollment if prerequisites are not satisfied
DELIMITER $$

CREATE TRIGGER before_enrollment_prereq_check
BEFORE INSERT ON enrollment
FOR EACH ROW
BEGIN
    DECLARE missing_prereqs INT;

    SELECT COUNT(*)
    INTO missing_prereqs
    FROM prerequisite p
    WHERE p.course_id = NEW.course_id
      AND NOT EXISTS (
          SELECT 1
          FROM completed_course c
          WHERE c.student_id = NEW.student_id
            AND c.course_id = p.prereq_course_id
      );

    IF missing_prereqs > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Prerequisites not satisfied';
    END IF;
END$$

DELIMITER ;



