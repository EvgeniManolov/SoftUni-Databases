SELECT e.FirstName + ' ' + e.LastName AS [Full Name], m.FirstName + ' ' + m.LastName AS [Manager Name] 
FROM Employees AS e
RIGHT OUTER JOIN Employees AS m
ON e.ManagerID = m.EmployeeID