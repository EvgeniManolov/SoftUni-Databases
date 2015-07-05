SELECT TOP 1 t.Name, COUNT(a.TownID) AS [Number of employees]
FROM Employees AS e
JOIN Addresses AS a
	ON e.AddressID = a.AddressID
JOIN Towns AS t
	ON a.TownID = t.TownID
GROUP BY t.Name
ORDER BY COUNT(a.TownID) DESC