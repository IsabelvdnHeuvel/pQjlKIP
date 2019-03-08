CREATE TABLE Degrees (DegreeID int, Dept varchar(50), DegreeDescription varchar(200), TotalECTS int);
CREATE TABLE Students (StudentID int, StudentName varchar(50), Adress varchar(200), BirthyearStudent int, Gender char(1));
CREATE TABLE StudentRegistrationsToDegrees(StudentRegistrationID int, StudentID int, DegreeID int, RegistrationYear int);
CREATE TABLE Teachers (TeacherID int, TeacherName varchar(50), Adress varchar(200), BirthyearTeacher int, Gender char(1));
CREATE TABLE Courses (CourseID int, CourseName varchar(50), CourseDescription varchar(200), DegreeID int, ECTS int);
CREATE TABLE CourseOffers (CourseOfferID int, CourseID int, Year int, Quartile smallint);
CREATE TABLE TeacherAssignmentsToCourses (CourseOfferID int, TeacherID int);
CREATE TABLE StudentAssistants (CourseOfferID int, StudentRegistrationID int);
CREATE TABLE CourseRegistrations (CourseOfferID int, StudentRegistrationID int, Grade varchar(4));
