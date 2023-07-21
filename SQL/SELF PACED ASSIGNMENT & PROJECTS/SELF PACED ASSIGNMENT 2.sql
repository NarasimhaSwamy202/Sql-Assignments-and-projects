--1. Create a customer table which comprises of these columns: 
--‘customer_id’, ‘first_name’, ‘last_name’, ‘email’, ‘address’, ‘city’,’state’,’zip’
create database assignemt_1
use assignemt_1
Create table customer
(
Customer_id int,
First_name varchar(20),
Last_name varchar(20),
email varchar(30),
address varchar(20),
city varchar(20),
state varchar(20),
Zip int
)
Select * from customer
--2. Insert 5 new records into the table 
 insert into customer values
 (1,'Aman','Sharma','aman123@outlook.com','1st cross','Bangalore','karnataka',279882),
 (2,'Ravi','Singh','ravi@gmail.com','2nd cross','Noida','Delhi',68768),
 (3,'Tania','Singh','tania@gmail.com','3rd main','Noida','Delhi',678234),
 (4,'Gourav','Singh','gourav1@outlook.com','7th 
street','Bangalore','Karnataka',687786),
 (5,'Aditya','Kumar','aditya@gmail.com','5th Street','Bangalore','Karnataka',989879)
 
--3. Select only the ‘first_name’ and‘last_name’ columns from the customer table 
Select First_name,Last_name from customer
--4. Select those records where ‘first_name’ starts with “G” and city is ‘San Jose’. 
 Select * from customer where First_name like'G%' and city like'San Jose'
-- or
 Select * from customer where First_name like'G%' and city='San Jose'
--5. Select those records where Email has only ‘gmail’. 
Select * from customer where email like'%GMAIL%'
--6. Select those records where the ‘last_name’ doesn't end with “A”.
Select * from customer where Last_name not like '%A'