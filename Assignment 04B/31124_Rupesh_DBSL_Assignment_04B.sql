drop database assignment04b;
create database assignment04b;
show databases;
use assignment04b;
create table circle(
  radius int not null auto_increment,
  area float not null,
  primary key(radius)
);
show tables;
desc circle;
delimiter / / create procedure calculate_area(radius int) begin
insert into
  circle
values
  (radius, 3.14 * radius * radius);
end;
/ / delimiter;
call calculate_area(5);
call calculate_area(6);
call calculate_area(7);
call calculate_area(8);
call calculate_area(9);
select
  *
from
  circle;