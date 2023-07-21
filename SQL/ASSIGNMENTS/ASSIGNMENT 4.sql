DROP DATABASE IF EXISTS MODULE_4
GO
CREATE DATABASE MODULE_4
GO
USE [MODULE_4]
GO
CREATE TABLE SOFTWARE(
	PNAME VARCHAR(20),
	TITLE VARCHAR(20),
	DEVELOPIN VARCHAR(20),
	SCOST INT,
	DCOST INT,
	SOLD INT
)
GO
CREATE TABLE STUDIES(
	PNAME VARCHAR(20),
	INSTITUTE VARCHAR(20),
	COURSE VARCHAR(20),
	[COURSE-FEE] INT
);
GO
CREATE TABLE PROGRAMMER(
	PNAME VARCHAR(20),
	DOB	DATE,
	DOJ	DATE,
	GENDER	VARCHAR(10),
	PROF1	VARCHAR(20),
	PROF2	VARCHAR(20),
	SALARY INT
);
GO
INSERT INTO SOFTWARE VALUES('MARY','README','CPP',300,1200,84),
('ANAND','PARACHUTES','BASIC',399.95,6000,43),
('ANAND','VIDEO TITLING','PASCAL',7500,16000,9),
('JULIANA','INVENTORY','COBOL',3000,3500,0),
('KAMALA','PAYROLL PKG.','DBASE',9000,20000,7),
('MARY','FINANCIAL ACCT.','ORACLE',18000,85000,4),
('MARY','CODE GENERATOR','C',4500,20000,23),
('PATTRICK','README','CPP',300,1200,84),
('QADIR','BOMBS AWAY','ASSEMBLY',750,3000,11),
('QADIR','VACCINES','C',1900,3100,21),
('RAMESH','HOTEL MGMT.','DBASE',13000,35000,4),
('RAMESH','DEAD LEE','PASCAL',599.95,4500,73),
('REMITHA','PC UTILITIES','C',725,5000,51),
('REMITHA','TSR HELP PKG.','ASSEMBLY',2500,6000,7),
('SREVATHI','HOSPITAL MGMT.','PASCAL',1100,75000,2),
('VIJAYA','TSR EDITOR','C',900,700,6)
GO
insert into programmer values
('Anand','12-apr-1966','21-apr-1992','M','Pascal','Basic',3200),
('Altaf','02-jul-1964','13-nov-1990','M','Clipper','Cobal',2800),
('Juliana','31-jan-1960','21-apr-1990','F','Cobal','Dbase',3000),
('Kamala','30-oct-1968','02-jan-1992','F','C','Dbase',2900),
('Mary','24-jun-1970','01-feb-1991','F','Cpp','Oracle',4500),
('Nekson','11-sep-1985','11-oct-1989','M','Cobal','Dbase',2500),
('Pattrick','10-nov-1965','21-apr-1990','M','Pascal','Clipper',2800),
('Qadir','31-aug-19565','21-apr-1991','M','Assembly','C',3000),
('Ramesh','03-may-1967','28-feb-1991','M','Pascal','Dbase',3200),
('Revecca','01-jan-1967','01-dec-1990','F','Basic','Cobal',2500),
('Remitha','19-apr-1970','20-apr-1993','F','C','Assembly',2600),
('Revathi','02-dec-1969','2-jan-1992','F','Pascal','Basic',2700),
('Vijay','14-dec-1965','2-may-1992','M','Foxpro','C',2500);
GO
insert into studies values
('Anand','sabhari','pgdca',4500),
('Altaf','coit','dca',7200),
('Juliana','bdps','mca',22000),
('Kamala','pragathi','dca',5000),
('Mary','sabhari','pgdca',4500),
('Nelson','pragathi','dap',6200),
('Patrick','pragathi','dcap',5200),
('Qadir','apple','hdca',14000),
('Ramesh','sabhari','pgdca',4500),
('Rebecca','brolliant','dcap',11000),
('Remitha','bdps','dcs',6000),
('Recathi','sabhari','dap',5000),
('Vijay','bdps','dca',48000);







--1. What is the cost of the costliest software development in Basic?
SELECT MAX(DCOST) AS CostliestSoftwareDevelopmentInBasic
FROM SOFTWARE
WHERE DEVELOPIN = 'Basic'
--2. Display details of Packages whose sales crossed the 2000 Mark.
SELECT *
FROM SOFTWARE
WHERE SOLD > 2000
--3. Who are the Programmers who celebrate their Birthdays during the Current Month?
SELECT PNAME
FROM PROGRAMMER
WHERE MONTH(DOB) = MONTH(GETDATE())

