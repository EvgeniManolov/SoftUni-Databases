SELECT e.FirstName + ' ' + e.LastName AS [Full Name], ISNULL(CONVERT(nvarchar(50), m.FirstName + ' ' + m.LastName),   'No manager')  AS [Manager Name]
FROM Employees AS e
LEFT JOIN Employees AS m
	ON e.ManagerID = m.EmployeeID