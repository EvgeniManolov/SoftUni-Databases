USE TransactSQL;
GO

IF OBJECT_ID('interestRate') IS NOT NULL
DROP FUNCTION interestRate;
GO

CREATE FUNCTION interestRate (@sum money, @interest int, @monthsNumber int)
RETURNS money AS

BEGIN
  DECLARE @result INT
  
  RETURN @result;

END

GO

SELECT interestRate(10000, 10, 3)