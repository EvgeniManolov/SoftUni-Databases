SELECT AVG(e.Salary) AS [Agerage Salary]
FROM Employees AS e
JOIN Departments AS d
ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'