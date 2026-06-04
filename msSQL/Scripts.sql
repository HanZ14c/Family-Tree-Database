/*
not working on MySQL :
DataDIFF (use TIMESTAMPDIFF instead) - query 3
*/


USE FamilyTree;
-- 1. Retrieve First, Last, Middle, and UsedNamed (if they have)
SELECT P.FirstName, P.LastName, PM.MiddleName, PU.UsedName
FROM Person AS P JOIN Person_MiddleName AS PM, Person_UsedName AS PU
WHERE P.PersonID = PM.PersonID OR P.PersonID = PU.PersonID OR PM.MiddleName IS NULL OR PU.UsedName IS NULL
ORDER BY P.LastName, P.FirstName;
 
 
 -- 2. Retrieve Name from person who is male
 SELECT FirstName, LastName
 FROM Person
 WHERE Gender = "Male"
 ORDER BY LastName, FirstName;


-- 3. Retrieve name from person who is an adult (living)
SELECT FirstName, LastName
FROM Person
WHERE DATEDIFF(YEAR, BirthDate, GETDATE()) > 18 AND DeathDate IS NULL
ORDER BY LastName, FirstName;


-- 4. Create View to display basic info for each person
CREATE VIEW Person_Basic_Info AS
SELECT *
FROM Person
ORDER BY LastName, FirstName;


-- 5. Retrieve Name from person who is someone's sibling
SELECT 
    P.FirstName AS PersonFirstName,
    P.LastName AS PersonLastName,
    S.FirstName AS SiblingFirstName,
    S.LastName AS SiblingLastName
FROM FatherOf AS F1
JOIN FatherOf AS F2 ON F1.Father_PersonID = F2.Father_PersonID AND F1.Child_PersonID != F2.Child_PersonID
JOIN Person AS P ON F1.Child_PersonID = P.PersonID
JOIN Person AS S ON F2.Child_PersonID = S.PersonID
WHERE P.FirstName = 'Seth' AND P.LastName = 'Edward'
ORDER BY S.LastName, S.FirstName, S.LastName, S.FirstName;
    
    
-- 6. Retrieve name of Father and mother from person
SELECT DISTINCT P1.FirstName AS PersonFirstName, 
	P1.LastName AS PersonLastName, 
    P2.FirstName AS FatherFirstName, 
    P2.LastName AS FatherLastName,
	P3.FirstName AS MomFirstName, 
    P3.LastName AS MomLastName
FROM 
	Person AS P1, 
    FatherOf AS F1, 
    MontherOf AS M1, 
    Person AS P2, 
    Person AS P3
WHERE 
	P2.PersonID = F1.Father_PersonID 
	AND M1.Monther_PersonID = P3.PersonID
    AND P1.PersonID <> F1.Father_PersonID 
    AND P1.PersonID <> M1.Monther_PersonID
ORDER BY PersonLastName, PersonFirstName;


-- 7. Retrieve Name from Person who is adopted (no genetic connection form both)
SELECT P.FirstName, P.LastName
FROM Person AS P
WHERE P.PersonOD IN (
	SELECT F.Child_PersonID
    FROM FatherOf AS F 
    JOIN MontherOf AS M ON F.Child_PersonID = M.Child_PersonID
    WHERE F.IsGenetically = "N" AND M.IsGenetically = "N")
ORDER BY P.LastName, P.FirstName;


-- 8.  Retrieve Name from current Spouse from Person
SELECT 
	P.FirstName AS HusbandFN, 
    P.LastName AS HusbandLN, 
    P2.FirstName AS WifeFN, 
    P2.LastName AS WifeLN
FROM 
	Person AS P, 
	SpouseHistory AS S, 
    Person AS P2
WHERE 
	P.PersonID = S.Husband_PersonID 
    AND P2.PersonID = S.Wife_PersonID 
    AND StartDATE IS NOT NULL 
    AND EndDate IS NULL;


-- 9.Retrieve Name, Start and End Date, from person from all mariage history
SELECT P.FirstName, P.LastName, S.StartDate, S.EndDate
FROM  Person AS P LEFT JOIN SpouseHistory AS S ON P.PersonID = S.Husband_PersonID OR P.PersonID = S.Wife_PersonID
WHERE StartDate IS NOT NULL;


