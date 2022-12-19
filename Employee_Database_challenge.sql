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
