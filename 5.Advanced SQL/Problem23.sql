UPDATE Users
SET Pass = CAST(NULL As nvarchar(100))
WHERE FullName IN 
	(SELECT e.FirstName + ' ' + e.LastName 
	FROM Employees AS e
	JOIN Users AS u
		ON e.FirstName + ' ' + e.LastName = u.FullName
	WHERE e.HireDate <'10-03-2010')