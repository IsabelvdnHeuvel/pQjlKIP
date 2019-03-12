--SELECT c.CourseName, cr.grade FROM Courses C, CourseOffers CO, StudentRegistrationsToDegrees STD, NewCR CR WHERE CR.StudentId=%1% AND STD.DegreeId=%2% AND CR.studentregistrationId = STD.studentregistrationId AND C.courseid = CR.courseid AND CR.grade >= 5.0 AND Cr.grade IS NOT NULL ORDER BY CO.year, CO.quartile, CO.courseofferid;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT (cast(SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(s.Gender)) as percentage FROM Students s INNER JOIN StudentRegistrationsToDegrees srd on (s.StudentId = srd.StudentId) INNER JOIN Degrees d on (srd.DegreeId = d.DegreeId) WHERE (d.Dept =  %1%);
WITH PassingStudent(CourseId, sumStudentId) AS (SELECT CO.CourseId, cast(COUNT(cr.studentregistrationid) as decimal) FROM CourseRegistrations CR, CourseOffers CO WHERE CO.CourseOfferId = CR.CourseOfferId AND CR.Grade >= %1% GROUP BY CO.CourseId ), EveryStudent(CourseId, everyStudentId) AS (SELECT CO.CourseId, cast(COUNT(cr.studentregistrationid) as decimal) FROM CourseRegistrations CR, CourseOffers CO WHERE CO.CourseOfferId = CR.CourseOfferId AND (CR.Grade IS NOT NULL) GROUP BY CO.CourseId ) SELECT p.CourseId, (P.sumStudentId / E.everyStudentId) as percentagePassing FROM PassingStudent P, EveryStudent E WHERE P.CourseId = E.CourseId
WITH HighestGrade(CourseOfferId, Grade) AS (SELECT CR.CourseOfferId, MAX(CR.Grade) FROM CourseRegistrations CR, CourseOffers CO WHERE CR.CourseOfferId = CO.CourseOfferId AND CO.year = 2018 AND CO.Quartile = 1 GROUP BY CR.CourseOfferId) SELECT SRD.StudentId, COUNT(SRD.StudentId) FROM HighestGrade HG, CourseRegistrations CR, StudentRegistrationsToDegrees SRD WHERE CR.StudentRegistrationId = SRD.StudentRegistrationId AND CR.CourseOfferId = HG.CourseOfferId AND HG.Grade = CR.Grade GROUP BY SRD.StudentId HAVING COUNT (SRD.StudentId) >= %1%;
SELECT 0;
WITH RequiredSA(CourseOfferId, numberSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId)/50 FROM CourseRegistrations GROUP BY CourseOfferId ), ActualSA(CourseOfferId, realSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId) FROM StudentAssistants GROUP BY CourseOfferId ) SELECT C.CourseName, CO.year, CO.quartile FROM CourseOffers CO,  Courses C WHERE CO.CourseId = C.CourseId GROUP BY C.CourseName, CO.year, CO.quartile ORDER BY CO.CourseOfferId EXCEPT SELECT C.CourseName, CO.year, CO.quartile FROM CourseOffers Co, Courses C, RequiredSA R, ActualSA A WHERE CO.Courseid = C.Courseid AND Co.courseofferid = r.courseofferid and co.courseofferid = a.courseofferid and A.realsas >= r.numbersas GROUP BY C.CourseName, CO.year, Co.quartile;
