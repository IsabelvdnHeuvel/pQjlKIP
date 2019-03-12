--SELECT c.CourseName, cr.grade FROM Courses C, CourseOffers CO, StudentRegistrationsToDegrees STD, NewCR CR WHERE CR.StudentId=%1% AND STD.DegreeId=%2% AND CR.studentregistrationId = STD.studentregistrationId AND C.courseid = CR.courseid AND CR.grade >= 5.0 AND Cr.grade IS NOT NULL ORDER BY CO.year, CO.quartile, CO.courseofferid;
SELECT 0;
SELECT 0;
SELECT 0;
SELECT (cast(SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(s.Gender)) as percentage FROM Students s INNER JOIN StudentRegistrationsToDegrees srd on (s.StudentId = srd.StudentId) INNER JOIN Degrees d on (srd.DegreeId = d.DegreeId) WHERE (d.Dept =  %1%);
SELECT 0;
SELECT 0;
SELECT 0;
WITH RequiredSA(CourseOfferId, numberSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId)/50 FROM CourseRegistrations GROUP BY CourseOfferId ), ActualSA(CourseOfferId, realSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId) FROM StudentAssistants GROUP BY CourseOfferId ) SELECT C.CourseName, CO.year, CO.quartile FROM CourseOffers CO,  Courses C WHERE CO.CourseId = C.CourseId GROUP BY C.CourseName, CO.year, CO.quartile ORDER BY CO.CourseOfferId EXCEPT SELECT C.CourseName, CO.year, CO.quartile FROM CourseOffers Co, Courses C, RequiredSA R, ActualSA A WHERE CO.Courseid = C.Courseid AND Co.courseofferid = r.courseofferid and co.courseofferid = a.courseofferid and A.realsas >= r.numbersas GROUP BY C.CourseName, CO.year, Co.quartile;
