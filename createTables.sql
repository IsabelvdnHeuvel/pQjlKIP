CREATE UNLOGGED TABLE Degrees (DegreeId int, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int);
CREATE UNLOGGED TABLE Students (StudentId int, StudentName varchar(50), Address varchar(200), BirthyearStudent int, Gender char(1));
CREATE UNLOGGED TABLE StudentRegistrationsToDegrees(StudentRegistrationId int, StudentId int, DegreeId int, RegistrationYear int);
CREATE UNLOGGED TABLE Teachers (TeacherId int, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char(1));
CREATE UNLOGGED TABLE Courses (CourseId int, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS int);
CREATE UNLOGGED TABLE CourseOffers (CourseOfferId int, CourseId int, Year int, Quartile smallint);
CREATE UNLOGGED TABLE TeacherAssignmentsToCourses (CourseOfferId int, TeacherId int);
CREATE UNLOGGED TABLE StudentAssistants (CourseOfferId int, StudentRegistrationId int);
CREATE UNLOGGED TABLE CourseRegistrations (CourseOfferId int, StudentRegistrationId int, Grade int);
COPY Degrees (DegreeId, Dept, DegreeDescription, TotalECTS) FROM '/mnt/ramdisk/tables/Degrees.table' DELIMITER ',' CSV HEADER;
COPY Students (StudentId, StudentName, Address, BirthyearStudent, Gender) FROM '/mnt/ramdisk/tables/Students.table' DELIMITER ',' CSV HEADER;
COPY StudentRegistrationsToDegrees (StudentRegistrationId, StudentId, DegreeId, RegistrationYear) FROM '/mnt/ramdisk/tables/StudentRegistrationsToDegrees.table' DELIMITER ',' CSV HEADER;
COPY Teachers (TeacherId, TeacherName, Address, BirthyearTeacher, Gender) FROM '/mnt/ramdisk/tables/Teachers.table' DELIMITER ',' CSV HEADER;
COPY Courses (CourseId, CourseName, CourseDescription, DegreeId, ECTS) FROM '/mnt/ramdisk/tables/Courses.table' DELIMITER ',' CSV HEADER;
COPY CourseOffers (CourseOfferId, CourseId, Year, Quartile) FROM '/mnt/ramdisk/tables/CourseOffers.table' DELIMITER ',' CSV HEADER;
COPY TeacherAssignmentsToCourses (CourseOfferId, TeacherId) FROM '/mnt/ramdisk/tables/TeacherAssignmentsToCourses.table' DELIMITER ',' CSV HEADER;
COPY StudentAssistants (CourseOfferId, StudentRegistrationId) FROM '/mnt/ramdisk/tables/StudentAssistants.table' DELIMITER ',' CSV HEADER;
COPY CourseRegistrations (CourseOfferId, StudentRegistrationId, Grade) FROM '/mnt/ramdisk/tables/CourseRegistrations.table' DELIMITER ',' NULL'null' CSV HEADER;
ANALYZE VERBOSE;
