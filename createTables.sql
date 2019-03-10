CREATE TABLE Degrees (DegreeId int, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int);

CREATE TABLE Students (StudentId int, StudentName varchar(50), Address varchar(200), BirthyearStudent int, Gender char(1));

CREATE TABLE StudentRegistrationsToDegrees(StudentRegistrationId int, StudentId int, DegreeId int, RegistrationYear int);

CREATE TABLE Teachers (TeacherId int, TeacherName varchar(50), Address varchar(200), BirthyearTeacher int, Gender char(1));

CREATE TABLE Courses (CourseId int, CourseName varchar(50), CourseDescription varchar(200), DegreeId int, ECTS int);

CREATE TABLE CourseOffers (CourseOfferId int, CourseId int, Year int, Quartile smallint);

CREATE TABLE TeacherAssignmentsToCourses (CourseOfferId int, TeacherId int);

CREATE TABLE StudentAssistants (CourseOfferId int, StudentRegistrationId int);

CREATE TABLE CourseRegistrations (CourseOfferId int, StudentRegistrationId int, Grade int NOT NULL)
