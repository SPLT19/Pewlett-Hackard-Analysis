Departments
-
dept_no varchar pk fk - dept_emp.dept_no
dept_name varchar


dept_manager
-
dept_no varchar pk fk - Departments.dept_no
emp_no int pk fk - employees.emp_no
from_date date
to_date date

dept_emp
-
dept_no varchar pk fk - dept_manager.dept_no
emp_no int fk - employees.emp_no 
from_date date
to_date date

employees
-
emp_no int pk fk - salaries.emp_no
birth_date date
first_name varchar
last_name varchar
gender varchar
hire_date date

salaries
-
emp_no int pk fk - titles.emp_no
salary
from_date date
to_date date

titles
-
emp_no int pk fk - dept_manager.dept_no
title int
from_date date
to_date date