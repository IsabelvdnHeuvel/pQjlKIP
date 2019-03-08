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

UPDATE CourseRegistrations SET Grade='null' WHERE Grade='0';
ALTER TABLE CourseRegistrations ALTER COLUMN Grade TYPE integer USING grade::integer;
