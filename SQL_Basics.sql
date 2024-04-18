CREATE DATABASE Kavyaworkspace; -- command helps to create a DB
USE Kavyaworkspace; -- switches to newly created database
CREATE TABLE Persons (  -- command helps to create a table
    PersonID int, -- specifing column name and its data type 
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
);
-- DROP TABLE Persons; --command to drop the table

INSERT INTO Persons Values
	(1001, 'Harper', 'Jim', 'goldcoast', 'Chicago')
INSERT INTO Persons VALUES (1002, 'Smith', 'John', 'beachview', 'New York');
INSERT INTO Persons VALUES (1003, 'Johnson', 'Emily', 'sunsetlane', 'Los Angeles');
INSERT INTO Persons VALUES (1004, 'Williams', 'Michael', 'oceanfront', 'Miami');
INSERT INTO Persons VALUES (1005, 'Jones', 'Sarah', 'downtown', 'San Francisco');
INSERT INTO Persons VALUES (1006, 'Brown', 'David', 'hillside', 'Seattle');
INSERT INTO Persons VALUES (1007, 'Davis', 'Jennifer', 'lakeview', 'Chicago');
INSERT INTO Persons VALUES (1008, 'Miller', 'Jessica', 'riverwalk', 'Boston');
INSERT INTO Persons VALUES (1009, 'Wilson', 'Daniel', 'parkavenue', 'New York');
INSERT INTO Persons VALUES (1010, 'Moore', 'Elizabeth', 'highland', 'Los Angeles');
INSERT INTO Persons VALUES (1011, 'Taylor', 'Matthew', 'coastal', 'Miami');
INSERT INTO Persons VALUES (1012, 'Anderson', 'Lauren', 'uptown', 'San Francisco');
INSERT INTO Persons VALUES (1013, 'Thomas', 'Christopher', 'midtown', 'Seattle');
INSERT INTO Persons VALUES (1014, 'Jackson', 'Ashley', 'suburbia', 'Chicago');
INSERT INTO Persons VALUES (1015, 'White', 'Brandon', 'downtown', 'Boston');

USE Kavyaworkspace;
CREATE TABLE IF NOT EXISTS EmployeeDetails (
    EmployeeID INT,
    Department VARCHAR(255),
    Position VARCHAR(255),
    Salary DECIMAL(10, 2),
    HireDate DATE
);
    
INSERT INTO EmployeeDetails VALUES (1001, 'Sales', 'Manager', 75000.00, '2020-03-15');
INSERT INTO EmployeeDetails VALUES (1002, 'Marketing', 'Analyst', 60000.00, '2019-07-22');
INSERT INTO EmployeeDetails VALUES (1003, 'HR', 'Coordinator', 50000.00, '2021-01-10');
INSERT INTO EmployeeDetails VALUES (1004, 'Finance', 'Accountant', 65000.00, '2018-11-28');
INSERT INTO EmployeeDetails VALUES (1005, 'IT', 'Developer', 70000.00, '2022-02-05');
INSERT INTO EmployeeDetails VALUES (1006, 'Operations', 'Supervisor', 62000.00, '2020-09-14');
INSERT INTO EmployeeDetails VALUES (1007, 'Sales', 'Associate', 55000.00, '2023-04-02');
INSERT INTO EmployeeDetails VALUES (1008, 'Marketing', 'Manager', 80000.00, '2017-05-20');
INSERT INTO EmployeeDetails VALUES (1009, 'HR', 'Manager', 78000.00, '2019-08-30');
INSERT INTO EmployeeDetails VALUES (1010, 'Finance', 'Analyst', 60000.00, '2021-11-15');
INSERT INTO EmployeeDetails VALUES (1011, 'IT', 'Engineer', 72000.00, '2018-03-25');
INSERT INTO EmployeeDetails VALUES (1012, 'Operations', 'Manager', 85000.00, '2016-06-12');
INSERT INTO EmployeeDetails VALUES (1013, 'Sales', 'Analyst', 60000.00, '2019-02-18');
INSERT INTO EmployeeDetails VALUES (1014, 'Marketing', 'Coordinator', 52000.00, '2020-07-30');
INSERT INTO EmployeeDetails VALUES (1015, 'HR', 'Assistant', 45000.00, '2023-01-12');


Use kavyaworkspace;
CREATE TABLE IF NOT EXISTS WHEmployee (
	PersonID int,
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255)
    );

INSERT INTO WHEmployee (PersonID, LastName, FirstName, Address, City)
VALUES
    (5001, 'Smith', 'John', '123 Main St', 'New York'),
    (5002, 'Johnson', 'Emily', '456 Elm St', 'Los Angeles'),
    (5003, 'Williams', 'Michael', '789 Oak Ave', 'Chicago'),
    (5004, 'Brown', 'Jessica', '101 Pine Rd', 'Miami'),
    (5005, 'Davis', 'Andrew', '246 Maple Blvd', 'Seattle');


SELECT MAX(Salary) AS MaxSalary
FROM EmployeeDetails;

SELECT count(PersonID) AS PersonIDCount
FROM Persons;

SELECT *
FROM Persons
WHERE FirstName = 'Jim';
-- we can aviod mutliple enties by using IN command->

