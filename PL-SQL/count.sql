create database rough;
use rough;

create table staff (
emp_id numeric primary key,
emp_name varchar(50),
dep_id numeric,
constraint fk_dept foreign key (dep_id) references department(department_id)
);
 
create table department(
department_id numeric primary key,
dept_name varchar(50),
emp_count numeric
);
insert into department values(1,'ES',2),(2,'DNA',1);
insert into staff values (101,'Subramani',1),(102,'Hari',2),(103,'sankar',1);
 
select * from staff;
select * from department;
 
-- When inserting the employee details in emp table automatically trigger trigg the values
-- and update the values in department table emp_count columns
 
delimiter //
create trigger get_trigger
after insert on staff
for each row
begin
update department
set emp_count = emp_count+1
where department_id = new.dep_id;
end;
//
 
insert into staff values(110 , 'sedhu', 2);