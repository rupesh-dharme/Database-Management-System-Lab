-- Rupesh Dharme
-- TE 01
-- L1
-- 31124
-- Assignment 05

/*
Named PL/SQL Block: PL/SQL Stored Procedure and Stored Function.
Write a Stored Procedure namely proc_Grade for the categorization of student. 
If marks scored by students in examination is <=1500 and marks>=990 then student
will be placed in distinction category 
if marks scored are between 989 and900 category is first class, 
if marks899and 825 category is Higher Second Class.
Write a PL/SQLblock to use procedure created with above requirement.
Stud_Marks(name, total_marks) Result(Roll,Name, Class)
Note: Instructor will frame the problem statement for writing stored procedure and
Function in line with above statement.
*/

drop database assignment05;

create database assignment05;

use assignment05;

-- Tables: Stud_Marks(name, total_marks) Result(Roll,Name, Class)
create table students(
    roll_no int not null auto_increment,
    name varchar(20) not null,
    marks int not null,
    primary key(roll_no)
);

create table results(
    roll_no int not null,
    name varchar(20) not null,
    class varchar(20),
    primary key(roll_no),
    foreign key(roll_no) references students(roll_no) on delete cascade
);

insert into students
values (31124, 'Rupesh', 1486);

insert into students(name, marks)
values ('Akash', 950),
       ('Rajan', 850),
       ('Nikhil', 1490),
       ('Sahil', 880);

select * from students;

select * from results;

delimiter //

-- Write a Stored Procedure namely proc_Grade for the categorization of student
create procedure proc_grade(rno int)
begin
declare n varchar(20);
declare m int;
select name, marks into n, m from students where roll_no = rno;
-- marks<=1500 and marks>=990 -> distinction category
if (m>=990 and m<=1500) then
    insert into results values(rno, n, 'distinction');
-- if marks scored are between 989 and900 category is first class, 
elseif (m>=899 and m<990) then
    insert into results values(rno, n, 'first class');
-- if marks899and 825 category is Higher Second Class.
elseif (m>=825 and m<899) then
    insert into results values(rno, n, 'higher second class');
end if;
end;
//

delimiter ;


call proc_grade(31124);
select * from students;
select * from results;

call proc_grade(31125);
call proc_grade(31126);
call proc_grade(31127);

select * from results;
