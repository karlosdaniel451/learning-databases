INSERT INTO
    teachers (name, subject, monthly_salary, class_id)
VALUES 
    ('Elisabeth Grey', 'History', 2500, NULL),
    ('Robert Sun', 'Literature', 2000, NULL),
    ('John Churchill', 'English', 2350, NULL),
    ('Sara Parker ', 'Math', 3000, NULL);

INSERT INTO
    classes (grade, teacher_id, number_of_students)
VALUES
    (10, 3, 21),
    (11, 4, 25),
    (12, 1, 28);

UPDATE teachers
SET class_id = 3
WHERE id = 1;

UPDATE teachers
SET class_id = 1
WHERE id = 3;

UPDATE teachers
SET class_id = 2
WHERE id = 4;

INSERT INTO
    students (name, GPA, class_id)
VALUES
    ('Jack Black', 3.45, 3),
    ('Daniel White', 3.15, 1),
    ('Kathrine Star', 3.85, 1),
    ('Helen Bright', 3.10, 2),
    ('Steve May', 2.40, 2);

