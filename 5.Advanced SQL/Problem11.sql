SELECT m.FirstName, m.LastName, COUNT(e.EmployeeID)
FROM Employees AS e
JOIN Employees AS m
	ON e.ManagerID = m.EmployeeID
WHERE (SELECT COUNT(EmployeeID) FROM Employees 
	WHERE m.EmployeeID = ManagerID) = 5
GROUP BY m.FirstName, m.LastName