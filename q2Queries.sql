WITH CourseRegistrations2 (CourseOfferId, Grade) AS (SELECT CourseOfferId, Grade FROM NewCR WHERE StudentId=%1% AND StudentRegistrationId IN (SELECT StudentRegistrationId FROM StudentRegistrationsToDegrees WHERE DegreeId=%2%) AND Grade>=5) SELECT Courses.CourseName, CourseRegistrations2.Grade FROM Courses, CourseOffers, CourseRegistrations2 WHERE Courses.CourseId IN (SELECT CourseId FROM CourseOffers WHERE CourseOffers.CourseOfferId=CourseRegistrations2.CourseOfferId) ORDER BY CourseOffers.Year, CourseOffers.Quartile, CourseOffers.CourseOfferID;
WITH CRR(StudentRegistrationId) AS (SELECT DISTINCT(NewCR.StudentRegistrationId) FROM NewCR, Courses C, ECTS E, StudentRegistrationsToDegrees SRD WHERE NewCR.StudentRegistrationId = SRD.StudentRegistrationId AND NewCR.StudentRegistrationId = E.StudentRegistrationId AND NewCR.CourseId = C.CourseId GROUP BY CR.StudentRegistrationId HAVING AVG((NewCR.Grade*C.ECTS)/E.sumECTS)>9) SELECT DISTINCT(StudentId) FROM StudentRegistrationsToDegrees SRD, CRR WHERE CRR.StudentRegistrationId = SRD.StudentRegistrationId AND NOT EXISTS (SELECT CR.StudentRegistrationId FROM CourseRegistrations CR WHERE CR.StudentRegistrationId = SRD.StudentRegistrationId AND CR.Grade<5) ORDER BY StudentId;
WITH FS (StudentId, DegreeId, sumECTS) AS (SELECT NewCR.StudentId, SRD.DegreeId SUM(C.ECTS) FROM NewCR, Courses C, StudentRegistrationsToDegrees SRD WHERE Grade>=5 AND StudentId IN (SELECT StudentId FROM Students WHERE Gender='F') AND C.CourseId = NewCR.CourseId AND SRD.StudentRegistrationId = NewCR.StudentRegistrationId GROUP BY SRD.DegreeId, SRD.StudentId, SRD.StudentRegistrationId) SELECT FS.DegreeId, (COUNT(FS.StudentId) * 100.0 / (SELECT COUNT(*) FROM StudentRegistrationsToDegrees SRD WHERE SRD.DegreeId=FS.DegreeId)) AS percentage FROM FS, Degrees D WHERE FS.DegreeId = D.DegreeId AND FS.sumECTS < D.TotalECTS GROUP BY FS.DegreeId ORDER BY FS.DegreeId;
WITH FemaleStudents(sumfemstud) AS (SELECT SUM(S.StudentId) FROM Students S, Degrees D, StudentRegistrationsToDegrees SRD WHERE S.StudentId = SRD.StudentId AND D.DegreeId = SRD.DegreeId AND D.Dept = %1% AND S.Gender = 'F'), AllStudents(sumallstud) AS (SELECT SUM(S.StudentId) FROM Students S, Degrees D, StudentRegistrationsToDegrees SRD WHERE S.StudentId = SRD.StudentId AND D.DegreeId = SRD.DegreeId AND D.Dept = %1%) SELECT (F.sumfemstud / A.sumallstud * 100.0) AS percentage FROM FemaleStudents F, Allstudents A;
WITH PassingStudent(CourseId, sumStudentId) AS (SELECT CO.CourseId, COUNT(SRD.StudentId) FROM CourseRegistrations CR, StudentRegistrationsToDegrees SRD, CourseOffers CO WHERE CR.StudentRegistrationId = SRD.StudentRegistrationId AND CO.CourseOfferId = CR.CourseOfferId AND CR.Grade >= %1% GROUP BY CO.CourseId), EveryStudent(CourseId, everyStudentId) AS (SELECT CO.CourseId, COUNT(SRD.StudentId) FROM CourseRegistrations CR, StudentRegistrationsToDegrees SRD, CourseOffers CO WHERE CR.StudentRegistrationId = SRD.StudentRegistrationId AND CO.CourseOfferId = CR.CourseOfferId GROUP BY CO.CourseId) SELECT P.CourseId, (P.sumStudentId/E.everyStudentId * 100.0) as percentagePassing FROM PassingStudent P, EveryStudent E WHERE P.CourseId = E.CourseId;
WITH HighestGrade(CourseOfferId, Grade) AS (SELECT CR.CourseOfferId, MAX(CR.Grade) FROM CourseRegistrations CR, CourseOffers CO WHERE CR.CourseOfferId = CO.CourseOfferId AND CO.year = 2018 AND CO.Quartile = 1 GROUP BY CR.CourseOfferId) SELECT SRD.StudentId, COUNT(SRD.StudentId) FROM HighestGrade HG, CourseRegistrations CR, StudentRegistrationsToDegrees SRD WHERE CR.StudentRegistrationId = SRD.StudentRegistrationId AND CR.CourseOfferId = HG.CourseOfferId AND HG.Grade = CR.Grade GROUP BY SRD.StudentId HAVING COUNT (SRD.StudentId) >= %1%;
SELECT 0;
WITH RequiredSA (CourseOfferId, numberSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationdId)/50 FROM CourseRegistrations GROUP BY CourseOfferId), ActualSA(CourseOfferId, realSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId) FROM StudentAssistants GROUP BY CourseOfferId) SELECT C.CourseName, CO.year, CO.quartile FROM RequiredSA R, ActualSA A, CourseOffers CO, Courses C WHERE R.CourseOfferId = A.CourseOfferId AND R.numberSAS > A.realSAS AND CO.CourseOfferId = A.CourseOfferId AND CO.CourseId = C.CourseId ORDER BY CO.CourseOfferId;
