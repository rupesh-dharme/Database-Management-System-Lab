-- Rupesh Dharme
-- 31124
-- TE 01
-- K1
-- Assignment 03

drop database assignment03;
create database assignment03;
use assignment03;

create table departments(
    dept_id int auto_increment not null, 
    dept_name varchar(15) not null,
    primary key(dept_id)
);

create table professors(
    prof_id int not null auto_increment,
    prof_fname varchar(20) not null,
    prof_lname varchar(20),
    dept_id int,
    designation varchar(20),
    salary int,
    doj date,
    email varchar(255),
    phone varchar(10),
    city varchar(15),
    primary key(prof_id),
    foreign key(dept_id) references departments(dept_id) on delete cascade
);

create table works(
    prof_id int not null,
    dept_id int not null,
    duration_hr int,
    primary key(prof_id, dept_id),
    foreign key(prof_id) references professors(prof_id) on delete cascade,
    foreign key(dept_id) references departments(dept_id) on delete cascade
);

create table shifts(
    prof_id int not null,
    shift varchar(10) not null,
    working_hours int not null,
    primary key(prof_id),
    foreign key(prof_id) references professors(prof_id) on delete cascade
);

show tables;
desc departments;
desc professors;
desc shifts;
desc works;

insert into departments (dept_name)
values ('Computer'),
       ('IT'),
       ('EnTC');

select * from departments;

insert into professors (prof_fname, prof_lname, dept_id, designation, salary, doj, email, phone, city)
values  ('Prof1', 'PLast1', 1, 'Professor', 100000, '2020-06-19', 'email@email.com', '9999888877', 'Pune'),
        ('Prof2', 'PLast2', 2, 'Assistant Professor', 100000, '2015-01-01', 'email1@email.com', '9999887877', 'Mumbai'),
        ('Prof3', 'PLast3', 3, 'Professor', 100000, '2008-02-07', 'email2@email.com', '8799888877', 'Mumbai'),
        ('Prof4', 'PLast4', 1, 'Assistant Professor', 100000, '2020-06-30', 'email3@email.com', '9999888877', 'Pune'),
        ('Prof5', 'PLast5', 2, 'Professor', 100000, '2015-01-01', 'email4@email.com', '9999887877', 'Mumbai'),
        ('Prof6', 'PLast6', 3, 'Assistant Professor', 100000, '2019-07-07', 'email5@email.com', '9998788877', 'Mumbai'),
        ('Prof7', 'PLast7', 1, 'Professor', 100000, '2019-02-02', 'email6@email.com', '9993338877', 'Pune');

select * from professors;

insert into shifts
values  (1,'Morning', 7),
        (2,'Afternoon', 7),
        (3,'Evening', 4),
        (4,'Morning', 7),
        (5,'Afternoon', 7),
        (6,'Evening', 4),
        (7,'Morning', 7);
select * from shifts;

insert into works
values
    (1, 1, 5),
    (2, 2, 7),
    (3, 3, 2),
    (4, 1, 6),
    (5, 2, 4),
    (6, 3, 3),
    (7, 1, 6);

select * from works;

-- 1. Find the professor details and department details using NATURAL JOIN.select * from professors
select * from professors
natural join departments;

-- 2. Find the prof_id, prof_name and shift. (INNER JOIN)
select professors.prof_id, prof_fname, shift
from professors
inner join shifts
on professors.prof_id = shifts.prof_id;

-- 3. List all the department details and the corresponding names of professors in the same
-- department.(left outer join)
select departments.dept_id, dept_name, prof_fname
from departments
left join professors
on departments.dept_id = professors.dept_id;

-- 4. List all the professors and the corresponding names of department.(right outer join)
select prof_fname, dept_name
from professors
right join departments
on professors.dept_id = departments.dept_id;

-- 5. Display professor name, dept_name, shift, salary where prof_id = 101;(multitable join)
select prof_fname, dept_name, shift, salary
from professors
inner join departments
on professors.dept_id = departments.dept_id
inner join shifts 
on professors.prof_id = shifts.prof_id
where professors.prof_id = 5;

-- 6. list the total number of professor in each department.(count and any join,groupby)
select dept_name, count(*)
from professors
inner join departments
on professors.dept_id = departments.dept_id
group by departments.dept_name;

-- 7. List the prof_id associated department and the dept_name having name ‘computer’;(subquery)
select prof_fname, prof_id, professors.dept_id, dept_name
from professors
inner join departments
on professors.dept_id = departments.dept_id
where dept_name in (
    select dept_name from departments
);

-- Find the names of all departments where the professors joined in year 2015 (or date of joining 
-- is 1-1-2015)
select dept_name
from professors
inner join departments
on professors.dept_id = departments.dept_id
where professors.doj = '2015-01-01';