drop database assignment07;

create database assignment07;

use assignment07;

create table library(
    id int not null auto_increment,
    name varchar(20) not null,
    name_book varchar(20) not null,
    doi date,
    dor date,
    primary key(id)
);

desc library;

create table library_audit(
    id int not null auto_increment,
    name varchar(20) not null,
    remark varchar(100),
    primary key(id)
);

desc library_audit;

insert into library (name, name_book, doi, dor)
values ('Rupesh', 'Book1', '2020/10/10', '2020/10/11'),
        ('Omkar', 'Book2', '2020/10/10', '2020/10/11'),
        ('Dheeraj', 'Book3', '2020/10/10', '2020/10/11'),
        ('Gayatri', 'Book4', '2020/10/10', '2020/10/11'),
        ('Nikhil', 'Book5', '2020/10/10', '2020/10/11');

select * from library;

delimiter //

create trigger delete_trigger
after delete on library
for each row
begin
    insert into library_audit(name, remark) values (old.name, 'This record was deleted.');
end;
//

create trigger update_trigger
after update on library
for each row
begin
    insert into library_audit(name, remark) values (old.name, 'This record was updated');
end;
//

create trigger statement_level_insert
after insert on library
begin
    insert into library_audit(name, remark) values ('Statement level', 'Insert trigger hit');
end;
//

create trigger statement_level_delete
after delete on library
begin 
    insert into library_audit(name, remark) values ('Statement level', 'Delete trigger hit');
end;
//

delimiter ;

delete from library where name = 'Rupesh';
select * from library_audit;

delete from library where name = 'Omkar';
select * from library_audit;

insert into library (name, name_book, doi, dor)
values ('Omkar', 'Book1', '2020/10/10', '2020/10/11');
select * from library_audit;

delete from library where name = 'Omkar';
select * from library_audit;

update library
set doi = curdate()
where name = 'Nikhil';
select * from library_audit;

update library
set dor = curdate()
where name = 'Gayatri';
select * from library_audit;