-- Rupesh Dharme
-- TE 01
-- K1
-- 31124
-- Assignment 04
/*
 Unnamed PL/SQL code block: Use of Control structure and Exception handling is
 mandatory.
 Suggested Problem statement:
 Consider Tables: 
 1. Borrower(Roll_no, Name, DateofIssue, NameofBook, Status) 
 2. Fine(Roll_no,Date,Amt)
 Accept Roll_no & NameofBook from user. 
  Check the number of days (from date of issue),
  If days are between 15 to 30 then fine amount will be Rs 5per day.
  If no. of days>30, per day fine will be Rs 50 per day & for days less than 30, Rs. 5 per 
 day. 
  After submitting the book, status will change from I to R.
  If condition of fine is true, then details will be stored into fine table.
  Also handles the exception by named exception handler or user define exception handler.
 */

drop database assignment04;

create database assignment04;

use assignment04;

show tables;

create table borrowers(
    roll_no int not null auto_increment,
    name varchar(20) not null,
    doi date not null,
    name_book varchar(20) not null,
    status char(1) not null,
    primary key(roll_no)
);

create table fines(
    roll_no int not null,
    dof date not null,
    amount int not null,
    foreign key(roll_no) references borrowers(roll_no) on delete cascade
);

show tables;

desc borrowers;

desc fines;

insert into borrowers
values (100, 'Rupesh', '2021-08-08', 'CNS', 'I');

insert into borrowers (name, doi, name_book, status)
values ('Rohan', '2021-07-05', 'DSA', 'I'),
       ('Dheeraj', '2021-06-20', 'SPOS', 'I'),
       ('Gayatri', '2021-07-18', 'MP', 'I'),
       ('Tejas', '2021-06-03', 'FDS', 'I');

select * from borrowers;

delimiter // 

create procedure calculate_fine(roll int, name varchar(20)) 
begin 
    declare days int;

    -- Also handles the exception by named exception handler or user define exception handler
    declare continue handler for not found 
    begin
        select "Customer Not Found";
    end;

    -- Check the number of days (from date of issue)
    select datediff(curdate(), doi) into days from borrowers where roll_no = roll and name = name;

    -- If days are between 15 to 30 then fine amount will be Rs 5per day
    if (days > 15 and days < 30) then
        insert into fines(roll_no, dof, amount)
        values (roll, curdate(), 5 * days);

    -- If no. of days>30, per day fine will be Rs 50 per day & for days less than 30, Rs. 5 per 
    -- day
    elseif days > 30 then
        insert into fines(roll_no, dof, amount) -- If condition of fine is true, then details will be stored into fine table
        values (roll, curdate(), 150 +(days -30) * 50);
    end if;

    -- After submitting the book, status will change from I to R
    update borrowers set status = 'R' where roll_no = roll;
end;
// 

delimiter ;

call calculate_fine(100, 'Rupesh');

select * from fines;

call calculate_fine(101, 'Rohan');

select * from fines;

call calculate_fine(104, 'Tejas');

select * from fines;
