use TE

create synonym dep for Department

select * from dep

select * from sys.synonyms

Select * from Employee

create view EmpView 
as
select * from Employee where EDesignation = 'Trainee'

select * from EmpView

insert into EmpView values(11,'Mike Ross','Trainee',25,101)

