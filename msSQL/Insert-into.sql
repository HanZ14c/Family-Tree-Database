-- This feature (skip generated value) does not work on MySQL
-- In MySQL: Insert values into corresponding column

-- Person (PersonID, SSN, FirstName, LastName, Gender, BirthDate, DeathDate, Picture)
INSERT INTO Person VALUES (NULL, 'Alexandrina', 'Hazel', 'Female', '1955-05-24', '2010-01-22', 'C:\Pictures\AlexandrinaHazel.jpg');
INSERT INTO Person VALUES (395792834, 'Franz', 'Edward', 'Male', '1950-08-26', '2001-12-14', NULL);
INSERT INTO Person VALUES (235364984, 'Albert', 'Edward', 'Female', '1975-12-09', NULL, 'C:\Pictures\AlbertEdward.jpg');
INSERT INTO Person VALUES (189367836, 'Arthur', 'Edward', 'Male', '1998-08-01', NULL, 'C:\Pictures\ArthurEdward.jpg');
INSERT INTO Person VALUES (523465563, 'Lily', 'Avery', 'Female', '2001-11-05', NULL, NULL);
INSERT INTO Person VALUES ( NULL, 'Po', 'Edward', 'Male', '1841-09-09', '1910-05-06', 'C:\Pictures\SethEdward.jpg');

-- Home (AddressID, Province, City, Street, BuildingNumber)
INSERT INTO Home  VALUES ('BC', 'Vancouver', 'W 57th Ave', 1001);
INSERT INTO Home  VALUES ('BC', 'Richmond', 'Bassett', 2341);
INSERT INTO Home  VALUES ('BC', 'Burnaby', 'Fir St', 9236);
INSERT INTO Home  VALUES ('BC', 'Vancouver', 'Manitoba St', 1371);

-- Organization (OrganizationID, OrganizationName)
INSERT INTO Organization VALUES ('Langara');
INSERT INTO Organization VALUES ('UBC');
INSERT INTO Organization VALUES ('Google');

--Achievement (ArchievementID, AchievementDescription)
INSERT INTO Achievement VALUES ('Graduation');
INSERT INTO Achievement VALUES ('Nobel Prize');

-- AchievementHistory (PersonID, ArchievementID, ArchievementDate)
INSERT INTO AchievementHistory VALUES (1, 1, '2004-03-02');
INSERT INTO AchievementHistory VALUES (2, 2, '1999-03-02');

-- HomeHistory (PersonID, AddressID, StartDate,EndDate)
INSERT INTO HomeHistory VALUES (3, 2, '2024-03-02', NULL);
INSERT INTO HomeHistory VALUES (1, 3, '1990-01-02', '2024-03-02');

-- EducationHistory (PersonID, OrganizationID, StartDate, EndDate, Degree)
INSERT INTO EducationHistory VALUES (4, 1, '2001-09-01', '2003-04-10', 'Diploma');
INSERT INTO EducationHistory VALUES (4, 2, '2003-09-10', '2006-04-10', 'BCS');

-- WorkHistory (PersonID, OrganizationID, StartDate, EndDate, JobPosition, Income)
INSERT INTO WorkHistory VALUES (4, 3, '2006-04-10', NULL, 'Leader', 150350);
INSERT INTO WorkHistory VALUES (3, 2, '2003-09-10', '2006-04-10', NULL, NULL);

-- FatherOf (Father_PersonID, Child_PersonID, IsGenetically)
INSERT INTO FatherOf VALUES (2,4,'Y');
INSERT INTO FatherOf VALUES (2,5,'N');
INSERT INTO FatherOf VALUES (2,6,'N');

-- MontherOf (Monther_PersonID, Child_PersonID, IsGenetically)
INSERT INTO MontherOf VALUES (1,4,'Y');
INSERT INTO MontherOf VALUES (3,5,'N');
INSERT INTO MontherOf VALUES (1,5,'N');
INSERT INTO MontherOf VALUES (1,6,'N');

-- SpouseHistory (Husband_PersonID, Wife_PersonID, StartDate, EndDate)
INSERT INTO SpouseHistory VALUES (1, 2, '1972-06-10', '2001-12-14');
INSERT INTO SpouseHistory VALUES (4, 5, '2023-12-10', NULL);

-- Person_MiddleName (PersonID, MiddleName)
INSERT INTO Person_MiddleName VALUES (1, 'August');
INSERT INTO Person_MiddleName VALUES (3, 'Karl');
INSERT INTO Person_MiddleName VALUES (3, 'Harry');

-- Person_UsedName (PersonID, UsedName)
INSERT INTO Person_UsedName VALUES (3, 'Clark');
INSERT INTO Person_UsedName VALUES (1, 'Karl');