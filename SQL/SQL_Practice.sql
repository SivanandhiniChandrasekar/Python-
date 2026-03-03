--Employee Management System

--Creating database
CREATE DATABASE employee_management;

USE employee_management;

--creating tables 
CREATE TABLE employees(
emp_id INT PRIMARY KEY NOT NULL,
emp_name VARCHAR(50),
department VARCHAR(50),
DOJ DATE,
email VARCHAR(50) UNIQUE);

--inserting into employee table
INSERT INTO employees (emp_id, emp_name, department, DOJ, email)
VALUES
(1,'nandhini','Data engineer','12-02-2026','sivanandhinic31@gmail.com',150000),
(2,'nandini','Data analyst','12-02-2026','nandini31@gmail.com',200000),
(3,'rahul','Devops engineer','12-02-2026','srahul65@gmail.com',200000),
(4,'Madan Kumar','Data engineer','12-02-2026','madan@gmail.com',300000);

ALTER TABLE employees
ADD  salary int;

INSERT INTO employees (emp_id, emp_name, department, DOJ, email,salary)
VALUES	
(5, 'Madhan','Service now','12-05-2025','madhan15@gmail.com',1000000),
(6, 'John','Service now','12-05-2025','john708@gmail.com',100000);


select * from employees;

--display employee names in upper
select upper(emp_name) from employees;

CREATE TABLE depart(
dept_name VARCHAR(50),
dept_id INT PRIMARY KEY,
emp_id INT,
FOREIGN KEY (emp_id) REFERENCES employees(emp_id));

INSERT INTO depart (dept_id, dept_name, emp_id)
VALUES
(101, 'Data engineer',1),
(102, 'Data analyst', 2),
(103, 'Service now', 5),
(104, 'Devops engineer',3);
--joins

--INNER JOIN
select e.emp_name, d.dept_id 
from employees e
inner join depart d
on e.emp_id = d.emp_id;

--LEFT JOIN
SELECT e.emp_name, d.dept_name, e.DOJ 
FROM employees e
LEFT JOIN depart d
on e.emp_id = d.emp_id;

--RIGHT JOIN
SELECT e.emp_name, d.dept_name, e.DOJ
FROM  employees e
RIGHT JOIN depart d ON e.department = d.dept_name;

--FULL JOIN
SELECT e.emp_name, d.dept_name, e.DOJ 
FROM employees e
FULL JOIN depart d
on e.emp_id = d.emp_id;

--Retrieve employees with DEPARTMENT name
SELECT emp_name, department from employees;


select * from depart;
select dept_name 
from depart;

--List department with no employees
SELECT  dept_id
from depart
group by emp_id
having count(dept_name) = 0;

select floor(avg(salary))
from employees;

select department, count(emp_id) as employee_count
from employees 
group by department;

select department, avg(salary) as avg_salary
from employees
group by department
having avg(salary) > 50000;

--calculate total project per department
select department, count(project) as project_count 
from employees 
group by department;

create view high_performing_employees as
select emp_name, emp_id, salary 
from employees 
where salary > 50000;

create view department_salary_summary as
select department, avg(salary) as salary_summary 
from employees 
group by department;

select emp_name, salary from employees 
where salary > (select avg(salary) from employees);

SELECT TOP 3 department,
       SUM(expenses) AS total_expenses
FROM employees
GROUP BY department
HAVING SUM(expenses) > (SELECT AVG(expenses) FROM employees)
ORDER BY total_expenses DESC;

select emp_name, emp_id
from employees 
where emp_id  in (7,6,2);

select emp_name, emp_id 
from employees 
where not exists (select dept_id from depart
where depart.emp_id = employees.emp_id);