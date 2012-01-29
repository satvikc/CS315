-- Satvik Chauhan
-- Y9521

USE employees;

-- Inner Join 
-- The result of the join can be defined as the outcome of first taking the 
-- Cartesian product of all records in the tables (combining every record in 
-- table A with every record in table B)—then return all records which satisfy the join predicate.
-- Selects those employees from employees table which also have a corresponding entry in dept_manager table.
select * from employees inner join dept_manager on dept_manager.emp_no = employees.emp_no;

-- Inner Join (implicit)
select * from employees , dept_manager where dept_manager.emp_no = employees.emp_no;
-- Natural Join 
-- Removes duplicate columns 
select * from employees natural join dept_manager ;

-- Outer Joins
-- Left Outer Join 
-- The result of a left outer join for table A and B always contains all records of the 
-- table A, even if the join-condition does not find any matching record in table B. 
-- Select all the departments and those dept_manager which satisfy the condition . Null is inserted incase no mathing tuple is found
-- in the right table for a tuple in left table. If more than one is found then the entries in the left table is repeated. 
select * from departments left outer join dept_manager on departments.dept_no = dept_manager.dept_no;

-- Right Outer Join 
-- Same as left outer join only the treatment of tables is reversed. 
-- Now all entries from the right table us included and only matching entries from the left table is included . Null is inserted if 
-- no matching entry is found.
select * from departments right outer join dept_manager on departments.dept_no = dept_manager.dept_no;

-- Full Outer Join 
-- Combines result of left and right outer joins.
-- It will contains all the entries from all the tables with null values for not matching entries. 
-- select * from departments full outer join dept_manager on departments.dept_no = dept_manager.dept_no;

-- find sum of all the employees 
select SUM(salary) from salaries;

-- find the minimum salary 
select MIN(salary) from salaries;

-- find the maximum salary 
select MAX(salary) from salaries;

-- find the average of all salaries
select AVG(salary) from salaries;

-- list the department_no with the total nuumber of managers, max , min and average salaries of managers for each department
select dept_manager.dept_no, count(distinct salaries.emp_no), MAX(salaries.salary) , MIN(salaries.salary), AVG(salaries.salary) from dept_manager inner join  salaries on dept_manager.emp_no = salaries.emp_no group by dept_manager.dept_no ;

-- List out the average salary of each title 
select titles.title, AVG(salaries.salary) from titles , salaries where titles.emp_no = salaries.emp_no group by titles.title ;

-- List out the number of employees for each job title 
select titles.title , count(distinct titles.emp_no) from titles group by  titles.title;

-- Insert a record 
insert into departments values ('d011', 'Maintenance');
select * from departments;
-- Update the dept_no of the 'Maintenance' to 'd010'
update departments set dept_no = "d010" where dept_name = "Maintenance";
select * from departments;

-- Delete the department with dept_no 'd010'
delete from departments where dept_no = "d010";
select * from departments;

