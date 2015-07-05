SELECT d.Name, e.JobTitle, e.FirstName, MIN(e.Salary)
FROM Employees AS e
JOIN Departments AS d
	ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name, e.JobTitle, e.FirstName