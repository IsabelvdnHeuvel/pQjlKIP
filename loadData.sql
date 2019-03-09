COPY Degrees (DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisc/tables/Degrees.table' DELIMITER ',' CSV HEADER;

COPY Students (StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/mnt/ramdisc/tables/Students.table' DELIMITER ',' CSV HEADER;

COPY StudentRegistrationsToDegrees (StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisc/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;

COPY Teachers (TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisc/tables/Teachers.table' DELIMITER ',' CSV HEADER;

COPY Courses (CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM '/mnt/ramdisc/tables/Courses.table' DELIMITER ',' CSV HEADER;

COPY CourseOffers (CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisc/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;

COPY TeacherAssignmentsToCourses (CourseOfferId, TeacherId) FROM '/mnt/ramdisc/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;

COPY StudentAssistants (CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisc/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;

COPY CourseRegistrations (CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisc/tables/CourseRegistrations.table' DELIMITER ',' CSV HEADER;


ANALYZE VERBOSE
;