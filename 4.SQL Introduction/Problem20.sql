SELECT e.FirstName + ' ' + e.LastName, m.FirstName + ' ' + m.LastName FROM Employees AS e
INNER JOIN Employees AS m
ON e.ManagerId = m.EmployeeId