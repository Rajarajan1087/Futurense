create table Students
( id int primary key identity(1,1),
name varchar(20) not null,
class int not null default 10,
subject varchar(20) not null,
city varchar(20) not null default 'Mumbai',
marks int check(marks>0 and marks<101));

INSERT INTO Students (name, class, subject, marks, city) VALUES
('Riya', 10, 'Math', 92, 'Mumbai'),
('Aarav', 10, 'English', 85, 'Delhi'),
('Sneha', 12, 'Math', 76, 'Mumbai'),
('Karan', 12, 'English', 89, 'Chennai'),
('Meena', 10, 'Math', 80, 'Delhi'),
('Rahul', 12, 'English', 95, 'Mumbai');

select name,marks,subject from Students where city = 'Delhi' and subject = 'Math';

select count(*) as TotalStu from Students;

select AVG(marks) from Students;

select sum(marks) as total,subject from Students group by subject;

select Avg(marks) as AvgMarks,class from Students group by class having Avg(marks) > 85;



create table Stu
(roll_no  int primary key identity(1,1),
name varchar(40) not null);

create table Mar
(roll_no  int primary key references Stu(roll_no),
marks int not null check(marks>0 and marks<101));


-- Table 1: Stu
insert into Stu(name) values
('Riya'),
('Ayaan'),
('Sneha'),
('Arjun');

-- Table 2: Mar
insert into Mar(roll_no, marks) values
(1, 88),
(2, 72),
(4, 95);

select count(s.name) as NoOfStuWitMarks from Stu s inner join Mar m on s.roll_no= m.roll_no 
where m.marks > 75 order by m.marks desc;

alter table Mar add subject varchar(20) not null default('Maths');

select * from Mar;

update Mar set subject = ' English' where marks < 90;

/*Into model DB*/
drop table sales;
create table sales 
(sale_id int primary key identity(101,1),
product_id int ,
amount float not null);

create table products 
(product_id int primary key not null,
product_name varchar(50) not null);

-- Insert products
INSERT INTO products (product_id, product_name) VALUES
(1, 'Laptop'),
(2, 'Mouse'),
(3, 'Keyboard');

-- Insert sales (including one with missing product)
INSERT INTO sales ( product_id, amount) VALUES
( 1, 50000),
( 2, 500),
( 3, 1500),
( 999, 200);   -- product_id 999 does not exist in products


select * from products p right join sales s on p.product_id = s.product_id;


-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

-- Timesheet table
CREATE TABLE timesheet (
    emp_id INT PRIMARY KEY,
    hours_logged INT NOT NULL
);

-- Employees only (no timesheet)
INSERT INTO employees (emp_id, name) VALUES
(1, 'Riya'),
(2, 'Ayaan'),
(5, 'Sneha');

-- Timesheet only (no employee record)
INSERT INTO timesheet (emp_id, hours_logged) VALUES
(2, 40),
(3, 35),
(4, 25);




SELECT 
    COALESCE(e.emp_id, t.emp_id) AS emp_id,
    e.name,
    t.hours_logged,
    CASE
        WHEN e.emp_id IS NOT NULL AND t.emp_id IS NOT NULL 
            THEN 'Matched'
        WHEN e.emp_id IS NOT NULL AND t.emp_id IS NULL 
            THEN 'Only in employees'
        WHEN e.emp_id IS NULL AND t.emp_id IS NOT NULL 
            THEN 'Only in timesheet'
    END AS status
FROM employees e
FULL JOIN timesheet t ON e.emp_id = t.emp_id
ORDER BY emp_id;

-- Table A: customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(40) NOT NULL
);

-- Table B: orders
CREATE TABLE orders (
    customer_id INT,
    order_id  INT PRIMARY KEY
);

-- Insert into customers
INSERT INTO customers (customer_id, name) VALUES
(5, 'Arun'),
(6, 'Farq');
-- Insert into orders
INSERT INTO orders (customer_id, order_id) VALUES
(4, 104),
(6, 106);

select * from customers c left join orders o on c.customer_id = o.customer_id ;
/*where c.name is null or o.customer_id is null;*/


--Model DB

create table stud
(roll_no int primary key identity(1,1),
name varchar(30));

create table submis
(roll_no int primary key references stud(roll_no),
status varchar(30) default('Submitted'));

insert into stud (name) values 
('Riya'),
('Ayaan '),
('Priya '),
('Meena ');

insert into submis(roll_no) values 
(1),
(2),
(3);

select COALESCE(s.roll_no,su.roll_no),name,status,subject
from stud s left join submis su on s.roll_no = su.roll_no order by status desc,name;

select COALESCE(s.roll_no,su.roll_no),name,subject
from stud s left join submis su on s.roll_no = su.roll_no where status is not null order by status desc,name ;

alter table submis add subject varchar(10) default('Maths');
alter table submis drop column subject ;
alter table submis drop PK__submis__9560EEE1CAFA0167 ; 

update submis set subject = 'English' where roll_no =2