--4. Display the Cost of Package Developed By each Programmer.
SELECT PNAME, SUM(DCOST) AS TotalCost
FROM SOFTWARE
GROUP BY PNAME
--5. Display the sales values of the Packages Developed by each Programmer.
SELECT PNAME, SUM(SCOST * SOLD) AS TotalSalesValue
FROM SOFTWARE
GROUP BY PNAME
--6. Display the Number of Packages sold by Each Programmer.
SELECT PNAME, SUM(SOLD) AS TotalPackagesSold
FROM SOFTWARE
GROUP BY PNAME
--7. Display each programmer’s name, costliest and cheapest Packages Developed by him or her.
SELECT P.PNAME, MAX(S.SCOST) AS CostliestPackage, MIN(S.SCOST) AS CheapestPackage
FROM PROGRAMMER AS P
JOIN SOFTWARE AS S ON P.PNAME = S.PNAME
GROUP BY P.PNAME
--8. Display each institute name with the number of Courses, Average Cost per Course.
SELECT INSTITUTE, COUNT(*) AS NumCourses, AVG([COURSE-FEE]) AS AvgCostPerCourse
FROM STUDIES
GROUP BY INSTITUTE
--9. Display each institute Name with Number of Students.
SELECT INSTITUTE, COUNT(*) AS NumStudents
FROM STUDIES
GROUP BY INSTITUTE
--10. List the programmers (form the software table) and the institutes they studied.
SELECT P.PNAME, S.INSTITUTE
FROM PROGRAMMER AS P
JOIN STUDIES AS S ON P.PNAME = S.PNAME
--11. How many packages were developed by students, who studied in institute that charge the lowest course fee?
SELECT COUNT(*) AS NumPackages
FROM SOFTWARE
WHERE PNAME IN (
    SELECT PNAME
    FROM STUDIES
    WHERE [COURSE-FEE] = (
        SELECT MIN([COURSE-FEE])
        FROM STUDIES
    )
)
--12. What is the AVG salary for those whose software sales is more than 50,000/-.
SELECT AVG(SALARY) AS AverageSalary
FROM PROGRAMMER
WHERE PNAME IN (
    SELECT PNAME
    FROM SOFTWARE
    WHERE SCOST * SOLD > 50000
)
--13. Which language listed in prof1, prof2 has not been used to develop any package.
SELECT DISTINCT PROF1 AS Language
FROM PROGRAMMER
WHERE PROF1 NOT IN (
    SELECT DISTINCT DEVELOPIN
    FROM SOFTWARE
)
UNION
SELECT DISTINCT PROF2 AS Language
FROM PROGRAMMER
WHERE PROF2 NOT IN (
    SELECT DISTINCT DEVELOPIN
    FROM SOFTWARE
)
--14. Display the total sales value of the software, institute wise.
SELECT P.INSTITUTE, SUM(S.SCOST * S.SOLD) AS TotalSalesValue
FROM SOFTWARE AS S
JOIN STUDIES AS P ON S.PNAME = P.PNAME
GROUP BY P.INSTITUTE
--15. Display the details of the Software Developed in C By female programmers of Pragathi.
SELECT S.*
FROM SOFTWARE AS S
JOIN PROGRAMMER AS P ON S.PNAME = P.PNAME JOIN STUDIES SS ON S.PNAME=P.PNAME
WHERE S.DEVELOPIN = 'C' AND P.GENDER = 'Female' AND SS.INSTITUTE = 'Pragathi'
--16. Display the details of the packages developed in Pascal by the Female Programmers.
SELECT S.*
FROM SOFTWARE AS S
JOIN PROGRAMMER AS P ON S.PNAME = P.PNAME
WHERE S.DEVELOPIN = 'Pascal' AND P.GENDER = 'Female'
--17. Which language has been stated as the proficiency by most of the Programmers?
SELECT PROF1 AS Language, COUNT(*) AS NumProgrammers
FROM PROGRAMMER
GROUP BY PROF1
ORDER BY COUNT(*) DESC
--18. Who is the Author of the Costliest Package?
SELECT P.PNAME
FROM PROGRAMMER AS P
JOIN SOFTWARE AS S ON P.PNAME = S.PNAME
WHERE S.SCOST = (
    SELECT MAX(SCOST)
    FROM SOFTWARE
)
--19. Which package has the Highest Development cost?
SELECT *
FROM SOFTWARE
WHERE DCOST = (
    SELECT MAX(DCOST)
    FROM SOFTWARE
)
--20. Who is the Highest Paid Female COBOL Programmer?
SELECT PNAME
FROM PROGRAMMER
WHERE GENDER = 'Female' AND PROF1 = 'COBOL' OR PROF2 = 'COBOL'
ORDER BY SALARY DESC
--21. Display the Name of Programmers and Their Packages.
SELECT DEVELOPIN, COUNT(*) AS NumPackages
FROM SOFTWARE
WHERE DEVELOPIN NOT IN ('C', 'C++')
GROUP BY DEVELOPIN
--22. Display the Number of Packages in Each Language Except C and C++.
SELECT DEVELOPIN, COUNT(*) AS NumPackages
FROM SOFTWARE
WHERE DEVELOPIN NOT IN ('C', 'C++')
GROUP BY DEVELOPIN
--23. Display AVG Difference between SCOST, DCOST for Each Package.
SELECT TITLE, AVG(SCOST - DCOST) AS AvgCostDifference
FROM SOFTWARE
GROUP BY TITLE
--24. Display the total SCOST, DCOST and amount to Be Recovered for each Programmer for Those Whose Cost has not yet been Recovered.
SELECT S.PNAME, SUM(S.SCOST) AS TotalSCost, SUM(S.DCOST) AS TotalDCost, SUM(S.SCOST - S.DCOST) AS AmountToBeRecovered
FROM SOFTWARE AS S
JOIN PROGRAMMER AS P ON S.PNAME = P.PNAME
GROUP BY S.PNAME
HAVING SUM(S.SCOST) > SUM(S.DCOST)
--25. Who is the Highest Paid C Programmers?
SELECT PNAME
FROM PROGRAMMER
WHERE PROF1 = 'C' OR PROF2 = 'C'
ORDER BY SALARY DESC
--26. Who is the Highest Paid Female COBOL Programmer?
SELECT PNAME
FROM PROGRAMMER
WHERE GENDER = 'Female' AND (PROF1 = 'COBOL' OR PROF2 = 'COBOL')
ORDER BY SALARY DESC
