INSERT INTO Users(Username,Pass,FullName)
SELECT 
	LEFT(FirstName, 1) + LOWER(LastName),
	LEFT(FirstName, 1) + LOWER(LastName),
	FirstName + ' ' + LastName
FROM Employees
WHERE LEN(LEFT(FirstName, 1) + LOWER(LastName)) > 5
