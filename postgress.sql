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
