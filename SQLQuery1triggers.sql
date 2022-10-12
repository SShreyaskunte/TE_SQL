use TE

--SYNONYM - SIMILAR NAME
--TABLE ALIAS/ALTERNATIVE NAME FOR YOUR TABLE,VIEW,PROCEDURE,FUNCTION,TRIGGER ETC

--Table - EmployeeSalaryDetails - EmpSal

create synonym dep for Department

select * from dep
select * from Department

--synonyms - where they get stored in SQL Server
Select * from sys.synonyms 

--VIEWS - Virtual Tables - depend on a table - System Views(SQL Server),User-Defined views(Custom)
--TYPES - User-Defined views(Custom)
--------------------------------------
--SIMPLE - SINGLE TABLE
--COMPLEX - MORE THAN ONE TABLE 

-- 1.Simple View
select * from Employee

create view Emp_View
as
select * from Employee where EDesignation='Trainee'

--Retrieve the view
select * from Emp_View

--insert into a simple view - will automatically reflect the changes in the original table
insert into Emp_View values(11,'Mike','Trainee',25,100)

--update in a simple view
update Emp_View set EAge=24 where EID=11

--delete in a simple view
delete from Emp_View where EID=11

--2. Complex View

--Result of 2 tables - using join clause
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

create view Student_Dep
as
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

select * from Student_Dep
select * from Students

--insert in a complex view
insert into Student_Dep values(15,'Sammy',103,'MCOM','Lisa')--View or function 'Student_Dep' is not updatable because the modification affects multiple base tables.

--update in a complex view
update Student_Dep set SName='Shawn' where SID=6

--delete in a complex view
delete from Student_Dep where SID=6--View or function 'Student_Dep' is not updatable because the modification affects multiple base tables.

--CAST() FUNCTION - TYPECASTING

select cast(12.365 as int) as Result

select cast(12.365 as varchar) as Result

select cast('2022-10-06' as datetime) as 'Current date'

--CONVERT() FUNCTION

select convert(int,12.3654) as Result

--COALESCE()

select COALESCE(NULL,NULL,'SQL',NULL,'SERVER')
select COALESCE(NULL,1,'SQL',NULL,'SERVER')

--CURRENT_USER
select CURRENT_USER

--IIF() - Working of ternary operator

select IIF(1>5,10,5) as Result

select * from Employee

create view Emp_Training_Status
as
select EID, EName, IIF(EDesignation='Trainee','Training in Process','Training Completed') as 'Training Status' from Employee

select * from Emp_Training_Status

--CHOOSE()

select CHOOSE(3,'C#','SQL','ANGULAR','REACT') as Result

select * from demo
alter table demo add DOJ datetime

update demo set DOJ=cast('2022-10-06' as datetime) where TID=116
update demo set DOJ=cast('2022-1-06' as datetime) where TID=118
update demo set DOJ=cast('2022-7-06' as datetime) where TID=120
update demo set DOJ=cast('2021-10-06' as datetime) where TID=122

select TID,TName,DOJ,CHOOSE(MONTH([DOJ]),'Jan','Feb','Mar','Apr','May','June','July',
'Aug','Sep','Oct','Nov','Dec') as 'Month' from demo;

--CASE Statement - multiple conditions
--Simple
--Searched
select * from Employee 

--Simple
select EID,EName,EDEsignation,
CASE EDesignation	
	WHEN 'Junior S/W Engineer' THEN 'Junior S/W Engineer -  PROBATION FOR 6 MONTHS'
	WHEN 'Senior S/W Engineer' THEN 'Senior S/W Engineer -  Approved for Client Projects'
	ELSE 'UNDERGOING TRAINING'
END
AS 'Employee designation details'
from Employee

--Searched
select EID,EName,EDEsignation,
CASE
	WHEN EDesignation='Junior S/W Engineer' THEN 'Junior S/W Engineer -  PROBATION FOR 6 MONTHS'
	WHEN EDesignation='Senior S/W Engineer' THEN 'Senior S/W Engineer -  Approved for Client Projects'
	ELSE 'UNDERGOING TRAINING'
END
AS 'Employee designation details'
from Employee

--Searched
select EID,EName,EDesignation,EAge,
CASE
	WHEN EAge >= 24 AND EAge <= 26  THEN 'CHECK PREVIOUS WORK EXP'
	WHEN EAge > 26 and EAge <28 THEN 'GET THE LIST OF PREVIOUS PROJECTS'
ELSE 'UNDERGOING TRAINING'
END
AS 'Employee designation details'
from Employee


USE TE

select * from Employee
select * from Department

--WHERE CLAUSE - SUBQUERY

--single table
select EID,EName,EAge from Employee where EAge IN(select DISTINCT EAge from Employee where EAge<26)

--more than one table
select EID,EName,EAge,EDeptNo from Employee where EDeptNo IN(select DID from Department where Dname IN('Admin','Training'))

--SELECT CLAUSE - SUBQUERY - CORRELATED SUBQUERY

--single table
select EID,EName,(select EDeptNo from Employee ie where ie.EID=oe.EID) as 'Emp No' from Employee oe;

