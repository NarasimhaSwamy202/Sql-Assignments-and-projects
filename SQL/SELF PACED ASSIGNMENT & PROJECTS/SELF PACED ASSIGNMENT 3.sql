--1. Create an ‘Orders’ table which comprises of these columns: 
--‘order_id’, ‘order_date’, ‘amount’, ‘customer_id’.
create table orders
(
order_id int,
order_date date,
amount int,
customer_id int
)
--2. Insert 5 new records.
insert into orders values
(1,'2023/01/25',56000,1),
(2,'2023/02/23',36223,3),
(3,'2023/03/12',23678,5),
(4,'2023/04/13',26373,7),
(5,'2023/05/14',23672,8)
Select * from orders
--3. Make an inner join on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’ column.
 Select C.*,O.order_id,O.order_date,O.amount from customer C
 inner join
 orders O
 on C.Customer_id=O.customer_id
--4. Make left and right joins on ‘Customer’ and ‘Orders’ tables on the ‘customer_id’
column. 
Select * from customer C left join orders O
On C.Customer_id=O .customer_id
Select * from customer C right join orders O
on C.Customer_id=O.customer_id
--5. Make a full outer join on ‘Customer’ and ‘Orders’ table on the ‘customer_id’
column. 
Select * from customer C
full join orders O
on C.Customer_id=O.customer_id
--6. Update the ‘Orders’ table and set the amount to be 100 where ‘customer_id’ is 3.
Select * from orders
update orders set amount=100 where customer_id=3