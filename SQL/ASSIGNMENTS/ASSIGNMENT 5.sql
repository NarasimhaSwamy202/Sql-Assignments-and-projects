DROP DATABASE IF EXISTS MODULE_5
GO
GO
CREATE DATABASE MODULE_5
GO
USE [MODULE_5]
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


--To optimize this query, you can use a Common Table Expression (CTE) with the ROW_NUMBER() function to get the highest-paid programmer for each language efficiently.
--1. Display the names of the highest paid programmers for each Language.
CREATE INDEX idx_language_salary ON PROGRAMMER (PROF1, SALARY);
SELECT P.PNAME, P.PROF1, P.SALARY
FROM PROGRAMMER P
WHERE  (P.SALARY) IN (
    SELECT MAX(SALARY)
    FROM PROGRAMMER
    GROUP BY PROF1
)
--2. Display the details of those who are drawing the same salary.
CREATE INDEX idx_salary ON PROGRAMMER (SALARY)
SELECT P1.*
FROM PROGRAMMER P1
JOIN PROGRAMMER P2 ON P1.SALARY = P2.SALARY AND P1.PNAME <> P2.PNAME
--3. Who are the programmers who joined on the same day?
CREATE INDEX idx_doj ON PROGRAMMER (DOJ)
SELECT P1.*
FROM PROGRAMMER P1
JOIN PROGRAMMER P2 ON P1.PNAME <> P2.PNAME AND P1.DOJ = P2.DOJ
--4. Who are the programmers who have the same Prof2?
CREATE INDEX idx_prof2 ON PROGRAMMER (PROF2)
SELECT P1.*
FROM PROGRAMMER P1
JOIN PROGRAMMER P2 ON P1.PNAME <> P2.PNAME AND P1.PROF2 = P2.PROF2

--5. How many packages were developed by the person who developed the cheapest package, where did he/she study?
CREATE INDEX idx_dcost ON SOFTWARE (DCOST);

SELECT P.PNAME, S.TITLE, P.PROF1, P.PROF2, S.SCOST
FROM PROGRAMMER P
JOIN SOFTWARE S ON P.PNAME = S.PNAME
WHERE S.SCOST = (
    SELECT MIN(SCOST)
    FROM SOFTWARE
)
ORDER BY S.SCOST

