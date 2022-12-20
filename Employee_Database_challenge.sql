-- Create reirement_title table from employees and titles tables
SELECT
	em.emp_no,
	em.first_name,
	em.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as em
INNER JOIN titles as ti
ON (em.emp_no = ti.emp_no)
WHERE (em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;
-- Check retirement_table

SELECT *
FROM retirement_titles;

-- Create Unique titles table from retirement titles table
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no;

-- Check unique_titles table
SELECT *
FROM unique_titles

-- Employee count by title who are about to retire
SELECT COUNT(un.title), un.title
INTO retiring_titles
FROM unique_titles as un
GROUP BY un.title
ORDER BY count DESC;
-- Check retiring_titles table
SELECT *
FROM retiring_titles

-- Employees eligible for mentorship program
SELECT DISTINCT ON (em.emp_no)
	em.emp_no,
	em.first_name,
	em.last_name,
	em.birth_date,
	de.from_date,
	de.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as em
INNER JOIN dept_emp as de
ON (em.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (em.emp_no = ti.emp_no)
WHERE (de.to_date = '9999-01-01') AND
	(em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY em.emp_no;

-- Check mentorship_eligibility table
SELECT *
FROM mentorship_eligibilty

-- Determining the total salary freed up from retiring employees.  
SELECT DISTINCT ON (un.emp_no)
	un.emp_no,
	un.first_name,
	un.last_name,
	un.title,
	sa.salary
INTO total_salaries
FROM unique_titles as un
INNER JOIN salaries as sa
on (un.emp_no = sa.emp_no);

SELECT SUM(salary)
FROM total_salaries;

SELECT sum(tt.salary), 
	tt.title
INTO salary_by_titles
FROM total_salaries as tt
GROUP BY tt.title;

SELECT *
FROM salary_by_titles;

