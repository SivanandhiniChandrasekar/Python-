create database company_db;
use company_db;

create table employee(
emp_id int PRIMARY KEY,
name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL(10,2),
hire_date DATE
);

INSERT INTO employee (emp_id, name, department, salary, hire_date) VALUES
(1, 'John Smith', 'Marketing', 55000.00, '2020-03-15'),
(2, 'Mary Johnson', 'Sales', 48000.00, '2019-07-23'),
(3, 'James Williams', 'Engineering', 75000.00, '2021-11-01'),
(4, 'Patricia Brown', 'HR', 60000.00, '2018-02-28'),
(5, 'Robert Jones', 'Finance', 90000.00, '2022-01-10'),
(6, 'Jennifer Garcia', 'Marketing', 52000.00, '2020-09-05'),
(7, 'Michael Martinez', 'Engineering', 80000.00, '2017-06-12'),
(8, 'Elizabeth Rodriguez', 'Sales', 47000.00, '2019-05-30'),
(9, 'William Wilson', 'Finance', 95000.00, '2021-03-22'),
(10, 'Linda Moore', 'HR', 64000.00, '2020-12-17'),
(11, 'David Taylor', 'Marketing', 56000.00, '2018-08-01'),
(12, 'Susan Anderson', 'Sales', 49000.00, '2019-11-18'),
(13, 'Joseph Thomas', 'Engineering', 77000.00, '2021-02-14'),
(14, 'Barbara Jackson', 'Finance', 98000.00, '2020-05-09'),
(15, 'Thomas White', 'HR', 62000.00, '2022-03-25'),
(16, 'Nancy Harris', 'Marketing', 54000.00, '2020-10-02'),
(17, 'Charles Martin', 'Sales', 50000.00, '2018-11-20'),
(18, 'Helen Thompson', 'Engineering', 76000.00, '2021-07-17'),
(19, 'George Garcia', 'Finance', 92000.00, '2020-06-04'),
(20, 'Jessica Robinson', 'HR', 58000.00, '2022-05-15');

--SQL Statement Fundamentals
select CURRENT_TIMESTAMP;
select UPPER(name) from employee;

select LEN(name) from employee;

select count(*) from employee;
select AVG(salary)from employee;

--selecting columns from employees--
select name,salary from employee;

--joins and sql 
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(40),
    emp_id INT,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id)
);

INSERT INTO department (emp_id, dept_name, dept_id) VALUES
(1, 'Human Resources', 101),
(2, 'Engineering', 102),
(3, 'Marketing', 103),
(4, 'Sales', 104),
(5, 'Finance', 105),
(6, 'Customer Support', 106),
(7, 'IT', 107),
(8, 'Legal', 108),
(9, 'Operations', 109),
(10, 'Product Management', 110),
(11, 'Research & Development', 111),
(12, 'Accounting', 112),
(13, 'Public Relations', 113),
(14, 'Supply Chain', 114),
(15, 'Training & Development', 115),
(16, 'Business Development', 116),
(17, 'Procurement', 117),
(18, 'Compliance', 118),
(19, 'Quality Assurance', 119),
(20, 'Creative', 120);

select e.name, d.dept_name 
from employee e 
inner join department d
on e.emp_id = d.emp_id;

select e.name, d.dept_name
from employee e 
left join department d 
on e.department = d.dept_name;

select top 3 department,avg(salary) as dept_avg_salary 
from employee
group by department
order by dept_avg_salary desc;

select floor(avg(salary))as avg_salary from employee;


select * from employee;

--views 
CREATE VIEW high_salary_emp AS
SELECT name, salary 
FROM employee
WHERE salary > 50000;

SELECT * FROM high_salary_emp;

--Sub Query
SELECT name, salary 
FROM employee 
WHERE AVG(salary) >(SELECT salary FROM employee);

--Limit or Top
select top 3 department,avg(salary) as dept_avg_salary 
from employee
group by department
order by dept_avg_salary desc;

