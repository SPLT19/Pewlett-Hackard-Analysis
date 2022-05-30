
 --Deliverable 1: Number of Retiring Employees by Title
 --determine number of retiring employees per title
SELECT emp.emp_no,
		emp.first_name,
		emp.last_name,
		tl.title,
		tl.from_date,
		tl.to_date
INTO retirement_titles
FROM employees as emp
  INNER JOIN titles as tl
	ON (emp.emp_no = tl.emp_no)
WHERE (emp.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no; 

--Results: SELECT * FROM retirement_titles

--Employees name repeat,duplicate entries (ppl that changed title during contract) 
-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rtl.emp_no)
	rtl.emp_no,
	rtl.first_name,
	rtl.last_name,
	rtl.title
INTO retirement_last_titles
FROM retirement_titles AS rtl
ORDER BY rtl.emp_no, rtl.to_date DESC;

--Restults: SELECT * FROM retirement_last_titles

--employee number, first and last name, and title columns from the Retirement Titles table.
SELECT COUNT(rlt.emp_no), rlt.title
INTO ret_title_num
FROM retirement_last_titles AS rlt
GROUP BY rlt.title
ORDER BY count DESC;

--Results: SELECT * FROM ret_title_num
--Most title retiring are Senior Engineer 29414, Senior Staff 14222, Engineer 14222









 --Deliverable 2: The Employees Eligible for the Mentorship Program
 --identify employees who are eligible to participate in a mentorship program.
 
  
  
  -- Extra tables
   --analysis and helps prepare Bobby’s manager for the “silver tsunami” 





