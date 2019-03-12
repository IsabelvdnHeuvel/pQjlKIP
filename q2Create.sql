CREATE INDEX idx_student ON StudentRegistrationsToDegrees(StudentRegistrationID);
CREATE INDEX idx_course ON CourseOffers(CourseOfferID);
CREATE INDEX idx_studreg ON NewCr USING hash(StudentRegistrationId);
CREATE MATERIALIZED VIEW NewCR(StudentID, CourseOfferID, CourseID, StudentRegistrationID, Grade) AS (SELECT SRD.StudentID, CR.CourseOfferID, CO.CourseID, CR.StudentRegistrationID, CR.Grade FROM ((CourseRegistrations CR INNER JOIN CourseOffers CO ON CR.CourseOfferID = CO.CourseOfferID) INNER JOIN StudentRegistrationsToDegrees SRD ON CR.StudentRegistrationID = SRD.StudentRegistrationID));
CREATE MATERIALIZED VIEW ECTS(StudentRegistrationID, DegreeID, sumECTS) AS (SELECT NewCR.StudentRegistrationID, SRD.DegreeID, SUM(C.ECTS) FROM NewCR, Courses C, StudentRegistrationsToDegrees SRD WHERE NewCR.Grade >= 5 AND SRD.StudentRegistrationID = NewCR.StudentRegistrationID AND C.CourseID = NewCR.CourseID GROUP BY NewCR.StudentRegistrationID, SRD.DegreeID);
