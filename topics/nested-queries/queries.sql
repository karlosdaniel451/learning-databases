--- Find all students that have above-average GPAs
SELECT *
FROM students
WHERE students.GPA > (
    SELECT AVG(students.GPA)
    FROM students
);

--- Calculate the average number of students in classes where the teacher
--- teaches History or English
SELECT AVG(classes.number_of_students)
FROM classes
WHERE classes.teacher_id IN (
    SELECT teachers.id
    FROM teachers
    WHERE teachers.subject IN ('History', 'English')
);

--- Show all information about the students in the class with the highest 
--- number of students
SELECT *
FROM students
WHERE students.class_id IN (
    SELECT classes.id
    FROM classes
    WHERE classes.number_of_students = (
        SELECT MAX(classes.number_of_students)
        FROM classes
    )
);


