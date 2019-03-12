SELECT c.CourseName, cr.grade FROM courses as c, courseoffers as co, studentregistrationstodegrees as std, courseregistrations as cr WHERE std.studentId = %1% AND  std.degreeId = %2% AND cr.studentregistrationId = std.studentregistrationId AND co.courseofferid = cr.courseofferid AND c.courseid = co.courseid AND cr.grade >= 5.0 ORDER BY co.year, co.quartile, co.courseofferid;
SELECT 0;
SELECT SRD.DegreeID, cast(SUM(case when S.Gender='F' then 1 else 0 end) as float)/ cast(COUNT(S.Gender) as float)) AS Percentage FROM StudentRegistrationsToDegrees SRD, Students S WHERE SRD.StudentId = S.StudentId AND SRD.StudentRegistrationId IN (SELECT E.StudentRegistrationId FROM ECTS E, Degrees D WHERE E.DegreeID=D.DegreeID AND E.sumECTS<D.TotalECTS) ORDER BY SRD.DegreeID;
SELECT (cast(SUM(CASE WHEN s.Gender = 'F' THEN 1 ELSE 0 END) as float) / COUNT(s.Gender)) as percentage FROM Students s INNER JOIN StudentRegistrationsToDegrees srd on (s.StudentId = srd.StudentId) INNER JOIN Degrees d on (srd.DegreeId = d.DegreeId) WHERE (d.Dept =  %1%);
WITH PassingStudent(CourseId, sumStudentId) AS (SELECT CO.CourseId, cast(COUNT(cr.studentregistrationid) as decimal) FROM CourseRegistrations CR, CourseOffers CO WHERE CO.CourseOfferId = CR.CourseOfferId AND CR.Grade >= %1% GROUP BY CO.CourseId ), EveryStudent(CourseId, everyStudentId) AS (SELECT CO.CourseId, cast(COUNT(cr.studentregistrationid) as decimal) FROM CourseRegistrations CR, CourseOffers CO WHERE CO.CourseOfferId = CR.CourseOfferId AND (CR.Grade IS NOT NULL) GROUP BY CO.CourseId ) SELECT p.CourseId, (P.sumStudentId / E.everyStudentId) as percentagePassing FROM PassingStudent P, EveryStudent E WHERE P.CourseId = E.CourseId
WITH HighestGrade(CourseOfferId, Grade) AS (SELECT CR.CourseOfferId, MAX(CR.Grade) FROM CourseRegistrations CR, CourseOffers CO WHERE CR.CourseOfferId = CO.CourseOfferId AND CO.year = 2018 AND CO.Quartile = 1 GROUP BY CR.CourseOfferId) SELECT SRD.StudentId, COUNT(SRD.StudentId) FROM HighestGrade HG, CourseRegistrations CR, StudentRegistrationsToDegrees SRD WHERE CR.StudentRegistrationId = SRD.StudentRegistrationId AND CR.CourseOfferId = HG.CourseOfferId AND HG.Grade = CR.Grade GROUP BY SRD.StudentId HAVING COUNT (SRD.StudentId) >= %1%;
SELECT 0;
WITH RequiredSA(CourseOfferId, numberSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId)/50 FROM CourseRegistrations GROUP BY CourseOfferId ), ActualSA(CourseOfferId, realSAS) AS (SELECT CourseOfferId, COUNT(StudentRegistrationId) FROM StudentAssistants GROUP BY CourseOfferId ) SELECT C.CourseName, CO.year, CO.quartile FROM CourseOffers CO,  Courses C WHERE CO.CourseId = C.CourseId GROUP BY C.CourseName, CO.year, CO.quartile ORDER BY CO.CourseOfferId EXCEPT SELECT C.CourseName, CO.year, CO.quartile FROM CourseOffers Co, Courses C, RequiredSA R, ActualSA A WHERE CO.Courseid = C.Courseid AND Co.courseofferid = r.courseofferid and co.courseofferid = a.courseofferid and A.realsas >= r.numbersas GROUP BY C.CourseName, CO.year, Co.quartile;
