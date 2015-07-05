SELECT e.FirstName + ' ' + e.LastName, a.AddressText  FROM Employees AS e
INNER JOIN Addresses AS a
ON e.AddressID = a.AddressID