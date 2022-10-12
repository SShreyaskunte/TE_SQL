create synonym demoo for demo


select * from demoo

select * from demo

Select * from sys.synonyms

--Index

--create a clustered index on demo table
create clustered index ind_TID on demo(TID)

--create a non clustered index on demo table
create index ind_TName on demo(TName) 

select * from demo

--Filtered index
create index ind on Student_Dept(DHead) where DName='BSC'
select * from Student_Dept where DName='BSC'



--Views--

--simple view-
select * from Student_Dept

create view dept_view
as
select * from Student_Dept where DName='MCA'

--Retrieve the view
select * from dept_view
--insert into a simple view - will automatically reflect the changes in the original table
insert into dept_view values(112,'BTECH','Jennie')

--update in a simple view
update dept_view set DHead='Rose' where DID=107
select * from Student_Dept
--delete in a simple view
delete from dept_view where DID=107

--Complex view--
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

create view Student_Dep
as
select s.SID,s.SName,sd.DID,sd.DName,sd.DHead 
from Students as s inner join Student_Dept as sd on s.SDept=sd.DID;

select * from Student_Dep


--update in a complex view
update Student_Dep set SName='Joy' where SID=5


--Sequence--
create table demo
(
TID int,
TName varchar(20)
)

create sequence TraineeID as int start with 100 increment by 2

insert into demo values(NEXT VALUE FOR TraineeID,'John')
insert into demo values(NEXT VALUE FOR TraineeID,'Sam')
insert into demo values(NEXT VALUE FOR TraineeID,'Paul')
insert into demo values(NEXT VALUE FOR TraineeID,'James')

select * from demo

create table demo1
(
TID int,
TName varchar(20)
)

insert into demo1 values(NEXT VALUE FOR TraineeID,'John')
insert into demo1 values(NEXT VALUE FOR TraineeID,'Sam')
insert into demo1 values(NEXT VALUE FOR TraineeID,'Paul')
insert into demo1 values(NEXT VALUE FOR TraineeID,'James')

select * from demo
select * from demo1

truncate table demo1

alter sequence TraineeID restart with 1000 increment by 1

drop sequence TraineeID

--string functions--

--ASCII function
SELECT DName, ASCII(DName) AS NumCodeOfFirstChar
FROM Student_Dept;

--CONCAT FUNCTION--Adds two strings
SELECT CONCAT('.NET', 'Full Stack Developer');

--LEN() function--Returns the length of string
SELECT LEN('DOTNET_Fullstack_Developer');

--Math Functions

--MIN() Function--Returns minimum value among two values
Select Min(DID) as lowestValue from Student_Dept

--MAX() Function--Returns maximum value among two values
Select MAX(DID) as HighestValue from Student_Dept

--Power Function--Returns the value of a number raised to the power of another number
SELECT POWER(5, 2);

--SUM() Function--Returns summation of a value
SELECT SUM(DID) AS summation FROM Student_Dept;

--Date Functions

--CURRENT_TIMESTAMP--Returns the current date and time
SELECT CURRENT_TIMESTAMP;

--DATEDIFF function--Returns the difference between two dates
SELECT DATEDIFF(year, '2011/02/13', '2001/02/13') AS Date;

--Month() Function--Return the month part of a date:
SELECT MONTH('2011/02/13') AS Month;