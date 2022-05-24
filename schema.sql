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