select * from Students
select * from Student_Dept
select * from Student_Rep

--more than one table

select SID,SName,(select DID from Student_Dept dep where dep.DID=stud.SDept) as 'Dept No' from Students stud;

--FROM CLAUSE - SUBQUERY

--single table
select SID,SName,SDept from (select DISTINCT count(SDept) as 'Total Departments' from Students) 
as i_stud,Students as o_stud
where o_stud.SID =i_stud.[Total Departments] 

--based on the assumption of SDept as the Score column
select SID,SName,SDept from (select DISTINCT avg(SDept) as 'Average Department' from Students) 
as i_stud,Students as o_stud
where o_stud.SDept <i_stud.[Average Department] 

--more than one table
select SID,SName,SDept from (select DISTINCT avg(DID) as 'Average Department' from Student_Dept) 
as i_stud,Students as o_stud
where o_stud.SDept < i_stud.[Average Department] 

--INSERT STATEMENT - SUBQUERY
select * from demo
select * from demo1

--INSERT INTO SELECT - Copying contents from one table to another
insert into demo1 select TID,TName from demo 

insert into demo1 select TID,TName from demo where TID IN(Select TID from demo where TID>102)

--UPDATE - SUBQUERY

UPDATE demo1 set TID=1000 where TName IN(select TName from demo where TName='John')

--DELETE -SUBQUERY

delete from demo1 where TID IN(Select TID from demo)


--TYPES OF SUB QUERIES
--1. INDEPENDENT NESTED QUERY
--2. DEPENDENT NESTED QUERY(CORRELATED QUERY)

--INDEPENDENT SUB QUERIES
--IN,NOT IN, ANY, ALL

select * from Employee
select * from Department

--100,101,102,103,104 - Any one is true
select * from Department where DID=ANY(select Distinct EDeptNo from Employee)

select * from Department where DID=Any(select avg(EDeptno) from Employee)

--100,101,102,103,104 - All the conditions must be satisfied
--105 and 1-6 did not have a matching values - FALSE
select * from Department where DID=ALL(select Distinct EDeptNo from Employee)

select * from Department where DID=ALL(select avg(EDeptno) from Employee) -- 102

--CORRELATED SUBQUERY

--EXISTS

select * from Department where exists(select EDeptNo from Employee where Department.DID=Employee.EDeptNo)

--Functions

use TE
create function FnSquare(@a int)
returns int
as 
begin
return @a * @a
end

select dbo.FnSquare(4) as Result

select * from demo

select dbo.FnSquare(Tid), Tname from demo

select dbo.FnSquare(EId), Ename from Employee

select * from demo

create function FnDateDifference(@DateField Date)
returns int
as
begin
	Declare @days int -- variable declaration
	set @days = datediff(day, @DateField,Getdate()) --assigining the diffenece in days to @days
	return @days
end

select Tid,TName,DOJ, dbo.FnDateDifference(DOJ) as 'Days Elapsed' from demo

alter function FnDateDifference(@DateField Date)
returns int
as
begin
	Declare @year int -- variable declaration
	set @year = datediff(year, @DateField,Getdate()) --assigining the diffenece in days to @month
	return @year
end

select dbo.FnDateDifference('2000/06/06') as 'Age'

--Table -valued function

Select * from Employee

--Procedure without params
create procedure sp
as
Begin
	select EDesignation, count(EDeptNo) as TotalEMpDes from Employee Group by EDesignation
end

exec sp

--Procedure with inout params

create procedure sp_EmpByName(@empname varchar(20))
as
Begin
	select * from Employee where EName = @empname
End

select * from Employee

exec sp_EmpByName 'John'

--procedure with output parameters - OUTPUT keyword

create procedure sp_TotalEmp(@totalemp int output)
as
Begin
	select @totalemp = count(EID) from Employee
End

Declare @result int
exec sp_TotalEmp @totalemp OUTPUT -- output is mandatory

use TE

create trigger trgDemoInsert
on demo
FOR INSERT
as 
begin
	print 'You cannot insert into the demo table'
	ROLLBACK transaction
end

select * from demo

insert into demo values(127,'Mad Max','2022/02/01')

delete from demo where TName = 'Cena'

alter trigger trgDemoInsert
on demo
FOR INSERT, UPDATE,DELETE
as 
begin
	print 'You cannot perform DML operation on the demo table'
	ROLLBACK transaction
end

create trigger trgDML
on demo
FOR INSERT, UPDATE, DELETE
as 
begin
	if(DATEPART(HH,GETDATE())) > 13
	BEGIN
		print 'You cannot insert into the demo table after 1pm'
		ROLLBACK transaction
	end
end

alter trigger trgDML
on demo
FOR INSERT, UPDATE, DELETE
as 
begin
	if(DATEPART(HH,GETDATE())) < 13
	BEGIN
		print 'You cannot insert into the demo table before 1pm'
		ROLLBACK transaction
	end
end

use TE

create trigger trg_instedof_onDemo
on demo
instead of insert
as 
select * from demo

insert into demo1 values(1029,'Volvarine')

create trigger trg_after_demo1
on demo1
after insert
as
	print 'After Trigger'

select * from demo1