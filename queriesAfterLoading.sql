SELECT CO.CourseOfferId, CO.CourseId, CO.Year, CO.Quartile, C.CourseName, C.CourseDescription, C.DegreeId, C.ECTS, D.Dept, D.DegreeDescription, D.TotalECTS, T.TeacherId, T.TeacherName, T.Address, T.BirthyearTeacher, T.Gender FROM CourseOffers CO, Courses C, Degrees D, Teachers T, TeacherAssignmentsToCourses TAC WHERE TAC.CourseOfferId = 1 AND CO.CourseOfferId = 1 AND TAC.TeacherId = T.TeacherId AND CO.CourseId = C.CourseId AND C.DegreeId = D.DegreeId;
SELECT CO.CourseOfferId, CO.CourseId, CO.Year, CO.Quartile, S.StudentId, S.StudentName, S.Address, S.BirthyearStudent, S.Gender, D.DegreeId, D.Dept, D.DegreeDescription, D.TotalECTS FROM CourseOffers CO, Students S, StudentAssistants SA, Degrees D, StudentRegistrationsToDegrees SRD WHERE SA.StudentRegistrationId = 3 AND SRD.StudentRegistrationId = 3 AND S.StudentId = SRD.StudentId AND SRD.DegreeId = D.DegreeId AND CO.CourseOfferId = SA.CourseOfferId;
SELECT AVG(Grade)*1.0 FROM CourseRegistrations WHERE StudentRegistrationId = 3;
