use TE

create table salesman
(
salesman_id int Primary key,
name varchar(25),
city varchar(25),
commission float
);

select * from salesman;

create view Nyc
as
select * from salesman where city = 'New York';

select * from Nyc;

create view salesmanDetails
as
select salesman_id, name, city from salesman;

select * from salesmanDetails;

CREATE VIEW citynum
AS 
SELECT city, COUNT (DISTINCT salesman_id) FROM salesman
GROUP BY city;

SELECT city, COUNT (DISTINCT salesman_id) FROM salesman
GROUP BY city;


select * from citynum

create table customer
(
customer_id int primary key,
cust_name varchar(25),
city varchar(25),
grade int,
salesman_id int references salesman(salesman_id),
);

select * from customer;

create view customer_number
as
SELECT customer_id, COUNT (DISTINCT customer_id) FROM customer
GROUP BY customer_id;


select * from customer_number

create table orders
(
ord_no int primary key,
purch_amt float,
ord_date datetime,
customer_id int references customer(customer_id),
salesman_id int references salesman(salesman_id)
);

select * from salesman;

select * from orders

drop table orders;

CREATE VIEW nameorders
AS SELECT ord_no, purch_amt, a.salesman_id, name, cust_name
FROM orders a, customer b, salesman c
WHERE a.customer_id = b.customer_id
AND a.salesman_id = c.salesman_id;

select * from nameorders;

use TE

create function Fn_Add(@a int, @b int)
returns int
as
begin
	return @a + @b
end

select dbo.Fn_Add(4,4) as Result



create trigger trig_ger
on demo
FOR INSERT,DELETE,UPDATE
as
begin
	if (DATEPART(HH,GETDATE())>18 or DATEPART(HH,GETDATE())<10)
	BEGIN
		print 'Insertion,Deletion or Updation not possible between 6:00PM and 10AM'
		Rollback transaction
	END
end

select * from demo

delete from demo where TID=116

select * from Employee

create procedure sp_TotalEmp(@totalemp int OUTPUT)
as
Begin
	Select @totalemp=count(EID) from Employee
End

--execute the procedure with ouput parameter
--execute the below three lines at once
Declare @Result int
exec sp_TotalEmp @Result OUTPUT --OUPUT is mandatory
Print @Result

create trigger Trig
on ALL Server
For Create_Table, Alter_Table,Drop_Table
as
Begin
	Print 'DDL cannot be performed'
	Rollback Transaction
End

create table Assign
(AID int
);

disable trigger Trig on All server

select * from demo1;

BEGIN TRANSACTION
	insert into demo1 values(1008,'Rock');
	--SAVEPOINT
	SAVE TRANSACTION insert_stmt
	delete from demo1 where TID=1003;
	ROLLBACK TRANSACTION insert_stmt
COMMIT TRANSACTION

create procedure sp_DivideByZeroTryCatch
as
Begin
	select EDesignation,count(EDeptNo) as Total_Emp_Designation from Employee Group By EDesignation
end

alter procedure sp_DivideByZeroTryCatch
@num1 int,
@num2 int
as
BEGIN	
	Declare @Result int
	SET @Result = 0
	BEGIN TRY
		BEGIN
			IF(@num2=0)
			RAISERROR('Cannot Divide By Zero',16,127) -- We can either use ERROR_NUMBER() or ERROR_MESSAGE()
			--THROW 50001,'Cannot Divide By Zero',1 -- ERROR_NUMBER() & ERROR_MESSAGE() & ERROR_STATE() & ERROR_SEVERITY() is 16 by default
			SET @Result=@num1/@num2
			PRINT 'Value is:' + CAST(@Result as varchar)
		END
	END TRY
	BEGIN CATCH
		PRINT ERROR_NUMBER()
		PRINT ERROR_MESSAGE()
		PRINT ERROR_SEVERITY()
		PRINT ERROR_STATE()		
	END CATCH
END

execute sp_DivideByZeroTryCatch 10,0