create database temp_DB;
use temp_DB;
 
create table employee (
employee_name varchar(20),
emp_experiance numeric,check(emp_experiance <5),
hike_percentage numeric,
emp_role varchar(20));
 
insert into employee values('Hari Gokul',2,25,'Data Analyst'),('Sankar',3,30,'Business analyst'),('Subramani',4,27,'Data Analyst');
select * from employee;
 
-- Question 1 - create a stored procedure that takes a product_id as 
-- input perameter and returns the details of that product;
create table product(
product_id numeric,
product_name varchar(20),
qty numeric,
price numeric
);
 
 
 
DELIMITER //
CREATE PROCEDURE get_detail(in id numeric)
begin 
select * from product where product_id = id;
end //
CALL get_detail(101);
 
-- IN and out perameter
insert into product values(1,'V-Neck T-Shirts',20,100),(2,'Chinese Neck',25,35),(2,'Y-Neck',25,125);
 
delimiter //
create procedure get_data(in id numeric,out total_qty numeric)
begin 
select sum(qty) as total_qty from product where product_id = id;
end //
 
call get_data(101, @product);
 
-- in&out method
delimiter //
create procedure multibytwo(inout num numeric)
begin
set num = num* 2; 
end //
 
set @value = 5;
call multibytwo(@value);
select @value;
 
-- Functions
 
delimiter // 
create function getproductdemo3(priceofproduct numeric) returns varchar(50)
deterministic
begin
declare pname varchar(50);
 
select group_concat(product_name separator ', ') as product_name into pname from product where price > priceofproduct ;
return pname;
end //
select * from product
select getproductdemo3(50);
 
delete from product where qty = 25
 
DELIMITER //
create procedure product_detail()
begin
select * from product;
end //
 
CALL product_detail()