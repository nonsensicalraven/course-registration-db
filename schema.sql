CREATE DATABASE university_registration;
USE university_registration;

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    program VARCHAR(50),
    year INT,
    cgpa DECIMAL(3,2)
);

CREATE TABLE course (
    course_id VARCHAR(10) PRIMARY KEY,
    title VARCHAR(100),
    credits INT,
    max_seats INT,
    semester VARCHAR(20)
);

CREATE TABLE enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id VARCHAR(10),
    status VARCHAR(20),
    timestamp DATETIME,
    waitlist_position INT,
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE completed_course (
    student_id INT,
    course_id VARCHAR(10),
    grade VARCHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE prerequisite (
    course_id VARCHAR(10),
    prereq_course_id VARCHAR(10),
    PRIMARY KEY (course_id, prereq_course_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (prereq_course_id) REFERENCES course(course_id)
);

