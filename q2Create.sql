ALTER TABLE CourseRegistrations ALTER COLUMN Grade TYPE integer USING grade::integer;
ALTER TABLE Students ADD PRIMARY KEY (StudentID);
ALTER TABLE Degrees ADD PRIMARY KEY (DegreeID);
ALTER TABLE StudentRegistrationsToDegrees ADD PRIMARY KEY (StudentRegistrationID);
ALTER TABLE StudentRegistrationsToDegrees ADD FOREIGN KEY (StudentID) REFERENCES Students(StudentID);
ALTER TABLE StudentRegistrationsToDegrees ADD FOREIGN KEY (DegreeID) REFERENCES Degrees(DegreeID);
ALTER TABLE Teachers ADD PRIMARY KEY (TeacherID);
ALTER TABLE Courses ADD PRIMARY KEY (CourseID);
ALTER TABLE Courses ADD FOREIGN KEY (DegreeID) REFERENCES Degrees(DegreeID);
ALTER TABLE CourseOffers ADD PRIMARY KEY (CourseOfferID);
ALTER TABLE CourseOffers ADD FOREIGN KEY (CourseID) REFERENCES Courses(CourseID);
ALTER TABLE TeacherAssignmentsToCourses ADD FOREIGN KEY (CourseOfferID) REFERENCES CourseOffers(CourseOfferID);
ALTER TABLE TeacherAssignmentsToCourses ADD FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID);
ALTER TABLE StudentAssistants ADD FOREIGN KEY (CourseOfferID) REFERENCES CourseOffers(CourseOfferID);
ALTER TABLE StudentAssistants ADD FOREIGN KEY (StudentRegistrationID) REFERENCES StudentRegistrationsToDegrees(StudentRegistrationID);
ALTER TABLE CourseRegistrations ADD FOREIGN KEY (CourseOfferID) REFERENCES CourseOffers(CourseOfferID);
ALTER TABLE CourseRegistrations ADD FOREIGN KEY (StudentRegistrationID) REFERENCES StudentRegistrationsToDegrees(StudentRegistrationID);
CREATE INDEX idx_student ON StudentRegistrationsToDegrees(StudentRegistrationID);
CREATE INDEX idx_course ON CourseOffers(CourseOfferID);
CREATE MATERIALIZED VIEW NewCR(StudentID, CourseOfferID, CourseID, StudentRegistrationID, Grade) AS (SELECT SRD.StudentID, CR.CourseOfferID, CO.CourseID, CR.StudentRegistrationID, CR.Grade FROM ((CourseRegistrations CR INNER JOIN CourseOffers CO ON CR.CourseOfferID = CO.CourseOfferID) INNER JOIN StudentRegistrationsToDegrees SRD ON CR.StudentRegistrationID = SRD.StudentRegistrationID));
CREATE MATERIALIZED VIEW ECTS(StudentRegistrationID, DegreeID, sumECTS) AS (SELECT NewCR.StudentRegistrationID, SRD.DegreeID, SUM(C.ECTS) FROM NewCR, Courses C, StudentRegistrationsToDegrees SRD WHERE NewCR.Grade >= 5 AND SRD.StudentRegistrationID = NewCR.StudentRegistrationID AND C.CourseID = NewCR.CourseID GROUP BY NewCR.StudentRegistrationID, SRD.DegreeID);
