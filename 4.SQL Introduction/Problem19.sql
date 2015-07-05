    SELECT Employees.FirstName + ' ' + Employees.LastName, Addresses.AddressText
    FROM Employees,Addresses  
    WHERE Employees.AddressID = Addresses.AddressID