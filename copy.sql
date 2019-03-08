
COPY Degrees (DegreeID, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisc/tables/Degrees.table' DELIMITER ',' CSV HEADER;
COPY Students (StudentID, StudentName, Adress, BirthyearStudent, Gender) FROM '/mnt/ramdisc/tables/Students.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees (StudentRegistrationID, StudentID, DegreeID, RegistrationYear) FROM '/mnt/ramdisc/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;
COPY Teachers (TeacherID, TeacherName, Adress, BirthyearTeacher, Gender) FROM '/mnt/ramdisc/tables/Teachers.table' DELIMITER ',' CSV HEADER;
COPY Courses (CourseID, CourseName, CourseDescription, DegreeID, ECTS) FROM '/mnt/ramdisc/tables/Courses.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers (CourseOfferID, CourseID, Year, Quartile) FROM '/mnt/ramdisc/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses (CourseOfferID, TeacherID) FROM '/mnt/ramdisc/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants (CourseOfferID, StudentRegistrationID) FROM '/mnt/ramdisc/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations (CourseOfferID, StudentRegistrationID, Grade) FROM '/mnt/ramdisc/tables/CourseRegistrations.table' DELIMITER ',' CSV HEADER;

ANALYZE VERBOSE