-- 10. Update (Add EndDate of) marriage history
UPDATE SpouseHistory
SET EndDate =  '2024-4-01'
WHERE Husband_PersonID = 4;

SELECT *
FROM SpouseHistory
WHERE Husband_PersonID = 4;


-- 11. Retrieve Name from Person and living history;
SELECT P.FirstName, P.LastName,
	HH.StartDate AS ResidenceStartDate,
    HH.EndDate AS ResidenceEndDate,
    H.Province, H.City, H.Street, H.BuildingNumber
FROM Person AS P
LEFT JOIN HomeHistory AS HH ON P.PersonID = HH.PersonID
LEFT JOIN Home AS H ON HH.AddressID = H.AddressID
ORDER BY P.LastName, P.FirstName, HH.StartDate;
    
    
-- 12. Retrieve Name of Person who (had) lives in BC;
SELECT P.FirstName, P.LastName
FROM Person AS p
JOIN HomeHistory AS HH ON P.PersonID = HH.PersonID
JOIN Home AS H ON HH.AddressID = H.AddressID
WHERE H.Province = 'BC'
ORDER BY P.LastName, P.FirstName;


-- 13. Retrieve Name of Person who current lives in multiple places;
SELECT P.FirstName, P.LastName
FROM Person AS P
JOIN HomeHistory AS HH ON P.PersonID = hh.PersonID
JOIN Home AS H ON hh.AddressID = H.AddressID
GROUP BY P.FirstName, P.LastName
HAVING COUNT(DISTINCT hh.AddressID) > 1;


-- 14. Retrieve AddressID from Home, number of Person who current lives in same place;
SELECT H.AddressID, COUNT(*) AS NumberOfResidents
FROM Home AS H
JOIN HomeHistory AS HH ON H.AddressID = H.AddressID
WHERE H.EndDate IS NULL
GROUP BY H.AddressID;


-- 15. Delete Achievement Graduation and Nobel Prize
DELETE FROM Achievement
WHERE AchievementDescription IN ('Graduation', 'Nobel Prize');
    

-- 16. Retrieve Name from Person and OrganizationName of education history, do not show empty history;
SELECT P.FirstName, P.LastName, O.OrganizationName AS EducationOrganization
FROM Person AS P
INNER JOIN EducationHistory AS EH ON P.PersonID = EH.PersonID
INNER JOIN Organization AS O ON EH.OrganizationID = O.OrganizationID
ORDER BY P.LastName, P.FirstName;

    
-- 17. Retrieve Name from Person and count how many work experience of each person;
SELECT P.FirstName, P.LastName, COUNT(wh.PersonID) AS WorkExperienceCount
FROM Person AS P
LEFT JOIN WorkHistory AS WH ON P.PersonID = WH.PersonID
GROUP BY P.PersonID, P.FirstName, P.LastName
ORDER BY P.LastName, P.FirstName;


-- 18. List all adpoted children in this family (DeathDate IS NOT NULL);
SELECT P.FirstName, P.LastName, P.Gender, P.BirthDate
FROM 
    Person AS P,
    FatherOf AS F,
    MontherOf AS M
WHERE 
	F.IsGenetically = 'N' 
    AND M.IsGenetically = 'N'
	AND P.DeathDate IS NOT NULL
ORDER BY P.LastName, P.FirstName;


-- 19. Find who works in their schools;
SELECT P.FirstName, P.LastName
FROM Person AS P
JOIN EducationHistory AS EH ON P.PersonID = EH.PersonID
JOIN WorkHistory AS WH ON EH.OrganizationID = WH.OrganizationID
ORDER BY P.LastName, P.FirstName;


-- 20. Find who is current on working or in school, group by status and order by their name
SELECT p.FirstName, p.LastName, 'Working' AS Status
FROM Person p
JOIN WorkHistory w ON p.PersonID = w.PersonID
WHERE w.EndDate IS NULL
UNION
SELECT p.FirstName, p.LastName, 'Attending school' AS Status
FROM Person p
JOIN EducationHistory e ON p.PersonID = e.PersonID
WHERE e.EndDate IS NULL
ORDER BY Status, LastName, FirstName;
