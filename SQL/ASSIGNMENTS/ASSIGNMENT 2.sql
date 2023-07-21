DROP DATABASE IF EXISTS MODULE_2
GO
CREATE DATABASE [MODULE_2]
GO
USE [MODULE_2]
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
GO
SELECT * FROM PROGRAMMER
SELECT * FROM STUDIES
SELECT * FROM SOFTWARE
GO
--1) What is the Highest Number of copies sold by a Package?
SELECT MAX(SOLD) AS [MAX SOLD] FROM SOFTWARE
--2) Display lowest course Fee.
SELECT MIN([COURSE-FEE]) FROM STUDIES
--3) How old is the Oldest Male Programmer.
SELECT DATEDIFF(YEAR,MIN(DOB),GETDATE()) AS OLD FROM PROGRAMMER WHERE GENDER='M'
--4) What is the AVG age of Female Programmers?
SELECT AVG(DATEDIFF(YEAR,DOB,GETDATE())) AS [AVG AGE OF FEMALE] FROM PROGRAMMER WHERE GENDER='F'
--5) Calculate the Experience in Years for each Programmer and Display with their names in Descending order.
SELECT PNAME FROM PROGRAMMER ORDER BY DATEDIFF(YEAR,DOB,GETDATE()) DESC
--6) How many programmers have done the PGDCA Course?
SELECT COUNT(*) AS PGDCA FROM STUDIES WHERE COURSE='PGDCA'
--7) How much revenue has been earned thru sales of Packages Developed in C.
SELECT SUM(SOLD) FROM SOFTWARE WHERE DEVELOPIN='C'
--8) How many Programmers Studied at Sabhari?
SELECT COUNT(*) AS [STUDIED AT SABHARI] FROM STUDIES WHERE INSTITUTE='SABHARI'
--9) How many Packages Developed in DBASE?
SELECT COUNT(*) AS [DBASE] FROM SOFTWARE WHERE DEVELOPIN='DBASE'
--10) How many programmers studied in Pragathi?
SELECT COUNT(*) AS [STUDIED AT PRAGATHI] FROM STUDIES WHERE INSTITUTE='PRAGATHI'
--11) How many Programmers Paid 5000 to 10000 for their course?
SELECT COUNT(*) AS [FEE B/W 5000 TO 10000] FROM STUDIES WHERE [COURSE-FEE]>5000 AND [COURSE-FEE]<10000
--12) How many Programmers know either COBOL or PASCAL?
SELECT COUNT(*) AS [COBOL or PASCAL?] FROM SOFTWARE WHERE DEVELOPIN='COBOL' OR DEVELOPIN='PASCAL'
--13) How many Female Programmers are there?
SELECT COUNT(*) AS [FEMALE PROGRAMMERS] FROM PROGRAMMER WHERE GENDER='F'
--14) What is the AVG Salary?
SELECT AVG(SALARY) [AVG SALARY OF PROGRAMMER] FROM PROGRAMMER
--15) How many people draw salary 2000 to 4000?
SELECT COUNT(*) AS [salary 2000 to 4000] FROM PROGRAMMER WHERE SALARY>2000 AND SALARY<4000
--16) Display the sales cost of the packages Developed by each Programmer Language wise
SELECT DEVELOPIN,SUM(SCOST*SOLD) FROM SOFTWARE GROUP BY DEVELOPIN
--17) Display the details of the software developed by the male students of Sabhari.
SELECT S.PNAME,S.TITLE,S.DEVELOPIN,S.SCOST,S.DCOST,S.SOLD FROM SOFTWARE AS S JOIN STUDIES AS ST ON S.PNAME=ST.PNAME JOIN PROGRAMMER AS P ON P.PNAME=ST.PNAME WHERE GENDER='M' AND INSTITUTE='SABHARI'
--18) Who is the oldest Female Programmer who joined in 1992?
SELECT PNAME FROM PROGRAMMER WHERE DOJ=(SELECT MIN(DOJ) FROM PROGRAMMER WHERE 1992=YEAR(DOJ) AND GENDER='F')
--19) Who is the youngest male Programmer born in 1965?
SELECT PNAME FROM PROGRAMMER WHERE DOB=(SELECT MAX(DOB) FROM PROGRAMMER WHERE 1965=YEAR(DOB) AND  GENDER='M')
--20) Which Package has the lowest selling cost?
SELECT DEVELOPIN FROM SOFTWARE WHERE SCOST=(SELECT MIN(SCOST) FROM SOFTWARE)
--21) Which Female Programmer earning more than 3000 does not know C, C++,ORACLE or DBASE?
SELECT P.PNAME FROM PROGRAMMER AS P WHERE P.SALARY>3000 AND NOT (PROF1='C' AND PROF1='C++' AND PROF1='ORACLE' AND PROF1='DBASE') AND NOT (PROF2='C' AND PROF2='C++' AND PROF2='ORACLE' AND PROF2='DBASE')
--22) Who is the Youngest Programmer knowing DBASE?
SELECT PNAME FROM PROGRAMMER WHERE DOB=(SELECT MAX(DOB) FROM PROGRAMMER WHERE PROF1='DBASE' OR PROF2='DBASE')
--23) Which Language is known by only one Programmer?
SELECT PROF1 FROM programmer GROUP BY PROF1 HAVING COUNT(*) = 1;
--24) Who is the most experienced male programmer knowing PASCAL?
SELECT PNAME FROM PROGRAMMER WHERE DOJ=(SELECT MIN(DOJ) FROM PROGRAMMER WHERE (PROF1='PASCAL' OR PROF2='PASCAL') AND GENDER='M')
--25) Who is the least experienced Programmer?
SELECT PNAME FROM PROGRAMMER WHERE DOJ=(SELECT MAX(DOJ) FROM PROGRAMMER)
--26) Display the Number of Packages in Each Language for which Development Cost is lessthan 1000.
SELECT DEVELOPIN,TITLE,COUNT(*) AS [NUMBER OF PACKAGES] FROM SOFTWARE WHERE  DCOST<1000 GROUP BY DEVELOPIN,TITLE