SELECT *
FROM Persons
WHERE FirstName IN ('Jim', 'David', 'Elizabeth');
			                                     /* JOINTS */
/* We combine 2 tables based on common column, EX: PersonID */
SELECT *
FROM Kavyaworkspace.Persons
Inner Join Kavyaworkspace.EmployeeDetails
	ON Persons.PersonID = EmployeeDetails.EmployeeID;
    
/* SELECT *
FROM Kavyaworkspace.Persons
Full Outer Join Kavyaworkspace.EmployeeDetails
	ON Persons.PersonID = EmployeeDetails.EmployeeID; */ -- this is for the outer joint MySQL dosnt suppport it
    
SELECT PersonID, FirstName, LastName, Salary
FROM Kavyaworkspace.Persons
Inner Join Kavyaworkspace.EmployeeDetails
	ON Persons.PersonID = EmployeeDetails.EmployeeID
WHERE FirstName <> 'Michael'
Order by Salary DESC;

SELECT Department, avg(Salary)
FROM Kavyaworkspace.Persons
Inner Join Kavyaworkspace.EmployeeDetails
	ON Persons.PersonID = EmployeeDetails.EmployeeID
Where Department = 'HR'
group by Department;


									 /* UNIONS */

/* with Union you can select all the data and put it in one output. it will let us put every coloum together */

SELECT *
FROM Persons
UNION 			-- This command will combine bith tables 
SELECT *		-- Union ALL will show the duplicate data. 
FROM WHEmployee;

SELECT PersonID, FirstName, City
FROM Persons	
UNION
SELECT EmployeeID, Department, Salary		
FROM EmployeeDetails
ORDER by PersonID;
											/* CASE STATMENT*/
     /* Allows you to specify condition and allows you to what to return when that codition is met*/
SELECT FirstName, LastName, City, PersonID,
    CASE
        WHEN PersonID > 1008 THEN 'OLD'   -- CASE is life if else statement
        ELSE 'NEW'
    END AS Status
FROM Persons
ORDER BY City;


-- join the tables and give the employes a rise.

SELECT FirstName, LastName, Position, Salary,
    CASE
        WHEN Position = 'Analyst' THEN Salary + (Salary * 0.10)
        WHEN Position = 'Engineer' THEN Salary + (Salary * 0.05)
        WHEN Position = 'Manager' THEN Salary + (Salary * 0.000001)
        ELSE Salary + (Salary * 0.3)
    END AS SalaryafterRaise
FROM Kavyaworkspace.Persons as a  
JOIN Kavyaworkspace.EmployeeDetails as b 
    ON a.PersonID = b.EmployeeID;
    
    /* HAVING CLAUSE*/
    
SELECT Position, COUNT(Position)
FROM Kavyaworkspace.Persons
Inner Join Kavyaworkspace.EmployeeDetails
	ON Persons.PersonID = EmployeeDetails.EmployeeID
group by Position
HAVING COUNT(Position) > 1;

-- Use HAVING statement to mention what they have to group by and order by. 

SELECT Position, avg(Salary)
FROM Kavyaworkspace.Persons
Inner Join Kavyaworkspace.EmployeeDetails
	ON Persons.PersonID = EmployeeDetails.EmployeeID
group by Position
HAVING avg(Salary) > 45000
ORDER BY AVG(Salary);

		-- UPDATING AND DELETING DATA IN THE TABLE 

SELECT *
FROM Kavyaworkspace.EmployeeDetails;

UPDATE Kavyaworkspace.EmployeeDetails
SET Salary = 55000.00
WHERE EmployeeID = 1015;


DELETE FROM Kavyaworkspace.Persons
WHERE PersonID = 1012;

-- use Select statment insted of delete so that you wint delete data acidentally

									/* ALIASING */   -- Temporarily changing the column name or the table name in the script. it imporves the readability

SELECT LastName + ' ' + FirstName AS FullName
FROM Kavyaworkspace.Persons;

										
SELECT AVG(Salary) as AvgSalary
FROM Kavyaworkspace.EmployeeDetails; 


SELECT ID.PersonID, sal.Salary
FROM Kavyaworkspace.Persons AS ID
JOIN Kavyaworkspace.EmployeeDetails AS sal
  ON ID.PersonID = sal.PersonID;

SELECT ID.PersonID, AD.Address
FROM Kavyaworkspace.Persons AS ID
JOIN Kavyaworkspace.Persons AS AD  
  ON ID.PersonID = AD.PersonID;

SELECT Per.PersonID, Per.LastName, Per.FirstName
FROM Kavyaworkspace.Persons as per
Left join Kavyaworkspace.EmployeeDetails as sal
	ON Per.PersonID = sal.EmployeeID
left join Kavyaworkspace.WHEmployee Ware
	ON Per.PersonID = Ware.PersonID;
    
							/* PARTITION BY*/  -- divide the results as Partition

SELECT *
FROM Kavyaworkspace.EmployeeDetails;


SELECT FirstName, LastName, Salary, Address
, count(Address) over (partition by Address) as Details
FROM Kavyaworkspace.Persons as Per
Join Kavyaworkspace.EmployeeDetails as sal
	ON per.PersonID = Sal.EmployeeID;




