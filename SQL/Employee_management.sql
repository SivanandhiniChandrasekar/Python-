use employee_db;

--------PERFORMANCE ANALYSIS---------
--Top 10 high performers
select top 10 review_id, emp_id, review_year, round(rating,2) as rating from Performance_review
order by rating desc ;

--Average Rating Per department
select e.dept_id, round(avg(p.rating),2) as avg_per_department
from Performance_review p
left join Employees e
on e.emp_id = p.emp_id
group by e.dept_id;

--Employees Eligible for promotion
select p.emp_id,round(p.rating,2)as rating from Performance_review p
left join Employees e
on e.emp_id = p.emp_id
where round(p.rating,2) > 4.0 and DATEDIFF(YEAR, e.join_date, GETDATE()) > 3;

--Performance Trend over years
select emp_id, review_year, round(rating,2)as rating
from Performance_review
order by emp_id, review_year;

--------------SALARY ANALYSIS------------------
--Salary Distribution per department
select  d.dept_name,
avg(s.salary) as avg_salary
from Salaries s
left join Employees e 
on e.emp_id = s.emp_id
left join Departments d
on e.dept_id = d.dept_id
group by d.dept_name
order by avg_salary desc;

--Highest and lowest salary per role
select d.dept_name, min(s.salary) as Lowest_salary, max(s.salary) as Highest_salary
from Salaries s
left join Employees e 
on e.emp_id = s.emp_id
left join Departments d
on e.dept_id = d.dept_id
group by d.dept_name;

--Salary vs Performance correlation
select
    round(p.rating,2) as rating,
    count(*) as total_employees,
    avg(s.salary) as avg_salary
from Salaries s
join Performance_Review p on p.emp_id = s.emp_id
group by p.rating
order by p.rating;

--Employees below department average salary
select 
    s.emp_id,
    s.salary,
    d.dept_id
from Salaries s
join Employees e on e.emp_id = s.emp_id
join Departments d on d.dept_id = e.dept_id
where s.salary < (
    select avg(s2.salary)
    from Salaries s2
    join Employees e2 on e2.emp_id = s2.emp_id
    where e2.dept_id = e.dept_id
);


-----------DEPARTMENT GROWTH-----------
--Hiring Trend Per year
select year(join_date)as years, count(*) as Hire_trend 
from Employees 
group by year(join_date);

--Headcount growth by department
select  dept_id,count(*) as Headcount, year(join_date) as years
from Employees
group by  dept_id, year(join_date)
order by dept_id;

--Attrition rate by department
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees,
    SUM(CASE WHEN e.status = 'Inactive' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        100.0 * SUM(CASE WHEN e.status = 'Inactive' THEN 1 ELSE 0 END)
        / COUNT(e.emp_id),
        2
    ) AS attrition_rate_percent
FROM Employees e
JOIN Departments d ON d.dept_id = e.dept_id
GROUP BY d.dept_name
ORDER BY attrition_rate_percent DESC;

----------STRATEGIC INSIGHTS----------

--Employees over due for promotion
select e.emp_id,e.emp_name,datediff(year,e.join_date,getdate())as experience,  round(p.rating,2) as rating, s.salary
from Employees e
join Salaries s
on s.emp_id = e.emp_id
join Performance_review p 
on p.emp_id = e.emp_id;

--High salary but low performance cases
select p.emp_id, round(p.rating,2) as rating, s.salary 
from Performance_review p 
left join Salaries s
on p.emp_id = s.emp_id 
where p.rating < 3.5 and s.salary > 500000;

--Most stable department (lowest attrition)

--Attendance vs Performance analysis

--Location wise salary comparison
select l.location_id,l.location_name, avg(s.salary) as avg_Salary
from Locations l 
join Employees e on e.location_id = l.location_id
join Salaries s on e.emp_id = s.emp_id
group by l.location_id,l.location_name
order by avg_Salary desc;

--Gender diversity ration
select round(sum(case when e.gender = 'Male' then 1 else 0 end )*100.0 / count(*),2) as Male,
round(sum(case when e.gender = 'Female' then 1 else 0 end )*100.0 / count(*),2) as Female 
from Employees e;

--Median salary calculation
select distinct
    PERCENTILE_CONT(0.5) 
        within group (order by salary) 
        over () as median_salary
from Salaries;

--Employees with multiple promotions

--Identify leadership pipeline candidates