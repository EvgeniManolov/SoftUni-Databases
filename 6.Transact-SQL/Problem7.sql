USE SoftUni
GO

CREATE FUNCTION dbo.ufn_SearchEmployeeAndTownNamesByGivenLettersSet(@letters nvarchar(10))
RETURNS @results TABLE (Results nvarchar(50), ColumnType nvarchar(50) NOT NULL)
AS
BEGIN

DECLARE @lettersExistsInSearchString bit = 1
DECLARE @length int

-- search in first names:
DECLARE empFirstNameCursor CURSOR READ_ONLY FOR

RETURN
END

-- test function:
SELECT * FROM dbo.ufn_SearchEmployeeAndTownNamesByGivenLettersSet('oistmiahf')