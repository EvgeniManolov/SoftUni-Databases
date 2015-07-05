SELECT e.FirstName + ' ' + e.LastName AS [Full Name], d.Name, e.Salary
FROM Employees AS e
JOIN Departments as d
ON e.DepartmentID = d.DepartmentID
WHERE e.Salary = (SELECT MIN(Salary) FROM Employees
	WHERE DepartmentID = d.DepartmentID)