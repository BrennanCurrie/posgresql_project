--Creating first table, reading in csv 
create table departments (
							dept_no varchar(10) not null,
							dept_name varchar(25),
							PRIMARY KEY (dept_no)
							);
select *
from departments;	

drop table departments;

--Creating second table, reading in csv
create table dept_emp (
						emp_no varchar(10) not null,
						dept_no varchar(10) not null,
						PRIMARY KEY (emp_no, dept_no)
						--FOREIGN KEY (dept_no) REFERENCES departments(debt_no)
							);
select *
from dept_emp;

drop table dept_emp;

--Creating third table, reading in csv
create table dept_manager (
						dept_no varchar(10),
						emp_no varchar(10) not null,
						PRIMARY KEY (emp_no),
						FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
						--FOREIGN KEY (dept_no) REFERENCES dept_emp(dept_no),
						--FOREIGN KEY (emp_no) REFERENCES dept_emp(emp_no),
						FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
						FOREIGN KEY (emp_no) REFERENCES salaries(emp_no)
							);
select *
from dept_manager;

drop table dept_manager;

--Creating forth table, reading in csv
create table employees (
						emp_no varchar(10) not null,
						emp_title_id varchar(10),
						birth_date varchar(10),
						first_name varchar(25),
						last_name varchar(25),
						sex varchar(10),
						hire_date varchar(10),
						PRIMARY KEY (emp_no),
						FOREIGN KEY (emp_no) REFERENCES dept_manager(emp_no),
						FOREIGN KEY (emp_no) REFERENCES salaries(emp_no)
							);
select *
from employees;

drop table employees;

--Creating fifth table, reading in csv
create table salaries (
						emp_no varchar(10) not null,
						salary int,
						PRIMARY KEY (emp_no)
							);
select *
from salaries;

drop table salaries;

--Creating sixth table, reading in csv
create table titles (
						title_id varchar(10) not null,
						title varchar(25),
						PRIMARY KEY (title_id)
							);
select *
from titles;

drop table titles;

---------------------------------------------------------------
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
full outer join salaries on salaries.emp_no=employees.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
select employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date like '%1986'

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
select dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name 
from dept_manager
inner join departments on departments.dept_no=dept_manager.dept_no
inner join employees on employees.emp_no=dept_manager.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select dept_emp.dept_no, dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
full outer join departments on dept_emp.dept_no=departments.dept_no
full outer join employees on dept_emp.emp_no=employees.emp_no

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules' and last_name like 'B%'

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
full outer join departments on dept_emp.dept_no=departments.dept_no
full outer join employees on dept_emp.emp_no=employees.emp_no
where dept_name='Sales'

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp
full outer join departments on dept_emp.dept_no=departments.dept_no
full outer join employees on dept_emp.emp_no=employees.emp_no
where dept_name='Sales' or dept_name='Development'

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select employees.last_name, count(employees.last_name)
from employees
group by last_name
order by count desc