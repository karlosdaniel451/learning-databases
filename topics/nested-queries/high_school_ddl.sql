CREATE TABLE classes (
    id SERIAL PRIMARY KEY,
    grade INTEGER NOT NULL,
    number_of_students INTEGER NOT NULL,
    teacher_id INTEGER NOT NULL/*,
    FOREIGN KEY (teacher_id) REFERENCES teacher(id)*/
);

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    GPA NUMERIC(3,2) NOT NULL,
    class_id INTEGER NOT NULL/*,
    FOREIGN KEY (class_id) REFERENCES classes(id)*/
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    monthly_salary INTEGER NOT NULL,
    class_id INTEGER/*,
    FOREIGN KEY (class_id) REFERENCES classes(id)*/
);

ALTER TABLE classes
    ADD CONSTRAINT fk_teacher FOREIGN KEY(teacher_id) REFERENCES teachers(id);

ALTER TABLE students
    ADD CONSTRAINT fk_class FOREIGN KEY(class_id) REFERENCES classes(id);

ALTER TABLE teachers 
    ADD CONSTRAINT fk_class FOREIGN KEY(class_id) REFERENCES classes(id);

