--1. Create a view named ‘customer_san_jose’ which comprises of onlythosecustomers who are from San Jose
CREATE VIEW customer_san_jose AS
SELECT *
FROM Customers
WHERE City = 'San Jose'
SELECT * FROM customer_san_jose
--2. Inside a transaction, update the first name of the customer to Franciswhere the  last name is Jordan: a. Rollback the transaction b. Set the first name of customer to Alex, where the last nameisJordan
--A.
BEGIN TRANSACTION
 UPDATE Customers
 SET First_Name = 'Francis'
 WHERE Last_Name = 'Jordan'
ROLLBACK TRANSACTION
--B.
BEGIN TRANSACTIO
 UPDATE Customers
 SET First_Name = 'Alex'
 WHERE Last_Name = 'Jordan'
COMMIT TRANSACTION
--3. Inside a TRY... CATCH block, divide 100 with 0, print the default error message.
BEGIN TRY
 SELECT 100 / 0
END TRY
BEGIN CATCH
 PRINT ERROR_MESSAGE()
END CATCH
--4. Create a transaction to insert a new record to Orders table and saveit.
BEGIN TRY
BEGIN TRANSACTION
 INSERT INTO Orders (OrderNumber, CustomerID, OrderDate)
 VALUES ('123456', 1, GETDATE())
 COMMIT TRANSACTION
END TRY
BEGIN CATCH
 ROLLBACK TRANSACTION;
 PRINT ERROR_MESSAGE()
END CATCH