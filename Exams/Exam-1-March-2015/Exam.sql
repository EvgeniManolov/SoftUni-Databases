-- Problem 1.All Mountain Peaks

SELECT PeakName
FROM Peaks
ORDER BY PeakName

-- Problem 2.Biggest Countries by Population

SELECT TOP 30 CountryName, Population
FROM Countries AS Cntry
	JOIN Continents AS Cont ON Cntry.ContinentCode = Cont.ContinentCode
WHERE Cont.ContinentName = 'Europe'
ORDER BY Population DESC

-- Problem 3.Countries and Currency (Euro / Not Euro)

SELECT CountryName, CountryCode, CASE WHEN Cntry.CurrencyCode = 'EUR' THEN 'Euro' ELSE 'Not Euro' END AS Currency
FROM Countries AS Cntry
	LEFT JOIN Currencies AS Curr ON Cntry.CurrencyCode = Curr.CurrencyCode
ORDER BY CountryName

-- Problem 4.Countries Holding 'A' 3 or More Times

SELECT CountryName AS [Country Name], IsoCode AS [ISO Code]
FROM Countries
WHERE (SELECT LEN(CountryName) - LEN(REPLACE(LOWER(CountryName),'a',''))) >= 3
ORDER BY IsoCode

-- Problem 5.Peaks and Mountains

SELECT p.PeakName, MountainRange AS Mountain, p.Elevation
FROM Mountains AS m
	JOIN Peaks AS p ON m.Id = p.MountainId
ORDER BY p.Elevation DESC, p.PeakName

-- Problem 6.Peaks with Their Mountain, Country and Continent

SELECT p.PeakName, MountainRange AS Mountain, cntr.CountryName, cont.ContinentName
FROM Mountains AS m
	JOIN Peaks AS p ON m.Id = p.MountainId
	JOIN MountainsCountries AS mc ON m.Id = mc.MountainId
	JOIN Countries AS cntr ON mc.CountryCode = cntr.CountryCode
	JOIN Continents AS cont ON cntr.ContinentCode = cont.ContinentCode
ORDER BY p.PeakName, cntr.CountryName

-- Problem 7.* Rivers Passing through 3 or More Countries

SELECT r.RiverName AS River, COUNT(r.Id) AS [Countries Count]
FROM Rivers AS r
	JOIN CountriesRivers AS cr ON r.Id = cr.RiverId
	JOIN Countries AS c ON cr.CountryCode = c.CountryCode

GROUP BY r.RiverName
HAVING COUNT(r.Id) >= 3
ORDER BY r.RiverName

-- Problem 8.Highest, Lowest and Average Peak Elevation

SELECT MAX(Elevation) AS MaxElevation, MIN(Elevation) AS MinElevation, AVG(Elevation) AS AverageElevation
FROM Peaks

-- Problem 9.Rivers by Country

SELECT cntr.CountryName , cont.ContinentName, CASE WHEN COUNT(r.Id) > 0 THEN COUNT(r.Id) ELSE 0 END AS [RiversCount], CASE WHEN SUM(r.Length) > 0 THEN SUM(r.Length) ELSE 0 END AS [TotalLength]
FROM Countries AS cntr
	FULL JOIN Continents AS cont ON cntr.ContinentCode = cont.ContinentCode
	FULL JOIN CountriesRivers AS cr ON cntr.CountryCode = cr.CountryCode
	FULL JOIN Rivers AS r ON cr.RiverId = r.Id
GROUP BY cntr.CountryName, cont.ContinentName
ORDER BY [RiversCount] DESC, [TotalLength] DESC, cntr.CountryName

-- Problem 10.Count of Countries by Currency

SELECT curr.CurrencyCode AS [CurrencyCode], curr.Description AS [Currency], COUNT(cntr.ContinentCode) AS [NumberOfCountries]
FROM Currencies AS curr
	LEFT JOIN Countries AS cntr ON curr.CurrencyCode = cntr.CurrencyCode
GROUP BY curr.CurrencyCode, curr.Description
ORDER  BY [NumberOfCountries] DESC, [Currency]

-- Problem 11.* Population and Area by Continent

SELECT cont.ContinentName, SUM(cntr.AreaInSqKm) AS [CountriesArea], SUM(CONVERT(DECIMAL,cntr.Population)) AS [CountriesPopulation]
FROM Continents AS cont
	JOIN Countries AS cntr ON cont.ContinentCode = cntr.ContinentCode
GROUP BY cont.ContinentName
ORDER BY [CountriesPopulation] DESC

-- Problem 12.Highest Peak and Longest River by Country

SELECT cntr.CountryName, MAX(p.Elevation) AS [HighestPeakElevation], MAX(r.Length) AS [LongestRiverLength]
FROM Countries AS cntr
	LEFT JOIN MountainsCountries AS mc ON cntr.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
	LEFT JOIN Peaks AS p ON m.Id = p.MountainId
	LEFT JOIN CountriesRivers AS cr ON cntr.CountryCode = cr.CountryCode
	LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
GROUP BY cntr.CountryName
ORDER BY [HighestPeakElevation] DESC, [LongestRiverLength] DESC, cntr.CountryName

-- Problem 13.Mix of Peak and River Names

SELECT p.PeakName, r.RiverName, LOWER(p.PeakName + SUBSTRING(r.RiverName, 2, LEN(r.RiverName))) AS PeakRiver
FROM Peaks AS p, Rivers AS r
WHERE RIGHT(p.PeakName, 1) = LEFT(r.RiverName, 1)
OrDER BY PeakRiver

-- Problem 14.** Highest Peak Name and Elevation by Country

