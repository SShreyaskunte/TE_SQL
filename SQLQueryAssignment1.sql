create database ORG

use ORG

Create table Worker
(
Worker_ID int NOT NULL PRIMARY KEY IDENTITY(1,1),
First_Name varchar(25),
Last_Name varchar(25),
Salary int,
Joining_Date Datetime,
Department varchar(25)
)

select * from Worker

update Worker set Joining_Date = '2014-04-11 09:00:00' where Worker_ID = 3

create database TE_Core_MVC

USE TE_Core_MVC

create table Trainess
(
TID int primary key,
TName varchar(25),
TAge int check(TAge >=22)
)

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT,
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);


INSERT INTO Bonus 
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '2016-02-20'),
		(002, 3000, '2016-06-11'),
		(003, 4000, '2016-02-20'),
		(001, 4500, '2016-02-20'),
		(002, 3500, '2016-06-11');

select * from Bonus

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(25),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);


INSERT INTO Title 
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
 (001, 'Manager', '2016-02-20 00:00:00'),
 (002, 'Executive', '2016-06-11 00:00:00'),
 (008, 'Executive', '2016-06-11 00:00:00'),
 (005, 'Manager', '2016-06-11 00:00:00'),
 (004, 'Asst. Manager', '2016-06-11 00:00:00'),
 (009, 'Lead', '2016-06-11 00:00:00'),
 (003, 'Lead', '2016-06-11 00:00:00');

 select * from Title

 insert into Worker values ('Keil', 'Star', 10000, '2014-10-06 09:00:00.000', 'Bank')

select * from Worker

select First_Name from Worker as WORKER_NAME

SELECT UPPER(First_Name) AS UppercaseName
FROM Worker;

SELECT DISTINCT DEPARTMENT from Worker;

SELECT SUBSTRING(First_Name,1,3) 
     FROM Worker;

SELECT DISTINCT Len(DEPARTMENT) from Worker;

SELECT CONCAT(First_Name,' ', Last_Name) AS Complete_Name from Worker

select * from Worker where First_Name IN ('Vipul','Satish')

Select * from Worker where Department = 'Admin'

select * from Worker where First_Name LIKE '%a';

select * from Worker where First_Name LIKE '%a%';