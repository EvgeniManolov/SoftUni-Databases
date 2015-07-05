INSERT INTO WorkHours(EmployeeId, Date, Task, Hours, Comments)
VALUES (1, '2015-3-1', 'Da se chudi kakvo da pravi', 8, 'Ako iska da si nameri drug s koito da se chudi')
UPDATE WorkHours
SET Task='Myrzeluvane'
WHERE EmployeeId = 1
DELETE FROM WorkHours
WHERE EmployeeId=1 