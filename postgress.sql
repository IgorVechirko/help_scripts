-------------------------------------------
--  ds_salaries.csv DB for samples below --
-------------------------------------------

--Display all colums and 10 rows from salaries
SELECT *
FROM salaries;
LIMIT 10;


--Display job_title, exp_level, salary_in_usd columns under aliases with conditions in WHERE and ordered by salary(DESC, ASC) 
-- combination "<>" - mean not equal other comparsion operators the same
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
	(CASE 
		WHEN COUNT(*) = COUNT(exp_level) 
		THEN 1 
		ELSE 0 END
	) AS no_empty_exp_level
FROM salaries
LIMIT 10;


--DISTINCT - return oncly unique values for specified column
SELECT 
	DISTINCT job_title
FROM salaries;


--MIN MAX AVG. MIN and MAX can be used with str
SELECT 
	MAX(salary_in_usd) AS max_salary
	, MIN(salary_in_usd) AS min_salary
	, AVG(salary_in_usd) AS avg_salary
FROM salaries
;
SELECT 
	COUNT(DISTINCT job_title) AS jobs_amount
FROM salaries;


--Condition operator is construction CASE WHEN THEN ... WHEN THEN ELSE END
SELECT 
	CASE
		WHEN exp_level = 'SE'
		THEN 'Senior'
		WHEN exp_level = 'MI'
		THEN 'Middle'
		ELSE 'Other'
		END AS Grade
FROM salaries;


--Cast int to float
SELECT 
	DISTINCT(CAST(remote_ration AS FLOAT) / 100)
FROM salaries;


--Value exist in specified range
SELECT
	*
FROM salaries
WHERE
	year BETWEEN 2020 AND 2024;


--Value exist in list
SELECT
	*
FROM salaries
WHERE
	year IN (2021, 2024);

--LIKE search patern in text. % - any amount on any character 0 included, _ - exact one character.
SELECT
	DISTINCT(job_title)
FROM salaries
WHERE
	job_title LIKE('%data%') 
	OR job_title LIKE('%Data%');


--ORDER BY alow agregate result by specified one or more columns.
--To apply filtering to agregated data use HAVING
--Statements execution order 
--1. First, the product of all tables in the FROM clause is formed.
--2. The WHERE clause is then evaluated to eliminate rows that do not satisfy the search_condition.
--3. Next, the rows are grouped using the columns in the GROUP BY clause.
--4. Then, groups that do not satisfy the search_condition in the HAVING clause are eliminated.
--5. Next, the expressions in the SELECT statement target list are evaluated.
--6. If the DISTINCT keyword in present in the select clause, duplicate rows are now eliminated.
--7. The UNION is taken after each sub-select is evaluated.
--8. Finally, the resulting rows are sorted according to the columns specified in the ORDER BY clause.
--9. TOP clause is executed.

SELECT 
	year
	, company_location AS loc
	, ROUND(AVG(salary_in_usd), 0) AS av
FROM salaries
GROUP BY company_location, year
HAVING avg(salary_in_usd) > 300000
ORDER BY av DESC


--Result of query can be used with other statements. Nested query returned format depends on statement wich will use those data.
--For comparsion in must be one value. For IN operator it must be a list. For FROM it must be a table with alias.
SELECT *
FROM salaries
WHERE company_location IN (SELECT 
				company_location 
			   FROM salaries
			   GROUP BY company_location
			   HAVING AVG(salary_in_usd) > (SELECT 
								AVG(salary_in_usd)
							FROM salaries
							)
			)
;
