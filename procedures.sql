USE university_registration;

DELIMITER $$

CREATE PROCEDURE drop_enrollment_and_promote (
    IN p_student_id INT,
    IN p_course_id VARCHAR(10)
)
BEGIN
    DECLARE promote_id INT DEFAULT NULL;

    START TRANSACTION;

    -- Drop the enrolled student
    UPDATE enrollment
    SET status = 'DROPPED'
    WHERE student_id = p_student_id
      AND course_id = p_course_id
      AND status = 'ENROLLED';

    -- Free a seat
    UPDATE course
    SET enrolled_count = enrolled_count - 1
    WHERE course_id = p_course_id;

    -- Find next waitlisted student
    SELECT enrollment_id
    INTO promote_id
    FROM enrollment
    WHERE course_id = p_course_id
      AND status = 'WAITLISTED'
    ORDER BY enrollment_id
    LIMIT 1;

    -- Promote if exists
    IF promote_id IS NOT NULL THEN
        UPDATE enrollment
        SET status = 'ENROLLED'
        WHERE enrollment_id = promote_id;

        UPDATE course
        SET enrolled_count = enrolled_count + 1
        WHERE course_id = p_course_id;
    END IF;

    COMMIT;
END$$

DELIMITER ;
