create database EmployeeDB
go
use EmployeeDB
go

--create tables
create table Department(
	DepartID int primary key,
	DepartName varchar(50),
	Description varchar(100)
)
go

create table Employee(
	EmpCode char(6) primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Birthday smalldatetime not null,
	Gender Bit default (1),
	Address varchar(100),
	DepartID int foreign key references Department(DepartID),
	Salary money
)
go

--Insert records
insert into Department values (1, 'Marketing Department', 'Department of Marketing')
insert into Department values (2, 'Sales Department', 'Department of Sales')
insert into Department values (3, 'Human Resource Department', 'Department of Human Resource')

insert into Employee values ('NV0001', 'Lam', 'Tran', '19930322', 1, '68 Cau Giay', 1, 2000)
insert into Employee values ('NV0002', 'Andrea', 'Tisdale', '19950618', 0, '55 Hang Bai', 2, 1500)
insert into Employee values ('NV0003', 'Tony', 'Pham', '19980909', 1, '25 Hang Bac', 3, 3000)

--Increase salary for all employees
update Employee
set Salary = Salary * 1.1

--Add constraint
alter table Employee
add constraint postSalary check (Salary > 0)

--Create index
create index IX_DepartmentName on Department(DepartName)

--Create view
create view EmplCode
as
	select e.EmpCode, e.FirstName + ' ' + e.LastName as FullName, d.DepartName 
	from Employee e
	inner join Department d
	on e.DepartID = d.DepartID

--Create stored procedure
create procedure sp_getAllEmp @DepartmentID int
as
	select * from Employee e
	inner join Department d
	on e.DepartID = d.DepartID and d.DepartID = @DepartmentID

--Create stored procedure 2
create procedure sp_delDept @EmployeeID char(6)
as
	delete from Employee
	where EmpCode = @EmployeeID
