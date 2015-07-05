SELECT t.Name, COUNT(e.ManagerID) AS [Number of managers]
FROM Employees AS e
JOIN Addresses AS a
	ON e.AddressID = a.AddressID
JOIN Towns AS t
	ON a.TownID = t.TownID
JOIN Employees AS m
	ON e.ManagerID = m.EmployeeID
GROUP BY t.Name