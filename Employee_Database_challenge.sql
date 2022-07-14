
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
INTO unique_titles
FROM retirement_titles AS rtl
ORDER BY rtl.emp_no, rtl.to_date DESC;

--Restults: SELECT * FROM unique_titles

--employee number, first and last name, and title columns from the Retirement Titles table.
SELECT COUNT(untl.emp_no), untl.title
INTO retiring_titles
FROM unique_titles AS untl
GROUP BY untl.title
ORDER BY count DESC;
--confirm that it looks like this image:
--Results: SELECT * FROM retiring_titles
--Most title retiring are Senior Engineer 29414, Senior Staff 14222, Engineer 14222




 --Deliverable 2: The Employees Eligible for the Mentorship Program


 --create a mentorship-eligibility table that holds the current 
 --employees who were born between January 1, 1965 and December 31, 1965.
 --identify employees who are eligible to participate in a mentorship program.
  SELECT DISTINCT ON(emp.emp_no)
		emp.emp_no,
		emp.first_name,
		emp.last_name,
		emp.birth_date,
		demp.from_date,
		demp.to_date,
		tl.title
INTO mentorship_eligibility
FROM employees AS emp
	INNER JOIN dept_emp AS demp
	ON (emp.emp_no = demp.emp_no)
		INNER JOIN titles AS tl
		ON (emp.emp_no = tl.emp_no)
WHERE (emp.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (demp.to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

--Results: SELECT * FROM mentorship_eligibility
  
  
  --Deliverable 3: A written report on the employee database analysis
  -- Extra tables
   --analysis and helps prepare Bobby’s manager for the “silver tsunami” 
   
   --number of promotion per employee about to retire : wich employees have had the most promotions
   --that could be considered to have more experience in different work post that could be helpful for new hires training
   
SELECT COUNT(unn.emp_no), unn.emp_no
INTO number_promotions
FROM retirement_titles AS unn
GROUP BY unn.emp_no 
ORDER BY count DESC;
SELECT * FROM number_promotions


--workers who retire, post and where they belong to
SELECT DISTINCT ON (ret.emp_no) 
	ret.emp_no,
	ret.last_name,
	ret.title,
	dep.dept_name
INTO lastname_lasttitle
FROM retirement_titles as ret
INNER JOIN dept_emp as demp
ON (ret.emp_no = demp.emp_no)
INNER JOIN departments as dep
ON (dep.dept_no = demp.dept_no)
ORDER BY ret.emp_no, ret.to_date DESC;