SELECT 
	c.CountryName AS [Country], 
	CASE WHEN MAX(p.Elevation) IS NOT NULL THEN MAX(p.PeakName) ELSE '(no highest peak)' END AS [Highest Peak Name],
	CASE WHEN MAX(p.Elevation) IS NOT NULL THEN MAX(p.Elevation) ELSE 0 END AS [Highest Peak Elevation],
	CASE WHEN c.ContinentCode IN (SELECT CountryCode FROM MountainsCountries WHERE CountryCode = c.CountryCode) THEN m.MountainRange ELSE '(no mountain)' END AS [Mountain]
FROM Countries As c
	LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
	LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
	LEFT JOIN Peaks AS p ON m.Id = p.MountainId

GROUP BY c.CountryName

-- Problem 15.Monasteries by Country

CREATE TABLE Monasteries(
  Id INT PRIMARY KEY IDENTITY,
  Name NVARCHAR(50),
  CountryCode CHAR(2)
)
GO

ALTER TABLE Monasteries WITH CHECK ADD CONSTRAINT FK_Monasteries_Countries
FOREIGN KEY (CountryCode) REFERENCES Countries(CountryCode)
GO

INSERT INTO Monasteries(Name, CountryCode) VALUES
('Rila Monastery “St. Ivan of Rila”', 'BG'), 
('Bachkovo Monastery “Virgin Mary”', 'BG'),
('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
('Kopan Monastery', 'NP'),
('Thrangu Tashi Yangtse Monastery', 'NP'),
('Shechen Tennyi Dargyeling Monastery', 'NP'),
('Benchen Monastery', 'NP'),
('Southern Shaolin Monastery', 'CN'),
('Dabei Monastery', 'CN'),
('Wa Sau Toi', 'CN'),
('Lhunshigyia Monastery', 'CN'),
('Rakya Monastery', 'CN'),
('Monasteries of Meteora', 'GR'),
('The Holy Monastery of Stavronikita', 'GR'),
('Taung Kalat Monastery', 'MM'),
('Pa-Auk Forest Monastery', 'MM'),
('Taktsang Palphug Monastery', 'BT'),
('Sümela Monastery', 'TR')

ALTER TABLE Countries
ADD IsDeleted BIT NOT NULL
DEFAULT 0

UPDATE Countries
SET IsDeleted = 1
WHERE CountryCode IN (
	SELECT c.CountryCode
	FROM Countries c
	  JOIN CountriesRivers cr ON c.CountryCode = cr.CountryCode
	  JOIN Rivers r ON r.Id = cr.RiverId
	GROUP BY c.CountryCode
	HAVING COUNT(r.Id) > 3
)

SELECT 
  m.Name AS Monastery, c.CountryName AS Country
FROM 
  Countries c
  JOIN Monasteries m ON m.CountryCode = c.CountryCode
WHERE c.IsDeleted = 0
ORDER BY m.Name

-- Problem 16.Monasteries by Continents and Countries

UPDATE Countries
SET CountryName = 'Burma'
WHERE CountryName = 'Myanmar'

INSERT INTO Monasteries (Name, CountryCode)
VALUES ('Hanga Abbey', (SELECT CountryCode FROM Countries WHERE CountryName = 'Tanzania'))

INSERT INTO Monasteries (Name, CountryCode)
VALUES ('Myin-Tin-Daik', (SELECT CountryCode FROM Countries WHERE CountryName = 'Myanmar'))

SELECT cont.ContinentName, cntr.CountryName, COUNT(m.Id) AS [MonasteriesCount]
FROM Countries AS cntr
	INNER JOIN Continents AS cont ON cntr.ContinentCode = cont.ContinentCode
	LEFT JOIN Monasteries AS m ON cntr.CountryCode = m.CountryCode
	WHERE cntr.IsDeleted = 0
GROUP BY cont.ContinentName, cntr.CountryName
ORDER BY [MonasteriesCount] DESC, cntr.CountryName

-- Problem 17.Stored Function: Mountain Peaks JSON

CREATE FUNCTION fn_MountainsPeaksJSON()
	RETURNS NVARCHAR(MAX)
AS
BEGIN
	DECLARE @json NVARCHAR(MAX) = '{"mountains":['

	DECLARE montainsCursor CURSOR FOR
	SELECT Id, MountainRange FROM Mountains

	OPEN montainsCursor
	DECLARE @mountainName NVARCHAR(MAX)
	DECLARE @mountainId INT
	FETCH NEXT FROM montainsCursor INTO @mountainId, @mountainName
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @json = @json + '{"name":"' + @mountainName + '","peaks":['

		DECLARE peaksCursor CURSOR FOR
		SELECT PeakName, Elevation FROM Peaks
		WHERE MountainId = @mountainId

		OPEN peaksCursor
		DECLARE @peakName NVARCHAR(MAX)
		DECLARE @elevation INT
		FETCH NEXT FROM peaksCursor INTO @peakName, @elevation
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @json = @json + '{"name":"' + @peakName + '",' +
				'"elevation":' + CONVERT(NVARCHAR(MAX), @elevation) + '}'
			FETCH NEXT FROM peaksCursor INTO @peakName, @elevation
			IF @@FETCH_STATUS = 0
				SET @json = @json + ','
		END
		CLOSE peaksCursor
		DEALLOCATE peaksCursor
		SET @json = @json + ']}'

		FETCH NEXT FROM montainsCursor INTO @mountainId, @mountainName
		IF @@FETCH_STATUS = 0
			SET @json = @json + ','
	END
	CLOSE montainsCursor
	DEALLOCATE montainsCursor

	SET @json = @json + ']}'
	RETURN @json
END
GO

SELECT dbo.fn_MountainsPeaksJSON()

-- Problem 18.Design a Database Schema in MySQL and Write a Query

