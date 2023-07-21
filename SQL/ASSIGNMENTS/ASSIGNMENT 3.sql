DROP DATABASE IF EXISTS MODULE_3
GO
CREATE DATABASE [MODULE_3]
GO
USE [MODULE_3]
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




SELECT * FROM PROGRAMMER
SELECT * FROM STUDIES
SELECT * FROM SOFTWARE


--1. How many Programmers Don’t know PASCAL and C
select * from programmer where PROF1 NOT IN ('PASCAL','C') AND PROF2 NOT IN('PASCAL','C')
--2. Display the details of those who don’t know Clipper, COBOL or PASCAL.
select * from programmer where PROF1 NOT IN ('PASCAL','COBAL','CLIPPER') AND PROF2 NOT IN('PASCAL','COBOL','CLIPPER')
--3. Display each language name with AVG Development Cost, AVG Selling Cost and AVG Price per Copy.
select developin,avg(dcost) as [AVG Development Cost],avg(scost)as[AVG Selling Cost],avg(sold) as [AVG Price per Copy]from SOFTWARE group by DEVELOPIN
--4. List the programmer names (from the programmer table) and No. Of Packages each has developed.
SELECT P.PNAME,COUNT(TITLE) [PACKAGES COUNT] FROM PROGRAMMER P JOIN SOFTWARE S ON P.PNAME=S.PNAME GROUP BY P.PNAME
--5. List each PROFIT with the number of Programmers having that PROF and the number of the packages in that PROF.
SELECT PROF1 AS PROF, COUNT(DISTINCT PROGRAMMER.PNAME) AS NumProgrammers, COUNT(*) AS NumPackages
FROM PROGRAMMER
INNER JOIN SOFTWARE ON PROGRAMMER.PNAME = SOFTWARE.PNAME
GROUP BY PROF1
--6. How many packages are developed by the most experienced programmer form BDPS.
SELECT S.PNAME, COUNT(*) AS NumPackagesDeveloped
    FROM SOFTWARE S JOIN PROGRAMMER P ON P.PNAME=S.PNAME
    GROUP BY S.PNAME
    HAVING S.PNAME IN ('BDPS')
--7. How many packages were developed by the female programmers earning more than the highest paid male programmer?
SELECT COUNT(*) AS NumPackages
FROM SOFTWARE
WHERE PNAME IN (
    SELECT PNAME
    FROM PROGRAMMER
    WHERE GENDER = 'Female' AND SALARY > (
        SELECT MAX(SALARY)
        FROM PROGRAMMER
        WHERE GENDER = 'Male'
    )
)
--8. How much does the person who developed the highest selling package earn and what course did HE/SHE undergo.
SELECT P.PNAME, SALARY, S.COURSE
FROM PROGRAMMER AS P JOIN STUDIES AS S
ON P.PNAME=S.PNAME
WHERE P.PNAME IN (
    SELECT PNAME
    FROM SOFTWARE
    WHERE SCOST = (
        SELECT MAX(SCOST)
        FROM SOFTWARE
    )
)
--9. In which institute did the person who developed the costliest package study?
SELECT INSTITUTE
FROM STUDIES
WHERE PNAME IN (
    SELECT PNAME
    FROM SOFTWARE
    WHERE SCOST = (
        SELECT MAX(SCOST)
        FROM SOFTWARE
    )
)
--10. Display the names of the programmers who have not developed any packages.
SELECT PNAME
FROM PROGRAMMER
WHERE PNAME NOT IN (
    SELECT DISTINCT PNAME
    FROM SOFTWARE
)
--11. Display the details of the software that has developed in the language which is neither the first nor the second proficiency
SELECT S.*
FROM SOFTWARE S JOIN PROGRAMMER P ON S.PNAME=P.PNAME
WHERE DEVELOPIN NOT IN (P.PROF1,P.PROF2)
--12. Display the details of the software Developed by the male programmers Born before 1965 and female programmers born after 1975
SELECT *
FROM SOFTWARE
WHERE PNAME IN (
    SELECT PNAME
    FROM PROGRAMMER
    WHERE (GENDER = 'Male' AND DOB < '1965-01-01')
       OR (GENDER = 'Female' AND DOB > '1975-12-31')
)
--13. Display the number of packages, No. of Copies Sold and sales value of each programmer institute wise.
SELECT P.INSTITUTE, COUNT(*) AS NumPackages, SUM(SOLD) AS NumCopiesSold, SUM(SCOST * SOLD) AS SalesValue
FROM SOFTWARE AS S
JOIN STUDIES AS P ON S.PNAME = P.PNAME
GROUP BY P.INSTITUTE
--14. Display the details of the Software Developed by the Male Programmers Earning More than 3000/
SELECT *
FROM SOFTWARE
WHERE PNAME IN (
    SELECT PNAME
    FROM PROGRAMMER
    WHERE GENDER = 'Male' AND SALARY > 3000
)
--15. Who are the Female Programmers earning more than the Highest Paid male?
SELECT PNAME
FROM PROGRAMMER
WHERE GENDER = 'Female' AND SALARY > (
    SELECT MAX(SALARY)
    FROM PROGRAMMER
    WHERE GENDER = 'Male'
)
--16. Who are the male programmers earning below the AVG salary of Female Programmers?
SELECT PNAME
FROM PROGRAMMER
WHERE GENDER = 'Male' AND SALARY < (
    SELECT AVG(SALARY)
    FROM PROGRAMMER
    WHERE GENDER = 'Female'
)
--17. Display the language used by each programmer to develop the Highest Selling and Lowest-selling package.
SELECT PNAME, DEVELOPIN AS HighestSellingLanguage
FROM SOFTWARE
WHERE SCOST = (
    SELECT MAX(SCOST)
    FROM SOFTWARE
)

