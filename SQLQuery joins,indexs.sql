use TE

create table Students
(
SID int primary key,
SName varchar(20) Not Null,
Sdept int Unique Not Null
)

create table StudentDept
(
DeptId int  primary key,
DeptName varchar(20),
DeptHead varchar(20)
)

select * from Students
select * from StudentDept

insert into Students values(1,'Peter',101),(2,'Johan Cena',102),(3,'Macclum',103),(4,'Joe',104),(5,'Dan',105),(6,'Luci',106)

insert into StudentDept values(101,'BCA','Mand'),(102,'BBA','Dwyane'),(103,'BCOM','Rock'),(104,'BSC','John'),(105,'BBA','Harry'),(106,'BBM','Mary')

--Inner join
select Students.SID,Students.SName,Sdept,DeptName,DeptHead from Students inner join 
StudentDept on Students.Sdept = StudentDept.DeptId;

insert into Students values(7,'Paul',107),(8,'Walkrr Cena',108),(9,'Tom',109);

select s.SID,s.SName,Sdept,DeptName,DeptHead from Students as s inner join 
StudentDept as sd on s.Sdept = sd.DeptId;

--Outer join

select Students.SID,Students.SName,Sdept,DeptName,DeptHead from Students left join 
StudentDept on Students.Sdept = StudentDept.DeptId;


select Students.SID,Students.SName,Sdept,DeptName,DeptHead from Students right join 
StudentDept on Students.Sdept = StudentDept.DeptId;

insert into StudentDept values(110,'MCA','Mandalorian'),(111,'MBA','Dwyane the rock')

select s.SID,s.SName,Sdept,DeptName,DeptHead from Students as s Full join 
StudentDept as sd on s.Sdept = sd.DeptId;

-- Alter the students table

alter table Students add SRep varchar(20)

create table StudentREp
(
SID int primary key,
SName varchar(20) unique Not Null,
)

create table demo
(
Tid int,
TName varchar(20),
)
create sequence TraineeID as int start with 100 increment by 2

insert into demo values(NEXT VALUE FOR TraineeID, 'John')
insert into demo values(NEXT VALUE FOR TraineeID, 'Cena')
insert into demo values(NEXT VALUE FOR TraineeID, 'Paul')
insert into demo values(NEXT VALUE FOR TraineeID, 'Walker')

create table demo1
(
Tid int,
TName varchar(20),
)
insert into demo1 values(NEXT VALUE FOR TraineeID, 'John')
insert into demo1 values(NEXT VALUE FOR TraineeID, 'Cena')
insert into demo1 values(NEXT VALUE FOR TraineeID, 'Paul')
insert into demo1 values(NEXT VALUE FOR TraineeID, 'Walker')

select * from demo
select * from demo1

truncate table demo

alter sequence TraineeID  restart with 1000 increment by 1

--Index
--create a clustered index on demo table
create clustered index ind_TID on demo(TID)

--create a non clustered index on demo table

create  index ind_TName on demo(TName)

select * from Employee

create index ind_Eds on Employee(EDesignation) where EDesignation = 'Trainee'

select * from Employee where EDesignation = 'Trainee'








