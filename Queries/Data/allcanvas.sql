-- Creating tables for PH-EmployeeDB
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);

-- Creating EPLOYEES TABLE
CREATE TABLE employees (
     emp_no INT NOT NULL,
     birth_date DATE NOT NULL,
     first_name VARCHAR NOT NULL,
     last_name VARCHAR NOT NULL,
     gender VARCHAR NOT NULL,
     hire_date DATE NOT NULL,
     PRIMARY KEY (emp_no)
);
-- Creating  TABLE department manager (Moved emp no and dept no vs. canvas ver. of script)
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
PRIMARY KEY (dept_no, emp_no,)
);

-- Creating  TABLE salaries
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

-- Creating  TABLE Titles
CREATE TABLE titles (
  emp_no INT NOT NULL,
  title INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES salaries (emp_no),
  PRIMARY KEY (emp_no)
);

-- Creating  TABLE dept emp
CREATE TABLE dept_emp (
  dept_no VARCHAR(4) NOT NULL,
  emp_no INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
   PRIMARY KEY (dept_no)
);

--Debugging corrupted tables (import function issue)
--Querry for confirmation
SELECT * FROM departments; 


---Recreate titles table
CREATE TABLE titles (
emp_no INT NOT NULL, 
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (emp_no, from_date)
);

-- Select 
SELECT * FROM dept_manager 

-- Recreat dept_manager
CREATE TABLE dept_manager (
	dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

--Select Queryes
SELECT * FROM dept_manager 
SELECT * FROM dept_emp
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles
SELECT * FROM departments

-- Recreat dept_emp
CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

--ANALYSIS QUERYS--

--Analysis  January 1, 1952, and December 31, 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';	
--(RESULTS messages: 90398 rows affected.)

--Analysis  only  employees born in 1952 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31'; 
--( RESULT messages: 21209 rows affected.)

--Analysis  only  employees born in 1953 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';
--( RESULT messages: 22857  rows affected.)

--Analysis  only  employees born in 1954 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';
--( RESULT messages: 23228 rows affected.)

--Analysis  only  employees born in 1955 
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';
--( RESULT messages: 23104 rows affected.)

--Narrow  Search for Retirement Eligibility (birth dates + hire date) 
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--(RESULTS messages 1380 rows affected)


--Counting querys
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--(RESULTS from count: 41,380)


--Create CSV Tables from querys
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
--(Result: Query returned successfully)

--Inspect result
SELECT * FROM retirement_info



-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--shortening names/aliases version
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining departments and dept_manager tables, 
--shortened ver
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no
WHERE dm.to_date = ('9999-01-01');


--Left Join to Capture retirement-info Table
-- Joining retirement_info and dept_emp tables
-- Selecting current employees

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--COUNT will count rows of data in a dataset, 
--GROUP BY groups data by type
-- ORDER BY arrange data to present in descending or ascending order
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
--ABOUT RESULTS: COUNT function was used on the employee numbers.
--Aliases were assigned to both tables.
--GROUP BY was added to the SELECT statement.


--add ORDER BY to keep everything in order
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--csv, skill drill 
SELECT COUNT(ce.emp_no), de.dept_no
INTO eployee_count_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM eployee_count_dept

-- Emplojee info
SELECT * FROM salaries
ORDER BY to_date DESC;
--Result: table with odd date entry, 
--solution: pull employment dates from dept_emp table again


--inspect to reuse code
--previous code selection to see:

SELECT *  FROM retirement_info
--result: is missing is the gender

--add gender SELECT
-- Employee list with gender and salary
-- Save into a new table
--adding columns needed from the Salaries table
--filter (multiple filters date and 9999 one)
SELECT e.emp_no, 
	   e.first_name, 
	   e.last_name, 
	   e.gender,
	   s.salary,
	   de.to_date
INTO emp_info	   
FROM employees as e
INNER JOIN salaries as s
	ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');
--Results: SELECT * FROM emp_info

--List2 List of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);
--Results: SELECT * FROM manager_info

--List3: employees with departments
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no);
--Results: SELECT * FROM dept_info

--don't need to see a column from each table in a join
--needed to link :  foreign and primary keys
--List of Sales employees
SELECT ce.emp_no,
ce.first_name,
ce.last_name,
d.dept_name
--INTO sales_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE d.dept_name = 'Sales';

--Tailored list: employees in Sales and Development
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO sales_dev
FROM current_emp as ce
	INNER JOIN dept_emp AS de
		ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
		ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales', 'Development')
ORDER BY ce.emp_no;
 --SELECT * FROM sales_dev
 