SELECT PNAME, DEVELOPIN AS LowestSellingLanguage
FROM SOFTWARE
WHERE SCOST = (
    SELECT MIN(SCOST)
    FROM SOFTWARE
)

--18. Display the names of the packages, which have sold less than the AVG number of copies.
SELECT TITLE
FROM SOFTWARE
WHERE SOLD < (
    SELECT AVG(SOLD)
    FROM SOFTWARE
)

--19. Which is the costliest package developed in PASCAL.
SELECT *
FROM SOFTWARE
WHERE DEVELOPIN = 'PASCAL'
ORDER BY SCOST DESC
--20. How many copies of the package that has the least difference between development and selling cost were sold. 
SELECT SOLD
FROM SOFTWARE
WHERE ABS(DCOST - SCOST) = (
    SELECT MIN(ABS(DCOST - SCOST))
    FROM SOFTWARE
)
--21. Which language has been used to develop the package, which has the highest salesamount?
SELECT DEVELOPIN
FROM SOFTWARE
WHERE SCOST = (
    SELECT MAX(SCOST)
    FROM SOFTWARE
)
--22. Who Developed the Package that has sold the least number of copies?
SELECT PNAME
FROM SOFTWARE
WHERE SOLD = (
    SELECT MIN(SOLD)
    FROM SOFTWARE
)
--23. Display the names of the courses whose fees are within 1000 (+ or -) of the Average Fee
SELECT COURSE
FROM STUDIES
WHERE [COURSE-FEE] BETWEEN (SELECT AVG([COURSE-FEE]) - 1000 FROM STUDIES)
                      AND (SELECT AVG([COURSE-FEE]) + 1000 FROM STUDIES)
--24. Display the name of the Institute and Course, which has below AVG course fee.
SELECT INSTITUTE, COURSE
FROM STUDIES
WHERE [COURSE-FEE] < (SELECT AVG([COURSE-FEE]) FROM STUDIES)
--25. Which Institute conducts costliest course.
SELECT INSTITUTE
FROM STUDIES
WHERE [COURSE-FEE] = (SELECT MAX([COURSE-FEE]) FROM STUDIES)
--26. What is the Costliest course
SELECT COURSE
FROM STUDIES
WHERE [COURSE-FEE] = (SELECT MAX([COURSE-FEE]) FROM STUDIES)