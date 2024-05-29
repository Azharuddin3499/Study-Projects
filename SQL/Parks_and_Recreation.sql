DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;

CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);

CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);


INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');


INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);



CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);

INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');


-- GroupBy
select gender,avg(age),max(age),min(age),count(age)
from employee_demographics group by gender;

-- where
select gender, avg(age) from  employee_demographics where age >= 30 and age <= 40
and gender = 'Male'
group by age;


-- Group By Clause: The group by clause is used to aggregate data.
-- When you use group by, you typically also use aggregate functions
-- like COUNT, SUM, AVG, etc. If you use group by without aggregate functions,
-- you need to specify how to handle non-grouped columns.


select occupation,salary from employee_salary group by occupation,salary;

-- Orderby
select * from employee_demographics order by gender,age ;
select * from employee_demographics order by 5,4 ;

-- having vs where 
select gender, avg(age)
from employee_demographics
group by gender
having avg(age) > 40;

--  When using GROUP BY, all columns in the SELECT clause that are not aggregate functions
-- must be included in the GROUP BY

select first_name,occupation,avg(salary) from employee_salary
where occupation like '%manager%'
group by first_name,occupation
having avg(salary) > 75000;


-- Limit & Aliasing
select * from employee_demographics
order by age desc
limit 3,1;

-- Limit the Results: The LIMIT 3, 1 clause means:
-- Skip the first 3 rows (offset is 3).
-- Return the next 1 row (count is 1).


-- Aliasing
select gender, avg(age) as Average_age
from employee_demographics
group by gender
having avg(age) > 40;

-- Joins(inner,left,right)
Select * from employee_demographics 
inner join employee_salary
on employee_demographics.employee_id = employee_salary.employee_id;

-- self join
select * from employee_salary emp1
join  employee_salary emp2
on emp1.employee_id+1 =emp2.employee_id;

-- joining multiple tables
select dem.employee_id,dem.first_name,dem.age,dem.gender,sal.occupation,sal.salary,pd.department_name from employee_demographics as dem
inner join employee_salary as sal
on dem.employee_id = sal.employee_id
inner join parks_departments pd
on sal.dept_id = pd.department_id;


-- union: A={1,2,3} B={3,4,5}  union = {1,2,3,4,5}
-- union all = {1,2,3,3,4,5}
select first_name,last_name from employee_demographics
union 
select first_name,last_name from employee_salary;

select first_name,last_name , 'Old' as Label
from employee_demographics
where age > 50
union
select first_name,last_name , 'Old Lady' as Label
from employee_demographics
where age > 40 and gender = 'Female'
union
select first_name,last_name , 'Highly Paid' as Label
from employee_salary
where salary > 70000
order by first_name,last_name;

-- String Functions
select length('skyfall');

select first_name,length(first_name) from employee_demographics
order by 2;

select upper('sky');

-- trim remove spaces ,Ltrim remove space from left, Rtrim remove space from right
select trim('           sky               ');

select first_name,
right(first_name,4),
left(first_name,4),
substring(first_name,3,2),
birth_date,
substring(birth_date,6,2) as birth_month
from employee_demographics;

select first_name,replace(first_name,'a','z') from employee_demographics;

select locate('x','Alexander');

select first_name, locate('An',first_name)
from employee_demographics;

select first_name, last_name,
concat(first_name, ' ' ,last_name) as full_name
from employee_demographics;

-- case statments
select first_name,last_name,age,
case 
	when age <= 30 then 'Young'
    when age between 31 and 50  then 'Old'
    when age >= 50 then "On Death's Door"
end as age_bracket
from employee_demographics;



-- pay increase and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

select first_name, last_name , salary,
case
	when salary < 50000 then salary + (salary * 0.05)
    when salary >= 50000 then salary + (salary * 0.07)
end as new_salary,
case 
	when dept_id = 6 then salary  * 0.10
end as bonus
from employee_salary;


-- subqueries in MySql
select * from employee_demographics
where employee_id in (
	select employee_id from employee_salary where dept_id =1
);

select first_name, salary,
(select avg(salary) from employee_salary)
from employee_salary;

select gender, avg(age), max(age), min(age),count(age) 
from employee_demographics
group by gender;

-- windows fucntions
select gender, avg(salary) 
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id
group by gender;


select dem.first_name, dem.last_name, gender,salary,
sum(salary) over(partition by gender order by dem.employee_id) as cummulaative_sum
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;


select dem.first_name, dem.last_name, gender,salary,
row_number() over()
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

select dem.first_name, dem.last_name, gender,salary,
row_number() over(partition by gender order by salary desc) ,
rank() over(partition by gender order by salary desc) rank_num
from employee_demographics dem
join employee_salary sal
on dem.employee_id = sal.employee_id;

-- CTEs
-- Temperory Tables

-- stored procedures
-- triggers and events


