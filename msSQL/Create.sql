-- This feature (IDENTITY(1,1)) does not work on MySQL
-- In MySQL:
-- AUTO_INCREMENT

CREATE DATABASE FamilyTree;
USE FamilyTree;

CREATE TABLE Person (
	PersonID INT PRIMARY KEY IDENTITY(1,1),
	SSN NUMERIC(9) UNIQUE,
	FirstName VARCHAR(30), 
	LastName VARCHAR(30), 
	Gender CHAR(6), -- Value: 'Male' or 'Female'
	BirthDate DATE NOT NULL, 
	DeathDate DATE, 
	Picture VARCHAR(100)
);

CREATE TABLE Home (
	AddressID INT PRIMARY KEY IDENTITY(1,1), 
	Province CHAR(2) NOT NULL, 
	City VARCHAR(30) NOT NULL, 
	Street VARCHAR(30)  NOT NULL, 
	BuildingNumber NUMERIC(10) NOT NULL,

	UNIQUE (Province, City, Street, BuildingNumber)
);

CREATE TABLE Organization (
	OrganizationID INT PRIMARY KEY IDENTITY(1,1), 
	OrganizationName VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Achievement (
	ArchievementID INT PRIMARY KEY IDENTITY(1,1), 
	AchievementDescription VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE AchievementHistory (
	PersonID INT REFERENCES Person(PersonID) ON DELETE CASCADE, 
	ArchievementID INT REFERENCES Achievement(ArchievementID) ON DELETE CASCADE,
	ArchievementDate DATE,

	PRIMARY KEY (PersonID, ArchievementID)
);

CREATE TABLE HomeHistory (
	PersonID INT REFERENCES Person(PersonID) ON DELETE CASCADE, 
	AddressID INT REFERENCES Home(AddressID) ON DELETE CASCADE, 
	StartDate DATE NOT NULL,
	EndDate DATE,

	PRIMARY KEY (PersonID, AddressID)
);

CREATE TABLE EducationHistory (
	PersonID INT REFERENCES Person(PersonID) ON DELETE CASCADE, 
	OrganizationID INT REFERENCES Organization(OrganizationID) ON DELETE CASCADE, 
	StartDate DATE NOT NULL,
	EndDate DATE,
	Degree VARCHAR(100),

	PRIMARY KEY (PersonID, OrganizationID)
);

CREATE TABLE WorkHistory (
	PersonID INT REFERENCES Person(PersonID) ON DELETE CASCADE, 
	OrganizationID INT REFERENCES Organization(OrganizationID) ON DELETE CASCADE, 
	StartDate DATE NOT NULL,
	EndDate DATE,
	JobPosition VARCHAR(30),
	Income INT,

	PRIMARY KEY (PersonID, OrganizationID)
);

CREATE TABLE FatherOf (
	Father_PersonID INT REFERENCES Person(PersonID),
	Child_PersonID INT REFERENCES Person(PersonID),
	IsGenetically CHAR(1) NOT NULL, -- Value: 'Y' or 'N'
    PRIMARY KEY (Father_PersonID, Child_PersonID)
);

CREATE TABLE MontherOf (
	Monther_PersonID INT REFERENCES Person(PersonID),
	Child_PersonID INT REFERENCES Person(PersonID),
	IsGenetically CHAR(1) NOT NULL, -- Value: 'Y' or 'N'
    PRIMARY KEY (Monther_PersonID, Child_PersonID)
);

CREATE TABLE SpouseHistory (
	Husband_PersonID INT REFERENCES Person(PersonID),
	Wife_PersonID INT REFERENCES Person(PersonID),
	StartDate DATE NOT NULL,
	EndDate DATE
);

CREATE TABLE Person_MiddleName (
	PersonID INT REFERENCES Person(PersonID) ON DELETE CASCADE,
	MiddleName VARCHAR(30),

	PRIMARY KEY (PersonID,MiddleName)
);

CREATE TABLE Person_UsedName  (
	PersonID INT REFERENCES Person(PersonID) ON DELETE CASCADE,
	UsedName  VARCHAR(30),

	PRIMARY KEY (PersonID,UsedName)
);