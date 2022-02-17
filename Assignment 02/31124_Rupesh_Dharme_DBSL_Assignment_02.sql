drop database assignment02;
create database assignment02;

show databases;

use assignment02;

create table customers (
    customer_id int not null auto_increment,
    first_name varchar(25) not null,
    last_name varchar(25),
    company varchar(25),
    customer_address varchar(255),
    city varchar(25),
    phone char(10),
    primary key(customer_id)
);

create table authors ( 
    author_id int not null auto_increment, 
    author_name varchar(25) not null, 
    author_country varchar(25), 
    primary key (author_id) 
);

create table publishers ( 
    publisher_id int not null auto_increment, 
    publisher_name varchar(25) not null, 
    publisher_address varchar(25) not null, 
    create_year year not null, 
    primary key (publisher_id)
);

create table books ( 
    isbn varchar(25) not null, 
    title varchar(25) not null, 
    unit_price int not null, 
    author_id int not null, 
    publisher_id int not null, 
    pub_year year not null, 
    primary key (isbn), 
    foreign key (publisher_id) references publishers(publisher_id) on delete cascade, 
    foreign key (author_id) references authors(author_id) on delete cascade 
);

create table orderings ( 
    order_no int not null auto_increment, 
    customer_id int not null, 
    isbn varchar(25) not null, 
    quantity int not null, 
    order_date date not null,
    primary key (order_no), 
    foreign key (customer_id) references customers(customer_id) on delete cascade, 
    foreign key (isbn) references books(isbn) on delete cascade 
);

-- #1. Insert at least 10 records in customer table and insert other tables accordingly.
insert into customers (first_name, last_name, company, customer_address, city, phone)
values ('Rupesh', 'Dharme', 'pict', 'akot', 'akot', '9075118158'),
       ('Omkar', 'Gaikwad', 'pict', 'pune', 'mumbai', '9999888855'),
       ('Dheeraj', 'Gonchikar', 'amazon', 'pune', 'pune', '9075118158'),
       ('Rohan', 'Khole', 'pict', 'pune', 'mumbai', '9955441122'),
       ('Gayatri', 'Godbole', 'google', 'pune', 'pune', '9075184158'),
       ('Aryan', 'C', 'pict', 'pune', 'mumbai', '9854625846'),
       ('Pushkar', 'Jain', 'pict', 'pune', 'pune', '9075184158'),
       ('Raj', 'Sharme', 'tcs', 'pune', 'pune', '9078418158'),
       ('Krishna', 'Gadam', 'coep', 'akot', 'akot', '9075118158'),
       ('Shreya', 'Verma', 'pict', 'pune', 'pune', '8475118158'),
       ('Harsh', 'Mohan', 'pict', 'pune', 'mumbai', '9084118158'),
       ('Priya', 'Khatri', 'pict', 'pune', 'mumbai', '9075848158'),
       ('Shruti', 'Shriwastav', 'pict', 'pune', 'aurangabad', '9075118158'),
       ('Hemant', 'Krishnan', 'pict', 'pune', 'mumbai', '9075118458');

insert into authors (author_name, author_country)
values ('R D Sharme', 'India'),
       ('H C Verma', 'India'),
       ('K P H', 'Australia');

insert into publishers (publisher_name, publisher_address, create_year)
values ('Prime', 'india', 2001),
       ('Mercury', 'USA', 1952),
       ('Akash', 'Australia', 1975),
       ('Chetan', 'india', 2017),
       ('Prime', 'india', 2015),
       ('Prime', 'india', 2016);


insert into books (isbn, title, unit_price, author_id, publisher_id, pub_year)
values ('85445822155', 'Title1', 350, 1, 2, 2006),
       ('85445822180', 'Title2', 20, 3, 1, 2015),
       ('85445822777', 'Title3', 240, 2, 1, 2000),
       ('85445866785', 'Title4', 320, 1, 2, 2004),
       ('85445822181', 'Title5', 555, 3, 1, 2015),
       ('85445825181', 'Title6', 75, 1, 2, 2015);

insert into orderings (customer_id, isbn, quantity, order_date)
values (5, '85445822180', 1, '2020-05-12'),
       (1, '85445822777', 3, '2020-04-15'),
       (9, '85445822155', 10, '2019-03-02');

-- #2. Display all customer details with city pune and mumbai and customer first name starting with
-- #'p' or 'h'.
select * from customers where city = 'pune' or city = 'mumbai';
select * from customers where first_name like 'p%' or first_name like 'h%';

-- #3. lists the number of different customer cities.(use of distinct)
select distinct city from customers;
select distinct company from customers;

-- #4. Give 5% increase in price of the books with publishing year 2015. ( use of update)
update books
set unit_price = 105/100*unit_price
where pub_year = 2015;
select * from books;

-- #5. Delete customer details living in pune.
select * from customers;
delete from customers
where city = 'pune';


-- #6. Find the names of authors living in India or Australia (use of UNION)
select * from authors;

select author_name from authors
where author_country = 'India'
UNION
select author_name from authors
where author_country = 'australia';


-- #7. Find the publishers who are established in year 2015 as well as in 2016 (use of INTERSECT)
select publisher_name from publishers
where create_year = '2015' or create_year = '2016';

SELECT publisher_name
FROM publishers
where create_year='2015'
INTERSECT
SELECT publisher_name
FROM publishers
where create_year='2016';

select max(unit_price) from books;


-- 8. Find the book having maximum price and find titles of book having price between 300 and 
-- 400.(use of max and between)
select * from books;

select title from books
where unit_price BETWEEN 300 and 400;

-- 9. Display all titles of books with price and published year in decreasing order of publishing 
-- year.
select title from books
where unit_price is not null AND
pub_year is not null ORDER BY pub_year desc;


-- 10. Display title,author_no and publisher_no of all books published in 2000,2004,2006. (use of
-- IN)
select * from books;

select title, author_id, publisher_id from books
where pub_year in ('2000','2001','2015');

-- #11.Create view showing the books and authors details. (COMPLEX VIEW)

select * from books
inner join authors on books.author_id=authors.author_id;