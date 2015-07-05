SELECT e.FirstName + ' ' + e.LastName, m.FirstName + ' ' + m.LastName, a.AddressText FROM Employees AS e
INNER JOIN Employees AS m
ON e.ManagerId = m.EmployeeId
INNER JOIN Addresses AS a
ON e.AddressID = a.AddressID