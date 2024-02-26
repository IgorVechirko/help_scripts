--Display all colums and 10 rows from salaries
SELECT *
FROM salaries;
LIMIT 10;


--Display job_title, exp_level, salary_in_usd columns under aliases with conditions in WHERE and ordered by salary(DESC, ASC) 
SELECT job_title as title
		, exp_level as expirience
		, salary_in_usd as money
FROM salaries
WHERE remote_ration = 100
		AND company_location = 'US'
ORDER BY salary_in_usd DESC
LIMIT 10;


--Count and display amount off all rows
SELECT 
	COUNT(*) AS amount
FROM salaries
LIMIT 10;


--No empty(null) values in column exp_level
SELECT 
	CASE COUNT(*) as total
	, COUNT(exp_level) as expirience
FROM salaries
LIMIT 10;
--or
SELECT 
	(CASE WHEN COUNT(*) = COUNT(exp_level) THEN 1 ELSE 0 END) AS no_empty_exp_level
FROM salaries
LIMIT 10;
