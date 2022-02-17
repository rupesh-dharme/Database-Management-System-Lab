/*
Name: Rupesh Dharme
Class: TE 01
Roll number: 31124
Batch: L1
Assignment Number: 06

Cursors: (All types: Implicit, Explicit, Cursor FOR Loop, Parameterized Cursor)
Write a PL/SQL block of code using parameterized Cursor, that will merge the data 
available in the newly created table 
N_EmpId with the data available in the table O_EmpId.
If the data in the first table already exist in the second table then that data should be 
skipped.
*/

drop database assignment06;

create database assignment06;

use assignment06;

create table O_Emps(
    id int not null auto_increment,
    name varchar(20) not null,
    salary int not null default 10000,
    primary key(id)
);

desc O_Emps;

create table N_Emps(
    id int not null auto_increment,
    name varchar(20) not null,
    salary int not null default 20000,
    primary key(id)
);

desc N_Emps;

insert into O_Emps (id, name)
    values (1, 'Rupesh'),
        (2, 'Rohan'),
        (3, 'Nikhil'),
        (5, 'Omkar'),
        (7, 'Dheeraj');

select * from O_Emps;

insert into N_Emps (id, name)
    values (1, 'Rama'),
        (2, 'Ramesh'),
        (3, 'Omkar');

select * from N_Emps;

delimiter //

create procedure merge()
begin
    declare v_name varchar(20);
    declare v_salary int;
    declare c1 cursor for select name, salary from O_Emps;
    declare exit handler for NOT FOUND select "Successfully Merged";
    open c1;
    loop
        fetch c1 into v_name, v_salary;
        if v_name not in (select name from N_Emps) then
            insert into N_Emps (name, salary) values (v_name, v_salary);
        end if;
    end loop;
    close c1;
end //

create procedure merge_parameterized(in name_in varchar(20))
begin
    declare v_name varchar(20);
    declare v_salary int;
    declare c1 cursor for select name, salary from O_Emps where name = name_in;
    declare exit handler for NOT FOUND select "Successfully Merged";
    open c1;
    loop
        fetch c1 into v_name, v_salary;
        if v_name not in (select name from N_Emps) then
            insert into N_Emps (name, salary) values (v_name, v_salary);
        end if;
    end loop;
    close c1;
end //


delimiter ;

select * from N_Emps;

call merge_parameterized("Nikhil");

select * from N_Emps;

select * from N_Emps;

call merge();

select * from N_Emps;