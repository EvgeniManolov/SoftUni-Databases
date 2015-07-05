SELECT e.FirstName + ' ' + e.LastName AS [Full Name], d.Name, e.HireDate
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name IN ('Sales', 'Finance')
AND e.HireDate >= '1995/1/1' AND e.HireDate <= '2005/1/1'
